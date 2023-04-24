<template>
  <div class="logo">
    <img alt="logo or something" src="./assets/logo1.png" />
  </div>
  <router-view></router-view>
</template>

<script>
export default {
  name: "App",
  components: {},
};
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
.logo {
  height: 250px;
}
img {
  height: 250px;
  width: 300px;
}
@media (max-width: 600px) {
  img {
    height: 150px;
    width: 200px;
  }
}
</style>
