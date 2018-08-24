class Slider < ActiveRecord::Base
  extend Enumerize
  
  belongs_to :member

  #validates :usdtxt, presence: true
  #validates :poundtxt, presence: true
  #validates :eurotxt, presence: true
  
  #validates_presence_of :usdtxt, :poundtxt, :eurotxt, allow_nil: true
  
  validates_uniqueness_of :member
end
