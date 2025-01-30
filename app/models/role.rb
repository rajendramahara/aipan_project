class Role < ApplicationRecord
  belongs_to :organization
  has_many :user_roles

  has_many :employee_roles
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions
end
