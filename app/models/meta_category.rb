class MetaCategory < ActiveRecord::Base
	has_many :meta_contents

	validates :title, presence: true

	before_save :create_slug

	def parent_category
		MetaCategory.find_by_id(self.parent_id)
	end


	private 
	def create_slug
		if self.slug.nil?
			slug = self.title.downcase.gsub(/[^0-9a-z]/,"_")
			mc = MetaCategory.find_by_slug(slug)
			if mc.nil?
				self.slug = slug
			else
				require 'securerandom'
				randomstring = SecureRandom.hex(2)
				self.slug = slug+"_"+randomstring
			end
		end
	end

	 

end
