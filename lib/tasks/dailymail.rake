namespace :dailymail do
  desc "Send email to users"
  task :email_sender => :environment do
  Subscriber.where(status: true).each do |subscriber|
    DailyemailMailer.dailymail(subscriber).deliver
  end
  end

end
