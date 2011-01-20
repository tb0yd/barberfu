class Review < ActiveRecord::Base
  searchable do
    text :name
  end
end
