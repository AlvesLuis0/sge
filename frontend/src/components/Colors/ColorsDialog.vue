<script setup>
import { STATUSES } from '@/storage/statuses';
import SearchDataTable from '../SearchDataTable.vue';
</script>

<template>
  <SearchDataTable path="/colors">
    <Column field="id" header="Código"></Column>
    <Column field="description" header="Descrição"></Column>
    <Column field="status" header="Status">
      <template #body="slotProps">
        <Tag :value="STATUSES[slotProps.data.status].description" :severity="STATUSES[slotProps.data.status].severity" />
      </template>
    </Column>
  </SearchDataTable>
</template>
