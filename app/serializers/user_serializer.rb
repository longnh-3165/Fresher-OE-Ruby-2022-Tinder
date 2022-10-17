class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_of_birth, :gender, :facebook, :phone,
             :description, :admin, :type_of, :country_id, :email,
             :created_at, :updated_at
end
