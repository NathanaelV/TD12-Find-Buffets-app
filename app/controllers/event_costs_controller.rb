class EventCostsController < ApplicationController
  before_action :set_event, only: %i[new create edit update]
  before_action :set_event_cost, only: %i[edit update]

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

  def edit; end

  def update
    @event_cost.update(event_cost_params)
    redirect_to @event, notice: 'Custo do evento atualizado com sucesso.'
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
end
