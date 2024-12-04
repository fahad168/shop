$(document).ready(function () {
    $.ajax({
        url: '/shop/admin/dashboard/pie_chart',
        type: 'GET',
        success: function (res) {
            product_pie_chart(res?.data, res?.drilldown_series)
            $('.highcharts-credits').remove()
        }
    })
})

/* Product Pie Chart */
function product_pie_chart(data, drilldown_series) {
    Highcharts.chart('container', {
        chart: {
            type: 'pie'
        },
        title: {
            text: 'Products'
        },
        accessibility: {
            announceNewData: {
                enabled: true
            },
        },

        plotOptions: {
            series: {
                borderRadius: 5,
                dataLabels: [{
                    enabled: true,
                    distance: 15,
                    format: '{point.name}'
                }]
            }
        },

        tooltip: {
            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: ' +
                '<b>{point.y}</b><br/>'
        },

        series: [
            {
                name: 'Total Products',
                colorByPoint: true,
                data: data
            }
        ],
        drilldown: {
            series: drilldown_series
        }
    });
}

Highcharts.chart('revenue_chart', {
    chart: {
        type: 'areaspline'
    },
    title: {
        text: 'Revenue From 2020 To 2024',
        align: 'left'
    },
    legend: {
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        x: 120,
        y: 70,
        floating: true,
        borderWidth: 1,
        backgroundColor:
            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF'
    },
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        title: {
            text: 'Months'
        }
    },
    yAxis: {
        title: {
            text: 'Revenue'
        },
        labels: {
            formatter: function () {
                return this.value + 'k';
            }
        }
    },
    tooltip: {
        shared: true,
        headerFormat: '<b>Revenue in {point.x}</b><br>',
        pointFormat: '{series.name}: {point.y}k'
    },
    credits: {
        enabled: false
    },
    plotOptions: {
        areaspline: {
            fillOpacity: 0.5
        }
    },
    series: [{
        name: '2023',
        data: [
            22, 23213, 24, 25, 426, 273, 29, 32, 35, 37213, 39, 36
        ]
    }, {
        name: '2024',
        data: [
            2212, 23123, 24, 25312, 236, 27, 29, 32, 335, 373, 39, 13236
        ]
    }]
});