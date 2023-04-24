import { createApp } from 'vue'
//import Vue from 'vue'
//import { BootstrapVue } from 'bootstrap-vue'
import App from './App.vue'
import router from './router/index.js'

createApp(App).use(router).mount('#app')
//Vue.App.use(BootstrapVue)
//Vue.use(router).mount('#app')