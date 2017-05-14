import I18n from "./../i18n";
import Constants from "./../server_constants";
import { on_page } from "./../application";
import { set_number_of_tabs } from "./../tab_commons";

$(() => { if(on_page("bills", "index")) new BillsCharts(); });

const BillsCharts = (function() {
  function BillsCharts() {
    // A new tab is created for each year;
    set_number_of_tabs("main", Object.keys(bill_chart_data).length);

    // Inside each year tab, each bill has its own tab - there's also a "Totals" tab;
    for (let year of Object.keys(bill_chart_data)) {
      set_number_of_tabs(year, Constants.number_of_bill_types+1);
    }

    const $S = require("scriptjs");
    $S("https://www.gstatic.com/charts/loader.js", () => {
      google.charts.load("current", {"packages":["corechart"], "language": I18n.locale});
      google.charts.setOnLoadCallback(this.draw_charts);
    });

    this.draw_charts = () => {
      /**
        'bill_chart_data' input example:

        {
          "2016":{
            "0":[["Jan", 45.23], ... , ["Dec",115.23]],     // Bill type "0";
            "1":[["Jan", 52.93], ... , ["Dec",123.87]],     // Bill type "1";
            ...
          },
          "2017":{
            ...
          }
        }
      */

      const bill_types = Constants.number_of_bill_types;
      const data = bill_chart_data;

      for (let year of Object.keys(data)) {
        const months = data[year];
        for(let type = 0; type < bill_types; ++type) {
          this.prepare_and_draw_chart(year, months, type);
        }

        // Totals;
        this.prepare_and_draw_chart(year, months, bill_types);
      }
    };

    this.prepare_and_draw_chart = (year, months, type) => {
      const clean_months = months[type].filter(month => month !== null);
      this.draw_chart_by_year(year, clean_months, type);
    };

    this.draw_chart_by_year = (year, months_array, type) => {
      const data = new google.visualization.DataTable();
      data.addColumn("string", I18n.t("datetime.prompts.month"));
      data.addColumn("number", I18n.t("number.value"));
      data.addRows(months_array);

      const options = {
        hAxis: {titleTextStyle: {color: "#333"}},
        vAxis: {minValue: 0, viewWindowMode: "explicit", viewWindow:{ min: 0 }, format: `${I18n.t("number.currency.format.unit")} ###,###,###.00`},
        "width": 500,
        chartArea: {  width: "65%" },
        legend: {position: "none"}
      };

      const formatter = new google.visualization.NumberFormat({decimalSymbol: I18n.t("number.currency.format.separator"), groupingSymbol: I18n.t("number.currency.format.delimiter"), negativeColor: "red", negativeParens: true, prefix: `${I18n.t("number.currency.format.unit")} `});
      formatter.format(data, 1);

      const chart = new google.visualization.AreaChart(document.getElementById(`chart_div_${year}_${type}`));
      chart.draw(data, options);
    };
  }

  return BillsCharts;
}());

export default BillsCharts;
