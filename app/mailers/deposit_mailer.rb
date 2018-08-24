class DepositMailer < BaseMailer

  def accepted(deposit_id)
    @deposit = Deposit.find deposit_id
    @membername = IdDocument.find @deposit.member.id
    @closename = @membername.name
    if @closename.blank?
       @closename = 'user'
	end
    mail to: @deposit.member.email
  end

end
