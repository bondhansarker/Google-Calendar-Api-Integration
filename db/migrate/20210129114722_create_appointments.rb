class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :appointment_id
      t.string :summary
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.string :html_link
      t.datetime :created
      t.datetime :updated
      t.belongs_to :user, null: false, foreign_key: true
    end
    add_index :appointments, :appointment_id, unique: true
  end
end
