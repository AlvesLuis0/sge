<script setup>
import ActionsToolbar from '@/components/ActionsToolbar.vue';
import Form from '@/layout/Form.vue';
import api from '@/service/api';
import { ENTRY_EXIT } from '@/storage/entry-exit';
import { OPERATION_CODE_DEFAULT } from '@/storage/operation-codes';
import { OPERATION_TYPES } from '@/storage/operation-types';
import { STATUSES } from '@/storage/statuses';
import { YES_NO } from '@/storage/yes-no';
import { dialogMessages, searchDialog } from '@/utils/dialog';
import { useDialog } from 'primevue/usedialog';
import { ref } from 'vue';

const operationCode = ref(OPERATION_CODE_DEFAULT());
const isOperationCodeLoaded = ref(false);

const reset = () => {
  operationCode.value = OPERATION_CODE_DEFAULT();
  isOperationCodeLoaded.value = false;
};

const dialog = useDialog();

const searchOperationCode = async (id) => {
  try {
    if (id == null) return;
    const response = await api.get('/operation_codes', id);
    operationCode.value = response;
    isOperationCodeLoaded.value = true;
  } catch (error) {
    operationCode.value.id = null;
    dialogMessages(dialog, error.response.data.errors);
  }
};

const openOperationCodeDialog = () => {
  searchDialog(dialog, 'OperationCodes', searchOperationCode);
};
</script>

<template>
  <Form title="CÓDIGOS DE OPERAÇÃO">
    <template #header>
      <ActionsToolbar @reset="reset" :resource="operationCode" :isResourceLoaded="isOperationCodeLoaded" path="/operation_codes" />
    </template>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label>Código</label>
        <InputGroup>
          <InputNumber v-model="operationCode.id" :disabled="isOperationCodeLoaded" @blur="searchOperationCode(operationCode.id)" />
          <Button severity="secondary" @click="openOperationCodeDialog">
            <i class="pi pi-search"></i>
          </Button>
        </InputGroup>
      </div>

      <div class="md:col-span-8">
        <label class="required">Descrição</label>
        <InputText v-model="operationCode.description" maxlength="60" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Status</label>
        <Select v-model="operationCode.status" :options="Object.values(STATUSES)" optionLabel="description" optionValue="value" />
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <div class="md:col-span-2">
        <label class="required">Tipo de operação</label>
        <Select v-model="operationCode.operation_type" :options="Object.values(OPERATION_TYPES)" optionLabel="description" optionValue="value" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Entrada/Saída</label>
        <Select v-model="operationCode.entry_exit" :options="Object.values(ENTRY_EXIT)" optionLabel="description" optionValue="value" />
      </div>

      <div class="md:col-span-2">
        <label class="required">Atualiza estoque</label>
        <Select v-model="operationCode.updates_stock" :options="Object.values(YES_NO)" optionLabel="description" optionValue="value" />
      </div>
    </div>

    <div class="grid md:grid-cols-12 gap-4">
      <Fieldset class="md:col-span-3" legend="Digita quantidade">
        <div class="flex gap-2">
          <Checkbox v-model="operationCode.input_quantity_on_inclusion" binary />
          <label>Inclusão</label>
        </div>

        <div class="flex gap-2 mt-2">
          <Checkbox v-model="operationCode.input_quantity_on_update" binary />
          <label>Alteração</label>
        </div>
      </Fieldset>

      <Fieldset class="md:col-span-3" legend="Digita preço">
        <div class="flex gap-2">
          <Checkbox v-model="operationCode.input_price_on_inclusion" binary />
          <label>Inclusão</label>
        </div>

        <div class="flex gap-2 mt-2">
          <Checkbox v-model="operationCode.input_price_on_update" binary />
          <label>Alteração</label>
        </div>
      </Fieldset>
    </div>
  </Form>
</template>
