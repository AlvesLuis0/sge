<script setup>
const emit = defineEmits(['reset']);
const { path, data } = defineProps(['path', 'data']);

const save = () => {
  console.table(data);
  console.log(path);
};

const cancel = () => {
  emit('reset');
};

const destroy = () => {
  console.log(path + '/' + data.id);
};
</script>

<template>
  <Toolbar>
    <template #start>
      <Button label="Salvar" icon="pi pi-save" severity="success" class="mr-2" @click="save" />
      <Button label="Cancelar" icon="pi pi-save" severity="warn" class="mr-2" @click="cancel()" />
      <Button label="Deletar" icon="pi pi-trash" severity="danger" @click="destroy" />
    </template>
  </Toolbar>
</template>
