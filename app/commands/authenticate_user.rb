class AuthenticateUser
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if user_exists? && !valid_password?
      errors.add(:password, "Incorrect password")
    elsif !user_exists?
      errors.add(:email, "User not found")
    else
      return JsonWebToken.encode(user_id: user.id)
    end

    nil
  end

  private

  def user_exists?
    User.exists?(email: email)
  end

  def valid_password?
    user&.authenticate(password)
  end

  def user
    @user ||= User.find_by(email: email)
  end
end