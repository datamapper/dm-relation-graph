require 'backports'
require 'backports/basic_object' unless defined?(BasicObject)
require 'rubygems'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
    add_group "Relation", "lib/data_mapper/relation"
  end
end

if RUBY_VERSION < '1.9'
  class OpenStruct
    def id
      @table.fetch(:id) { super }
    end
  end
end

require 'pp'
require 'ostruct'
require 'dm-relation-graph'

require 'rspec'

%w(shared support).each do |name|
  Dir[File.expand_path("../#{name}/**/*.rb", __FILE__)].each { |file| require file }
end

RSpec.configure do |config|

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.include(SpecHelper)
end

include DataMapper
