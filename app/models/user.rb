class User < ApplicationRecord
  attr_reader :password
  validates :username, session_token: presence: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :password_digest, presence: { message: 'Password cannot be blank' }

  after_initialization :ensure_session_token

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    return if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  # Session helpers
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
