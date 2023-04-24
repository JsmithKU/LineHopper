<template>
  <LandingPage msg=""/>
  <router-link v-if="showTrust" to="/trust"> Trusted View </router-link>
  <button class="request" @click="requestTrust()" v-else>Request Trusted</button>
  <button @click="signout() ">Sign-Out</button>
</template>

<script>
import LandingPage from '../components/LandingPage.vue'
import api from '../api.js'
let refresh = {}
export default{
  name: 'UserHome',
  components: {
    LandingPage,

  },
  data(){
    return{
      role: "",
      showTrust: false,
    }
  },
  async created(){
    try{
        refresh = await api.refresh()
        //this.$_userid = await api.getemail(this.$_useremail)

      }catch(err){
        this.$router.push('/login')
        this.error = "No login."
      }
      try{
        //console.log(`Token: ${refresh.token}`)
        //console.log(`Userid: ${refresh.userid}`)  
        let roleRes = await api.role(refresh.token, refresh.userid)
        this.role = roleRes.role[0].role // Clean up in return type row = row[0]
        if(this.role == "trusted"){
          this.showTrust = true
        }
        if(this.role == null){
          this.$route.push('/login')
        }
        //console.log(roleRes.role[0].role)
      }catch(error){
        console.log(`Error with: ${error}`)
      }
  },
  methods: {
    async signout(){
      try{
        await api.signout()
        this.$router.push('/login')
      }catch(error){
        this.error = "No login"
        this.$router.push('/login')
      }
    },
    async requestTrust(){
      await api.rtrust(refresh.userid)
      await api.signout()
      this.$router.push('/login')
    }
  },
}
</script>
