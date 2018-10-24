class User < ApplicationRecord
  validates :username, :password_digest, :session_token, :email, presence: true
  validates :password, length: { minimum: 3, allow_nil: true }

  attr_reader :password

  has_many :projects,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Project"

  has_many :pledges,
  foreign_key: :user_id

  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password )
    user = User.find_by(username: username )
    return nil unless user && user.valid_password?(password)
    user
  end
end
