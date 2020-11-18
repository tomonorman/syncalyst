class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :start]

  def index
    @meetings = policy_scope(current_user.meetings)
  end

  def show
    @agenda = Agenda.new
    @agenda.meeting = @meeting
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

  def start
    @meeting.start = true
    @meeting.save
    redirect_to meeting_path(@meeting)
  end

  private

  def meeting_params
    params.require(:meeting).permit(:date_time, :description, :trello_board, :title, :duration, :start, :finish)
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end
end
