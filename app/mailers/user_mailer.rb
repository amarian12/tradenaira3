class UserMailer < ActionMailer::Base

  default from: 'support@tradenaira.com'

  def success(getemail,getsubject,getcc,getcontent)
    set_mail(getemail,getsubject,getcc,getcontent)
  end

  #when receiver does not have account
  def signup_request me,member
    @by_member = member
    @amount = me.amount
    @me = me
    @member_name = member.display_name.nil? ? member.email : member.display_name
    @currency = me.account.currency
    if @me.request_type == "send_money"
      subjects = "You have been sent some money"
    elsif @me.request_type == "request_meney"
      subjects = "You have been requetsed some money"
    end
    mail to: me.sent_on_email, subject: subjects
  end


  def signup_request_escrow escrow, email
    @escrow = escrow
    
    subjects = "You have been escrowed some money from TRADENaira"
    mail to: email, subject: subjects    
  end

  def escrow_created escrow, current_user
    @escrow       = escrow
    @member       = current_user
    @seller       = @escrow.seller
    @buyer        = @escrow.buyer
    receips       = []
    subjects      = "You have been escrowed some money"
    if @seller
      receips << @seller.email
    end
    if @buyer
      receips << @buyer.email
    end
    receips << escrow.member.email
    mail to: receips, subject: subjects
  end

  #sent to receiver after receive money
  def receive_success me,member
    @by_member = member
    @amount = me.amount
    @currency = me.account.currency
    @me = me
    subjects = "You have been sent some money"
    mail to: me.receiver.email, subject: subjects
    #when receiver has account
  end

  def money_request me,member
    @by_member = member
    @amount = me.amount
    @me = me
    @currency = me.account.currency
    @sender = @me.sender
    @receiver = @me.receiver
    subjects = "You have been requested money"
    mail to: me.receiver.email, subject: subjects
  end

  # sent success mail to sender
  def sent_success me, member
    @by_member = member
    @amount = me.amount
    @me = me
    @currency = me.account.currency
    subjects = "Money sent success"
    mail to: me.sender.email, subject: subjects
  end
  # declined request to receive money by receipent
  def request_declined me 
    @amount = me.amount
    @me = me
    @currency = me.account.currency
    subjects = "Money request declined by receipent!"
    mail to: me.sender.email, subject: subjects
  end

  def admin_decline me,member
    @by_member = member
    @amount = me.amount
    @receiver_email = me.sent_on_email
    @currency = me.account.currency
    subjects = "Your money transfer has failed"
    mail to: member.email, subject: subjects
     #when admin decline
  end

  def escrow_success escrow
    @escrow       = escrow
    @seller   = @escrow.seller
    @buyer = @escrow.buyer
    receips = []
    subjects  = "Money escrowed successfully!"
    if @seller
      receips << @seller.email
    end
    if @buyer
      receips << @buyer.email
    end
    receips << escrow.member.email
    
    mail to: receips, subject: subjects
  end

 

  def admin_approval me
    @amount = me.amount
    @receiver_email = me.sent_on_email
    @currency = me.account.currency
    @me = me 
    @action = ""
    if me.request_type == "send_money"
      @action = "send"
      subjects = "Approval requets to send money"
      @sender_name = @me.sender.display_name || @me.sender.email
       
      if @me.receiver.nil?
        @receiver_name = @me.sent_on_email
      else
        @receiver_name = @me.receiver.display_name || @me.receiver.email
      end     

    elsif me.request_type == "request_meney"
      @action = "request"
      subjects = "Approval requets to receive money"
      @sender_name = @me.sender.display_name || @me.sender.email
      @receiver_name = @me.receiver.nil? ? @me.sent_on_email : @me.receiver.email

    elsif me.request_type == "escrow_money"
      @action = "escrow"
      subjects = "Approval requets to escrow money"
      @sender_name = @me.sender.display_name || @me.sender.email
      @receiver_name = @me.receiver.nil? ? @me.sent_on_email : @me.receiver.email
    end
    
    mail to: "support@tradenaira.com",  subject: subjects
  end


  private

  def set_mail(getemail,getsubject,getcc,getcontent)
    @getcontent = getcontent
    @memberid = Member.where(:email => getemail).pluck(:id)
    if @memberid.blank? == false
      @membername = IdDocument.find_by(id: @memberid)
      @closename = @membername.name
        if @closename.blank?
            @closename = 'user'
	     end
    else
      @closename = 'user'
	  end
    mail to: getemail, subject: getsubject, cc: getcc
  end

end

