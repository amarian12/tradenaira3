class Project < ApplicationRecord
  validates :title, :blurb, :description, :end_date, :funding_goal, :image_url, :author, :total_amount, presence: true

  belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "User"

  belongs_to :member,
  foreign_key: :user_id
  #,
  #optional: true

  has_many :rewards
  has_many :pledges

  has_many :likes,
  primary_key: :id,
  foreign_key: :project_id,
  class_name: "Like"

  has_many :project_categories

  has_many :categories,
  through: :project_categories,
  source: :category

  def self.search_results(query_param)
    param = '%' + query_param.downcase + '%'
    Project.where('lower(title) LIKE ?', param)
  end
end
