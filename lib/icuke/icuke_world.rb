require 'nokogiri'

require 'icuke/sdk'
require 'icuke/simulator_driver'

module ICukeWorld
  def icuke_driver
    @icuke_driver ||= ICuke::SimulatorDriver.default_driver(icuke_configuration)
  end
  
  def icuke_configuration
    @icuke_configuration ||= ICuke::Configuration.new({
      :build_configuration => 'Debug'
    })
  end
end

After do
  #icuke_driver.quit
end
include ICukeWorld

Given /^(?:"([^\"]*)" from )?"([^\"]*)"(?: with build configuration "([^\"]*)")? is loaded in the (?:(retina|non-retina) )?(?:(iphone|ipad) )?simulator(?: with SDK ([0-9.]+))?$/ do |target, project, configuration, retina, platform, sdk_version|
  if sdk_version
    ICuke::SDK.use(sdk_version)
  elsif platform
    ICuke::SDK.use_latest(platform.downcase.to_sym)
  else
    ICuke::SDK.use_latest
  end
  attrs = { :target => target,
            :platform => platform,
            :env => {
              'DYLD_INSERT_LIBRARIES' => ICuke::SDK.dylib_fullpath
            }
          }
  attrs.merge!(:retina => !(retina =~ /non/)) if retina
  attrs.merge!(:build_configuration => configuration) if configuration
  icuke_driver.launch(File.expand_path(project), attrs)
end

Given /^the module "([^\"]*)" is loaded in the simulator$/ do |path|
  path.sub!(/#{File.basename(path)}$/, ICuke::SDK.dylib(File.basename(path)))
  simulator.load_module(File.expand_path(path))
end

Then /^I should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, scope|
  raise %Q{Content "#{text}" not found in: #{icuke_driver.screen.xml}} unless icuke_driver.screen.visible?(text, scope)
end

Then /^I should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, scope|
  raise %Q{Content "#{text}" was found but was not expected in: #{icuke_driver.screen.xml}} if icuke_driver.screen.visible?(text, scope)
end

When /^I tap "([^\"]*)"$/ do |label|
  icuke_driver.tap(label)
end

When /^I tap (\d+),(\d+)$/ do |x,y|
  icuke_driver.tap_at_point(x.to_i, y.to_i)
end

When /^I type "([^\"]*)" in "([^\"]*)"$/ do |text, textfield|
  options = {:return => true}
  icuke_driver.type(textfield, text, options)
end

When /^I type "([^"]*)" in "([^"]*)" without return$/ do |text, textfield|
  options = {:return => false}
  icuke_driver.type(textfield, text, options)
end

When /^I drag from (.*) to (.*)$/ do |source, destination|
  hold_for = 0.15
  icuke_driver.drag_with_source(source, destination, hold_for)
end

When /^I touch (.*) for (.*) seconds then drag to (.*)$/ do |source, hold_for, destination| 
  icuke_driver.drag_with_source(source, destination, hold_for)
end

Then /^the "([^"]*)" picker should be set to "([^"]*)"$/ do |picker, target_value|
   actual_value = icuke_driver.get_picker_value(picker)
   raise %Q{#{picker} contains #{actual_value}. Expecting #{target_value}} if actual_value != target_value
 end
  
When /^I choose "([^"]*)" in the "([^"]*)" picker$/ do |value, picker|
  icuke_driver.choose_value_in_picker(value, picker)
end
 
When /^I choose "([^"]*)" in the "([^"]*)" picker by moving the picker (up|down)$/ do |value, label, direction|
  icuke_driver.drag_picker_to_value(label, direction.to_sym, value)
end

When /^I select the "(.*)" slider and drag (.*) pixels (down|up|left|right)$/ do |label, distance, direction|
  icuke_driver.drag_slider_to(label, direction.to_sym, distance.to_i)
end

When /^I move the "([^\"]*)" slider to (.*) percent$/ do |label, percent|
  icuke_driver.drag_slider_to_percentage(label, percent.to_i)
end

When /^I scroll (down|up|left|right)(?: to "([^\"]*)")?$/ do |direction, text|
  if text
    icuke_driver.scroll_to(text, :direction => direction.to_sym)
  else
    icuke_driver.scroll(direction.to_sym)
  end
end

When /^I suspend the application/ do
  icuke_driver.suspend
end

When /^I resume the application/ do
  icuke_driver.resume
end

Then /^I put the phone into recording mode$/ do
  icuke_driver.record
end

Then /^show me the screen$/ do
  puts icuke_driver.screen.xml.to_s
end
