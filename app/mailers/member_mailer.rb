class MemberMailer < BaseMailer

  def notify_signin(member_id)
    set_mail(member_id)
  end

  def google_auth_activated(member_id)
    set_mail(member_id)
  end

  def google_auth_deactivated(member_id)
    set_mail(member_id)
  end

  def sms_auth_activated(member_id)
    set_mail(member_id)
  end

  def sms_auth_deactivated(member_id)
    set_mail(member_id)
  end

  def reset_password_done(member_id)
    set_mail(member_id)
  end

  def phone_number_verified(member_id)
    set_mail(member_id)
  end

  def contact_mail(user)
  @user = user
  
  mail( :to => "support@tradenaira.com", 
    :subject => "You Have a Message From Your Website")
  end

  private
  def set_mail(member_id)
    @member = Member.find member_id
    @membername = IdDocument.find @member.id
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	  end
    mail to: @member.email
  end
end
