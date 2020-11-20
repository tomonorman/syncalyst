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

  def update
    @agenda = Agenda.find(params[:id])
    authorize @agenda
    # @agenda.audio = params[:audio]
    # binding.pry
    @agenda.update(agenda_params)
    redirect_to meeting_path(@agenda.meeting)

  end

  private

  def agenda_params
    params.require(:agenda).permit(:title, :description, :est_duration, :transcription, :audio)
  end
end
