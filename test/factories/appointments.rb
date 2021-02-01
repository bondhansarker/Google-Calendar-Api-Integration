FactoryBot.define do
  factory :appointment do
      sequence :appointment_id do |n|
        n
      end
      summary { "This is a test summary" }
      start_date{ "2019-10-14 04:30:00.000000000 +0000"}
      end_date{ "2019-10-14 05:30:00.000000000 +0000"}
      status{ "confirmed"}
      html_link{ "https://www.google.com/calendar/event?eid=MnE2dWhm"}
      created{ "2021-01-29 12:56:57.000000000 +0000"}
      updated{ "2021-01-29 12:56:57.411000000 +0000"}
  end
end
