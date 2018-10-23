class Category < ApplicationRecord
  validates :name, presence: true

  has_many :project_categories

  has_many :projects,
  through: :project_categories,
  source: :project
end
