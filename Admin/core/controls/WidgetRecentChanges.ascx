<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WidgetRecentChanges.ascx.cs" Inherits="WebBack.core.controls.WidgetRecentChanges" %>
	<script>

	    $(document).ready(function () {

	        $.ajax({
	            type: 'POST',
	            url: "ajax/WBWidgetAjaxResponse.aspx",
                cache: false,
	            data: {
	                action: 'recentchanges'
	            },
	            success: function (msg) {
	                var data = $(msg).filter(".data-recentchanges");
	                $("div.wrc-data").html(data.html());
	                wrc_convert_dates();
	            }
	        });

	        function wrc_convert_dates() {
	            $('td.wrc-col-date').each(function () {
	                var cell = $(this);
	                var hdateorig = cell.text();
	                var hmoment = moment.utc(hdateorig);
	                if (hmoment != null && hmoment.isValid()) {
	                    // convert to local time
	                    hmoment.local();
	                    var hdatefriendly = hmoment.format('MM/DD/YYYY') + '&nbsp;&nbsp;&nbsp;' + hmoment.format('h:mm A');
	                    cell.html(hdatefriendly);
	                }
	            });
	        }

	    });
</script>

<div class="wrc-data">
</div>