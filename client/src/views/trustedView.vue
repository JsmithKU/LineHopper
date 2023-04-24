<template>
<router-link to="/"> Home View </router-link>
<adminPage msg="Report Trust"/>
<addlocation />
</template>


<script>
import api from '../api.js'
import adminPage from '../components/adminPage.vue'
import addlocation from '../components/addlocation.vue'
let refresh = []
export default{
  name: 'trustedView',
  components: {
    adminPage, 
    addlocation
  },
  async created(){
    try{
        refresh = await api.refresh()

      }catch(err){
        this.$router.push('/login')
        this.error = "No login."
      }
      try{
        //console.log(`Token: ${refresh.token}`)
        //console.log(`Userid: ${refresh.userid}`)  
        let roleRes = await api.role(refresh.token, refresh.userid)
        this.role = roleRes.role[0].role // Clean up in return type row = row[0]
        if(this.role !== "trusted"){
          this.$router.push('/')
        }
        //console.log(roleRes.role[0].role)
      }catch(error){
        console.log(`Error with: ${error}`)
        this.$router.push('/')
      }
  }
}
</script>
