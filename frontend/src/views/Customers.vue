<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { CUSTOMER_DEFAULT } from '@/storage/customers';
import { MARITAL_STATUSES } from '@/storage/marital-statuses';
import { PERSON_TYPES } from '@/storage/person-types';
import { STATUSES } from '@/storage/statuses';
import { stringToDate } from '@/utils/date';
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
    customer.value.registered_at = stringToDate(customer.value.registered_at);
    customer.value.person.birth_date = stringToDate(customer.value.person.birth_date);
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

    <!-- individual -->
    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>CPF</label>
        <InputText v-model="customer.person.cpf" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="11" />
      </div>

      <div class="md:col-span-2">
        <label>RG</label>
        <InputText v-model="customer.person.rg" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="15" />
      </div>

      <div class="md:col-span-2">
        <label>Órgão emissor</label>
        <InputText v-model="customer.person.issuing_agency" maxlength="20" />
      </div>

      <div class="md:col-span-2">
        <label>Data de nascimento</label>
        <DatePicker v-model="customer.person.birth_date" show-icon :max-date="new Date()" />
      </div>

      <div class="md:col-span-2">
        <label>Estado civil</label>
        <Select v-model="customer.person.marital_status" showClear :options="Object.values(MARITAL_STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>

    <!-- company -->
    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>CNPJ</label>
        <InputText v-model="customer.person.cnpj" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="14" />
      </div>

      <div class="md:col-span-2">
        <label>Inscrição estadual</label>
        <InputText v-model="customer.person.state_registration" maxlength="20" />
      </div>

      <div class="md:col-span-4">
        <label>Nome fantasia</label>
        <InputText v-model="customer.person.trade_name" maxlength="40" />
      </div>
    </div>
  </Form>
</template>
