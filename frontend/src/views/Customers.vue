<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { CUSTOMER_DEFAULT } from '@/storage/customers';
import { PERSON_TYPES } from '@/storage/person-types';
import { STATUSES } from '@/storage/statuses';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const customer = ref(CUSTOMER_DEFAULT());
const isCustomerLoaded = ref(false);

const reset = () => {
  customer.value = CUSTOMER_DEFAULT();
  isCustomerLoaded.value = false;
};

const dialog = useDialog();

const searchCustomer = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/customers', id);
    customer.value = response;
    customer.value.registered_at = new Date(customer.value.registered_at);
    isCustomerLoaded.value = true;
  } catch (error) {
    customer.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openCustomerDialog = () => {
  searchDialog(dialog, 'Customers', searchCustomer);
};
</script>

<template>
  <Form title="CLIENTES">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="customer" :isResourceLoaded="isCustomerLoaded" path="/customers" />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>Código</label>
        <InputGroup>
          <InputNumber v-model="customer.id" :disabled="isCustomerLoaded" @blur="searchCustomer(customer.id)" />
          <Button severity="secondary" @click="openCustomerDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-4">
        <label class="required">Nome</label>
        <InputText v-model="customer.person.name" maxlength="100" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Tipo de pessoa</label>
        <Select v-model="customer.person.person_type" :options="Object.values(PERSON_TYPES)" optionLabel="description" optionValue="value" />
      </div>

      <div class="md:col-span-2">
        <label>Registrado em</label>
        <DatePicker v-model="customer.registered_at" disabled />
      </div>

      <div class="md:col-span-2">
        <label class="required">Status</label>
        <Select v-model="customer.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>
  </Form>
</template>
