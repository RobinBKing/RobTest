<%@ Page Title="" Language="C#" AutoEventWireup="True" CodeBehind="~/core/ajax/modal/preview.aspx.cs" Inherits="WebBack.core.modal.preview" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebBack Support</title>
</head>
<body>
    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h4 class="modal-title"><i class="icon-question4"></i>Preview</h4>
    </div>

    <div class="modal-body with-padding">
       <asp:HyperLink ID="LinkPreview" runat="server" CssClass="btn btn-block btn-info wb-detail-btn-preview" Text="Website" NavigateUrl="#" Target="_blank" />
        <br />
<asp:HyperLink ID="LinkGooglePreview" runat="server" CssClass="btn btn-block btn-info wb-detail-btn-preview" Text="Google Resizer" NavigateUrl="#" Target="_blank" />

    </div>

    <div class="modal-footer">
	    <button class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
</body>
</html>