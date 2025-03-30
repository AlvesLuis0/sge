<script setup>
import api from '@/service/api';

const emit = defineEmits(['reset']);
const { path, resource } = defineProps(['path', 'resource']);

const save = async () => {
  const { data } = await api.save(path, resource);
  emit('reset');
  return data;
};

const cancel = () => {
  emit('reset');
};

const destroy = () => {
  console.log(path + '/' + resource.id);
};
</script>

<template>
  <Toolbar>
    <template #start>
      <Button label="Salvar" icon="pi pi-save" severity="success" class="mr-2" @click="save" />
      <Button label="Cancelar" icon="pi pi-save" severity="warn" class="mr-2" @click="cancel" />
      <Button label="Deletar" icon="pi pi-trash" severity="danger" @click="destroy" />
    </template>
  </Toolbar>
</template>
