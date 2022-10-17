class User::RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    resource.addresses.build
    respond_with resource
  end
end
