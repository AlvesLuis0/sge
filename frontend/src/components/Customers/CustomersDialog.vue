<script setup>
import { STATUSES } from '@/storage/statuses';
import SearchDataTable from '../SearchDataTable.vue';
</script>

<template>
  <SearchDataTable path="/customers" search-param="q[person_name_cont]">
    <Column field="id" header="Código"></Column>
    <Column field="person.name" header="Nome"></Column>
    <Column field="status" header="Status">
      <template #body="slotProps">
        <Tag :value="STATUSES[slotProps.data.status].description" :severity="STATUSES[slotProps.data.status].severity" />
      </template>
    </Column>
  </SearchDataTable>
</template>
