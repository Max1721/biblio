class Book < ApplicationRecord
  belongs_to :lender, class_name: "User"

  validates :title, length: { minimum: 2 }, presence: true
  validates :author, length: { minimum: 2 }, presence: true
  validates :category, length: { minimum: 2 }, presence: true
end
