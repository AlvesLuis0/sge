import AppLayout from '@/layout/AppLayout.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: AppLayout,
      children: [
        {
          path: '/sale_methods',
          name: 'sale_methods',
          component: () => import('@/views/SaleMethods.vue')
        },
        {
          path: '/payment_methods',
          name: 'payment_methods',
          component: () => import('@/views/PaymentMethods.vue')
        }
      ]
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not_found',
      component: () => import('@/views/NotFound.vue')
    }
  ]
});

export default router;
