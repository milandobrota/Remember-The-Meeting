# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "remember_the_meeting/version"

Gem::Specification.new do |s|
  s.name        = "remember_the_meeting"
  s.version     = RememberTheMeeting::VERSION
  s.authors     = ["Milan Dobrota"]
  s.email       = ["milan@milandobrota.com"]
  s.homepage    = ""
  s.summary     = %q{Gem that integrates against Exchange server and notifies you 15 minutes before meetings.}
  s.description = %q{Gem that integrates against Exchange server and notifies you 15 minutes before meetings. Linux and OSX. }

  s.rubyforge_project = "remember_the_meeting"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'handsoap'
  s.add_runtime_dependency 'httpclient'
  s.add_runtime_dependency 'rubyntlm'
  s.add_runtime_dependency 'icalendar'
  s.add_runtime_dependency 'viewpoint'
end
