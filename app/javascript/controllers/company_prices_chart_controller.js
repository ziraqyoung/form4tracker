import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

import Highcharts from 'highcharts/highstock';
window.Highcharts = Highcharts; //this line did the magic

// Connects to data-controller="company-prices-chart"
export default class extends Controller {

  async connect() {
    const request = new FetchRequest('get', '/api/prices?company_id=1');
    const response = await request.perform();

    if (response.ok) {
      const body = await response.json
      const data = Object
        .entries(body)
        .map(([date, price]) => [Date.parse(date), parseFloat(price)])
        .reverse();

      Highcharts.stockChart('container', {
        rangeSelector: {
          selected: 0
        },

        title: {
          text: 'USD to EUR exchange rate'
        },

        tooltip: {
          style: {
            width: '200px'
          },
          valueDecimals: 4,
          shared: true
        },

        yAxis: {
          title: {
            text: 'Exchange rate'
          }
        },

        series: [{
          name: 'USD to EUR',
          data: data,
          id: 'dataseries'
        }, {
          type: 'flags',
          data: [{
            x: Date.UTC(2017, 11, 1),
            title: 'A',
            text: 'Some event with a description'
          }, {
            x: Date.UTC(2017, 11, 12),
            title: 'B',
            text: 'Some event with a description'
          }, {
            x: Date.UTC(2017, 11, 22),
            title: 'C',
            text: 'Some event with a description'
          }],
          onSeries: 'dataseries',
          shape: 'circlepin',
          width: 16
        }]
      });
    }
  }
}
