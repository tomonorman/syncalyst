class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :start]

  def index
    set_all_meetings
  end

  def show
    @agenda = Agenda.new
    @agenda.meeting = @meeting
    @task = Task.new
    @task.meeting = @meeting
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
      redirect_to meeting_path(@meeting)
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

  def set_all_meetings
    @user_host_meetings = policy_scope(current_user.meetings)
    @meetings_attending = current_user.attendances.map(&:meeting)
    @all_current_meetings =
      (@user_host_meetings + @meetings_attending)
      .select { |meeting| meeting.date_time > Date.today }
      .sort_by(&:date_time)
    @previous_meetings =
      (@user_host_meetings + @meetings_attending)
      .select { |meeting| meeting.date_time < Date.today }
      .sort_by(&:date_time)
    @next_meeting = @all_current_meetings.min_by(&:date_time)
  end
end
