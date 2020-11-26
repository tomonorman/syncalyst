require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

class GoogleCalendar
  attr_reader :service, :credentials

  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "Syncalyst".freeze
  CREDENTIALS_PATH = "credentials.json".freeze
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = "https://www.googleapis.com/auth/calendar"
  TIME_ZONE = "Asia/Tokyo"
  TEST_CALENDAR_ID = 'primary'

  def initialize(meeting = nil)
    @meeting = meeting
    authorize
    initialize_api
    create_meeting_event(@meeting)
  end

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    @credentials = authorizer.get_credentials user_id
    if @credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
        "resulting code after authorization:\n" + url
      code = gets
      @credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    @credentials
  end

  def initialize_api
    # Initialize the API
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
    @service
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
    @service.insert_event('primary', google_event)
  end
end
