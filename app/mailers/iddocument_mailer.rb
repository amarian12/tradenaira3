class IddocumentMailer < ActionMailer::Base

  default from: 'support@tradenaira.com'

  def unverified(iddocument_id)
    set_mail(iddocument_id)
  end

  def verified(iddocument_id)
    set_mail(iddocument_id)
  end

  def senddocument(getemail)
    set_mailsend(getemail)
  end

  def senddeposit(getemail,getcurrency,getamount)
    set_maildepositsend(getemail,getcurrency,getamount)
  end

  def sendwithdraw(getemail,getcurrency,getamount)
    set_mailwithdrawsend(getemail,getcurrency,getamount)
  end

  def depaccepted(getid,getcur,getbal)
    set_depacceptedmail(getid,getcur,getbal)
  end

  def sendinvite(getemail,getroot,getid)
    set_sendinvite(getemail,getroot,getid)
  end

  private

  def set_mail(iddocument_id)
    @iddocument = IdDocument.find iddocument_id
    @membername = IdDocument.find @iddocument.member.id
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end
    mail to: @iddocument.member.email
    #mail(:to => @iddocument.member.email, :template_name => "verified").deliver!
    #mail(:to => 'msk@cogzidel.com', :template_name => "unverified").deliver!
  end

  def set_mailsend(getemail)
	@getemail = getemail
    @closename = 'admin'
    mail to: 'support@tradenaira.com', subject: '[Tradenaira] Account verification submit from user'
  end

  def set_maildepositsend(getemail,getcurrency,getamount)
	@getemail = getemail
	@getcurrency = getcurrency
	@getamount = getamount
    @closename = 'admin'
    mail to: 'support@tradenaira.com', subject: '[Tradenaira] Deposit Request from user'
  end

  def set_mailwithdrawsend(getemail,getcurrency,getamount)
	@getemail = getemail
	@getcurrency = getcurrency
	@getamount = getamount
    @closename = 'admin'
    mail to: 'support@tradenaira.com', subject: '[Tradenaira] Withdraw Request from user'
  end

  def set_depacceptedmail(getid,getcur,getbal)
    @getcurrency = getcur
    @getbalance = getbal
    @deposit = Deposit.find getid
    @membername = IdDocument.find @deposit.member.id
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end
    mail to: @deposit.member.email, subject: '[Tradenaira] Your deposit has been credited into your account'
  end

  def set_sendinvite(getemail,getroot,getid)
	@getemail = getemail
    @getroot = getroot
    @getid = getid
    @closename = 'user'
    mail to: getemail, subject: '[Tradenaira] Invitation instructions'
  end


end

