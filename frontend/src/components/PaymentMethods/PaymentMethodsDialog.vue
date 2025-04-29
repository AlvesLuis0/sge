<script setup>
import { STATUSES } from '@/storage/statuses';
import SearchDataTable from '../SearchDataTable.vue';
import { PAYMENT_TYPES } from '@/storage/payment-types';
</script>

<template>
  <SearchDataTable path="/payment_methods">
    <Column field="id" header="Código"></Column>
    <Column field="description" header="Descrição"></Column>
    <Column field="payment_type" header="Tipo de pagamento">
      <template #body="slotProps">
        <Tag :value="PAYMENT_TYPES[slotProps.data.payment_type].description" :severity="PAYMENT_TYPES[slotProps.data.payment_type].severity" />
      </template>
    </Column>
    <Column field="status" header="Status">
      <template #body="slotProps">
        <Tag :value="STATUSES[slotProps.data.status].description" :severity="STATUSES[slotProps.data.status].severity" />
      </template>
    </Column>
  </SearchDataTable>
</template>
