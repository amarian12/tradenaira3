class Reward < ApplicationRecord
  validates :title, :amount_met, :description, presence: true

  belongs_to :project
  has_many :pledges
end
