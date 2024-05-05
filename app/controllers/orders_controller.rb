class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
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
