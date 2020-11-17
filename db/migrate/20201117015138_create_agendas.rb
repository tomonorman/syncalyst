class CreateAgendas < ActiveRecord::Migration[6.0]
  def change
    create_table :agendas do |t|
      t.references :meeting, null: false, foreign_key: true
      t.string :title
      t.text :transcription
      t.text :description
      t.integer :est_duration

      t.timestamps
    end
  end
end
