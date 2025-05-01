<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import ImageUpload from '@/components/ImageUpload.vue';
import Form from '@/layout/Form.vue';
import api, { getImageUrl } from '@/service/api';
import { COLOR_DEFAULT } from '@/storage/colors';
import { STATUSES } from '@/storage/statuses';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const color = ref(COLOR_DEFAULT());
const isColorLoaded = ref(false);

const reset = () => {
  color.value = COLOR_DEFAULT();
  isColorLoaded.value = false;
};

const dialog = useDialog();

const searchColor = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/colors', id);
    color.value = response;
    color.value.image_path = getImageUrl(color.value.image_path);
    isColorLoaded.value = true;
  } catch (error) {
    color.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openColorDialog = () => {
  searchDialog(dialog, 'Colors', searchColor);
};
</script>

<template>
  <Form title="CORES">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="color" :isResourceLoaded="isColorLoaded" path="/colors" as-form-data />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>Código</label>
        <InputGroup>
          <InputNumber v-model="color.id" :disabled="isColorLoaded" @blur="searchColor(color.id)" />
          <Button severity="secondary" @click="openColorDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-8">
        <label class="required">Descrição</label>
        <InputText v-model="color.description" maxlength="60" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Status</label>
        <Select v-model="color.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <ImageUpload v-model="color.image" :initial-preview="color.image_path" />
      </div>
    </div>
  </Form>
</template>
