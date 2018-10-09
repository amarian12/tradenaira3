class Blogo::Banner < ActiveRecord::Base

	mount_uploader :image, FileUploader

	validates :category, presence: true

	#as_enum category: [:news_home_top, :news_home_side, :article_home_top, :article_home_side]

	#as_enum category: :news_home_top

	attr_accessor :category_cd

	as_enum :category, [:news_home_top, :news_home_side, 
		:article_home_top, :article_home_side], map: :integer, source: :category,
		pluralize_scopes: false

	#as_enum category: news_home_top: 0, news_home_side: 1, article_home_top: 2,
	# article_home_side: 3 


end
