import { Routes } from '@angular/router';
import { SaleMethod } from './salemethod/salemethod';

export default [
  { path: 'salemethod', component: SaleMethod },
  { path: '**', redirectTo: '/notfound' }
] as Routes;
