<%@ Control Language="c#" AutoEventWireup="false" Codebehind="fileuploader.ascx.cs" Inherits="Admin.fileuploader" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Literal ID="errorMessage" Runat=server></asp:Literal>
<asp:Literal Id="FileDisplay" runat=server></asp:Literal>
<input type=file id="ImageFile" style="width:100%" name="ImageFile" runat=server>
