namespace :dailymail do
  desc "Send email to users"
  task :email_sender => :environment do
  Subscriber.where(status: true, email: "tl1.ptiwebtech@gmail.com").each do |subscriber|
    DailyemailMailer.dailymail(subscriber).deliver
  end
  end

end
