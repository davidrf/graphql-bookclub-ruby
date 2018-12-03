class Repository < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true

  def self.gen(current_user:,id:)
    where(private: false)
      .or(where(private: true, user_id: current_user.id))
      .find_by(id: id)
  end
end