<script setup>
import SearchDataTable from '../SearchDataTable.vue';
</script>

<template>
  <SearchDataTable path="/cities" search-param="q[name_cont]">
    <Column field="id" header="Código"></Column>
    <Column field="name" header="Nome"></Column>
    <Column field="state.name" header="Estado"></Column>
  </SearchDataTable>
</template>
