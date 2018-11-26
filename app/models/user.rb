class User < ApplicationRecord
  has_many :repositories

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end