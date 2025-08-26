# frozen_string_literal: true

class ApplicationConstant
  def self.values
    _values.values
  end

  def self.value(key)
    _values.fetch(key)
  end

  protected

  def self._values
    {}
  end
end
