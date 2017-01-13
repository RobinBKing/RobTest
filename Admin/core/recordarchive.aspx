<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="~/core/recordarchive.aspx.cs" Inherits="WebBack.core.recordarchive" EnableViewState="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WebBack Archive</title>
</head>
<body>
    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h4 class="modal-title"><i class="icon-remove"></i> WebBack Archive</h4>
    </div>

    <div class="modal-body with-padding">
	    
        <asp:Repeater ID="RepItems" runat="server">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <th>ArchiveID</th>
                        <th>Published By</th>
                        <th>Publish Date</th>
                        <th>&nbsp;</th>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                        <tr>
                            <td><%# Eval("ArchiveID") %></td>
                            <td><%# Eval("UserFirst") %> <%# Eval("UserLast") %></td>
                            <td><%# Eval("LastUpdated") != null ? "<span class='wb-arc-date'>" + ((DateTime)Eval("LastUpdated")).ToString("u") + "</span>" : "" %></td>
                            <td class="wb-archive-actions">
                                <a class="btn btn-xs btn-icon btn-link" title="View" href="recorddetail.aspx?object=<%# WBRequest.Object.Name %>&language=<%# WBRequest.Language %>&status=archived&id=<%# WBRequest.QueryInt("ID",-1) %>&archiveid=<%# Eval("ArchiveID") %>&archived=1"><i class="icon-eye"></i></a>
                                <a class="btn btn-xs btn-icon btn-link" title="Restore" href="recordlist.aspx?object=<%# WBRequest.Object.Name %>&language=<%# WBRequest.Language %>&status=queued&wbaction=restore&archiveid=<%# Eval("ArchiveID") %>&opendetails=1"><i class="icon-undo2"></i></a>
                                <a class="btn btn-xs btn-icon btn-link" title="Copy" href="recordlist.aspx?object=<%# WBRequest.Object.Name %>&language=<%# WBRequest.Language %>&status=archived&wbaction=copy&archiveid=<%# Eval("ArchiveID") %>&opendetails=1"><i class="icon-copy"></i></a>
                            </td>
                        </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <script type="text/javascript">
            // localized time using moment
            $('span.wb-arc-date').each(function () {
                var updateMoment = moment($(this).text());
                $(this).html(updateMoment.format('MMM D, YYYY [&nbsp;] h:mm A'));
            });
        </script>
    </div>

    <div class="modal-footer">
	    <button class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
</body>
</html>
