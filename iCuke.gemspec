# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{iCuke}
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Holland"]
  s.date = %q{2010-04-22}
  s.description = %q{Cucumber support for iPhone applications}
  s.email = %q{rob@the-it-refinery.co.uk}
  s.extensions = ["ext/iCuke/Rakefile"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/iCuke/.gitignore",
     "app/iCuke/Classes/FlipsideView.h",
     "app/iCuke/Classes/FlipsideView.m",
     "app/iCuke/Classes/FlipsideViewController.h",
     "app/iCuke/Classes/FlipsideViewController.m",
     "app/iCuke/Classes/MainView.h",
     "app/iCuke/Classes/MainView.m",
     "app/iCuke/Classes/MainViewController.h",
     "app/iCuke/Classes/MainViewController.m",
     "app/iCuke/Classes/iCukeAppDelegate.h",
     "app/iCuke/Classes/iCukeAppDelegate.m",
     "app/iCuke/FlipsideView.xib",
     "app/iCuke/MainView.xib",
     "app/iCuke/MainWindow.xib",
     "app/iCuke/SniffingView.h",
     "app/iCuke/SniffingView.m",
     "app/iCuke/iCuke-Info.plist",
     "app/iCuke/iCuke.xcodeproj/project.pbxproj",
     "app/iCuke/iCuke_Prefix.pch",
     "app/iCuke/main.m",
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
     "features/icuke.feature",
     "features/support/env.rb",
     "iCuke.gemspec",
     "lib/icuke.rb",
     "lib/icuke/core_ext.rb",
     "lib/icuke/cucumber.rb",
     "lib/icuke/simulate.rb",
     "lib/icuke/simulator.rb"
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

