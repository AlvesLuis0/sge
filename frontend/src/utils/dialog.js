import { defineAsyncComponent } from 'vue';

const dialog = (context, options) => {
  context.require(options);
};

const customDialog = (context, view, options) => {
  context.open(view, options);
};

export const searchDialog = (
  context,
  resource,
  onSelect = (id) => {
    console.log(id);
  }
) => {
  customDialog(
    context,
    defineAsyncComponent(() => import(`@/components/${resource}/${resource}Dialog.vue`)),
    {
      props: {
        header: 'PESQUISAR',
        modal: true
      },
      onClose: (opt = {}) => {
        onSelect((opt.data || {}).selectedId);
      }
    }
  );
};

export const dialogMessages = (context, messages) => {
  customDialog(
    context,
    defineAsyncComponent(() => import('@/components/DialogList.vue')),
    {
      props: {
        header: 'INFORMAÇÃO',
        modal: true
      },
      data: { items: messages }
    }
  );
};

export const dialogConfirmation = (context, accept) =>
  dialog(context, {
    message: 'Tem certeza que deseja fazer isso?',
    header: 'CONFIRMAÇÃO',
    icon: 'pi pi-info-circle',
    rejectProps: {
      label: 'Cancelar',
      severity: 'secondary',
      outlined: true
    },
    acceptProps: {
      label: 'Confirmar',
      severity: 'danger'
    },
    accept
  });
