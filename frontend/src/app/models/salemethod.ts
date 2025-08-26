import { Status } from "@/constants/status";
import { BaseModel } from "./basemodel";

export class SaleMethodModel extends BaseModel {
  id?: number;
  name = '';
  position?: number;
  status = Status.value('active');

  override default(): void {
    this.id = undefined;
    this.name = '';
    this.position = undefined;
    this.status = Status.value('active');
  }
}
