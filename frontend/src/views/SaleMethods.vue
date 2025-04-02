<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/components/Form.vue';
import { SALE_METHOD_DEFAULT } from '@/factory/sale-methods';
import { STATUSES_OPTIONS } from '@/factory/statuses';
import api from '@/service/api';
import { dialogMessages } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const saleMethod = ref(SALE_METHOD_DEFAULT());
const isSaleMethodLoaded = ref(false);
const statusesOptions = ref(STATUSES_OPTIONS());

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
        <Button severity="secondary">
          <i class="pi pi-search"></i>
        </Button>
      </InputGroup>
    </div>

    <div class="md:col-span-6">
      <label for="description" class="required">Descrição</label>
      <InputText id="description" v-model="saleMethod.description" />
    </div>

    <div class="md:col-span-2">
      <label for="position">Posição</label>
      <InputNumber id="position" v-model="saleMethod.position" />
    </div>

    <div class="md:col-span-2">
      <label for="status" class="required">Status</label>
      <Select id="status" v-model="saleMethod.status" :options="statusesOptions" optionLabel="description" optionValue="value" />
    </div>
  </Form>
</template>
