require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:issue) }
    it { is_expected.to belong_to(:creator).class_name("User").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end
end


