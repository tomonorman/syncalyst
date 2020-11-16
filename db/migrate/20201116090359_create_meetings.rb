class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date_time
      t.string :description
      t.string :trello_board
      t.string :title
      t.integar :duration

      t.timestamps
    end
  end
end
