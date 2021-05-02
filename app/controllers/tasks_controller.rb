class TasksController < ApplicationController
    # Controller Code
    swagger_controller :tasks, "Tasks Management"

    swagger_api :index do
        summary "Fetches all Tasks"
        notes "This lists all the tasks"
    end

    swagger_api :show do
        summary "Shows one Task"
        param :path, :id, :integer, :required, "Task ID"
        notes "This lists details of one task"
        response :not_found
    end

    swagger_api :create do
        summary "Creates a new Task"
        param :form, :name, :string, :required, "Name"
        param :form, :points, :integer, :required, "Points"
        param :form, :active, :boolean, :required, "Active"
        response :not_acceptable
    end

    swagger_api :update do
        summary "Updates an existing Task"
        param :path, :id, :integer, :required, "Task Id"
        param :form, :name, :string, :optional, "Name"
        param :form, :points, :integer, :optional, "Points"
        param :form, :active, :boolean, :optional, "Active"
        response :not_found
        response :not_acceptable
    end

    swagger_api :destroy do
        summary "Deletes an existing Task"
        param :path, :id, :integer, :required, "Task Id"
        response :not_found
    end
  
    before_action :set_task, only: [:show, :update, :destroy]
  
    # GET /tasks
    def index
      @tasks = Task.all
  
      render json: TaskSerializer.new(@tasks)
    end
  
    # GET /task/1
    def show
      render json: TaskSerializer.new(@task)
    end
  
    # POST /tasks
    def create
      @task = Task.new(task_params)
  
      if @task.save
        render json: TaskSerializer.new(@task), status: :created, location: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /tasks/1
    def update
      if @task.update(task_params)
        render json: TaskSerializer.new(@task)
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /tasks/1
    def destroy
      @task.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def task_params
        params.permit(:name, :points, :active)
      end
  end