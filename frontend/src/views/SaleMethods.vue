<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { SALE_METHOD_DEFAULT } from '@/storage/sale-methods';
import { STATUSES } from '@/storage/statuses';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const saleMethod = ref(SALE_METHOD_DEFAULT());
const isSaleMethodLoaded = ref(false);

const reset = () => {
  saleMethod.value = SALE_METHOD_DEFAULT();
  isSaleMethodLoaded.value = false;
};

const dialog = useDialog();

const searchSaleMethod = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/sale_methods', id);
    saleMethod.value = response;
    isSaleMethodLoaded.value = true;
  } catch (error) {
    saleMethod.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openSaleMethodDialog = () => {
  searchDialog(dialog, 'SaleMethods', searchSaleMethod);
};
</script>

<template>
  <Form title="FORMAS DE VENDA">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="saleMethod" :isResourceLoaded="isSaleMethodLoaded" path="/sale_methods" />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>Código</label>
        <InputGroup>
          <InputNumber v-model="saleMethod.id" :disabled="isSaleMethodLoaded" @blur="searchSaleMethod(saleMethod.id)" />
          <Button severity="secondary" @click="openSaleMethodDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-6">
        <label class="required">Descrição</label>
        <InputText v-model="saleMethod.description" maxlength="60" />
      </div>

      <div class="md:col-span-2">
        <label>Posição</label>
        <InputNumber v-model="saleMethod.position" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Status</label>
        <Select v-model="saleMethod.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>
  </Form>
</template>
