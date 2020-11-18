class MeetingsController < ApplicationController
  def index
    @meetings = policy_scope(current_user.meetings)
  end

  def new
    @meeting = Meeting.new
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    authorize @meeting
    if @meeting.save
      redirect_to meetings_path
      # redirect_to meeting_path(@meeting)
    else
      render 'new'
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date_time, :description, :trello_board, :title, :duration)
  end

  def set_meeting
    @meeting = Meeting.new(params[:id])
    authorize @meeting
  end

  def show
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end
end
