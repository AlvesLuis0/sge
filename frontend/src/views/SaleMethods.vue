<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import { SALE_METHOD_DEFAULT } from '@/factory/sale-methods';
import api from '@/service/api';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';
import { STATUSES } from '@/factory/statuses';

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
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openSaleMethodDialog = () => {
  searchDialog(dialog, 'SaleMethods');
};
</script>

<template>
  <Form title="FORMAS DE VENDA">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="saleMethod" :isResourceLoaded="isSaleMethodLoaded" path="/sale_methods" />
    </template>

    <div class="md:col-span-2">
      <label for="id">Código</label>
      <InputGroup>
        <InputNumber id="id" v-model="saleMethod.id" :disabled="isSaleMethodLoaded" @blur="searchSaleMethod(saleMethod.id)" />
        <Button severity="secondary" @click="openSaleMethodDialog">
          <i class="pi pi-search"></i>
        </Button>
      </InputGroup>
    </div>

    <div class="md:col-span-6">
      <label for="description" class="required">Descrição</label>
      <InputText id="description" v-model="saleMethod.description" maxlength="60" />
    </div>

    <div class="md:col-span-2">
      <label for="position">Posição</label>
      <InputNumber id="position" v-model="saleMethod.position" />
    </div>

    <div class="md:col-span-2">
      <label for="status" class="required">Status</label>
      <Select id="status" v-model="saleMethod.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
    </div>
  </Form>
</template>
