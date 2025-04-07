<script setup>
defineProps(['title']);
</script>

<template>
  <div class="card">
    <div class="font-semibold text-xl mb-3">{{ title }}</div>
    <slot name="header" />
    <slot />
  </div>
</template>
