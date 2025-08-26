require "rails_helper"

RSpec.describe Project, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:creator).class_name("User").optional }
    it { is_expected.to have_many(:issues).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "dependent destroys" do
    it "destroys issues when project is destroyed" do
      project = create(:project)
      create_list(:issue, 2, project: project)
      expect { project.destroy }.to change { Issue.count }.by(-2)
    end
  end
end


