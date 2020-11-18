class AddColumnsToMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :meetings, :start, :boolean, default: false
    add_column :meetings, :finish, :boolean, default: false
  end
end
