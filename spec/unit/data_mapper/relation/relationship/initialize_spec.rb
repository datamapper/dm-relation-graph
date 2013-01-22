require 'spec_helper'

describe Relation::Relationship, '#initialize' do
  subject { object.new(:group, user_model, group_model) }

  let(:user_model)  { mock_model('User') }
  let(:group_model) { mock_model('Group') }

  it_should_behave_like 'an abstract type'
end
