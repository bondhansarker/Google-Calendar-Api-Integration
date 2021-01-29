class AddGoogleCalendarFieldsInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :google_calendar_access_token, :string
    add_column :users, :google_calendar_access_token_expires_in, :string
    add_column :users, :google_calendar_refresh_token, :string
  end
end
