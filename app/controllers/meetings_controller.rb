class MeetingsController < ApplicationController
  before_action :set_meeting, only: :create
  def index
    @meetings = policy_scope(current_user.meetings)
  end

  def new
    @meeting = Meeting.new
    authorize @meeting
  end

  def create
    @meeting.user = current_user
    if @meeting.save
      redirect_to meeting_path(@meeting)
    else
      render 'new'
    end
  end

  private

  def set_meeting
    @meeting = Meeting.new(params[:id])
    authorize @meeting
  end
end
