class Api::V1::BuffetsController < Api::V1::ApiController
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500

  def index
    query = params[:query]

    buffets = if query
                Buffet.where('brand_name LIKE ?', "%#{query}%")
              else
                Buffet.all
              end

    render status: 200, json: buffets.to_json(except: except_on_buffets)
  end

  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet.to_json(except: except_on_buffet)
  end

  private

  def return_500
    render status: 500
  end

  def except_on_buffets
    %i[corporate_name registration_number phone email address zip_code description payment owner_id created_at
       updated_at]
  end

  def except_on_buffet
    %i[corporate_name registration_number owner_id created_at updated_at]
  end
end
