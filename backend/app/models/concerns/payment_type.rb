module PaymentType
  module Enum
    extend ActiveSupport::Concern

    included do
      enum :payment_type,
        {
          cash: "cash",
          credit_card: "credit_card",
          debit_card: "debit_card",
          installment: "installment",
          pix: "pix"
        },
        prefix: true,
        validate: true
    end
  end
end
