class MetaCategory < ActiveRecord::Base
	has_many :meta_contents

	validates :title, presence: true

	 
	def parent_category
		MetaCategory.find_by_id(self.parent_id)
	end
end
