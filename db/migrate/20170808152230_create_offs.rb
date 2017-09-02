class CreateOffs < ActiveRecord::Migration[5.1]
  def change
    create_table :offs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
