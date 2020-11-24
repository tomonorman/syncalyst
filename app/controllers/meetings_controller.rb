class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :summary, :report, :start, :finish]

  def index
    set_all_meetings
  end

  def show
    @agenda = Agenda.new
    @agenda.meeting = @meeting
    @task = Task.new
    @task.meeting = @meeting
  end

  def summary
  end

  def report
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@meeting.date_time.strftime('%Y%m%d')}_#{@meeting.title}_#{@meeting.user.nickname}",
          # Excluding ".pdf" extension
          page_size: 'A4',
          template: "meetings/report.html.erb",
          layout: "pdf.html",
          lowquality: true,
          zoom: 1,
          dpi: 75,
        footer: {
          font_size: 6,
          line: true,
        right: 'This is an automatically generated file from Syncalyst'}
      end
    end
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

  def finish
    @meeting.finish = true
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
      .select { |meeting| meeting.date_time > DateTime.now }
      .select { |meeting| meeting.start == false }
      .sort_by(&:date_time)
    @all_upcoming_meetings = @all_current_meetings.slice(1..@all_current_meetings.length)
    @previous_meetings =
      (@user_host_meetings + @meetings_attending)
      .select { |meeting| meeting.finish == true }
      .sort_by(&:date_time)
      .reverse
    @next_meeting = @all_current_meetings.select { |meeting| meeting.start == false }.min_by(&:date_time)
  end
end
