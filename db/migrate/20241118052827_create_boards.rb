class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :mines, null: false
      t.jsonb :mine_positions, default: []
      t.timestamps
    end
  end
end
