class Dashing.Highchart extends Dashing.Widget

  createChart: (series, categories, color, title, ytitle) ->
    container = $(@node).find('.highchart-container')
    if $(container)[0]
      @chart = new Highcharts.Chart(
        chart:
          renderTo: $(container)[0]
          type: "line"
          backgroundColor: color

        title:
          text: title

        yAxis:
          title: {
                text: ytitle
            }
        xAxis: {
          type: 'datetime'
        },

        legend:
          enabled: false

        series: series

        tooltip:
          pointFormat: '<b>{point.y}</b>'

        plotOptions:
          column:
            cursor: 'pointer'
            animation: false
            dataLabels:
              enabled: true
              style:
                fontWeight: 'bold'
          series: {
            animation: false
          }

        navigation:
          buttonOptions:
            verticalAlign: 'top'
            theme:
              'stroke-width': 1
              stroke: color
              r: 0
              fill: color
              states:
                hover:
                  fill: color
                select:
                  fill: color

      )

  onData: (data) ->
    @createChart(data.series, data.categories, data.color, data.title, data.ytitle)