<template>
  <LandingPage msg="Prototype UI"/>
  <router-link to="/trust"> Trusted View </router-link>
  <button @click="signout() ">Sign-Out</button>
</template>

<script>
import LandingPage from '../components/LandingPage.vue'
import api from '../api.js'
export default{
  name: 'UserHome',
  components: {
    LandingPage,

  },
  async created(){
    try{
        const response = await api.refresh()
        localStorage.setItem('access_token', response)
      }catch(err){
        this.$router.push('/login')
        this.error = "HUH"
      }
  },
  methods: {
    async signout(){
      try{
        await api.signout()
        localStorage.removeItem('access_token')
        this.$router.push('/login')
      }catch(error){
        this.error = "No login"
        this.$router.push('/login')
      }
    }
  },
}
</script>
