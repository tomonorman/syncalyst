class AgendasController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    @agenda = Agenda.new(agenda_params)
    @agenda.meeting = @meeting
    if @agenda.save
      redirect_to meeting_path(@meeting)
    end
    authorize @agenda
  end

  private

  def agenda_params
    params.require(:agenda).permit(:title, :description, :est_duration, :transcription)
  end
end
