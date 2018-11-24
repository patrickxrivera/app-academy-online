class Person < ApplicationRecord
  belongs_to :house

  validates :house_id, :name, presence: true
end
