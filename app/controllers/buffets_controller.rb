class BuffetsController < ApplicationController
  before_action :authenticate_owner!, except: %i[show index]
  before_action :set_buffet, only: %i[show edit update]

  def index
    @query = params[:query]

    @buffets = Buffet.where('brand_name LIKE ? OR city LIKE ?', "%#{@query}%", "%#{@query}%").to_a
    Event.where('name LIKE ?', "%#{@query}%").each do |event|
      @buffets << event.buffet
    end

    @buffets = @buffets.uniq.sort_by!(&:brand_name)
  end

  def show
    @events = @buffet.events
  end

  def new
    existing_buffet = current_owner.buffet
    redirect_to existing_buffet if existing_buffet

    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.owner = current_owner
    if @buffet.save
      redirect_to @buffet, notice: 'Buffet criado com sucesso!'
    else
      @buffet_errors = @buffet.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      redirect_to @buffet, notice: 'Buffet atualizado com sucesso'
    else
      @buffet_errors = @buffet.errors.full_messages
      render :edit
    end
  end

  private

  def buffet_params
    params.require(:buffet).permit(:brand_name, :corporate_name, :registration_number, :phone, :email, :address, :city,
                                   :state, :zip_code, :description, :payment)
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end
end
