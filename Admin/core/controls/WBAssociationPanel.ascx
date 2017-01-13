<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBAssociationPanel.ascx.cs" Inherits="WebBack.core.controls.WBAssociationPanel" EnableViewState="false" %>
<div class="wb-ass-panel <%= (WBRequest.QueryString("archived")=="1") ? "wb-ass-readonly" : "" %> panel panel-default" data-wbid="<%= WbId %>" data-section="<%= (WBRequest.QueryString("archived")=="1") ? "archived" : "queued" %>" data-archiveid="<%= ArchiveId %>" data-srcobj="<%=srcObjType %>" data-destobj="<%=destObjType %>" data-name="<%=name %>" data-isranked="<%=isRanked %>" data-isdetailed="<%=isDetailed %>" data-ranklevels="<%=rankLevels %>" data-recordcount="<%= destRecordCount %>">

    <div class="wb-ass-header panel-heading">
        <a href='#' class='wb-ass-bodytoggle pull-right btn btn-xs btn-link btn-icon' title='Edit Associations'><i class='icon-pencil'></i></a>
        <h6 class="panel-title panel-title-large">
            <asp:Literal ID="AssociationTitle" runat="server"></asp:Literal>
        </h6>
    </div>

    <div class="wb-ass-loading">Loading&hellip;</div>

    <div class="wb-ass-body panel-body form-horizontal">
        <div class="wb-ass-choices form-group">
            <div class="col-sm-10">
                <div class="wb-ass-choices-controls">
                    <select class="wb-ass-choices-list form-control"></select>
                    <a class="wb-ass-hv-launch wb-combobox-actionbtn" data-toggle="modal" data-target="#modal_remote" href="../core/ajax/associationpopup.aspx?wbid=<%= WbId %>&archiveid=<%= ArchiveId %>&srcobj=<%= srcObjType %>&destobj=<%= destObjType %>&name=<%= name %>" title="View All Records"><i class="icon-search2"></i></a>
                </div>
            </div>
            <div class="col-sm-2">
                <a class="wb-ass-choices-add btn btn-block btn-xs btn-success" href='#'>Add</a>
            </div>
        </div>
        <div class="wb-ass-existing form-horizontal">
            <ul class="wb-ass-existing-list <%= WBAssoc.Rankable ? "wb-ass-ranked" : "" %> <%= WBAssoc.RankableLevels > 1 ? "wb-ass-nested" : "" %>"></ul>
        </div>
        <asp:PlaceHolder ID="PHDetailActions" runat="server" Visible="false">
            <div class="wb-ass-detail-actions">
                <a href="#" class="wb-ass-detail-update btn btn-xs btn-info">Update Details</a>
            </div>
        </asp:PlaceHolder>
        <div class="wb-ass-statusecho"></div>
    </div>

</div>