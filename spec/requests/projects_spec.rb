require "rails_helper"

RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /projects" do
    it "renders index successfully" do
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Projects")
    end
  end

  describe "POST /projects" do
    it "creates project and redirects" do
      expect do
        post projects_path, params: { project: { name: "My Project" } }
      end.to change(Project, :count).by(1)

      expect(response).to redirect_to(projects_path)
      follow_redirect!
      expect(response.body).to include("Project was successfully created")
    end

    it "renders new on validation error" do
      post projects_path, params: { project: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /projects/:id" do
    it "updates project and redirects" do
      project = create(:project, creator: user)
      patch project_path(project), params: { project: { name: "Updated" } }
      expect(response).to redirect_to(projects_path)
      follow_redirect!
      expect(response.body).to include("successfully updated")
      expect(project.reload.name).to eq("Updated")
    end

    it "renders edit on validation error" do
      project = create(:project, creator: user)
      patch project_path(project), params: { project: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /projects/:id" do
    it "destroys project and redirects" do
      project = create(:project, creator: user)
      expect {
        delete project_path(project)
      }.to change(Project, :count).by(-1)
      expect(response).to redirect_to(projects_path)
    end
  end
end


