<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/components/Form.vue';
import { ref } from 'vue';

const defaultSaleMethod = () => ({
  id: null,
  description: null,
  position: null,
  status: 'active'
});
const saleMethod = ref(defaultSaleMethod());
const isSearchValueDisabled = ref(false);
const statusesOptions = ref([
  { description: 'Ativo', value: 'active' },
  { description: 'Inativo', value: 'inactive' }
]);

const reset = () => {
  saleMethod.value = defaultSaleMethod();
  isSearchValueDisabled.value = false;
};

const searchSaleMethod = async(id) => {
  //
}
</script>

<template>
  <div class="card">
    <ActionsToolbar @reset="reset" :data="saleMethod" path="/sale_methods" />
    <Form title="FORMAS DE VENDA">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex flex-wrap gap-2 w-full">
          <label for="id">Código</label>
          <InputGroup>
            <InputNumber id="id" v-model="saleMethod.id" :disabled="isSearchValueDisabled" @blur="searchSaleMethod(saleMethod.id)" />
            <Button severity="secondary">
              <i class="pi pi-search"></i>
            </Button>
          </InputGroup>
        </div>
        <div class="flex flex-wrap gap-2 w-full">
          <label for="description" class="required">Descrição</label>
          <InputText id="description" v-model="saleMethod.description" />
        </div>
        <div class="flex flex-wrap gap-2 w-full">
          <label for="position">Posição</label>
          <InputNumber id="position" v-model="saleMethod.position" />
        </div>
        <div class="flex flex-wrap gap-2 w-full">
          <label for="status" class="required">Status</label>
          <Select id="status" v-model="saleMethod.status" :options="statusesOptions" optionLabel="description" optionValue="value" class="w-full"></Select>
        </div>
      </div>
    </Form>
  </div>
</template>
