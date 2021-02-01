require 'minitest_helper'

class RouteTest < ActionController::TestCase
  test "callback route for google calendar should match" do
    assert_equal(google_calendar_callback_path, '/google_calendar/callback')
  end
end