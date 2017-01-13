<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSite.Master" AutoEventWireup="true" CodeBehind="WidgetRecentChanges.aspx.cs" Inherits="WebBack.core.WidgetRecentChanges" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../core/js/plugins/interface/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // convert dates before we make a datatable
            wrc_convert_dates();

            $('#Changetable').DataTable({
                saveState: true,
                "sPaginationType": "full_numbers",
                "aaSorting": [[0, 'desc', "asc"]],
                "oLanguage": {
                    "sSearch": "_INPUT_"                  
                },
                "sDom": '<"datatable-header"f><"datatable-filteradv"><"datatable-scroll"t><"datatable-footer"ipl>'
            });

            //===== Date/time pickers =====//
            $(".datepicker").datepicker({
                showOtherMonths: true
            });

            $('.dataTables_filter input').attr('placeholder', 'Keyword');
        });

        function wrc_convert_dates() {
            $('td.wrc-col-date').each(function () {
                var cell = $(this);
                var hdateorig = cell.text();
                var hmoment = moment.utc(hdateorig);
                if (hmoment != null && hmoment.isValid()) {
                    // convert to local time
                    hmoment.local();
                    var hdatefriendly = hmoment.format('MM/DD/YYYY') + ' ' + hmoment.format('h:mm A');
                    cell.html(hdatefriendly);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    <h1>Recent Changes</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">	
    


    <div class="wb-widget-recentchanges">
         <asp:DropDownList ID="UserDDL" CssClass="form-control" runat="server"></asp:DropDownList> 
         Start Date: <asp:TextBox ID="DateStart" CssClass="form-control datepicker" runat="server"></asp:TextBox>        
         End Date: <asp:TextBox ID="DateEnd" CssClass="form-control datepicker" runat="server"></asp:TextBox> 
       
        <asp:Button ID="DateFilter" Text="Filter" runat="server" CssClass="btn btn-default" OnClick="ChangeFilter_Click" />
    </div>
              
          
    <asp:Repeater ID="RepActivity" Runat="server">
        <HeaderTemplate>
               <div class="panel panel-default">
            <table id="Changetable" class="table dataTable no-footer">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>User</th>
                    <th>Action</th>
                </tr>
            </thead>
        </HeaderTemplate>
		<ItemTemplate>
			<tr>
				<td class="wrc-col-date">
					<%# DataBinder.Eval(Container.DataItem, "HISTDate") %>
				</td>			
				<td>
					<a href='recorddetail.aspx?Object=<%# DataBinder.Eval(Container.DataItem, "ObjectName") %>&Id=<%# DataBinder.Eval(Container.DataItem, "Id") %>'><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
				</td>
				<td>
					<a href='recordlist.aspx?Object=<%# DataBinder.Eval(Container.DataItem, "ObjectName") %>'><%# DataBinder.Eval(Container.DataItem, "Type") %></a>
				</td>		
				<td>
					<%# DataBinder.Eval(Container.DataItem, "WBUsersFirstName") %> <%# DataBinder.Eval(Container.DataItem, "WBUsersLastName") %>
				</td>	  
				<td>
					<%# DataBinder.Eval(Container.DataItem, "WBActionsAction") %>
				</td>	                              	
			</tr>
		</ItemTemplate>
        <FooterTemplate>
            </table></div>
            <div class="datatable-footer">

            </div>
        </FooterTemplate>
	</asp:Repeater>

</asp:Content>

