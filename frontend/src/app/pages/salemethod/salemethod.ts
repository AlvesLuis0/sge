import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { SelectModule } from 'primeng/select';
import { ToolbarModule } from 'primeng/toolbar';
import { InputNumber } from "primeng/inputnumber";
import { Status } from '@/constants/status';

@Component({
  selector: 'app-salemethod',
  standalone: true,
  imports: [
    FormsModule,
    ToolbarModule,
    ButtonModule,
    InputTextModule,
    InputNumber,
    SelectModule
],
  template: `
    <p-toolbar class="mb-6">
      <ng-template #start>
        <div class="flex gap-2">
          <p-button label="Incluir" severity="primary" />
          <p-button severity="success" label="Salvar" />
          <p-button severity="warn" label="Cancelar" />
          <p-button severity="danger" label="Excluir" />
        </div>
      </ng-template>
    </p-toolbar>

    <div class="flex mt-8">
      <div class="card flex flex-col gap-6 w-full">
        <div class="font-semibold text-xl">Forma de venda</div>
        <div class="flex flex-col md:flex-row gap-6">
          <div class="flex flex-wrap gap-2 w-full">
            <label>Código</label>
            <p-inputnumber mode="decimal"></p-inputnumber>
          </div>

          <div class="flex flex-wrap gap-2 w-full">
            <label class="required">Nome</label>
            <input pInputText />
          </div>

          <div class="flex flex-wrap gap-2 w-full">
            <label class="required">Ordem</label>
            <p-inputnumber showButtons mode="decimal" />
          </div>

          <div class="flex flex-wrap gap-2 w-full">
            <label class="required">Status</label>
            <p-select [options]="statusValues" />
          </div>
        </div>
      </div>
    </div>
  `
})
export class SaleMethod {
  statusValues = Status.options();
}
