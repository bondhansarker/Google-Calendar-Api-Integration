require "minitest_helper"

describe Appointment do
  before do
    @user = FactoryBot.create(:user)
    @valid_appointment = FactoryBot.build(:appointment, user: @user)
    @invalid_appointment = Appointment.new
  end

  it "should_return_validation_errors_for_appointmens" do
    @invalid_appointment.save
    assert @invalid_appointment.errors.count == 2
    assert @invalid_appointment.errors[:user] == ["must exist"]
    assert @invalid_appointment.errors[:appointment_id] == ["can't be blank"]
  end

  it "should_create_an_appointment" do
    @valid_appointment.save
    assert_equal "This is a test summary", @valid_appointment.summary
    assert_equal "14 October, 2019, Monday", @valid_appointment.start_date.strftime("%d %B, %Y, %A")
    assert_equal "14 October, 2019, Monday", @valid_appointment.end_date.strftime("%d %B, %Y, %A")
    assert_equal "confirmed", @valid_appointment.status
    assert_equal "https://www.google.com/calendar/event?eid=MnE2dWhm", @valid_appointment.html_link
    assert_equal "29 January, 2021, Friday", @valid_appointment.created.strftime("%d %B, %Y, %A")
    assert_equal "29 January, 2021, Friday", @valid_appointment.updated.strftime("%d %B, %Y, %A")
    assert_equal @user, @valid_appointment.user
    assert @valid_appointment.errors.count == 0
  end

  it "should_update_an_appointment" do
    @valid_appointment.save
    assert_equal "This is a test summary", @valid_appointment.summary
    @valid_appointment.update(summary: "This is updated summary")
    assert_equal "This is updated summary", @valid_appointment.summary

    assert_equal @user, @valid_appointment.user
    assert @valid_appointment.errors.count == 0
  end
end
