#
#
#  Some extra functions which make icuke/cucumber tests more reliable
#
#  It is recommended to use frequently wait_for... functions instead of using sleep
#
#  Test::Unit::Assertions is included to reduce need for asserts in your test scripts
#  
#
#  To enable this extension use:
#
#  require 'icuke/cucumber_ext'
#  instead of
#  require 'icuke/cucumber'
#
#  Author:: Davor Crnomat, @Jayway
#

require 'icuke/cucumber'
require 'rexml/document'
require 'test/unit/assertions'
include Test::Unit::Assertions

class ICukeWorld

  @@timeout = 30
  @@debug = false

  def set_debug(enable = true)
    @@debug = enable
  end

  def set_timeout(timeout = 30)
    @@timeout = timeout
  end

## get an element

  def get_element_by_type(type, index = 0)
    puts "#{method_name}(#{type}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type(type)
    assert(elements.length > 0, "No element found with type: '#{type}'")
    assert(elements.length > index, "No element with index: '#{index}'")
    elements[index]
  end

  def get_element_by_type_and_label(type, label, index = 0)
    puts "#{method_name}(#{type}, #{label}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_and_label(type, label)
    assert(elements.length > 0, "No element found with type: '#{type}' and label: '#{label}'")
    assert(elements.length > index, "No element with index: '#{index}'")
    elements[index]
  end

  def get_element_by_type_and_traits(type, traits, index = 0)
    puts "#{method_name}(#{type}, #{traits}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_and_label(type, traits)
    assert(elements.length > 0, "No element found with type: '#{type}' and traits: '#{traits}'")
    assert(elements.length > index, "No element with index: '#{index}'")
    elements[index]
  end

  def get_element_by_type_label_and_traits(type, label, traits, index = 0)
    puts "#{method_name}(#{type}, #{label}, #{traits}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_label_and_traits(type, label, traits)
    assert(elements.length > 0, "No element found with type: '#{type}', label: '#{label}' and traits: '#{traits}")
    assert(elements.length > index, "No element with index: '#{index}'")
    elements[index]
  end

## get all elements

  def get_all_elements_by_type(type)
    puts "#{method_name}(#{type})" if @@debug
    puts "get_all_elements_by_type(#{type})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    elements = REXML::XPath.match(doc, "//#{type}")
    elements
  end

  def get_all_elements_by_type_and_label(type, label)
    puts "#{method_name}(#{type}, #{label})" if @@debug
    puts "get_all_elements_by_type_and_label(#{type}, #{label})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    elements = REXML::XPath.match(doc, "//#{type}[@label=#{label.inspect}]")
    elements
  end

  def get_all_elements_by_type_and_traits(type, traits)
    puts "#{method_name}(#{type}, #{traits})" if @@debug
    puts "get_all_elements_by_type_and_traits(#{type}, #{traits})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    elements = REXML::XPath.match(doc, "//#{type}[@traits=#{traits.inspect}]")
    elements
  end

  def get_all_elements_by_type_label_and_traits(type, label, traits)
    puts "#{method_name}(#{type}, #{label}, #{traits})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    elements = REXML::XPath.match(doc, "//#{type}[@label=#{label.inspect}][@traits=#{traits.inspect}]")
    elements
  end

  def get_all_static_texts()
    puts "#{method_name}()" if @@debug
    refresh_screen
    get_all_labels_by_traits("static_text")
  end

  def get_all_labels_by_type(type)
    puts "#{method_name}(#{type})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    root = doc.root
    labels = Array.new
    root.elements.each("//#{type}"){|el| labels << el.attributes["label"] if (el.attributes["traits"] =~ /static_text/)}
    puts "#{method_name}: got #{labels.inspect}" if @@debug
    return labels
  end

  def get_all_labels_by_traits(traits)
    puts "#{method_name}(#{traits})" if @@debug
    refresh_screen
    doc = REXML::Document.new(screen.xml.to_s)
    root = doc.root
    labels = Array.new
    root.elements.each("//"){|el| labels << el.attributes["label"] if (el.attributes["traits"] =~ /#{traits}/)}
    puts "#{method_name}: got #{labels.inspect}" if @@debug
    return labels
  end

## does exists?

  def element_by_type_exists?(type, index = 0)
    puts "#{method_name}(#{type}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type(type)
    elements.length > index
  end

  def element_by_type_and_label_exists?(type, label, index = 0)
    puts "#{method_name}(#{type}, #{label}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_and_label(type, label)
    elements.length > index
  end

  def element_by_type_and_traits_exists?(type, traits, index = 0)
    puts "#{method_name}(#{type}, #{traits}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_and_traits(type, traits)
    elements.length > index
  end

  def element_by_type_label_and_traits_exists?(type, label, traits, index = 0)
    puts "#{method_name}(#{type}, #{label}, #{traits}, #{index})" if @@debug
    assert(index >= 0, "Wrong index: '#{index}'")
    elements = get_all_elements_by_type_label_and_traits(type, label, traits)
    elements.length > index
  end

  def text_exists?(text)
    puts "#{method_name}(#{text})" if @@debug
    refresh_screen
    screen.exists?(text)
  end

## wait for ... Even return element after wait time

  def wait_for_element_by_type(type, index = 0, timeout = @@timeout)
    puts "#{method_name}(#{type}, #{index}, #{timeout})" if @@debug
    refresh_screen
    start_time = Time.now
    until(element_by_type_exists?(type, index))  do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds\n")
      end
      refresh_screen
      sleep 0.1
    end
    get_element_by_type(type, index)
  end

  def wait_for_element_by_type_and_label(type, label, index = 0, timeout = @@timeout)
    puts "#{method_name}(#{type}, #{label}, #{index}, #{timeout})" if @@debug
    refresh_screen
    start_time = Time.now
    until(element_by_type_and_label_exists?(type, label, index))  do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds\n")
      end
      refresh_screen
      sleep 0.1
    end
    get_element_by_type_and_label(type, label, index)
  end

  def wait_for_element_by_type_and_traits(type, traits, index = 0, timeout = @@timeout)
    puts "#{method_name}(#{type}, #{traits}, #{index}, #{timeout})" if @@debug
    refresh_screen
    start_time = Time.now
    until(element_by_type_and_traits_exists?(type, traits, index))  do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds\n")
      end
      refresh_screen
      sleep 0.1
    end
    get_element_by_type_and_traits(type, traits, index)
  end

  def wait_for_element_by_type_label_and_traits(type, label, traits, index = 0, timeout = @@timeout)
    puts "#{method_name}(#{type}, #{label}, #{traits}, #{index}, #{timeout})" if @@debug
    refresh_screen
    start_time = Time.now
    until(element_by_type_label_and_traits_exists?(type, label, index))  do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds\n")
      end
      refresh_screen
      sleep 0.1
    end
    get_element_by_type_label_and_traits(type, label, traits, index)
  end

  def wait_for_text(text, timeout = @@timeout)
    puts "#{method_name}(#{text}, #{timeout})" if @@debug
    refresh_screen
    start_time = Time.now
    until(screen.exists?(text)) do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds")
      end
      sleep 0.1
      refresh_screen
    end
  end

  def wait_for_download_indicator_finish(indicator_type = "UIActivityIndicatorView", label="In progress", timeout = @@timeout)
    puts "#{method_name}(#{indicator_type}, #{label}, #{timeout})" if @@debug
    start_time = Time.now
    while(element_by_type_and_label_exists?(indicator_type, label)) do
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{@@timeout} seconds")
      end
      refresh_screen
      sleep 0.1
    end
  end

## getting element's position and taping

  def get_center_of_the_element(element)
    puts "#{method_name}" if @@debug
    assert(element != nil, "#{method_name}: Element is nil")
    doc = REXML::Document.new(element.to_s)
    frame = REXML::XPath.first(doc, '//frame')
    h = frame.attributes["height"].to_f
    w = frame.attributes["width"].to_f
    x = frame.attributes["x"].to_f + w/2
    y = frame.attributes["y"].to_f + h/2
    puts "#{method_name}: X=#{x.to_s} : Y=#{y.to_s}" if @@debug
    return x, y
  end

  def get_xy_of_the_element(element)
    puts "#{method_name}" if @@debug
    assert(element != nil, "#{method_name}: Element is nil")
    doc = REXML::Document.new(element.to_s)
    frame = REXML::XPath.first(doc, '//frame')
    x = frame.attributes["x"].to_f
    y = frame.attributes["y"].to_f
    puts "#{method_name}: X=#{x.to_s} : Y=#{y.to_s}" if @@debug
    return x, y
  end

  def tap_coordinates(x, y)
    puts "#{method_name}(#{x.to_s}, #{y.to_s}" if @@debug
    @simulator.fire_event(ICuke::Simulate::Gestures::Tap.new(x, y))
  end

  def double_tap_coordinates(x, y)
    puts "#{method_name}(#{x.to_s}, #{y.to_s}" if @@debug
    2.times {@simulator.fire_event(ICuke::Simulate::Gestures::Tap.new(x, y))}
  end

  def tap_element(element)
    puts "#{method_name}" if @@debug
    x, y = get_center_of_the_element(element)
    @simulator.fire_event(ICuke::Simulate::Gestures::Tap.new(x, y))
  end

  def double_tap_element(element)
    puts "#{method_name}" if @@debug
    x, y = get_center_of_the_element(element)
    2.times {@simulator.fire_event(ICuke::Simulate::Gestures::Tap.new(x, y))}
  end

  def tap_text(text)
    tap(text) # alias
  end

  def double_tap_text(text)
    2.times {tap(text)}
  end

## scrolling

  def scroll_to_text(direction, text, timeout = @@timeout)
    puts "#{method_name}: #{text} -> #{direction}" if @@debug
    refresh_screen
    start_time = Time.now
    scroll(direction.to_sym)
    until(screen.visible?(text))  do
      scroll(direction.to_sym)
      if Time.now - start_time > timeout
        flunk("#{method_name}: Timed out after #{timeout} seconds")
      end
      sleep 0.1
    end
  end

  def scroll_down_to_bottom
    puts "#{method_name}" if @@debug
    refresh_screen
    scr1 = screen.xml.to_s
    scroll("down".to_sym)
    while scr1 != screen.xml.to_s
      scr1 = screen.xml.to_s
      scroll("down".to_sym)
    end
  end

  def scroll_up_to_top
    puts "#{method_name}" if @@debug
    refresh_screen
    scr1 = screen.xml.to_s
    scroll("up".to_sym)
    while scr1 != screen.xml.to_s
      scr1 = screen.xml.to_s
      scroll("up".to_sym)
    end
  end

## kill processes, sometimes very useful to prevent Errno::ECONNREFUSED

  def kill_simulator
    puts "#{method_name}" if @@debug
    system("killall 'iPhone Simulator'")
    system("killall 'waxsim'") # even waxsim processes if any
  end

## pop up dialogs

  def alert_view_is_visible?
    puts "#{method_name}" if @@debug
    element_by_type_exists?("UIAlertView")
  end

  def return_alert_view_as_text()
    puts "#{method_name}" if @@debug
    if(alert_view_is_visible?)
      return get_element_by_type("UIAlertView").to_s
    else
      return ""
    end
  end

  def confirm_popup_dialog(button_label = "ok", timeout = @@timeout)
    puts "#{method_name}(#{button_label}, #{timeout}" if @@debug
    wait_for_text(button_label, timeout)
    button = get_element_by_type_and_label("UIThreePartButton", button_label)
    assert(button != nil, "Button is not found")
    tap_element(button)
  end

  def confirm_popup_dialog_if_present(button_label = "ok")
    puts "#{method_name}(#{button_label})" if @@debug
    found = false
    if element_by_type_label_and_traits_exists?("UIThreePartButton", button_label, "button ")
      button = get_element_by_type_label_and_traits("UIThreePartButton", button_label, "button ")
      tap_element(button)
      found = true
    end
    found
  end

## clipboard

  def write_to_mac_clipboard(text)
    puts "#{method_name}" if @@debug
    IO.popen('pbcopy', 'w+') {|clipboard| clipboard.write(text)}
  end

  def paste_clipboard_to_text_field(type = "UITextFieldLabel", label = "", index = 0)
    puts "#{method_name}(#{type}, #{label})" if @@debug
    IO.popen('pbpaste') {|clipboard| puts clipboard.read} if @@debug
    text_field = wait_for_element_by_type_and_label(type, label, index)
    assert(text_field != nil, "Text field is not found - type: #{type}, label: #{label}, index: #{index}")
    double_tap_element(text_field)
    #cmnd + v is needed here
    system("osascript -e 'tell application \"iPhone Simulator\"' -e 'activate' \
      -e 'tell application \"System Events\" to keystroke \"v\" using command down' -e 'end tell'")
    wait_for_text("Paste")
    tap("Paste")
  end

## simulator orientation

  def rotate_simulator_left
    system("osascript -e 'tell application \"iPhone Simulator\"' -e 'activate' \
      -e 'tell application \"System Events\" to key code 123 using command down' -e 'end tell'")
  end

  def rotate_simulator_right
    system("osascript -e 'tell application \"iPhone Simulator\"' -e 'activate' \
      -e 'tell application \"System Events\" to key code 124 using command down' -e 'end tell'")
  end

  ## refresh screen, should be used frequently

  def refresh_screen
    refresh
    screen
  end

  private

  def method_name
    /`(.*)'/.match(caller.first).captures[0].to_sym rescue nil
  end

  ##

  # supported options:
  # :type, :label, :value, :traits
  # usage: get_all_elements(:type => "UITabBarButton", :label => "MyButton")
  def get_all_elements(options = {})
    puts "#{method_name}(#{options.inspect})" if @@debug
    refresh_screen
    query = "//"
    if(options[:type])
     query += options[:type]
    end
    if(options[:label])
      query += "[@label=\"#{options[:label]}\"]"
    end
    if(options[:traits])
      query += "[@traits=\"#{options[:traits]}\"]"
    end
    if(options[:value])
     query += "[@value=\"#{options[:value]}\"]"
    end
    doc = REXML::Document.new(screen.xml.to_s)
    elements = REXML::XPath.match(doc, query)
    elements
  end

  # supported options:
  # :type, :label, :value, :traits, :index, :timeout
  # first index is 0
  # usage: wait_for_element(:type => "UITabBarButton", :label => "MyButton")
  def wait_for_element(options = {})
    puts "#{method_name}(#{options.inspect})" if @@debug
    index = 0
    if(options[:index])
      index = options[:index]
      assert(index >= 0, "Wrong index: '#{index}'")
    end
    if(options[:timeout])
      timeout = options[:timeout]
      options.delete(:timeout)
    else
      timeout = @@timeout
    end
    refresh_screen
    start_time = Time.now
    until(element_exists?(options))  do
      if Time.now - start_time > timeout
        flunk("Timed out after #{timeout} seconds\n")
      end
      refresh_screen
      sleep 0.1
    end
    get_all_elements(options)[index]
  end

  # supported options:
  # :type, :label, :value, :traits, :index
  # index is counted from 0
  # usage: wait_for_element(:type => "UITabBarButton", :label => "MyButton", :index => 1)
  def element_exists?(options = {})
    puts "#{method_name}(#{options.inspect})" if @@debug
    index = 0
    if(options[:index])
      index = options[:index]
      assert(index >= 0, "Wrong index: '#{index}'")
      options.delete(:index)
    end
    elements = get_all_elements(options)
    elements.length > index
  end

  # alias for wait_for_element(options = {})
  def get_element(options = {})
    puts "#{method_name}(#{options.inspect})" if @@debug
    wait_for_element(options)
  end

end
