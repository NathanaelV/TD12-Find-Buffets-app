class ProposalsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @proposal = Proposal.new
    @proposal.cost = event_cost_calculate
  end

  def create
    @order = Order.find(params[:order_id])
    @proposal = Proposal.new(proposal_params)
    @proposal.order = @order
    @proposal.event = @order.event
    @proposal.event_cost = event_cost

    if @proposal.save
      @order.approved!
      notice = "Proposta enviada com sucesso, para o pedido: #{I18n.l @order.event_date} - #{@order.code}"
      redirect_to orders_path, notice:
    else
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:cost, :validate_date, :price_change, :price_change_details, :payment)
  end

  def event_cost_calculate
    event = @order.event
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
