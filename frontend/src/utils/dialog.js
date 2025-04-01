import { defineAsyncComponent } from 'vue';

const dialog = (context, options) => {
  context.require(options);
};

const customDialog = (context, view, options) => {
  context.open(view, options);
};

export const dialogMessages = (context, messages) => {
  customDialog(
    context,
    defineAsyncComponent(() => import('@/components/DialogList.vue')),
    {
      props: {
        header: 'Informação',
        modal: true
      },
      data: { items: messages }
    }
  );
};

export const dialogConfirmation = (context, accept) =>
  dialog(context, {
    message: 'Tem certeza que deseja fazer isso?',
    header: 'Confirmação',
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
