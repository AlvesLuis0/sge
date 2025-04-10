<script setup>
import { STATUSES } from '@/storage/statuses';
import SearchDataTable from '../SearchDataTable.vue';
import { OPERATION_TYPES } from '@/storage/operation-types';
</script>

<template>
  <SearchDataTable lazy path="/operation_codes">
    <Column field="id" header="Código"></Column>
    <Column field="description" header="Descrição"></Column>
    <Column field="operation_type" header="Tipo de operação">
      <template #body="slotProps">
        <Tag :value="OPERATION_TYPES[slotProps.data.operation_type].description" :severity="OPERATION_TYPES[slotProps.data.operation_type].severity" />
      </template>
    </Column>
    <Column field="status" header="Status">
      <template #body="slotProps">
        <Tag :value="STATUSES[slotProps.data.status].description" :severity="STATUSES[slotProps.data.status].severity" />
      </template>
    </Column>
  </SearchDataTable>
</template>
