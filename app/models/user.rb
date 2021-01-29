require 'google/api_client/client_secrets'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers:[:google_oauth2]

  has_many :appointments

  def get_google_calendar_client
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (self.present? && self.google_calendar_access_token.present? && self.google_calendar_refresh_token.present?)
    secrets = Google::APIClient::ClientSecrets.new({
                                                     "web" => {
                                                       "access_token" => self.google_calendar_access_token,
                                                       "refresh_token" => self.google_calendar_refresh_token,
                                                       "client_id" => Rails.application.secrets.google_client_id,
                                                       "client_secret" => Rails.application.secrets.google_client_secret
                                                     }
                                                   })
    client.authorization = secrets.to_authorization
    client.authorization.grant_type = "refresh_token"

    client.authorization.refresh!
    self.update_columns(
      google_calendar_access_token: client.authorization.access_token,
      google_calendar_refresh_token: client.authorization.refresh_token,
      google_calendar_access_token_expires_in: client.authorization.expires_at.to_i
    )

    response = client.list_events("primary")

  end

  def self.create_from_provider_data(provider_data)
    email = provider_data.info.email
    first_name = provider_data.info.name.split(' ')[0]
    last_name = provider_data.info.name.split(' ')[1]
    password = Devise.friendly_token[0, 20]
    self.create(email: email, password: password,first_name: first_name,last_name: last_name)
  end
end
