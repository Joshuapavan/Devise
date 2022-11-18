class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  def respond_with(resource, options={}) # method overriding
    if resource.persisted?
      render json: {
        status: 200,
        message: "Signed up successfully.",
        data: resource
      }, status: :ok
    else
      render json:{
        status: 500,
        message: "User wasn't created.",
        error: resource.errors.full_message
      }, status: :unprocessable_entity
    end
  end
end
