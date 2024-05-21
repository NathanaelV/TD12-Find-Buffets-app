class HomeController < ApplicationController
  def index
    # redirect_to current_owner.buffet if owner_signed_in?
    @buffets = Buffet.all
  end
end
