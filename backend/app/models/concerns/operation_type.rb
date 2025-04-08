module OperationType
  module Enum
    extend ActiveSupport::Concern

    included do
      enum :operation_type,
        {
          sale: "sale",
          consignment: "consignment",
          return: "return"
        },
        prefix: true,
        validate: true
    end
  end
end
