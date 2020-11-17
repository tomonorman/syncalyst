class MeetingsController < ApplicationController

  def new

  end

  def show
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end
end
