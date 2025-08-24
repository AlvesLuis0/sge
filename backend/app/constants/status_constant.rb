# frozen_string_literal: true

class StatusConstant < ApplicationConstant
  def self.all_values
    {
      active: 1,
      inactive: 0,
      deleted: -1
    }
  end

  def self.public_values
    super.except(:deleted)
  end
end
