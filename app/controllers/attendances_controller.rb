class AttendancesController < ApplicationController

  def create
    @meeting = Meeting.find(params[:id])
    @user = User.find(params[:user_id])
    @attendance = Attendance.new
    @attendance.meeting = @meeting
    @attendance.user = @user
    authorize @attendance
    if @attendance.save
      redirect_to meeting_path(@meeting)
    else
      raise
    end
  end
end
