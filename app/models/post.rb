class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :date, presence: true
  validates :distance, presence: true, length: { maximum: 50 }
  validates :time, presence: true, length: { maximum: 50 }
end
