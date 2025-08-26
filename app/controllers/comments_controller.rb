class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_issue

  layout 'signed_in'

  def create
    @comment = @issue.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      redirect_to edit_project_issue_path(@project, @issue), notice: "Comment added."
    else
      # Re-render the edit view with errors displayed near the form
      @comments = @issue.comments.order(created_at: :asc)
      @new_comment = @comment
      render 'issues/edit', status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_issue
    @issue = @project.issues.find(params[:issue_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end


