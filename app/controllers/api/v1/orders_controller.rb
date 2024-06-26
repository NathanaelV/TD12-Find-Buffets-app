class Api::V1::OrdersController < Api::V1::ApiController
  rescue_from ActionController::ParameterMissing, with: :return_412

  def create
    @event = Event.find(params[:event_id])
    @order = Order.new(order_params)
    @order.event = @event
    if order_valid_api?
      advance_price = "R$ #{format('%.2f', event_cost_calculate / 100.0)}"
      render status: 201, json: { advance_price: }
    else
      render status: 412, json: { errors: @error_messages }
    end
  end

  private

  def event_cost_calculate
    event_cost.minimum + event_cost.additional_per_person * (@order.people - @event.min_people)
  end

  def event_cost
    event_cost_select || @event.event_costs.first
  end

  def event_cost_select
    if @order.event_date.on_weekday?
      @event.event_costs.find { |event| event.description == 'Dias de semana' }
    else
      @event.event_costs.find { |event| event.description == 'Fim de semana' }
    end
  end

  def order_params
    params.require(:order).permit(:event_date, :people)
  end

  def return_412
    render status: 412, json: { error: 'Order não pode ficar em branco' }
  end

  def order_valid_api?
    present_parameters? && available_date?
  end

  def present_parameters?
    return true if order_params[:event_date] && order_params[:people]

    @error_messages = ['Data do evento não pode ficar em branco', 'Quantidade de pessoas não pode ficar em branco']
    false
  end

  def available_date?
    if Order.find_by(event_date: order_params[:event_date])
      @error_messages = 'Buffet indisponível na data escolhida'
      false
    else
      true
    end
  end
end
