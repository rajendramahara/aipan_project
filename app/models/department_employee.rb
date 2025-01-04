class DepartmentEmployee < ApplicationRecord
  belongs_to :user
  belongs_to :department
end
