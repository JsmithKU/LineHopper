<template>
  <LandingPage msg="Prototype UI"/>
  <router-link to="/trust"> Trusted View </router-link>
</template>

<script>
import LandingPage from '../components/LandingPage.vue'

export default{
  name: 'UserHome',
  components: {
    LandingPage,

  },
}
</script>
