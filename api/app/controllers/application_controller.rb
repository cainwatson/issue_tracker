class ApplicationController < ActionController::API
  private

  def current_user
    header = request.headers['Authorization'].to_s
    # Strip "Bearer " prefix
    token = header.slice(7..-1)
    Accounts::User.from_jwt(token)
  end
end
