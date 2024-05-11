class Api::V1::EventsController < Api::V1::ApiController
  def index
    buffet_id = params[:buffet_id]
    begin
      Buffet.find(buffet_id)
      events = Event.where(buffet_id:)
      render status: 200, json: events.as_json(only: %i[id name description], include: include_on_events)
    rescue ActiveRecord::RecordNotFound
      render status: 404, json: { error: { message: 'Buffet não encontrado. Verifique o ID' } }
    end
  end

  def show
    event = Event.find(params[:id])
    render status: 200, json: event.to_json(except: %i[buffet_id created_at updated_at])
  end

  private

  def include_on_events
    { buffet: { only: %i[id brand_name] } }
  end
end
