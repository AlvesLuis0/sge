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
      <div class="grid sm:grid-cols-3 grid-cols-1 gap-2">
        <Button label="Salvar" icon="pi pi-save" severity="success" class="col-span-1" @click="save" />
        <Button label="Cancelar" icon="pi pi-save" severity="warn" class="col-span-1" @click="cancel" />
        <Button label="Deletar" icon="pi pi-trash" severity="danger" class="col-span-1" @click="destroy" :disabled="!isResourceLoaded" />
      </div>
    </template>
  </Toolbar>
</template>
