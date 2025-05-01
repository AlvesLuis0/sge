<script setup>
import { ref, watch } from 'vue';

const { initialPreview, modelValue } = defineProps({
  modelValue: File,
  initialPreview: String
});

const emit = defineEmits(['update:modelValue', 'update:_removeImage']);

const preview = ref(initialPreview);

const onImageSelect = (event) => {
  const file = event.files[0];
  if (file) {
    emit('update:modelValue', file);
    emit('update:_removeImage', false);

    const reader = new FileReader();
    reader.onload = (e) => {
      preview.value = e.target.result;
    };
    reader.readAsDataURL(file);
  }
};

const clearImage = () => {
  emit('update:modelValue', null);
  emit('update:_removeImage', true);
  preview.value = null;
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
      <Image :src="preview" alt="Prévia da imagem" class="w-full max-h-64 object-contain rounded shadow" preview />
      <Button icon="pi pi-times" class="absolute top-2 right-2 p-button-rounded p-button-danger" @click="clearImage()" aria-label="Limpar imagem" />
    </div>
  </div>
</template>
