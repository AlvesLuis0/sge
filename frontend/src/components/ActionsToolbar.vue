<script setup>
import api from '@/service/api';
import { dialogConfirmation, dialogMessages } from '@/utils/dialog';
import { useConfirm, useDialog } from 'primevue';

const emit = defineEmits(['reset']);
const { path, resource, isResourceLoaded } = defineProps(['path', 'resource', 'isResourceLoaded']);
const confirm = useConfirm();
const dialog = useDialog();

const save = async () => {
  try {
    const data = await api.save(path, resource);
    dialogMessages(dialog, data.messages);
    emit('reset');
  } catch (error) {
    dialogMessages(dialog, error.response.data.errors);
  }
};

const cancel = () => {
  dialogConfirmation(confirm, () => emit('reset'));
};

const destroy = () => {
  dialogConfirmation(confirm, async () => {
    const { data } = await api.destroy(path, resource.id);
    emit('reset');
    return data;
  });
};
</script>

<template>
  <Toolbar>
    <template #start>
      <Button label="Salvar" icon="pi pi-save" severity="success" class="mr-2" @click="save" />
      <Button label="Cancelar" icon="pi pi-save" severity="warn" class="mr-2" @click="cancel" />
      <Button label="Deletar" icon="pi pi-trash" severity="danger" @click="destroy" :disabled="!isResourceLoaded" />
    </template>
  </Toolbar>
</template>
