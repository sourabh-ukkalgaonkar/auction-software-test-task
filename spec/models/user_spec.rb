# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:password) { Faker::Internet.password }
  let(:user) { create(:user, password: password) }

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should allow_value(Faker::Internet.email).for(:email) }
    it { should_not allow_value(Faker::Name.name).for(:email) }
  end

  context 'Associations' do 
    it { should have_many(:projects) }
  end

  context 'Instance Methods' do
    describe 'authenticate?' do
      it 'should authenticate user' do
        expect(user.authenticate?(password)).to be_truthy
      end

      it 'should not authenticate user' do
        expect(user.authenticate?(Faker::Internet.password)).to be_falsey
      end
    end
  end
end
