class Category < ApplicationRecord
  validates :name, presence: true, length: {minimum: 2, maximum: 200}

  has_many :film
end
