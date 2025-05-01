<script setup>
import { ref, watch } from 'vue';

const { initialPreview, modelValue } = defineProps({
  modelValue: File,
  initialPreview: String
});

const emit = defineEmits(['update:modelValue']);

const preview = ref(initialPreview);

const onImageSelect = (event) => {
  const file = event.files[0];
  if (file) {
    emit('update:modelValue', file);

    const reader = new FileReader();
    reader.onload = (e) => {
      preview.value = e.target.result;
    };
    reader.readAsDataURL(file);
  }
};

watch(
  () => initialPreview || modelValue,
  (value) => (preview.value = value)
);
</script>

<template>
  <div class="space-y-3">
    <FileUpload mode="basic" name="image" accept="image/*" customUpload :auto="true" @uploader="onImageSelect" chooseLabel="Selecionar Imagem" class="w-full" />

    <div v-if="preview" class="relative">
      <img :src="preview" alt="Prévia da imagem" class="w-full max-h-64 object-contain rounded shadow" />
    </div>
  </div>
</template>
