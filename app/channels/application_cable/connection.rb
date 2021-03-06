module ApplicationCable
  class Connection < ActionCable::Connection::Base

  	identified_by :current_user
 
    def connect
    	puts "***************************"
      self.current_user = find_verified_user
    end
 
    private
	def find_verified_user
		verified_user = Member.find_by(id: cookies.encrypted[:user_id])
	    if verified_user  
	      verified_user
	    else
	      reject_unauthorized_connection
	    end
	end


	 
   


  end
end
