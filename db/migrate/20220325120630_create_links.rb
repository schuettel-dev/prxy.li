class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :target, null: false
      t.datetime :expires_at, null: false, default: Time.new(9999, 12, 31).at_end_of_year
      t.integer :redirect_count, null: false, default: 0

      t.timestamps
    end
  end
end
