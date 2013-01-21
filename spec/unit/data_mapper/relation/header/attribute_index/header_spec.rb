require 'spec_helper'

describe Relation::Header::AttributeIndex, '#header' do
  subject { described_class.new(entries, strategy_class) }

  let(:entries)        { { initial => current } }
  let(:initial)        { attribute_alias(:initial_id, :users) }
  let(:current)        { attribute_alias(:current_id, :users) }
  let(:strategy_class) { mock }

  its(:header) { should eql(Set[current]) }
end
