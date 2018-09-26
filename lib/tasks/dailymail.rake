namespace :dailymail do
  desc "Send email to users"
  task :email_sender => :environment do
  Member.all.each do |members|
    DailyemailMailer.dailymail(members).deliver
  end
  end

end
