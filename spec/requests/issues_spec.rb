require "rails_helper"

RSpec.describe "Issues", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, creator: user) }

  before do
    sign_in user
  end

  describe "GET /projects/:project_id/issues" do
    it "renders index successfully" do
      get project_issues_path(project)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(project.name)
    end
  end

  describe "POST /projects/:project_id/issues" do
    it "creates issue and redirects" do
      params = { issue: { title: "Bug", description: "Something broke", assignee_name: "Alex", status: "active" } }
      expect {
        post project_issues_path(project), params: params
      }.to change(project.issues, :count).by(1)
      expect(response).to redirect_to(project_issues_path(project))
      follow_redirect!
      expect(response.body).to include("successfully created")
    end

    it "renders new on validation error" do
      post project_issues_path(project), params: { issue: { title: "", description: "", assignee_name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /projects/:project_id/issues/:id" do
    it "updates issue and redirects" do
      issue = create(:issue, project: project)
      patch project_issue_path(project, issue), params: { issue: { title: "New" } }
      expect(response).to redirect_to(project_issues_path(project))
      follow_redirect!
      expect(response.body).to include("successfully updated")
      expect(issue.reload.title).to eq("New")
    end

    it "renders edit on validation error" do
      issue = create(:issue, project: project)
      patch project_issue_path(project, issue), params: { issue: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Edit issue")
      expect(response.body).to include("Title")
    end
  end

  describe "DELETE /projects/:project_id/issues/:id" do
    it "destroys issue and redirects" do
      issue = create(:issue, project: project)
      expect {
        delete project_issue_path(project, issue)
      }.to change(project.issues, :count).by(-1)
      expect(response).to redirect_to(project_issues_path(project))
    end
  end
end


