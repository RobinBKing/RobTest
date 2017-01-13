<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WBWidgetAjaxResponse.aspx.cs" Inherits="WebBack.core.ajax.WBWidgetAjaxResponse" %>

<span class="data-recentchanges">
    <asp:Repeater ID="RepActivity" Runat="server">
        <HeaderTemplate>
            <h4>My Recent Changes</h4>
             <div class="panel panel-default">
            <table class="table dataTable no-footer">
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
					<%# DataBinder.Eval(Container.DataItem, "Date") %>
				</td>			
				<td>
					<a href='recorddetail.aspx?object=<%# DataBinder.Eval(Container.DataItem, "ObjectName") %>&id=<%# DataBinder.Eval(Container.DataItem, "Id") %>'><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
				</td>
				<td>
					<a href='recordlist.aspx?object=<%# DataBinder.Eval(Container.DataItem, "ObjectName") %>'><%# DataBinder.Eval(Container.DataItem, "Type") %></a>
				</td>		
				<td>
					<%# DataBinder.Eval(Container.DataItem, "FirstName") %> <%# DataBinder.Eval(Container.DataItem, "LastName") %>
				</td>	  
				<td>
					<%# DataBinder.Eval(Container.DataItem, "Action") %>
				</td>	                              	
			</tr>
		</ItemTemplate>
        <FooterTemplate>

            <tr>
				<td>
					
				</td>			
				<td>
					 <a href="../core/WidgetRecentChanges.aspx?User=<%=WBAppHelper.CurrentUser.getUserId %>">View All</a>
				</td>
				<td>
					
				</td>		
				<td>
					
				</td>	  
				<td>
					
				</td>	                              	
			</tr>
           
            </table>
            </div>
        </FooterTemplate>
	</asp:Repeater>
</span>