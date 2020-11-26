class AgendasController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    @agenda.update(update_params)

  end

  private

  def agenda_params
    params.require(:agenda).permit(:title, :description, :est_duration, :transcription, :audio)
  end

  def update_params
    params.permit(:transcription, :audio)
  end
end
