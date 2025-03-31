export const dialog = (dialog, options) => {
  dialog.require(options);
};

export const confirmation = (confirm, accept) =>
  dialog(confirm, {
    message: 'Tem certeza?',
    header: 'Confirmação',
    icon: 'pi pi-info-circle',
    rejectLabel: 'Cancelar',
    acceptLabel: 'Confirmar',
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
