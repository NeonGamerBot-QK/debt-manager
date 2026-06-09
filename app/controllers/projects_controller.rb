class ProjectsController < ApplicationController
def new
  @project = Project.new
end

def create
  @project = Project.new 
  @project.name = params[:name]
  # @project.description = params[:description]
  @project.hackatime_projects = params[:hackatime_projects].to_s.split(",").map(&:strip).reject(&:empty?)
  @project.user = current_user
  if @project.save
    redirect_to dash_path, notice: "Project created successfully"
  else
    redirect_to dash_path, alert: "Failed to create project: #{@project.errors.full_messages.join(", ")}"
  end
end
def show 
  @project = Project.find(params[:id])
  # @hours_needed = HackatimeService.new.calculate_hours_needed(@project.hackatime_projects)
end

end
