<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { CATEGORY_DEFAULT } from '@/storage/categories';
import { STATUSES } from '@/storage/statuses';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const category = ref(CATEGORY_DEFAULT());
const isCategoryLoaded = ref(false);

const reset = () => {
  category.value = CATEGORY_DEFAULT();
  isCategoryLoaded.value = false;
};

const dialog = useDialog();

const searchCategory = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/categories', id);
    category.value = response;
    isCategoryLoaded.value = true;
  } catch (error) {
    category.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openCategoryDialog = () => {
  searchDialog(dialog, 'Categories', searchCategory);
};
</script>

<template>
  <Form title="CATEGORIAS">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="category" :isResourceLoaded="isCategoryLoaded" path="/categories" />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>Código</label>
        <InputGroup>
          <InputNumber v-model="category.id" :disabled="isCategoryLoaded" @blur="searchCategory(category.id)" />
          <Button severity="secondary" @click="openCategoryDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-8">
        <label class="required">Descrição</label>
        <InputText v-model="category.description" maxlength="60" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Status</label>
        <Select v-model="category.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>
  </Form>
</template>
