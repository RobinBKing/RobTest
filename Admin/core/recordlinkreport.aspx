<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSite.Master" AutoEventWireup="True" CodeBehind="recordlinkreport.aspx.cs" Inherits="WebBack.core.recordlinkreport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../core/js/plugins/interface/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#Changetable').DataTable({
                saveState: true,
                "sPaginationType": "full_numbers",
                "aaSorting": [[2, 'desc', "asc"]],
                "oLanguage": {
                    "sSearch": "_INPUT_"
                },
                "sDom": '<"datatable-header"f><"datatable-filteradv"><"datatable-scroll"t><"datatable-footer"ipl>'
            });

            $('#modal_remote').on('show.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                var id = button.data("id");                
                if (button.data("linkchecker") == true) {
                    $.ajax({
                        type: 'POST',
                        url: 'ajax/WBAjaxPage.aspx',
                        data: {
                            action: 'linkreport_get',
                            id: id
                        },
                        success: function (data) {
                            var outRecs = data.Data.records;
                            var results = "";
                            var tableString = " <table class='table'><thead><th>Field</th><th>URL</th></thead>"
                            for (var i = 0; i < outRecs.length; i++) {
                                tableString += "<tr><td>" + outRecs[i].fieldname + "</td><td>" + outRecs[i].url + "</td></tr>"
                                //modal-body
                            }
                            tableString += "</table>"
                            $(".modal-body").html(tableString);
                            $(".modal-title .icon-spinner").hide();
                        }
                    });
                }
            })
        });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    <h1>Link Report</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">
    <div class="importdata">
    <asp:Repeater ID="RepLinkReport" Runat="server">
        <HeaderTemplate>
                    
               <div class="panel panel-default">
            <table id="linktable" class="table dataTable no-footer">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Section</th>
                    <th>Link Errors</th>
                    <th></th>
                </tr>
            </thead>
        </HeaderTemplate>
		<ItemTemplate>
			<tr>
				<td>
					<a href="recorddetail.aspx?object=<%# DataBinder.Eval(Container.DataItem, "objectname") %>&id=<%# DataBinder.Eval(Container.DataItem, "wbid") %>&language=<%# DataBinder.Eval(Container.DataItem, "Language") %>"><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
				</td>			
				<td>
					<%# DataBinder.Eval(Container.DataItem, "Section") %>
				</td>	
                <td>
                        <%# DataBinder.Eval(Container.DataItem, "NumLinks") %>
                    </td>
                <td>
                    <a class="wb-listaction-preview btn btn-xs btn-icon btn-link" href="#" data-linkchecker="true" data-toggle="modal" data-target="#modal_remote" data-id="<%# DataBinder.Eval(Container.DataItem, "wbid") %>" target="_blank" title="Preview"><i class="icon-eye7"></i></a>
                </td>				            			
			</tr>
		</ItemTemplate>
        <FooterTemplate>
            </table></div>
                        <div class="datatable-footer">

            </div>
        </FooterTemplate>
	</asp:Repeater>
</div>

    
</asp:Content>
