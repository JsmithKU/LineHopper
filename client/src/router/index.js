import {createRouter, createWebHashHistory} from 'vue-router'

// Views 
import UserHome from '../views/home.vue'
import trustedView from '../views/trustedView.vue'

const routes = [
  {
    path: '/',
    name: 'UserHome',
    component: UserHome,
  },
  {
    path: '/trust',
    name: 'trustedView',
    component: trustedView,
  }

]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router; 