<script setup>
import SearchDataTable from '../SearchDataTable.vue';
</script>

<template>
  <SearchDataTable lazy path="/cities" search-param="q[name_cont]">
    <Column field="id" header="Código"></Column>
    <Column field="name" header="Nome"></Column>
    <Column field="ibge" header="IBGE"></Column>
  </SearchDataTable>
</template>
