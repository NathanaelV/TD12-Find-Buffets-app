class ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
    @order = @proposal.order
    @proposal_cost = @proposal.cost / 100.0
    @proposal_price_change = @proposal.price_change / 100.0
    @proposal_final_cost = @proposal_cost + @proposal_price_change
  end

  def new
    @order = Order.find(params[:order_id])
    redirect_to root_path if current_owner != @order.buffet.owner

    @proposal = Proposal.new
    @proposal.cost = event_cost_calculate
  end

  def create
    proposal_and_order_generate

    if @proposal.save
      @order.approved!
      notice = "Proposta enviada com sucesso, para o pedido: #{I18n.l @order.event_date} - #{@order.code}"
      redirect_to orders_path, notice:
    else
      @proposal_errors = @proposal.errors.full_messages
      render :new
    end
  end

  def accept
    proposal = Proposal.find(params[:id])
    proposal.accepted!
    redirect_to orders_path, notice: 'Evento aceito com sucesso'
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

  def proposal_and_order_generate
    @order = Order.find(params[:order_id])
    @proposal = Proposal.new(proposal_params)
    @proposal.order = @order
    @proposal.event = @order.event
    @proposal.event_cost = event_cost
    @proposal.customer = @order.customer
  end
end
