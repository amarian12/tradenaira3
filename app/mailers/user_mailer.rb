class UserMailer < ActionMailer::Base

  default from: 'support@tradenaira.com'

  def success(getemail,getsubject,getcc,getcontent)
    set_mail(getemail,getsubject,getcc,getcontent)
  end

  def signup_request me,member
    @by_member = member
    @amount = me.amount
    @member_name = member.display_name.nil? ? member.email : member.display_name
    @currency = me.account.currency
    subjects = "You have been sent some money"
    mail to: me.sent_on_email, subject: subjects
  end

  def receive_success me,member
    @by_member = member
    @amount = me.amount
    @currency = me.account.currency
    subjects = "You have been sent some money"
    mail to: me.sent_on_email, subject: subjects
    #when receiver has account
  end

  def admin_decline me,member
    @by_member = member
    @amount = me.amount
    @receiver_email = me.email
    @currency = me.account.currency
    subjects = "Your money transfer has failed"
    mail to: member.sent_on_email, subject: subjects
     #when admin decline
  end

  def admin_approval

    # subject ="New money transfer request"
    # mail to: 
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

