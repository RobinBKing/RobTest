<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WBAjaxUploader.aspx.cs" Inherits="WebBack.core.ajax.WBAjaxUploader" EnableEventValidation="false" EnableViewState="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>WBAjaxUploader</title>
    <style type="text/css">
        body {font-family:'Open Sans',arial,helvetica,sans-serif;color:#000;font-size:16px;line-height:20px;font-weight:normal;}
        html,body {padding:0;margin:0;position:relative;}
        img {-ms-interpolation-mode:bicubic;}
        #wbau-data {display:none;}
        .wbau-uploader {display:block;max-width:500px;max-height:500px;padding:0;margin:0;overflow:hidden;position:relative;}
        .wbau-mask {display:block;width:500px;height:500px;position:absolute;top:0;left:0;z-index:10;background-color:#fff;}
        .wbau-label {display:block;width:100%;position:relative;left:0;top:0;z-index:12;text-align:center;font-weight:normal;cursor:pointer;}
        .wbau-label {background-color:#65b688;color:#fff;font-size:13px;line-height:1.5em;padding:5px 0;}
        .wbau-label:hover {}
    </style>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
    <script type="text/javascript">
        // -------------------------------------------------
        // internal page functions for webback ajax uploader
        // -------------------------------------------------

        // dispatch event to the parent window.
        // data can include:  action, success, message, fileID, fileName, fileNameRaw, fileDetails
        function wbau_int_notifyParent(data) {
            var wbau_localid = 'wbau_<%= inType.ToLower() %>_<%= inFieldName.ToLower() %>';
            if (window.parent.wbau_ext_trigger) {
                window.parent.wbau_ext_trigger(wbau_localid,data);
            }
            else {
                alert('No JS parent handler for WBAjaxUploader was found; check configuration.');
            }
        }

        // executed when a file is selected for upload
        function wbau_int_fileSelected() {
            wbau_int_notifyParent({
                action: 'uploadstart',
                success: false,
                message: 'Starting Upload...'
            });
            // update the button text
            document.getElementById('fileLabel').innerHTML = '(Uploading)';
            // instant submission of form
            document.forms[0].submit();
        }


        <% if (this.IsPostBack) { %>
        // ------------------------------------------------------------
        // Code executed only when page loads with a successful upload.
        // ------------------------------------------------------------
        wbau_int_notifyParent({
            action: "uploadcomplete",
            success: <%= this.outResult.success.ToString().ToLower() %>,
            message: "<%= this.outResult.message %>",
            fileID: <%= this.outResult.fileID %>,
            fileName: "<%= this.outResult.fileName %>",
            fileNameRaw: "<%= this.outResult.fileNameRaw %>",
            fileDetails: "<%= this.outResult.fileDetails %>"
        });
        // ------------------------------------------------------------
        <% } %>
    </script>
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div id="wbau-data"></div>
        <div class="wbau-uploader">
            <div class="wbau-mask">&nbsp;</div>
            <label class="wbau-label" for="fileUpload" id="fileLabel" title="Upload">Upload</label>
            <input class="wbau-file" type="file" id="fileUpload" name="fileUpload" runat="server" onchange="javascript:wbau_int_fileSelected();" />
        </div>
    </form>

    <asp:Repeater ID="RepUploadedItems" runat="server">
        <HeaderTemplate><div class="wbau-files-received"></HeaderTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>
</body>
</html>
