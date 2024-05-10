class Api::V1::BuffetsController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500

  def index
    buffets = Buffet.all
    # render status: 200, json: buffets.to_json(except: %i[created_at updated_at], include: include_owner)
    render status: 200, json: buffets.to_json(except: %i[owner_id created_at updated_at], include: include_owner)
  end

  private

  def return_500
    render status: 500
  end

  def include_owner
    { owner: { except: %i[created_at updated_at] } }
  end
end
