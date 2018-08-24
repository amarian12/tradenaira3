class FundSource < ActiveRecord::Base
  include Currencible

  attr_accessor :name

  paranoid

  belongs_to :member

  validates_presence_of :uid, :extra, :member

  def label
    if currency_obj.try :coin?
      "#{uid} (#{extra})"
    else
      [I18n.t("banks.#{extra}"), "****#{uid[-4..-1]}"].join('#')
    end
  end
  def labelngn
    if currency_obj.try :coin?
      "#{uid} (#{extra})"
    else
      [I18n.t("js.ngnbanks.#{extra}"), "****#{uid[-4..-1]}"].join('#')
    end
  end


  def labelghs
    if currency_obj.try :coin?
      "#{uid} (#{extra})"
    else
      [I18n.t("js.ghsbanks.#{extra}"), "****#{uid[-4..-1]}"].join('#')
    end
  end
  
  def labelusd
    if currency_obj.try :coin?
      "#{uid} (#{extra})"
    else
      ["#{extra}", "****#{uid[-4..-1]}"].join('#')
    end
  end

  def as_json(options = {})
    super(options).merge({label: label, labelusd: labelusd, labelngn: labelngn, labelghs: labelghs })
  end
end
