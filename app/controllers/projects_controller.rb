class ProjectsController < ApplicationController
def create
  @project = Project.new 
  @project.name = params[:name]  
  @project.description = params[:description]
  @project.user = current_user
  if @project.save
    redirect_to dash_path, notice: "Project created successfully"
  else
    redirect_to dash_path, alert: "Failed to create project: #{@project.errors.full_messages.join(", ")}"
end

end
