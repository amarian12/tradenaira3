class TokenMailer < BaseMailer

  def reset_password(email, token)
    @token_url = edit_reset_password_url(token)
    @rid = Member.where(:email => email).pluck(:id)
    @membername = IdDocument.find_by(id: @rid)
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end
    mail to: email
  end

  def activation(email, token)
    @token_url = edit_activation_url token
    #mail to: email

    @rid = Member.where(:email => email).pluck(:id)
    @membername = IdDocument.find_by(id: @rid)
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end

    mail(:to => email, :template_name => "activation").deliver!
    @closename = 'admin'
    mail(:to => 'support@tradenaira.com', :subject => "[Tradenaira] New User Sign up", :template_name => "sendadmin").deliver!
  end

end
