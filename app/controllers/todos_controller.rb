class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :authenticate_admin , except: [:index, :update_status]
  before_action :authenticate_developer, only: [:index, :update_status] 

  # GET /todos
  # GET /todos.json
  def index
    @todos = current_user.todos.group_by{|g| g.project.name}
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @project = Project.find_by_id(params[:project_id])
    @todo = @project.todos.new
  end

  # GET /todos/1/edit
  def edit
    @project = @todo.project
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.save
    redirect_to @todo.project, notice: "Created Successfully"
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo.project, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to @todo.project, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_status
    @todo.status = params[:status]
    @todo.save
    render json: {status: @todo.status}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    params.require(:todo).permit(:description, :developer_id, :project_id)
  end

  def authenticate_developer
    return if current_user.type == 'Developer'
    redirect_to root_path, notice: "Only developer can access this page"
  end

end