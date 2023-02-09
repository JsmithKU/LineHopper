<template>
<router-link to="/"> Normal View </router-link>
<adminPage msg="Trusted View"/>

</template>


<script>
import adminPage from '../components/adminPage.vue'

export default{
  name: 'trustedView',
  components: {
    adminPage, 
  },
}
</script>
