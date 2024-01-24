require 'rails_helper'

RSpec.describe Project, type: :model do
  context "Validations" do
    it { should validate_presence_of(:title) }
  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category).optional }
  end
end
