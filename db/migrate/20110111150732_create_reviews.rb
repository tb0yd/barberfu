class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :name
      t.integer :zip
      t.integer :rating
      t.string :author
      t.text :full

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
