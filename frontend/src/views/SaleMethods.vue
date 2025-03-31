<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/components/Form.vue';
import { SALE_METHOD } from '@/factory/sale-methods';
import { STATUSES_OPTIONS } from '@/factory/statuses';
import api from '@/service/api';
import { ref } from 'vue';

const saleMethod = ref(SALE_METHOD());
const isSaleMethodLoaded = ref(false);
const statusesOptions = ref(STATUSES_OPTIONS());

const reset = () => {
  saleMethod.value = SALE_METHOD();
  isSaleMethodLoaded.value = false;
};

const searchSaleMethod = async (id) => {
  if (id == null) return;
  const response = await api.get('/sale_methods', id);
  saleMethod.value = response;
  isSaleMethodLoaded.value = true;
};
</script>

<template>
  <div class="card">
    <ActionsToolbar @reset="reset" :resource="saleMethod" :isResourceLoaded="isSaleMethodLoaded" path="/sale_methods" />
    <Form title="FORMAS DE VENDA">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex flex-wrap gap-2 w-2/6">
          <label for="id">Código</label>
          <InputGroup>
            <InputNumber id="id" v-model="saleMethod.id" :disabled="isSaleMethodLoaded" @blur="searchSaleMethod(saleMethod.id)" />
            <Button severity="secondary">
              <i class="pi pi-search"></i>
            </Button>
          </InputGroup>
        </div>
        <div class="flex flex-wrap gap-2 w-full">
          <label for="description" class="required">Descrição</label>
          <InputText id="description" v-model="saleMethod.description" />
        </div>
        <div class="flex flex-wrap gap-2 w-2/6">
          <label for="position">Posição</label>
          <InputNumber id="position" v-model="saleMethod.position" />
        </div>
        <div class="flex flex-wrap gap-2 w-2/6">
          <label for="status" class="required">Status</label>
          <Select id="status" v-model="saleMethod.status" :options="statusesOptions" optionLabel="description" optionValue="value" class="w-full" />
        </div>
      </div>
    </Form>
  </div>
</template>
