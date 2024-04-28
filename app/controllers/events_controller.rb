class EventsController < ApplicationController
  before_action :authenticate_owner!, except: %i[show]
  before_action :set_event, only: %i[show edit update destroy]

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

  def update
    @event.update(event_params)
    redirect_to @event, notice: 'Evento atualizado com sucesso!'
  end

  def destroy
    buffet = @event.buffet
    event_name = @event.name
    @event.destroy
    redirect_to buffet, notice: "#{event_name} excluído(a) com sucesso"
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :min_people, :max_people, :duration, :menu, :alcoholic_beverages,
                                  :decoration, :parking, :parking_valet, :customer_space)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
