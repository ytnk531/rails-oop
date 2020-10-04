class CreateAffiliations < ActiveRecord::Migration[6.0]
  def change
    create_table :affiliations do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :member_id
      t.integer :due

      t.timestamps
    end
  end
end
