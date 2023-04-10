<template>
    <div class="chart">
      <Bar v-if="loaded" :data="chartData" />
    </div>
  </template>
  
  <script>
  import api from '../api'
  import { Bar } from 'vue-chartjs'
  import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'
  
  ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  
  export default {
    name: 'BarChart',
    components: { Bar },
    props: {rid: String},
    data: () => ({
    loaded: false,
    chartData: null
  }),
  
    async mounted () {
    this.loaded = false

    try {
      //last 2 weeks of data api call -- return averages
      //get each day of the week for selected location (2 weeks worth)
        


      this.chartdata = await api.getChartData(this.rid)

      this.loaded = true
    } catch (e) {
      console.error(e)
    }
  }
}
  
  



  </script>





<!-- --<template>
<div id = "chart">
<canvas id = "barchart">





</canvas>
</div>

</template>


<script>

import { Bar } from 'vue-chartjs'

export default{
name: barchart,
components: { Bar }

}
</script>
-->
