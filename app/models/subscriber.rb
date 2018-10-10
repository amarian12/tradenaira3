class Subscriber < ActiveRecord::Base
	validates :email, uniqueness: { 
    message: "You are already added in the list!" }, unless: :values_there?

    validates :email, uniqueness: { 
    message: "You are already added in the list!" }, unless: :values_there?

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

    validates :email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :values_there? 



    def values_there?
    	self.email.nil?
    end
    
end
