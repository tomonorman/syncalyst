class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :meeting, null: false, foreign_key: true
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
