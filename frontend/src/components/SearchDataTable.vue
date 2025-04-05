<script setup>
import api from '@/service/api';
import { onMounted, ref } from 'vue';

const props = defineProps({
  path: String,
  params: {
    type: Object,
    default: () => {}
  }
});

const resources = ref([]);
const page = ref(0);
const isLoading = ref(false);
const meta = ref({ totalPages: 0, perPage: 0, totalCount: 0, currentPage: 1 });

const fetchResources = async () => {
  isLoading.value = true;
  const data = await api.get(props.path, null, { page: page.value, ...props.params });
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
  <DataTable lazy :value="resources" paginator :rows="meta.perPage" :totalRecords="meta.totalCount" :loading="isLoading" @page="onPageChange($event)">
    <slot></slot>
  </DataTable>
</template>
