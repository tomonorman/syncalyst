class TasksController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    authorize @meeting
    @task = Task.new(task_params)
    authorize @task
    @task.meeting = @meeting
    @task.user = current_user
    if @task.save
      redirect_to meeting_path(@meeting)
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :meeting,:user)
  end
end
