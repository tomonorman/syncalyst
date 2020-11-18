class MeetingsController < ApplicationController
  def index
    @user_host_meetings = policy_scope(current_user.meetings)
    @meetings_attending = current_user.attendances.map(&:meeting)
    @next_meeting = (@user_host_meetings + @meetings_attending).min_by(&:date_time)
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

  def show
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date_time, :description, :trello_board, :title, :duration)
  end

  def set_meeting
    @meeting = Meeting.new(params[:id])
    authorize @meeting
  end

end
