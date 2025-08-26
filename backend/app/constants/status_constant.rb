# frozen_string_literal: true

class StatusConstant < ApplicationConstant
  protected

  def self._values
    {
      active: 1,
      inactive: 0,
      deleted: -1
    }
  end
end
