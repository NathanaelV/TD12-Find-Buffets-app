class BuffetsController < ApplicationController
  before_action :authenticate_owner!

  def show
    @buffet = Buffet.find(params[:id])
  end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.owner = current_owner
    @buffet.save!
    redirect_to @buffet, notice: 'Buffet criado com sucesso!'
  end

  private

  def buffet_params
    params.require(:buffet).permit(:brand_name, :corporate_name, :registration_number, :phone, :email, :address, :city,
                                   :state, :zip_code, :description, :payment)
  end
end
