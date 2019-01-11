namespace :dailymail do
  desc "Send email to users"
  task :email_sender => :environment do
  Subscriber.where(status: true).each do |subscriber|
  	begin
  		DailyemailMailer.dailymail(subscriber).deliver
  	rescue Exception => e
  		puts "getting error for #{subscriber.email}"
  	end
  end
  end

end
