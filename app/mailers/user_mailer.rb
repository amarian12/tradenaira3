class UserMailer < ActionMailer::Base

  default from: 'support@tradenaira.com'

  def success(getemail,getsubject,getcc,getcontent)
    set_mail(getemail,getsubject,getcc,getcontent)
  end

  def signup_request me,member
    @by_member = member
    @amount = me.amount
    @currency = me.account.currency
    subjects = "You have received money from #{@by_member.email}!"
    mail to: @by_member.email, subject: subjects
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

