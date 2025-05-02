<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { CONTACT_TYPES } from '@/storage/contact-types';
import { CUSTOMER_DEFAULT } from '@/storage/customers';
import { MARITAL_STATUSES } from '@/storage/marital-statuses';
import { PERSON_TYPES } from '@/storage/person-types';
import { STATUSES } from '@/storage/statuses';
import { stringToDate, stringToDatetime } from '@/utils/date';
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
    customer.value.registered_at = stringToDatetime(customer.value.registered_at);
    customer.value.person.birth_date = stringToDate(customer.value.person.birth_date);
    searchCity(customer.value.person.address.city_id);
    isCustomerLoaded.value = true;
  } catch (error) {
    customer.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const searchCity = async (id) => {
  try {
    if (id == null) {
      customer.value.person.address.city_id = null;
      customer.value.person.address.city_name = null;
      return;
    }
    const response = await api.get('/cities', id);
    customer.value.person.address.city_id = response.id;
    customer.value.person.address.city_name = response.name;
  } catch (error) {
    customer.value.person.address.city_id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openCityDialog = () => {
  searchDialog(dialog, 'Cities', searchCity);
};

const openCustomerDialog = () => {
  searchDialog(dialog, 'Customers', searchCustomer);
};

const isEmail = ({ contact_type }) => contact_type == CONTACT_TYPES.email.value;
const isMobile = ({ contact_type }) => contact_type == CONTACT_TYPES.mobile.value;
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
    <div v-show="customer.person.person_type == PERSON_TYPES.individual.value" class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>CPF</label>
        <InputText v-model="customer.person.cpf" v-keyfilter.pint maxlength="11" />
      </div>

      <div class="md:col-span-2">
        <label>RG</label>
        <InputText v-model="customer.person.rg" v-keyfilter.pint maxlength="15" />
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
    <div v-show="customer.person.person_type == PERSON_TYPES.company.value" class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>CNPJ</label>
        <InputText v-model="customer.person.cnpj" v-keyfilter.pint maxlength="14" />
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

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-6">
        <label>Rua</label>
        <InputText v-model="customer.person.address.street" maxlength="60" />
      </div>

      <div class="md:col-span-1">
        <label>Número</label>
        <InputText v-model="customer.person.address.number" v-keyfilter.pint maxlength="5" />
      </div>

      <div class="md:col-span-5">
        <label>Complemento</label>
        <InputText v-model="customer.person.address.complement" maxlength="60" />
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>CEP</label>
        <InputText v-model="customer.person.address.zip_code" v-keyfilter.pint maxlength="8" />
      </div>

      <div class="md:col-span-6">
        <label>Bairro</label>
        <InputText v-model="customer.person.address.neighborhood" maxlength="60" />
      </div>

      <div class="md:col-span-1">
        <label>Cidade</label>
        <InputGroup>
          <InputNumber v-model="customer.person.address.city_id" @blur="searchCity(customer.person.address.city_id)" />
          <Button severity="secondary" @click="openCityDialog()">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-3">
        <label>&nbsp;</label>
        <InputText v-model="customer.person.address.city_name" disabled />
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <div v-for="(contact, index) of customer.person.contacts" :key="contact.id || index" :class="`md:col-span-${isEmail(contact) ? '4' : '2'}`">
        <div v-if="isEmail(contact)">
          <label>Email</label>
          <InputText v-model="contact.email" v-keyfilter.email maxlength="100" />
        </div>

        <div v-if="isMobile(contact)">
          <label>Celular {{ index }}</label>
          <InputText v-model="contact.mobile_number" v-keyfilter.pint maxlength="13" />
        </div>
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-12">
        <label>Observação</label>
        <Textarea v-model="customer.note" maxlength="1000" />
      </div>
    </div>
  </Form>
</template>
