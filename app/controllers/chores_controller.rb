class ChoresController < ApplicationController
    # Controller Code
    swagger_controller :chores, "Chores Management"

    swagger_api :index do
        summary "Fetches all Chores"
        notes "This lists all the chores"
    end

    swagger_api :show do
        summary "Shows one Chore"
        param :path, :id, :integer, :required, "Chore ID"
        notes "This lists details of one chore"
        response :not_found
    end

    swagger_api :create do
        summary "Creates a new Chore"
        param :form, :child_id, :integer, :required, "Child"
        param :form, :task_id, :integer, :required, "Task"
        param :form, :due_on, :date, :required, "Due_on"
        param :form, :completed, :boolean, :required, "Completed"
        response :not_acceptable
    end

    swagger_api :update do
        summary "Updates an existing Chore"
        param :path, :id, :integer, :required, "Chore Id"
        param :form, :child_id, :integer, :optional, "Child"
        param :form, :task_id, :integer, :optional, "Task"
        param :form, :due_on, :date, :optional, "Due_on"
        param :form, :completed, :boolean, :optional, "Completed"
        response :not_found
        response :not_acceptable
    end

    swagger_api :destroy do
        summary "Deletes an existing Chore"
        param :path, :id, :integer, :required, "Chore Id"
        response :not_found
    end
  
    before_action :set_chore, only: [:show, :update, :destroy]
  
    # GET /tasks
    def index
      @chores = Chore.all
  
      render json: ChoreSerializer.new(@chores)
    end
  
    # GET /chore/1
    def show
      render json: ChoreSerializer.new(@chore)
    end
  
    # POST /chores
    def create
      @chore = Chore.new(chore_params)
  
      if @chore.save
        render json: ChoreSerializer.new(@chore), status: :created, location: @chore
      else
        render json: @chore.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /chores/1
    def update
      if @chore.update(chore_params)
        render json: ChoreSerializer.new(@chore)
      else
        render json: @chore.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /chores/1
    def destroy
      @chore.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chore
        @chore = Chore.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def chore_params
        params.permit(:child_id, :task_id, :due_on, :completed)
      end
  end