class CreateTimecards < ActiveRecord::Migration[6.0]
  def change
    create_table :timecards do |t|
      t.references :fee, null: false, foreign_key: true
      t.date :date
      t.integer :hours

      t.timestamps
    end
  end
end
