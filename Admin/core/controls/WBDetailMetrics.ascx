<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBDetailMetrics.ascx.cs" Inherits="WebBack.core.controls.WBDetailMetrics" %>
<div id="wbdetailmetrics">

    <div id="SL1" class="Sc1" style="width:100%;min-height:300px;">Loading&hellip;</div>
    <div class="clear"></div>
    <script type="text/javascript">
        // called on window load, after all images/content are in place
        $(document).ready(function () {

            // attach all of this behavior to the click event on the tab link
            $('ul.nav').on('click', 'a[href="#detailmetrics"]', function (evt) {
                wb_detail_MetricsInitialize();
            });
        });

        // Load our <script> includes in order, then kick off our chart rendering
        function wb_detail_MetricsInitialize() {
            // make sure this only runs once by marking it with an initialization class
            var mycontainer = $('#wbdetailmetrics');
            if (mycontainer.hasClass('js-initialized')) {
                return;
            }
            else {
                mycontainer.addClass('js-initialized');
            }

            // pull in required libraries
            helper_AddNewScript('//www.google.com/jsapi');
            helper_AddNewScript('//cdn.kendostatic.com/2014.1.416/js/kendo.all.min.js');

            // give a delay for download/parse, then execute our calls
            setTimeout(function () {
                wb_detail_MetricsCreateChart();
            }, 2000);
        }

        // load a JavaScript dynamically for this page
        // NOTE: may take a short time to actually download and parse!)
        function helper_AddNewScript(url) {
            var scriptel = document.createElement('script');
            scriptel.setAttribute('type', 'text/javascript');
            scriptel.setAttribute('src', url);
            if (typeof scriptel != 'undefined') {
                document.getElementsByTagName('head')[0].appendChild(scriptel);
            }
        }

        // actually build the request to make the chart
        function wb_detail_MetricsCreateChart() {
            var Data = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: "http://ga.saturnodesign.com/Reports/AnalyticsExplorer?D=day&M=visits,bounces,pageviews&S=<%= DateTime.Now.AddDays(-30).ToString("M/d/yyyy") %>&E=<%= DateTime.Now.ToString("M/d/yyyy") %>&U=<%= GetSlugList(WBRequest.QueryInt("ID",-1)) %>&Key=<%= ObjectLibrary.WBTools.GetAppVar("ChartsGuid") %>",
                        dataType: "jsonp"
                    }
                },
                sort: {
                    field: "day",
                    dir: "desc"
                }
            });


            // Unique Page Views
            $("#SL1").kendoChart({
                dataSource: Data,
                autoBind: true,
                title: {
                    text: ""
                },
                legend: {
                    position: "top"
                },
                seriesDefaults: {
                    type: "area"
                },
                series: [{
                    field: "visits",
                    name: "Visits",
                    color: "#FF3451"
                }, {
                    field: "pageviews",
                    name: "Pageviews",
                    color: "#0D79D1"
                }, {
                    field: "bounces",
                    name: "Bounces",
                    color: "#910C24"
                }],
                categoryAxis: {
                    labels: {
                        rotation: 90
                    },
                    crosshair: {
                        visible: true
                    }
                },
                valueAxis: {
                    labels: {
                        format: "N0"
                    }
                },
                tooltip: {
                    visible: true,
                    shared: true,
                    format: "N0",
                    background: "blue",
                    color: "#FFFFFF"
                }
            });
        };
    </script>

</div>