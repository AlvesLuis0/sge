<script setup>
import { inject, onMounted, ref } from 'vue';

const dialogRef = inject('dialogRef');
const items = ref([]);

onMounted(() => {
  items.value = dialogRef.value.data.items;
});
</script>
<template>
  <ul class="list-disc list-inside">
    <li class="p-confirmdialog-message" v-for="item of items" :key="item">{{ item }}</li>
  </ul>
  <div class="p-dialog-footer"></div>
</template>
