<script setup>
defineProps(['title']);
</script>

<template>
  <div class="card">
    <div class="font-semibold text-xl mb-3">{{ title }}</div>
    <slot name="header" />
    <div class="card flex flex-col gap-4">
      <slot />
    </div>
  </div>
</template>
