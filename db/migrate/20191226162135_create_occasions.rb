class CreateOccasions < ActiveRecord::Migration
  def change
    create_table :occasions do |t|
      t.string :title
      t.integer :user_id
    end
  end
end
