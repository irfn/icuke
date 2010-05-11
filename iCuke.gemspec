# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{iCuke}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Holland"]
  s.date = %q{2010-05-11}
  s.description = %q{Cucumber support for iPhone applications}
  s.email = %q{rob@the-it-refinery.co.uk}
  s.extensions = ["ext/iCuke/Rakefile"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/.gitignore",
     "app/AlertsViewController.h",
     "app/AlertsViewController.m",
     "app/AppDelegate.h",
     "app/AppDelegate.m",
     "app/ButtonsViewController.h",
     "app/ButtonsViewController.m",
     "app/Constants.h",
     "app/ControlsViewController.h",
     "app/ControlsViewController.m",
     "app/ImagesViewController.h",
     "app/ImagesViewController.m",
     "app/Info.plist",
     "app/MainViewController.h",
     "app/MainViewController.m",
     "app/Picker/CustomPickerDataSource.h",
     "app/Picker/CustomPickerDataSource.m",
     "app/Picker/CustomView.h",
     "app/Picker/CustomView.m",
     "app/PickerViewController.h",
     "app/PickerViewController.m",
     "app/Prefix.pch",
     "app/ReadMe.txt",
     "app/SearchBarController.h",
     "app/SearchBarController.m",
     "app/SegmentViewController.h",
     "app/SegmentViewController.m",
     "app/TextFieldController.h",
     "app/TextFieldController.m",
     "app/TextViewController.h",
     "app/TextViewController.m",
     "app/ToolbarViewController.h",
     "app/ToolbarViewController.m",
     "app/TransitionViewController.h",
     "app/TransitionViewController.m",
     "app/UICatalog.xcodeproj/project.pbxproj",
     "app/WebViewController.h",
     "app/WebViewController.m",
     "app/en.lproj/AlertsViewController.xib",
     "app/en.lproj/ButtonsViewController.xib",
     "app/en.lproj/ControlsViewController.xib",
     "app/en.lproj/ImagesViewController.xib",
     "app/en.lproj/Localizable.strings",
     "app/en.lproj/MainWindow.xib",
     "app/en.lproj/PickerViewController.xib",
     "app/en.lproj/SearchBarController.xib",
     "app/en.lproj/SegmentViewController.xib",
     "app/en.lproj/TextFieldController.xib",
     "app/en.lproj/TextViewController.xib",
     "app/en.lproj/ToolbarViewController.xib",
     "app/en.lproj/TransitionViewController.xib",
     "app/en.lproj/WebViewController.xib",
     "app/images/12-6AM.png",
     "app/images/12-6PM.png",
     "app/images/6-12AM.png",
     "app/images/6-12PM.png",
     "app/images/Default.png",
     "app/images/Icon.png",
     "app/images/UIButton_custom.png",
     "app/images/blueButton.png",
     "app/images/orangeslide.png",
     "app/images/scene1.jpg",
     "app/images/scene2.jpg",
     "app/images/scene3.jpg",
     "app/images/scene4.jpg",
     "app/images/scene5.jpg",
     "app/images/segment_check.png",
     "app/images/segment_search.png",
     "app/images/segment_tools.png",
     "app/images/slider_ball.png",
     "app/images/whiteButton.png",
     "app/images/yellowslide.png",
     "app/main.m",
     "ext/iCuke/.gitignore",
     "ext/iCuke/DefaultsResponse.h",
     "ext/iCuke/DefaultsResponse.m",
     "ext/iCuke/EventResponse.h",
     "ext/iCuke/EventResponse.m",
     "ext/iCuke/Rakefile",
     "ext/iCuke/Recorder.h",
     "ext/iCuke/Recorder.m",
     "ext/iCuke/RecorderResponse.h",
     "ext/iCuke/RecorderResponse.m",
     "ext/iCuke/SynthesizeSingleton.h",
     "ext/iCuke/ViewResponse.h",
     "ext/iCuke/ViewResponse.m",
     "ext/iCuke/Viewer.h",
     "ext/iCuke/Viewer.m",
     "ext/iCuke/iCukeHTTPResponseHandler.h",
     "ext/iCuke/iCukeHTTPResponseHandler.m",
     "ext/iCuke/iCukeHTTPServer.h",
     "ext/iCuke/iCukeHTTPServer.m",
     "ext/iCuke/iCukeServer.h",
     "ext/iCuke/iCukeServer.m",
     "ext/iCuke/json/JSON.h",
     "ext/iCuke/json/NSObject+SBJSON.h",
     "ext/iCuke/json/NSObject+SBJSON.m",
     "ext/iCuke/json/NSString+SBJSON.h",
     "ext/iCuke/json/NSString+SBJSON.m",
     "ext/iCuke/json/SBJSON.h",
     "ext/iCuke/json/SBJSON.m",
     "ext/iCuke/json/SBJsonBase.h",
     "ext/iCuke/json/SBJsonBase.m",
     "ext/iCuke/json/SBJsonParser.h",
     "ext/iCuke/json/SBJsonParser.m",
     "ext/iCuke/json/SBJsonWriter.h",
     "ext/iCuke/json/SBJsonWriter.m",
     "ext/iCuke/libicuke.dylib",
     "features/support/env.rb",
     "features/uicatalog.feature",
     "iCuke.gemspec",
     "lib/icuke.rb",
     "lib/icuke/com.apple.Accessibility.plist",
     "lib/icuke/core_ext.rb",
     "lib/icuke/cucumber.rb",
     "lib/icuke/headless.rb",
     "lib/icuke/simulate.rb",
     "lib/icuke/simulator.rb",
     "lib/icuke/xcode.rb"
  ]
  s.homepage = %q{http://github.com/unboxed/iCuke}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Cucumber support for iPhone applications}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<rb-appscript>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rb-appscript>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rb-appscript>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

