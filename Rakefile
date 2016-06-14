################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'bundler'
require 'bundler/gem_tasks'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: :spec
spec_pattern = 'spec/**/*_spec.rb'
def_spec_options = '--color '
def_int_spec_options = '-f d --color '

desc 'Run unit tests only'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = spec_pattern
  spec.rspec_opts = def_spec_options
  spec.rspec_opts << ' --tag ~integration'
  spec.rspec_opts << ' --tag ~system'
end

desc 'Run integration tests only'
RSpec::Core::RakeTask.new('spec:integration') do |spec|
  spec.pattern = spec_pattern
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag integration'
end

desc 'Run integration creation tests only'
RSpec::Core::RakeTask.new('spec:integration:create') do |spec|
  spec.pattern = 'spec/**/*create_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag integration'
end

desc 'Run integration update tests only'
RSpec::Core::RakeTask.new('spec:integration:update') do |spec|
  spec.pattern = 'spec/**/*update_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag integration'
end

desc 'Run integration deletion tests only'
RSpec::Core::RakeTask.new('spec:integration:delete') do |spec|
  spec.pattern = 'spec/**/*delete_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag integration'
end

desc 'Run System tests'
RSpec::Core::RakeTask.new('spec:system') do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag system'
end

desc 'Run System tests Light Profile'
RSpec::Core::RakeTask.new('spec:system:light') do |spec|
  spec.pattern = 'spec/system/light_profile/*_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag system'
end

desc 'Run System tests Medium Profile'
RSpec::Core::RakeTask.new('spec:system:medium') do |spec|
  spec.pattern = 'spec/system/medium_profile/*_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag system'
end

desc 'Run System tests Heavy Profile'
RSpec::Core::RakeTask.new('spec:system:heavy') do |spec|
  spec.pattern = 'spec/system/heavy_profile/*_spec.rb'
  spec.rspec_opts = def_int_spec_options
  spec.rspec_opts << ' --tag system'
end

RuboCop::RakeTask.new

desc 'Runs rubocop and unit tests'
task :test do
  Rake::Task[:rubocop].invoke
  Rake::Task[:spec].invoke
end

desc 'Run rubocop, unit & integration tests'
task 'test:all' do
  Rake::Task[:rubocop].invoke
  Rake::Task[:spec].invoke
  Rake::Task['spec:integration'].invoke
  Rake::Task['spec:system'].invoke
end
