<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { PAYMENT_METHOD_DEFAULT } from '@/storage/payment-methods';
import { PAYMENT_TYPES } from '@/storage/payment-types';
import { STATUSES } from '@/storage/statuses';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const paymentMethod = ref(PAYMENT_METHOD_DEFAULT());
const isPaymentMethodLoaded = ref(false);

const reset = () => {
  paymentMethod.value = PAYMENT_METHOD_DEFAULT();
  isPaymentMethodLoaded.value = false;
};

const dialog = useDialog();

const searchPaymentMethod = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/payment_methods', id);
    paymentMethod.value = response;
    isPaymentMethodLoaded.value = true;
  } catch (error) {
    paymentMethod.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openPaymentMethodDialog = () => {
  searchDialog(dialog, 'PaymentMethods', searchPaymentMethod);
};
</script>

<template>
  <Form title="FORMAS DE PAGAMENTO">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="paymentMethod" :isResourceLoaded="isPaymentMethodLoaded" path="/payment_methods" />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label for="id">Código</label>
        <InputGroup>
          <InputNumber id="id" v-model="paymentMethod.id" :disabled="isPaymentMethodLoaded" @blur="searchPaymentMethod(paymentMethod.id)" />
          <Button severity="secondary" @click="openPaymentMethodDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-6">
        <label for="description" class="required">Descrição</label>
        <InputText id="description" v-model="paymentMethod.description" maxlength="60" />
      </div>

      <div class="md:col-span-2">
        <label for="payment_type" class="required">Tipo de pagamento</label>
        <Select id="payment_type" v-model="paymentMethod.payment_type" :options="Object.values(PAYMENT_TYPES)" optionLabel="description" optionValue="value" />
      </div>

      <div class="md:col-span-2">
        <label for="status" class="required">Status</label>
        <Select id="status" v-model="paymentMethod.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>
  </Form>
</template>
