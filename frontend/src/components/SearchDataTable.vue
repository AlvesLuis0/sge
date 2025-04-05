<script setup>
import api from '@/service/api';
import { onMounted, ref } from 'vue';

const props = defineProps({
  path: String,
  searchParam: {
    type: String,
    default: () => 'q[description_cont]'
  },
  params: {
    type: Object,
    default: () => ({})
  }
});

const resources = ref([]);
const page = ref(1);
const search = ref('');
const isLoading = ref(false);
const meta = ref({ totalPages: 0, perPage: 0, totalCount: 0, currentPage: 1 });

const fetchResources = async () => {
  isLoading.value = true;
  const params = { ...props.params, page: page.value };
  params[props.searchParam] = search.value;
  const data = await api.get(props.path, null, params);
  resources.value = data.resources;
  meta.value = {
    totalPages: data.meta.total_pages,
    perPage: data.meta.per_page,
    totalCount: data.meta.total_count,
    currentPage: data.meta.current_page
  };
  isLoading.value = false;
};

const onPageChange = (event) => {
  page.value = event.page + 1;
  fetchResources();
};

onMounted(fetchResources);
</script>

<template>
  <div>
    <div class="flex gap-2">
      <IconField class="w-full">
        <InputIcon>
          <i class="pi pi-search" />
        </InputIcon>
        <InputText type="search" v-model="search" />
      </IconField>
      <Button @click="fetchResources()">Buscar</Button>
    </div>

    <DataTable lazy :value="resources" paginator :rows="meta.perPage" :totalRecords="meta.totalCount" :loading="isLoading" @page="onPageChange($event)">
      <template #empty>Nenhum registro encontrado</template>
      <template #loading>Carregando registros. Por favor, espere</template>
      <slot></slot>
    </DataTable>
  </div>
</template>
