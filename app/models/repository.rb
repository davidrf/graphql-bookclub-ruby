class Repository < ApplicationRecord
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :name, presence: true
  validates :user, presence: true

  def self.gen(current_user:,id:)
    where(private: false)
      .or(where(private: true, user_id: current_user.id))
      .find_by(id: id)
  end
end