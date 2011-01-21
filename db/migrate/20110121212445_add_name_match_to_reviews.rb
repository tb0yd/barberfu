class AddNameMatchToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :name_match, :string
  end

  def self.down
    remove_column :reviews, :name_match
  end
end
