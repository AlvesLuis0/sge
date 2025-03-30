<script setup>
defineProps(['title']);
</script>

<template>
  <Fluid>
    <div class="flex">
      <div class="card flex flex-col gap-4 w-full">
        <div class="font-semibold text-xl">{{ title }}</div>
        <slot />
      </div>
    </div>
  </Fluid>
</template>
