class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show]
  def new

  end

  def show
    @agenda = Agenda.new()
    @agenda.meeting = @meeting
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end
end
