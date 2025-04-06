class CreatePaymentTypes < ActiveRecord::Migration[8.0]
  def change
    create_enum :payment_types, [ 'cash', 'credit_card', 'debit_card', 'installment', 'pix' ]
  end
end
