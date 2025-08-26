import { BaseConstant } from "./baseconstant";

export class Status extends BaseConstant {
  protected static override _values = {
    active: { value: 1, label: "Ativo" },
    inactive: { value: 0, label: "Inativo" },
    deleted: { value: -1, label: "Excluído" }
  };

  static override options() {
    return [this._values.active, this._values.inactive];
  }
}
