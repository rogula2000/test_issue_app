require "rails_helper"

RSpec.describe Issue, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:assignee_name) }
  end

  it "has default status active" do
    issue = build(:issue)
    expect(issue.status).to eq("active")
  end
end


