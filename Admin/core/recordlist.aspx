<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSite.Master" AutoEventWireup="True" CodeBehind="recordlist.aspx.cs" Inherits="WebBack.core.recordlist" %>
<%@ Register TagPrefix="uc" TagName="filters" Src="~/core/controls/WBRecordListFilters.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%= (WBRequest.Object.CustomCss) ? "<link rel='stylesheet' type='text/css' href='../custom/css/custom-" + WBRequest.Object.Name + ".css'/>" : ""%>
    <script type="text/javascript" src="../core/js/plugins/interface/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../core/js/plugins/interface/daterangepicker.js"></script>
    <script type="text/javascript" src="../core/js/wb-list.js?mod=201601116"></script>
     <%= (WBRequest.Object.CustomJavascript) ? " <script type='text/javascript' src='../custom/js/custom-" + WBRequest.Object.Name + ".js'></script>" : "" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <h1><%= WBRequest.Object.LongPluralName %></h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">

    <div class="panel panel-default">
        <div class="well wb-well-panelhead clearfix">
            <ul class="nav nav-pills wb-listnav">
                <li wb-data-tabstatus="active"><a href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>"><i class="icon-checkmark3"></i><%= PHPrivateTab.Visible ? "Public" : "Active" %> </a></li>
                <asp:PlaceHolder ID="PHPrivateTab" runat="server"><li wb-data-tabstatus="private"><a href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=private"><i class="icon-eye-blocked"></i> Private</a></li></asp:PlaceHolder>
                <li wb-data-tabstatus="queued"><a href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=queued"><i class="icon-quill2"></i> Drafts</a></li>
                <li wb-data-tabstatus="archived"><a href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=archived"><i class="icon-history"></i> Archive</a></li>
            </ul>
            <asp:PlaceHolder ID="PHAddNewRecord" runat="server" EnableViewState="false">
                <div class="btn-group pull-right wb-navbuttons">
                    <a class="btn btn-lg btn-success" href="recorddetail.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBAppHelper.DefaultLanguageID %>&id=-1"><i class="icon-plus"></i> New Record</a>
                </div>
            </asp:PlaceHolder>
        </div>

        <div class="wb-filterelements-init">            
            <asp:Repeater ID="RepLangSwap" runat="server" EnableViewState="false">
                <HeaderTemplate>
                    <div class="wb-langswap">
                        <a class="dropdown-toggle btn btn-default" href="#" data-toggle="dropdown"><i class="icon-earth"></i> <%= WBRequest.LanguageName %><span class="caret"></span></a>
                        <ul class="dropdown-menu dropdown-menu-right">
                </HeaderTemplate>
                <ItemTemplate>
                            <li class="<%# (WBRequest.Language==(int)Eval("ID")) ? "active" : "" %>"><a href="recordlist.aspx?object=<%# WBRequest.Object.Name %>&language=<%# Eval("ID") %>&status=<%# WBRequest.Status %>"><%# Eval("Title") %></a></li>
                </ItemTemplate>
                <FooterTemplate>
                        </ul>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <!-- .wb-listfilters-toggler will be moved via JS into .datatable-header -->
            <div class="wb-listfilters-toggler">
                <a class="btn btn-default" href="#"><i class="icon-filter"></i> Advanced&hellip;</a>
            </div>

            <!-- .wb-listfilters will be moved via JS into .datatable-filteradv -->
            <div class="wb-listfilters">
                <uc:filters ID="ctlFilters" runat="server" />
            </div>
        </div>

        <div class="datatable wb-datatable-ajax">
            <table class="table">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

    </div>


    <div id="wbdata" style="display:none!important;">
        <!-- WebBack data values entered here for clean access in javascript -->
        <div class="wbdata-objectname"><%= WBRequest.Object.Name%></div>
        <div class="wbdata-currentstatus"><%= WBRequest.Status %></div>
        <div class="wbdata-currentlanguage"><%= WBRequest.Language %></div>
        <div class="wbdata-listcols"><%= WBListColumnNames %></div>
        <div class="wbdata-listlabels"><%= WBListColumnLabels %></div>
        <div class="wbdata-previewpage"><%= WBRequest.Object.PreviewPage %></div>
        <div class="wbdata-postpublishpopupurl"><%= WBRequest.Object.PostPublishPopupUrl %></div>
        <div class="wbdata-template-status-active">
            <div class="wb-liststatus-hoverzone dropdown">
                <a class="wb-liststatus-btn btn btn-xs btn-icon btn-link dropdown-toggle" href="#" data-toggle="dropdown">
                    <i class="wb-liststatus-normal icon-info"></i><i class="wb-liststatus-locked icon-lock3"></i>
                </a>
                <ul class="wb-liststatus-dropdown dropdown-menu">
                    <li><label>Record ID:</label> {id}</li>
                    <li><label>Updated:</label> {lastupdatedcal} &nbsp; ({lastupdatedago})</li>
                    {checkouts}
                </ul>
            </div>
            {altlangstatus}
        </div>
        <div class="wbdata-template-statuslang">
            <div class="wb-liststatus-hoverzone dropdown">
                <a class="wb-liststatus-btn btn btn-xs btn-icon btn-link wb-liststatus-lang" href="recorddetail.aspx?object=<%= WBRequest.Object.Name %>&id={id}&language={langid}">
                    <span class="wb-liststatus-langcode">{langcode}</span>
                </a>
                <ul class="wb-liststatus-dropdown dropdown-menu">
                    <li><label>{langname} ID:</label> {id}</li>
                    <li><label>Updated:</label> {lastupdatedcal} &nbsp; ({lastupdatedago})</li>
                    {checkouts}
                </ul>
            </div>
        </div>
        <div class="wbdata-template-checkout">
            <li class="wb-listtip-checkout" data-wb-checkout-stale="{stalestatus}">
                <label>Checked Out:</label> {datecal}<br />by {username}
            </li>
        </div>
        <div class="wbdata-template-actions-active">
            <div class="wb-listactions">
                <asp:PlaceHolder ID="PHPreviewLinkActive" runat="server" EnableViewState="false">
                    <a class="wb-listaction-preview btn btn-xs btn-icon btn-link" href="<%= GetPreviewUrlTemplate() %>" target="_blank" title="Preview"><i class="icon-arrow-left9"></i></a>
                </asp:PlaceHolder>
                <asp:Repeater ID="RepCustomActionsActive" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <a class="wb-listaction-custom btn btn-xs btn-icon btn-link" href="<%# Eval("Href") %>" title="<%# Eval("Title") %>" <%# (Eval("Target") != "") ? "target='" + Eval("Target") + "'" : "" %>><i class="icon-<%# Eval("Icon") %>"></i></a>
                    </ItemTemplate>
                </asp:Repeater>
                
                <a class="wb-listaction-view btn btn-xs btn-icon btn-link" href="recorddetail.aspx?object=<%= WBRequest.Object.Name %>&id={id}&archiveid={archiveid}&archived=1" title="View"><i class="icon-eye7"></i></a>
                <a class="wb-listaction-edit wb-listaction-default btn btn-xs btn-icon btn-link" href="recorddetail.aspx?object=<%= WBRequest.Object.Name %>&id={id}" title="Edit"><i class="icon-pencil"></i></a>
                <a class="wb-listaction-copy btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=copy&archiveid={archiveid}&opendetails=1" title="Copy"><i class="icon-copy"></i></a>
                <a class="wb-listaction-archive btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=archive&id={id}&archiveid={archiveid}" title="Archive"><i class="icon-remove"></i></a>
                <asp:PlaceHolder ID="PHRankLinks" runat="server" EnableViewState="false">
                    <span class="wb-listactions-rank">
                        <a class="btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=rank&id={id}&rankdir=up" title="Rank Higher"><i class="icon-arrow-up"></i></a>
                        <a class="btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=rank&id={id}&rankdir=down" title="Rank Lower"><i class="icon-arrow-down"></i></a>
                    </span>
                </asp:PlaceHolder>
            </div>
        </div>
        <div class="wbdata-template-actions-queued">
            <div class="wb-listactions">
                <asp:PlaceHolder ID="PHPreviewLinkQueued" runat="server" EnableViewState="false">
                    <a class="wb-listaction-preview btn btn-xs btn-icon btn-link" href="<%= GetPreviewUrlTemplate() %>" target="_blank" title="Preview"><i class="icon-arrow-left9"></i></a>
                </asp:PlaceHolder>
                <a class="wb-listaction-publish btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=publish&id={id}" title="Publish"><i class="icon-checkmark"></i></a>
                <a class="wb-listaction-edit wb-listaction-default btn btn-xs btn-icon btn-link" href="recorddetail.aspx?object=<%= WBRequest.Object.Name %>&id={id}&status=queued" title="Edit"><i class="icon-pencil"></i></a>
                <a class="wb-listaction-copy btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=copy&archiveid={archiveid}&opendetails=1" title="Copy"><i class="icon-copy"></i></a>
                <a class="wb-listaction-archive btn btn-xs btn-icon btn-link" href="recordlist.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&status=<%= WBRequest.Status %>&wbaction=discard&archiveid={archiveid}" title="Discard"><i class="icon-remove"></i></a>
            </div>
        </div>
        <div class="wbdata-template-actions-archived">
            <div class="wb-listactions">
                <a class="wb-listaction-history wb-listaction-default btn btn-xs btn-icon btn-link" data-toggle="modal" data-target="#modal_remote" href="recordarchive.aspx?object=<%= WBRequest.Object.Name %>&language=<%= WBRequest.Language %>&id={id}" title="View History"><i class="icon-list"></i></a>
            </div>
        </div>
    </div>
    
</asp:Content>
