# frozen_string_literal: true
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.warning = true
  t.description = 'Run "Page" tests'
  t.test_files = FileList['test/*_test.rb']
  t.libs << 't'
end
