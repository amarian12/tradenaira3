class MetaContent < ActiveRecord::Base
	belongs_to :meta_category
	has_many :escrows

	before_save :create_slug



	private 
	def create_slug
		
		if self.slug.nil?
			slug = self.title.downcase.gsub(/[^0-9a-z]/,"_")
			mc = MetaContent.find_by_slug(slug)
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
