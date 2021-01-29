class OmniauthController < ApplicationController

  def google_oauth2
    if registered_user.present?
      sign_in_and_redirect registered_user
    else
      failure
    end
  end

  def failure
    redirect_to new_user_registration_url, error: 'There is a problem signing you in'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def registered_user
    email = auth_hash.info.email
    available_user = User.find_by(email: email)
    user = available_user.present? ? available_user : User.create_from_provider_data(auth_hash)
  end
end
