<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WBDetailSubRecords.ascx.cs" Inherits="WebBack.core.controls.WBDetailSubRecords" EnableViewState="false" %>
<div id="wbdetailsubrecs" class="wb-subrecs panel panel-default block">
    <asp:PlaceHolder ID="PHParentView" runat="server" Visible="true">
        <div class="panel-heading panel-heading-noborder">
            <h6 class="panel-title">Sub-Records</h6>
            <asp:LinkButton ID="BtnCreate" runat="server" CssClass="btn btn-xs btn-default pull-right" OnClick="BtnCreate_Click"><i class="icon-plus-circle2"></i> Create Sub-Record</asp:LinkButton>
        </div>
        <asp:Repeater ID="RepExistingRecs" runat="server">
            <HeaderTemplate>
                <ul class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
                    <li class="list-group-item">
                        <a class="" href="../core/recorddetail.aspx?object=<%# WBRequest.Object.Name %>&id=<%# Eval("ID") %>"><%# WBTools.Coalesce(Eval("Title"),"Untitled Sub-Record") %></a>
                        <a class="wb-subrecs-delete btn btn-icon btn-link" href="#" title="Delete Sub-Record" data-object="<%# WBRequest.Object.Name %>" data-archiveid="<%# Eval("ArchiveID") %>" data-id="<%# Eval("ID") %>"><i class="icon-close"></i></a>
                    </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>

        <script type="text/javascript">
            $(document).ready(function () {
                // connect the "delete" buttons for child records
                $('div.wb-subrecs').on('click', 'a.wb-subrecs-delete', function (evt) {
                    var verifyClick = confirm('Are you sure you wish to archive this sub-record?');
                    if (verifyClick) {
                        var clickedLink = $(this);
                        var urlAjax = '../core/ajax/WBAjaxPage.aspx';
                        var inObject = clickedLink.attr('data-object');
                        var inID = clickedLink.attr('data-id');
                        var inArchiveID = clickedLink.attr('data-archiveid');

                        // assemble our request
                        var xhr = $.ajax({
                            url: urlAjax,
                            type: 'POST',
                            dataType: 'json',
                            data: {
                                action: 'record_archive',
                                object: inObject,
                                id: inID,
                                archiveid: inArchiveID
                            }
                        });

                        // handle results... we repopulate
                        xhr.done(function (data) {
                            if (data.Success) {
                                clickedLink.closest('li').slideUp(350, function () {
                                    $(this).remove();
                                });
                            }
                            else {
                                alert('Sub-Record Delete Failed:\n\n' + data.ErrorMessage);
                            }
                        });

                    }
                    return false;
                });
            });
        </script>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="PHChildView" runat="server" Visible="false">
        <div class="panel-heading panel-heading-noborder">
            <h6 class="panel-title">Sub-Record Edit Mode</h6>
            <a class="btn btn-xs btn-default pull-right" href="../core/recorddetail.aspx?object=<%= WBRequest.Object.Name %>&id=<%= ParentID %>"><i class="icon-arrow-up7"></i> Parent Record</a>
        </div>
    </asp:PlaceHolder>
</div>