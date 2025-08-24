# frozen_string_literal: true

class ApplicationConstant
  def self.all_values
    {}
  end

  def self.public_values
    self.all_values
  end

  def self.get_value(key)
    self.all_values.fetch(key)
  end
end
