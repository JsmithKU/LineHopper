<template>

  <img alt="logo or something" src="./assets/logo.png">
  <router-view ></router-view>
</template>

<script>

export default {
  name: 'App',
  components: {
  }
}
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
img{
  height: 25%;
  width: 25%;
}
</style>
