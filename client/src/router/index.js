// Router for Client
import {createRouter, createWebHistory} from 'vue-router'

// Views 
import UserHome from '../views/home.vue'
import trustedView from '../views/trustedView.vue'



// Paths 
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
  // history: createWebHashHistory(process.env.BASE_URL), // people on the internet think the <url>/#/ so I changed it. 
  history: createWebHistory(), // within html5 people like the look of this more
  routes
})

export default router; 



// import { createRouter, createWebHistory } from 'vue-router'

// const router = createRouter({
//   history: createWebHistory(),
//   routes: [
//     //...
//   ],
// })