# frozen_string_literal: true

module MaritalStatus
  module Enum
    extend ActiveSupport::Concern

    included do
      enum :marital_status,
           {
             single: "single",
             married: "married",
             divorced: "divorced",
             widowed: "widowed"
           },
           prefix: true,
           validate: { allow_blank: true }
    end
  end
end
