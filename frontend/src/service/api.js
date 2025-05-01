import { objectToFormData } from '@/utils/form';
import axios from 'axios';

const API_URL = 'http://localhost:3000';
const api = axios.create({ baseURL: API_URL });

export function getImageUrl(path) {
  if (path == null) return null;
  return API_URL + path;
}

export default {
  async get(path, id, params = {}) {
    path += id == null ? '' : `/${id}`;
    path += '?' + new URLSearchParams(params).toString();
    const { data } = await api.get(path);
    return data;
  },

  async save(path, resource, asFormData = false) {
    const id = resource.id;
    let method;
    if (asFormData) resource = objectToFormData(resource);
    if (id != null) {
      method = api.put;
      path += `/${id}`;
    } else {
      method = api.post;
    }
    const { data } = await method(path, resource);
    return data;
  },

  async destroy(path, id) {
    path += id == null ? '' : `/${id}`;
    const { data } = await api.delete(path);
    return data;
  }
};
