namespace :admin do
  desc "Clean up all temporary files in the application directory"

   

  task cleanup: [:environment] do

     # require 'rake'
     # rake = Rake.application
     # rake.init
     # rake.load_rakefile
    #stop daemons
     # puts "stopping daemons"
     # begin
     #   rake['daemons:stop'].invoke()
     #   puts "daemons:stoped successfully"
     # rescue  
     #   puts "error stoping daemons"
     # end

    #sleep 90
    
    # keep sleep for 1 minutes
    puts "Removing temporary directory contents"

    # tmp_files = []
    # %w{ cache pids sessions sockets }.each do |dir|
    #   tmp_files += Dir.glob( File.join(Rails.root, "tmp", dir, "*") )
    # end
    #File.delete(*tmp_files)

    puts "Removing log files"
    log_files = Dir.glob( File.join(Rails.root, "log", "*") )
    File.delete(*log_files)
    #puts "listing files"
    #log_files.each do |tf|
      #fname = tf.split(".")
      #unless fname.last == "pid"
        #File.open(tf, 'w') {|file| file.truncate(0) }
      #end
      
    #end

     # puts "starting daemons"
     # begin
     #    #rake['daemons:start'].invoke()
     #    puts "daemons:started successfully"
     # rescue 
     #    puts "error starting daemons"
     # end  

    #sleep 90

    #exec("sudo service rabbitmq-server restart")
    #exec("service redis_6379 restart")


    #puts "server restarted successfully"




    #puts "Removing emacs temporary files"
    #emacs_tmp_files = Dir.glob( File.join(Rails.root, "**", "*~") )
    #emacs_tmp_files += Dir.glob( File.join(Rails.root, "**", "\#*\#") )
    #File.delete(*emacs_tmp_files)
  end

  # task restarts: [:environment] do
  #   exec("service redis_6379 restart")
  # end
end
