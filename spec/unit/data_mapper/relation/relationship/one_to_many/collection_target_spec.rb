require 'spec_helper'

describe Relationship::OneToMany, "#collection_target?" do
  subject { object.collection_target? }

  let(:object)       { described_class.new(:name, source_model, target_model) }
  let(:source_model) { mock('source_model', :name => 'User') }
  let(:target_model) { mock('target_model', :name => 'Address') }

  it { should be(true) }
end
