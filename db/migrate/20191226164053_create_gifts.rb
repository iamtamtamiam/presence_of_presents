class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :giver
      t.string :category
      t.text :description
      t.integer :occasion_id
    end
  end
end
