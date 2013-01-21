require 'spec_helper'

describe Relationship, '#through' do
  subject { object.through }

  let(:object)       { subclass.new(name, source_model, target_model, options) }
  let(:name)         { :songs }
  let(:source_model) { mock('source_model') }
  let(:target_model) { mock('target_model') }

  context 'when :through is not present in options' do
    let(:options) { {} }

    it { should be(nil) }
  end

  context 'when :through is present in options' do
    let(:options) { { :through => through } }
    let(:through) { :song_tags }

    it { should be(through) }
  end
end
