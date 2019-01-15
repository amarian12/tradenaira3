class IdDocument < ActiveRecord::Base
  STATES = [:unverified, :verified, :verifying]
  extend Enumerize
  include AASM
  include AASM::Locking
  before_validation :test_values

  has_one :id_document_file, class_name: 'Asset::IdDocumentFile', as: :attachable
  accepts_nested_attributes_for :id_document_file

  has_one :id_bill_file, class_name: 'Asset::IdBillFile', as: :attachable
  accepts_nested_attributes_for :id_bill_file

  belongs_to :member

  validates_presence_of :name, :id_document_type, :id_document_number, :id_bill_type, :address, :country, :zipcode , :id_document_file, :id_bill_file, allow_nil: false
  validates_uniqueness_of :member
  validates_presence_of :id_document_file

  enumerize :id_document_type, in: {id_card: 0, passport: 1, driver_license: 2}
  enumerize :id_bill_type,     in: {bank_statement: 0, tax_bill: 1, utility_bill: 2}

  alias_attribute :full_name, :name

  aasm do
    state :unverified, initial: true, after_commit: :send_email
    state :verifying
    state :verified, after_commit: :send_email

    event :submit do
      transitions from: :unverified, to: :verifying
    end

    event :approve do
      transitions from: [:unverified, :verifying],  to: :verified
    end

    event :reject do
      transitions from: [:verifying, :verified],  to: :unverified
    end
    
    event :reset do
      transitions from: [:unverified, :verified],  to: :verifying
    end
    
  end
  
  class << self
    
    def search(field: nil, term: nil)
      result = case field
               when 'email'
                 joins(:member).where('members.email LIKE ?', "%#{term}%")
               when 'name'
                 where('id_documents.name LIKE ?', "%#{term}%")
               else
                 all
               end

      result.order(:id).reverse_order
    end
    
  end

  def test_values
    puts self.inspect
  end
  
  private

    def send_email
      IddocumentMailer.verified(self.id).deliver if self.verified?
      IddocumentMailer.unverified(self.id).deliver if self.unverified?
    end
  
end
