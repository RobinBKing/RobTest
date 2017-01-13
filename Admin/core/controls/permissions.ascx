<%@ Control Language="c#" AutoEventWireup="True" Codebehind="permissions.ascx.cs" Inherits="WebBack.core.controls.permissions" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table class="table wb-permissions">
	<tr>
		<td>
			<b>Type</b>
		</td>
		<td align=center >
			<b>Edit</b>
		</td>
		<td align=center >
			<b>Approve</b>
		</td>		
	</tr>
	
	<asp:Repeater ID="Permissions" OnItemDataBound="Permissions_Databound" Runat="server">
		<ItemTemplate>
			<tr>
				<td>
					<%# DataBinder.Eval(Container.DataItem, "Label") %>
				</td>			
				<td align=center width=60>
					<input value="true" type=checkbox name="<%# DataBinder.Eval(Container.DataItem, "Id") %>_Edit" <asp:Literal ID="isChecked" Runat=server></asp:Literal>>
				</td>
				<td align=center width=60>
					<input value="true" type=checkbox name="<%# DataBinder.Eval(Container.DataItem, "Id") %>_Approve" <asp:Literal ID="isChecked3" Runat=server></asp:Literal>>
				</td>			
			</tr>
		</ItemTemplate>
	</asp:Repeater>
</table>