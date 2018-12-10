class Collaboration < ApplicationRecord
  belongs_to :repository
  belongs_to :user

  validates :repository, presence: true
  validates :user, presence: true
end
