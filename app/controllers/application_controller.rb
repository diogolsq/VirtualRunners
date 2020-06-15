class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :request_email, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def request_email
    if current_user && !current_user.email.present?
      redirect_to edit_user_registration_path
    end
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password, :password_confirmation, :photo, :name, :cellphone, :address, :seller])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :photo, :name, :Bio, :level])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
