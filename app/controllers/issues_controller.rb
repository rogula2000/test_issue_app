class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_issue, only: [:edit, :update, :destroy]

  layout 'signed_in'

  def index
    @issues = @project.issues.order(created_at: :asc)
  end

  def new
    @issue = @project.issues.new
  end

  def create
    @issue = @project.issues.new(issue_params)
    if @issue.save
      redirect_to project_issues_path(@project), notice: "Issue was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @comments = @issue.comments.order(created_at: :asc)
    @new_comment = @issue.comments.new
  end

  def update
    if @issue.update(issue_params)
      redirect_to project_issues_path(@project), notice: "Issue was successfully updated."
    else
      @comments = @issue.comments.order(created_at: :asc)
      @new_comment = @issue.comments.new
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @issue.destroy
    redirect_to project_issues_path(@project), notice: "Issue was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_issue
    @issue = @project.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :assignee_name, :status)
  end
end


