<%@ Control Language="C#" AutoEventWireup="True" Codebehind="WBSidebar.ascx.cs" Inherits="WebBack.core.controls.WBSidebar" EnableViewState="false" %>
<!-- sidebar -->
<div class="sidebar collapse">
	<div class="sidebar-content">

		<!-- User dropdown -->
		<div class="user-menu dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <img src="<%= WBAppHelper.CurrentUser.WB_Image %>" alt="" />
				<div class="user-info">
					<%= WBAppHelper.CurrentUser.GetFullNameTruncated(22,"&hellip;") %> <span><%= WBAppHelper.CurrentUser.WB_Name %></span>
				</div>
			</a>
			<div class="popup dropdown-menu dropdown-menu-right">
				<div class="thumbnail">
					<div class="thumb">
                        <img src="<%= WBAppHelper.CurrentUser.WB_Image %>" alt="" />
					</div>
					    
					<div class="caption text-center">
					    <h6>
                            <%= WBAppHelper.CurrentUser.WB_FirstName %> <%= WBAppHelper.CurrentUser.WB_LastName %>
                            <small><%= WBAppHelper.CurrentUser.WB_Name %></small>
                            <small><a href="mailto:<%= WBAppHelper.CurrentUser.WB_Email %>"><%= WBAppHelper.CurrentUser.WB_Email %></a></small>
                        </h6>
                        <asp:PlaceHolder ID="PHProfileActions" runat="server" Visible="true">
                            <div class="wb-userprofile-actions">
						        <a href="../core/recorddetail.aspx?object=WB_UserProfile&id=<%= WBAppHelper.CurrentUser.getUserId %>" class="btn btn-icon btn-default" title="Edit Profile">Edit Profile</a>
                                <asp:HyperLink ID="LinkLogout" runat="server" CssClass="btn btn-icon btn-danger" Text="Log Out" />
                            </div>
                        </asp:PlaceHolder>
					</div>

				</div>
			</div>
		</div>
		<!-- /user dropdown -->

        <!-- navigation -->
        <ul class="navigation">
	        <li><a href="../core/admin.aspx"><span>Dashboard</span> <i class="icon-screen2"></i></a></li>

            <asp:Repeater ID="RepMenu" runat="server">
                <ItemTemplate>
                    <li data-objectname="<%# WBTools.GetSafeString(Eval("ObjectName")).ToLower() %>">
                        <a href="<%# Eval("Link") %>" class="<%# (bool)Eval("HasChildren") ? "expand" : (Menu_IsObjectActive(Eval("ObjectName")) ? "level-opened" : "") %> <%# (int)Eval("WarningBit") == 1 ? "bg-danger" : "" %>">
                            <span><%# Eval("Text") %></span>
                            <i class="icon-<%# ((bool)Eval("HasChildren") || Eval("ObjectName") != "") ? Eval("Icon") : "arrow-right12" %>"></i>
                        </a>
                        <asp:Repeater ID="RepMenuInner" runat="server" DataSource='<%# ((WBSidebarMenuItem)Container.DataItem).Children %>'>
                            <HeaderTemplate><ul></HeaderTemplate>
                            <ItemTemplate>
                                <li class="<%# (Menu_IsObjectActive(Eval("ObjectName")) && ((bool)Eval("IsObjectLink")) ? "active" : "") %> <%# (int)Eval("WarningBit") == 1 ? "bg-danger" : "" %>" data-objectname="<%# WBTools.GetSafeString(Eval("ObjectName")).ToLower() %>">
                                    <a href="<%# ObjectLibrary.WBTools.Coalesce(Eval("Link"),"../core/recordlist.aspx?object="+Eval("ObjectName")) %>"><%# Eval("Text") %></a>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
        <!-- /navigation -->

	</div>
</div>
<!-- /sidebar -->