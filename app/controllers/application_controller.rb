class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :owner_has_buffet

  def after_sign_in_path_for(resource)
    if resource.is_a?(Owner)
      new_buffet_path
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def owner_has_buffet
    return if action_new? || action_destroy? || create_buffet? || owner_authorized?

    redirect_to new_buffet_path
  end

  private

  def owner_authorized?
    current_owner&.buffet || !owner_signed_in?
  end

  def action_new?
    params[:action] == 'new'
  end

  def action_destroy?
    params[:action] == 'destroy'
  end

  def create_buffet?
    params[:controller] == 'buffets' && params[:action] == 'create'
  end
end
