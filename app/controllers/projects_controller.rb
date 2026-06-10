class ProjectsController < ApplicationController
  def new
    @project = Project.new
    @users = User.all
    @ysws_programs = fetch_ysws_programs
  end

  def create
    @project = Project.new
    @project.name = params.dig(:project, :name)
    @project.hackatime_projects = params[:hackatime_projects].to_s.split(",").map(&:strip).reject(&:empty?)
    @project.user = current_user

    if @project.save
      Array(params[:debts]).each do |debt_params|
        next if debt_params[:amount].blank? || debt_params[:owing_id].blank? || debt_params[:ysws_program].blank?

        @project.debts.create!(
          owing_id: debt_params[:owing_id],
          ysws_program: debt_params[:ysws_program],
          amount: debt_params[:amount].to_f
        )
      end
      redirect_to dash_path, notice: "Project created successfully"
    else
      redirect_to dash_path, alert: "Failed to create project: #{@project.errors.full_messages.join(", ")}"
    end
  end

  def show
    @project = Project.find(params[:id])
    @hours_needed = (HackatimeService.new(@project.user.slack_id).calculate_hours_needed(@project.hackatime_projects) / 60).round(2)
  end

  private

  def fetch_ysws_programs
    response = Faraday.get("https://ysws.hackclub.com/feed.xml")
    return [] unless response.success?

    doc = Nokogiri::XML(response.body)
    doc.xpath("//item").map { |item| item.at_xpath("title")&.text }.compact
  rescue StandardError
    []
  end
end
