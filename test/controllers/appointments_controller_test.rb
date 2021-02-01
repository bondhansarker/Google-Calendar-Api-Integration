require 'minitest_helper'

class AppointmentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @routes = Rails.application.routes
    @user = FactoryBot.create(:user)
    sign_in @user
    super
  end

  test 'authenticated users can access index' do
    get :index
    assert_response :success
  end

  test 'authenticated users can view his appointments' do
    FactoryBot.create(:appointment, user: @user)
    get :index
    assert_not_empty(@controller.view_assigns['appointments'])
  end

end