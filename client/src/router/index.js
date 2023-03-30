// Router for Client
import {createRouter, createWebHistory} from 'vue-router'

// Views 
import UserHome from '../views/home.vue'
import trustedView from '../views/trustedView.vue'
import userSignup from '../views/userSignup.vue'
import userLogin from '../views/userLogin.vue'
import forgotUser from '../views/forgotUser.vue'
import veriuserform from '../views/veriuserform.vue'
import trustedconfirm from '../views/trustedconfirm.vue'
// Paths 
const routes = [
  {
    path: '/',
    name: 'UserHome',
    component: UserHome,
  },
  {
    path: '/trustedconfirm/:uuid',
    name: 'trustedConfirm',
    component: trustedconfirm,
  },
  {
    path: '/trust',
    name: 'trustedView',
    component: trustedView,
  },
  {
    path: '/login',
    name: 'login',
    component: userLogin,
  },
  {
    path: '/signup',
    name: 'signup',
    component: userSignup,
  },
  {
    path: '/forgot',
    name: 'forgotpass',
    component: forgotUser,
  },
  {
    path:'/confirm/:email',
    name: 'veriuserform',
    component: veriuserform, 
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