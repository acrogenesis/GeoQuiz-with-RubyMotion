# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'GeoQuiz'
  app.api_version = '19'
  app.package = 'com.acrogenesis.geoquiz'
  app.main_activity = 'QuizActivity'
  app.sub_activities = ['CheatActivity']
  app.theme = '@android:style/Theme.Holo.Light'
end
