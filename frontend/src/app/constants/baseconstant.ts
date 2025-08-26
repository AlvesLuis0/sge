export type Constant = { value: number; label: string }

export abstract class BaseConstant {
  protected static _values: { [key: string]: Constant } = {};

  static values() {
    return Object.values(this._values).map(v => v.value)
  }

  static value(key: string) {
    return this._values[key].value;
  }

  static options() {
    return Object.values(this._values)
  }
}
