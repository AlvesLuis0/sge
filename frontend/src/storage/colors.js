import { STATUSES } from './statuses';

export const COLOR_DEFAULT = () => ({
  id: null,
  description: null,
  image_path: null,
  image: null,
  _remove_image: false,
  status: STATUSES.active.value
});
