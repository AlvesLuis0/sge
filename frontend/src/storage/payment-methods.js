import { PAYMENT_TYPES } from './payment-types';
import { STATUSES } from './statuses';

export const PAYMENT_METHOD_DEFAULT = () => ({
  id: null,
  description: null,
  payment_type: PAYMENT_TYPES.cash.value,
  status: STATUSES.active.value
});
