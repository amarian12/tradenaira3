class Feed < ActiveRecord::Base
    has_many :entries, dependent: :destroy
    validates :name, presence: true
    validates :url,  presence: true
    validates :description,  presence: true 
end



