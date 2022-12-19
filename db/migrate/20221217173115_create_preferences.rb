class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.jsonb :payload, null: false, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  # add_index :preferences, :payload, using: :gin
  end
end
