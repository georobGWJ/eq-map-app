class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  include BCrypt

  def create
    @user = User.new({first_name: params[:first_name],
                     last_name: params[:last_name],
                     email: params[:email]})
    @user.password = params[:password]
    @user.save!
  end

  def password
    @password ||= Password.new(password_hash)
    @password
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(passed_password)
    self.password == passed_password
  end

end
