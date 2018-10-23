class Pledge < ApplicationRecord
  validates :amount_pledged, presence: true

  belongs_to :user
  belongs_to :project
  belongs_to :reward
end
