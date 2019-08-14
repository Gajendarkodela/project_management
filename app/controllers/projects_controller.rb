class ProjectsController < ApplicationController
	before_action :authenticate_admin
	before_action :set_project, except: [:index, :new, :create]
	def index
		@projects = current_user.projects.eager_load(:todos, :developers)
	end

	def show
		@developers = Developer.all.select(:id, :name)
		@assigned_developers = @project.developer_ids
	end

	def new
		@project = Project.new
	end

	def create
		@project = current_user.projects.new(project_params)
		@projects = current_user.projects
		@project.save
	end

	def edit
	end

	def update
		if @project.update(project_params)
			@projects = current_user.projects
		end
	end

	def graph
		todos = @project.todos
		render json: {
			new: todos.select{|t| t.status == Todo::Status::NEW}.count,
			in_progress: todos.select{|t| t.status == Todo::Status::INPROGRESS}.count,
			done: todos.select{|t| t.status == Todo::Status::DONE}.count
		}
	end

	def assign_devs
		@project.developers = Developer.where(id: params[:developer_ids])
		render json: {message: 'Assigned Successfully'}
    end

	private
	def set_project
		@project = current_user.projects.find(params[:id])
	end

	def project_params
		params.require(:project).permit(:name)
	end

end