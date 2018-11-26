class Repository < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true
end