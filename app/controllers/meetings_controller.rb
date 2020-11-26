require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :summary, :report, :start, :finish]
  TIME_ZONE = "Asia/Tokyo"


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
      client = get_google_calendar_client(current_user)
      @test = client.list_events('primary')
      event = get_event(@meeting,client)
      # event = Google::Apis::CalendarV3::Event.new(event)
      # client.insert_event('primary', event)
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
    all_current_meetings =
      (@user_host_meetings + @meetings_attending)
    .select { |meeting| meeting.date_time >= Time.now.utc + 9.hours }
    .select { |meeting| meeting.start == false }
    .sort_by(&:date_time)
    @all_upcoming_meetings = all_current_meetings.slice(1..all_current_meetings.length)
    @previous_meetings =
      (@user_host_meetings + @meetings_attending)
    .select { |meeting| meeting.finish == true }
    .sort_by(&:date_time)
    .reverse
    @next_meeting =
      all_current_meetings
    .reject { |meeting| meeting.finish == true }
    .min_by(&:date_time)
  end

  def get_event(meeting,client)
    end_time = meeting.date_time + meeting.duration.minutes
    event = Google::Apis::CalendarV3::Event.new(
      summary: meeting.title,
      description: "Meeting description: #{meeting.description}.\nMeeting link: https://www.syncalyst.com://www.syncalyst.com/meetings/#{meeting.id}",
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{meeting.date_time.strftime('%F')}T#{meeting.date_time.strftime("%k")}:#{meeting.date_time.strftime("%M")}:00",
        time_zone: TIME_ZONE
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{end_time.strftime('%F')}T#{end_time.strftime("%k")}:#{end_time.strftime("%M")}:00",
        time_zone: TIME_ZONE
      )
      # sendNotifications: true,
      # reminders: {
      #   use_default: true
      # }
    )

    event[:id] = meeting.event if meeting.event

    event
    client.insert_event('primary', event)

  end


  def create_meeting_event(meeting)
    end_time = meeting.date_time + meeting.duration.minutes
    google_event = Google::Apis::CalendarV3::Event.new(
      summary: meeting.title,
      description: "Meeting description: #{meeting.description}.\nMeeting link: http://localhost:3000/meetings/#{meeting.id}",
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{meeting.date_time.strftime('%F')}T#{meeting.date_time.strftime("%k")}:#{meeting.date_time.strftime("%M")}:00",
        time_zone: TIME_ZONE
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: "#{end_time.strftime('%F')}T#{end_time.strftime("%k")}:#{end_time.strftime("%M")}:00",
        time_zone: TIME_ZONE
      )
    )
    google_event
  end

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
                                                     "web" =>
                                                     {
                                                       "access_token" => current_user.access_token,
                                                       "refresh_token" => current_user.refresh_token,
                                                       "client_id" => ENV["GOOGLE_CLIENT_KEY"],
                                                       "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
                                                     }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if current_user.expired?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      raise e.message
    end
    client
  end
end
