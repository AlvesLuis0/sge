export const PAYMENT_TYPES = Object.freeze({
  cash: { value: 'cash', description: 'Dinheiro', severity: 'success' },
  credit_card: { value: 'credit_card', description: 'Cartão de crédito', severity: 'success' },
  debit_card: { value: 'debit_card', description: 'Cartão de débito', severity: 'success' },
  installment: { value: 'installment', description: 'Crediário', severity: 'success' },
  pix: { value: 'pix', description: 'Pix', severity: 'success' }
});
