import { STATUSES } from './statuses';

export const SALE_METHOD_DEFAULT = () => ({
  id: null,
  description: null,
  position: null,
  status: STATUSES.active.value
});
