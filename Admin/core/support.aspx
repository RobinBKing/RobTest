<%@ Page Title="" Language="C#" AutoEventWireup="true" Inherits="System.Web.UI.Page" Trace="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebBack Support</title>
</head>
<body>
    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h4 class="modal-title"><i class="icon-question4"></i> WebBack Support</h4>
    </div>

    <div class="modal-body with-padding">
        <p>
            <%= ObjectLibrary.WBTools.Coalesce(System.Configuration.ConfigurationManager.AppSettings["SaturnoSupportMessage"],"For any questions or needs, please email your Saturno Project Manager with a description of the issue:") %>
        </p>
        <p>
            <strong><%= ObjectLibrary.WBTools.Coalesce(System.Configuration.ConfigurationManager.AppSettings["SaturnoSupportName"],"Greg Fredette") %></strong>
            <br />
            <a href="mailto:<%= ObjectLibrary.WBTools.Coalesce(System.Configuration.ConfigurationManager.AppSettings["SaturnoSupportEmail"],"greg@saturnodesign.com") %>">
                <%= ObjectLibrary.WBTools.Coalesce(System.Configuration.ConfigurationManager.AppSettings["SaturnoSupportEmail"],"greg@saturnodesign.com") %>
            </a>
        </p>

        <hr />

        <h6 class="subtitle">Still Stuck?</h6>
        <p>
            For additional concerns and emergency contact information, please consult the <a href="http://www.saturnodesign.com/clientsupport/" target="_blank">Saturno Client Support Page</a>.
        </p>
    </div>

    <div class="modal-footer">
	    <button class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
</body>
</html>