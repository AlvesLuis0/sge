<script setup>
import { ref } from 'vue';

import AppMenuItem from './AppMenuItem.vue';

const model = ref([
  {
    label: 'Administrador',
    icon: 'pi pi-fw pi-cog',
    to: '/',
    items: [
      {
        label: 'Formas de venda',
        icon: 'pi pi-fw pi-tags',
        to: '/sale_methods'
      },
      {
        label: 'Formas de pagamento',
        icon: 'pi pi-fw pi-credit-card',
        to: '/payment_methods'
      }
    ]
  }
]);
</script>

<template>
  <ul class="layout-menu">
    <template v-for="(item, i) in model" :key="item">
      <app-menu-item v-if="!item.separator" :item="item" :index="i"></app-menu-item>
      <li v-if="item.separator" class="menu-separator"></li>
    </template>
  </ul>
</template>

<style lang="scss" scoped></style>
