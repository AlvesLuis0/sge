# frozen_string_literal: true

class CrudRecord < ApplicationRecord
  self.abstract_class = true

  validates :status, inclusion: { in: StatusConstant.all_values.values }

  default_scope { where.not(status: StatusConstant.get_value(:deleted)) }
end
