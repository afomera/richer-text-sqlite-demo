class Post < ApplicationRecord
  has_richer_text :body, store_as: :json
end
