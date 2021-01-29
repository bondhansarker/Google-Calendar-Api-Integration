class GoogleCalendarController < ApplicationController
  before_action :authenticate_user!

  def redirect
    client = Signet::OAuth2::Client.new(client_options)
    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    response = client.fetch_access_token!
    client.update!(response)

    current_user.update_columns(
      google_calendar_access_token: response["access_token"],
      google_calendar_access_token_expires_in: response["expires_in"],
      google_calendar_refresh_token: client.refresh_token.present? ? client.refresh_token : current_user.google_calendar_refresh_token,
    )

    response = current_user.get_google_calendar_client
    redirect_to root_path, notice: "You are synced with Google calendar now."
  end

  def client_options(options={})
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: "#{Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY}",
      redirect_uri: options[:redirect_uri] || google_calendar_callback_url
    }
  end

end
