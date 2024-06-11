class EventCostsController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_event, only: %i[new create edit update]
  before_action :set_event_cost, only: %i[edit update]
  before_action :redirect_to_buffet, only: %i[new create edit update]

  def new
    @event_cost = EventCost.new
  end

  def create
    @event_cost = EventCost.new(event_cost_params)
    @event_cost.event = @event
    if @event_cost.save
      redirect_to @event, notice: 'Custo do evento criado com sucesso.'
    else
      @event_cost_errors = @event_cost.errors.full_messages
      render :new
    end
  end

  def edit
    owner_buffet = current_owner.buffet
    redirect_to owner_buffet if owner_buffet != @event.buffet
  end

  def update
    if @event_cost.update(event_cost_params)
      redirect_to @event, notice: 'Custo do evento atualizado com sucesso.'
    else
      @event_cost_errors = @event_cost.errors.full_messages
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_cost
    @event_cost = EventCost.find(params[:id])
  end

  def event_cost_params
    params.require(:event_cost).permit(:description, :minimum, :additional_per_person, :overtime)
  end

  def redirect_to_buffet
    owner_buffet = current_owner.buffet
    redirect_to owner_buffet if owner_buffet != @event.buffet
  end
end
