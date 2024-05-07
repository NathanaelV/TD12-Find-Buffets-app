class ProposalsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @proposal = Proposal.new
    @proposal.cost = event_cost_calculate
  end

  private

  def event_cost_calculate
    # event_cost = event_cost
    event = @order.event
    return 0 unless event_cost

    event_cost.minimum + event_cost.additional_per_person * (@order.people - event.min_people)
  end

  def event_cost
    if @order.event_date.on_weekday?
      @order.event.event_costs.find { |event| event.description == 'Dias de semana' }
    else
      @order.event.event_costs.find { |event| event.description == 'Fim de semana' }
    end
  end
end
