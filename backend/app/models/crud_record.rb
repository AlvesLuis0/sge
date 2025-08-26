# frozen_string_literal: true

class CrudRecord < ApplicationRecord
  self.abstract_class = true

  validates :status, inclusion: { in: StatusConstant.values }

  default_scope { where.not(status: StatusConstant.value(:deleted)) }
end
