class AddEventColumnToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :event, :string
  end
end
