require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, creator: user) }
  let(:issue) { create(:issue, project: project) }

  before do
    sign_in user
  end

  describe "POST /projects/:project_id/issues/:issue_id/comments" do
    it "creates comment and redirects back to issue edit" do
      expect {
        post project_issue_comments_path(project, issue), params: { comment: { content: "Nice" } }
      }.to change(issue.comments, :count).by(1)
      expect(response).to redirect_to(edit_project_issue_path(project, issue))
      follow_redirect!
      expect(response.body).to include("Comment added")
    end

    it "re-renders issue edit with errors on invalid" do
      post project_issue_comments_path(project, issue), params: { comment: { content: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Comments")
      expect(response.body).to include("can&#39;t be blank")
    end
  end
end


