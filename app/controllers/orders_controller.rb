class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: %i[create]

  def index
    if owner_signed_in?
      @buffet = current_owner.buffet
      orders = Order.where(buffet: @buffet)
      @pending_orders = orders.select(&:pending?)
      @approved_orders = orders.select(&:approved?)
      @canceled_orders = orders.select(&:canceled?)
    else
      @orders = Order.where(customer: current_customer)
      @proposal_orders = Proposal.where(customer: current_customer).select { |order| order.status == 'sent' }
    end
  end

  def show
    order_id = params[:id].to_i
    @order = Order.find(order_id)
    redirect_to root_path unless current_owner == @order.buffet.owner || current_customer == @order.customer

    @conflicting_orders = Order.where(event_date: @order.event_date).reject { |order| order.id == order_id }
  end

  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @event = Event.find(params[:event_id])
    @order.event = @event
    @order.buffet = @event.buffet
    @order.customer = current_customer

    if @order.save
      redirect_to @order, notice: 'Pedido realizado com sucesso. Aguardar aprovação do Buffet'
    else
      @order_errors = @order.errors.full_messages
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:event_date, :people, :details, :address)
  end
end
