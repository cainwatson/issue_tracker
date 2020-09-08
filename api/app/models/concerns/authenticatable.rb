module Authenticatable
  extend ActiveSupport::Concern

  included do
    attr_accessor :password

    before_save :hash_password
    before_create :initialize_jti
    after_save :clear_password

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 8 }
  end

  class_methods do
    def from_jwt(jwt)
      decoded_array = Authenticatable.decode_jwt(jwt)
      payload = decoded_array.first
      user = find(payload['sub'])

      user if user['jti'] == payload['jti']
    rescue ActiveRecord::RecordNotFound
      nil
    rescue JWT::DecodeError
      nil
    end
  end

  def self.decode_jwt(jwt)
    JWT.decode(jwt, Authenticatable.jwt_secret, true, { algorithm: 'HS256' })
  end

  def self.jwt_secret
    ENV['JWT_SECRET']
  end

  def jwt
    payload = { sub: id, jti: jti }
    JWT.encode(payload, Authenticatable.jwt_secret, 'HS256')
  end

  def valid_jwt?(jwt)
    decoded_array = Authenticatable.decode_jwt(jwt)
    payload = decoded_array.first
    payload['jti'] == jti
  rescue JWT::VerificationError
    false
  end

  def revoke_jwt
    update_column(:jti, generate_jti)
  end

  private

  def hash_password
    hasher = Argon2::Password.new
    self.password_digest = hasher.create(password)
  end

  def clear_password
    self.password = nil
  end

  def initialize_jti
    self.jti = generate_jti
  end

  def generate_jti
    SecureRandom.uuid
  end
end
