module Organization::Attachable
  extend ActiveSupport::Concern

  def logo_attached?
    logo.attached?
  end

  def get_logo
    logo
  end
end
