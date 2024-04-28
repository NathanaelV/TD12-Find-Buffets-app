class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit]

  def show; end

  def new
    @event = Event.new
  end

  def create
    buffet = current_owner.buffet
    event = Event.create(event_params)
    buffet.events << event
    redirect_to event, notice: 'Evento criado com sucesso!'
  end

  def edit; end

  private

  def event_params
    params.require(:event).permit(:name, :description, :min_people, :max_people, :duration, :menu, :alcoholic_beverages,
                                  :decoration, :parking, :parking_valet, :customer_space)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
