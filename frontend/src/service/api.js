import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000'
});

export default {
  async get(path, id) {
    const { data } = await api.get(`${path}/${id}`);
    return data;
  },

  async save(path, resource) {
    const method = resource.id == null ? api.post : api.put;
    path += resource.id == null ? '' : `/${resource.id}`;
    const { data } = await method(path, resource);
    console.log(data);
    return data;
  }
};
