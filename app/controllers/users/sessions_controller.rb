class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private # overiding methods which is defined in Sessions Controller
  def respond_with(resource, options={})
    render json:{
      status: 200,
      message: "user signed in successfully.",
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],Rails.application.credentials.fetch(:secret_key_base)).first

    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json:{
      status: 200,
      message: "Signed out successfully."
    }, status: :ok
    else
      render json:{
        status: 401,
        message: "User has no active sessions."
      }, status: :unauthorized
    end
  end


end
