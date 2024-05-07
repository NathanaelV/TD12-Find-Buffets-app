class OrdersController < ApplicationController
  def index
    if owner_signed_in?
      @buffet = current_owner.buffet
      orders = Order.where(buffet: @buffet)
      @pending_orders = orders.select(&:pending?)
      @approved_orders = orders.select(&:approved?)
      @canceled_orders = orders.select(&:canceled?)
    else
      @orders = Order.where(customer: current_customer)
    end
  end

  def show
    order_id = params[:id].to_i
    @order = Order.find(order_id)
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

    @order.save!
    redirect_to @order, notice: 'Pedido realizado com sucesso. Aguardar aprovação do Buffet'
  end

  private

  def order_params
    params.require(:order).permit(:event_date, :people, :details, :address)
  end
end
