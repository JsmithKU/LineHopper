<template>
  <div class="sizing">
    <Bar :data="chartData" :options="chartOptions" />
  </div>
</template>

<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: { Bar },
  props: {
    chartData: {
        type: Object,
        required: true
      },
    chartOptions: {
      type: Object,
      default: () => {}
    }
  }
}
</script>

<style scoped>
.sizing{
}
</style>




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

<!--
  <template>
  <div class="chart">
    <Bar v-if="loaded" :data="chartData" />
  </div>
</template>
  
  <script>
import api from "../api";
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);

export default {
  name: "BarChart",
  components: { Bar },
  props: { rid: String },
  data: () => ({
    loaded: false,
    chartData: null,
  }),

  async created () {
    this.loaded = false;

    try {
      //last 2 weeks of data api call -- return averages
      //get each day of the week for selected location (2 weeks worth)
      const cd = await api.getChartData(this.rid);
      //console.log(cd.data)
      let tmpformat = cd.data
      let xlabels = []
      let xbusy = []
      let xclean = []
      tmpformat.forEach(day =>{
        xlabels.push(day.dayname)
        xbusy.push(day.busyavg)
        xclean.push(day.cleanavg)
      })
      //console.log(labels)
      //console.log(data)
      this.chartData = {
        labels: xlabels,
        datsets: [
          {
            label: 'Busy',
            backgroundColor: '#0317fc',
            data: xbusy
          },
          {
            label: 'Clean',
            backgroundColor: '#ebaf09',
            data: xclean
          }

        ]
      }
      this.loaded = true;
    } catch (e) {
      console.error(e);
    }
  },
};
</script>
-->