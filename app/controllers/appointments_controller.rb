class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = current_user.appointments
  end

  def google_calendar
    @events = current_user.get_google_calendar_client
    if @events.present?
      @events.items.each do |event|
        appointment = current_user.appointments.find_by(appointment_id: event.id)
        if appointment.present?
          appointment.update(summary: event.summary,
                              start_date: event.start.date_time,
                              end_date: event.end.date_time,
                              status: event.status,
                              updated: event.updated)
        else
          current_user.appointments.create(summary: event.summary,
                                          start_date: event.start.date_time,
                                          end_date: event.end.date_time,
                                          appointment_id: event.id,
                                          status: event.status,
                                          html_link: event.html_link,
                                          created: event.created,
                                          updated: event.updated)
        end
      end
      redirect_to appointments_path, notice: "You are synced with Google calendar now."
    else
      redirect_to google_calendar_redirect_path
    end
  end
end
