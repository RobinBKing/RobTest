<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSite.Master" AutoEventWireup="True" CodeBehind="~/core/admin.aspx.cs" Inherits="WebBack.core.admin" %>
<%@ Register TagPrefix="wb" TagName="stats" Src="~/core/controls/WBStats.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <h3>WebBack Dashboard</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
    <div class="block">
          <wb:stats ID="statsListing" runat="server" />
          <asp:PlaceHolder ID="DashboardWidgets" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
