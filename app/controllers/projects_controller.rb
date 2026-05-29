class ProjectsController < ApplicationController
def create
  @project = Project.new 
  @project.name = params[:name]  
end
