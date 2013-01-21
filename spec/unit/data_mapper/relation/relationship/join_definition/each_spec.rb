require 'spec_helper'

describe Relationship::JoinDefinition, '#each' do
  let(:object) { described_class.new(left, right) }

  let(:left)           { described_class::Side.new(left_relation, left_keys) }
  let(:left_relation)  { mock('left', :name => :songs) }
  let(:left_keys)      { [ :id, :title ] }

  let(:right)          { described_class::Side.new(right_relation, right_keys) }
  let(:right_relation) { mock('right', :name => :song_tags) }
  let(:right_keys)     { [ :song_id, :tag_id ] }

  context "with a block" do
    subject { object.each { |left, right| yields[left] = right } }

    let(:yields) { {} }

    before do
      object.should be_instance_of(described_class)
    end

    it_should_behave_like 'an #each method'

    it 'yields each mapping' do
      expect { subject }.to change { yields.dup }.from({}).to(object.to_hash)
    end
  end
end

describe Relationship::JoinDefinition do
  subject { described_class.new(left, right) }

  let(:object) { described_class }

  let(:left)           { described_class::Side.new(left_relation, left_keys) }
  let(:left_relation)  { mock('left', :name => :songs) }
  let(:left_keys)      { [ :id, :title ] }

  let(:right)          { described_class::Side.new(right_relation, right_keys) }
  let(:right_relation) { mock('right', :name => :song_tags) }
  let(:right_keys)     { [ :song_id, :tag_id ] }


  before do
    subject.should be_instance_of(object)
  end

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
