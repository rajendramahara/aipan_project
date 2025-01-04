class Department < ApplicationRecord
  belongs_to :organization

  has_many :department_employees, dependent: :destroy
  has_many :users, through: :department_employees

  has_many :announcement_recipients, as: :announceable, dependent: :destroy
end
