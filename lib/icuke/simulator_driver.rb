require 'icuke/simulator'
require 'icuke/simulate'
require 'icuke/screen'
require 'icuke/configuration'

module ICuke
  class SimulatorDriver
  
    DSL_METHODS = [:launch, :quit, :suspend, :resume, :screen,
                 :response, :record, :tap, :swipe, :drag,
                 :drag_with_source, :drag_slider_to, 
                 :drag_slider_to_percentage, :type, :scroll_to,
                 :scroll, :set_application_defaults,
                 :drag_picker_to_value, :choose_value_in_picker]
   
    include ICuke::Simulate::Gestures
    
    def initialize(simulator, configuration)
      @simulator = simulator
      @configuration = configuration
    end
    
    def self.default_driver(configuration)
      new(ICuke::Simulator.new, configuration)
    end
    
    def launch(application, options = {})
      default_options = {:build_configuration => configuration[:build_configuration]}
      process = ICuke::Simulator::Process.new(application, default_options.merge(options))
      @simulator.launch(process)
    end

    def quit
      @simulator.quit
    end

    def suspend
      @simulator.suspend
    end

    def resume
      @simulator.resume
    end

    def screen
      @screen ||= Screen.new(response)
    end

    def response
      @response ||= @simulator.view
    end

    def record
      @simulator.record
    end
  
    def tap_at_point(x, y, options={})
      options = {
        :pause => true
      }.merge(options)
      @simulator.fire_event(Tap.new(x,y,options))
      sleep(options[:pause] ? 2 : 0.2)
      refresh
    end

    def tap(label, options = {}, &block)
      options = {
        :pause => true
      }.merge(options)

      element = screen.first_tappable_element(label)
      x, y = screen.element_center(element)

      @simulator.fire_event(Tap.new(x, y, options))

      sleep(options[:pause] ? 2 : 0.2)

      refresh

      yield element if block_given?
    end

    def swipe(direction, options = {})
      x, y, x2, y2 = screen.swipe_coordinates(direction)
      @simulator.fire_event(Swipe.new(x, y, x2, y2, 0.015, options))
      sleep(1)
      refresh
    end

    def drag(source_x, source_y, dest_x, dest_y, options = {})
      @simulator.fire_event(Drag.new(source_x, source_y, dest_x, dest_y, 0.15, options))
      sleep(1)
      refresh
    end

    def drag_with_source(source, destination)
      sources = source.split(',').collect {|val| val.strip.to_i}
      destinations = destination.split(',').collect {|val| val.strip.to_i}
      drag(sources[0], sources[1], destinations[0], destinations[1])
    end

    def drag_slider_to(label, direction, distance)
      element = screen.first_slider_element(label)
      x, y = screen.find_slider_button(element)

      dest_x, dest_y = x, y
      modifier = direction_modifier(direction)

      if [:up, :down].include?(direction)
        dest_y += modifier * distance
      else
        dest_x += modifier * distance
      end

      drag(x, y, dest_x, dest_y)
    end
  
    def picker_values(picker)
      index = picker_number(picker)
      picker_tables = screen.xml.xpath("//UIPickerTable")
      values = picker_tables.map do |picker_table|
        picker_table.xpath("UITableCellAccessibilityElement/UITableTextAccessibilityElement/@label").map {|x| x.value }
      end
      values[index]
    end

    def picker_component(picker)
      picker_components = screen.xml.xpath("//UIAccessibilityPickerComponent")
      index = picker_number(picker)
      picker_components[index]
    end
  
    def picker_number(picker)
      picker_components = screen.xml.xpath("//UIAccessibilityPickerComponent")
      index = picker_components.to_ary.index do |c|
        c.attributes["label"].value == picker
      end
    end

    def picker_component_value(picker_component)
      picker_component.attributes['value'].value.match(/(.*) (\d+) of (\d+)/)[1]
    end

    def picker_direction(value, component_value)
      if component_value == '.'
        direction = :up
      else
        picker_index = picker_values.index(value)
        component_index = picker_values.index(component_value)
        if picker_index > component_index
          direction = :up
        elsif picker_index < component_index
          direction = :down
        end
      end
    end
    
    def choose_value_in_picker(value, picker)
      require 'ruby-debug'
      debugger
      component = picker_component(picker)
      values = picker_values(picker)
      component_value = picker_component_value(component)
      one_step_distance = 25
      x, y = screen.element_center(target_picker_component)
      direction = picker_direction(value, component_value)
      modifier = direction_modifier(direction)
      dest_x = x
      dest_y = y + (modifier * one_step_distance)
      loop do
        refresh
        break if picker_component_value(component) == value
        drag(x, y, dest_x, dest_y)
      end
    end

    def drag_picker_to_value(label, direction, target_value)
      loop do
        picker = screen.first_picker_element(label)
        actual_value = picker.attributes['value'].value
        break if target_value == actual_value
        one_step_distance = 25
        x, y = screen.element_center(picker)
        dest_x, dest_y = x, y
        modifier = direction_modifier(direction)
        if [:up, :down].include?(direction)
          dest_y += modifier * one_step_distance
        else
          dest_x += modifier * one_step_distance
        end
        drag(x, y, dest_x, dest_y)
      end
    end


    def drag_slider_to_percentage(label, percentage)
      element = screen.first_slider_element(label)
      x, y = screen.find_slider_button(element)
      dest_x, dest_y = screen.find_slider_percentage_location(element, percentage)
      drag(x, y, dest_x, dest_y)
    end

    def type(textfield, text, options = {})
       unless textfield == '' || textfield.nil?
         tap(textfield, :hold_for => 0.75) do |field|
           if field['value']
             tap('Select All')
             tap('Delete')
           end
         end
       end
       
       # Without this sleep fields which have auto-capitilisation/correction can
       # miss the first keystroke for some reason.
       sleep(0.3)
       
       text.split('').each do |c|
         begin
           tap(c == ' ' ? 'space' : c, :pause => false)
         rescue Exception => e
           try_keyboards =
             case c
             when /[a-zA-Z]/
               ['more, letters', 'shift']
             when /[0-9]/
               ['more, numbers']
             else
               ['more, numbers', 'more, symbols']
             end
           until try_keyboards.empty?
             begin
               tap(try_keyboards.shift, :pause => false)
               retry
             rescue
             end
           end
           raise e
         end
       end

       # From UIReturnKeyType
       # Should probably sort these in rough order of likelyhood?
       return_keys = ['return', 'go', 'google', 'join', 'next', 'route', 'search', 'send', 'yahoo', 'done', 'emergency call']
       return_keys.each do |key|
         begin
           tap(key)
           return
         rescue
         end
       end
     end


    def scroll_to(text, options = {})
      x, y, x2, y2 = screen.swipe_coordinates(swipe_direction(options[:direction]))
      previous_response = response.dup
      until screen.visible?(text) do
        @simulator.fire_event(Swipe.new(x, y, x2, y2, 0.15, options))
        refresh
        raise %Q{Content "#{text}" not found in: #{screen}} if response == previous_response
      end
    end

    def scroll(direction)
      swipe(swipe_direction(direction))
    end

    def set_application_defaults(defaults)
      @simulator.set_defaults(defaults)
    end
    
    def refresh
      @response = nil
      @screen = nil
    end

    private

    def swipe_direction(direction)
      swipe_directions = { :up => :down, :down => :up, :left => :right, :right => :left }
      swipe_directions[direction]
    end

    def direction_modifier(direction)
      [:up, :left].include?(direction) ? -1 : 1
    end
    
    def configuration
      @configuration
    end
  end
end
