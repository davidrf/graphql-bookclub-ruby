class User < ApplicationRecord
  has_many :repositories

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.lazy_find(id)
    BatchLoader.for(id).batch do |ids, loader|
      where(id: ids).each { |user| loader.call(user.id, user) }
    end
  end
end