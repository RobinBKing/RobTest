<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBNavbar.ascx.cs" Inherits="WebBack.core.controls.WBNavbar" %>
<ul class="nav navbar-nav navbar-right collapse" id="navbar-icons">

    <asp:PlaceHolder ID="PHAdminSaturno" runat="server" Visible="false">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown"><i class="icon-cogs" title="Saturno Admin"></i></a>
            <ul class="dropdown-menu dropdown-menu-right">
                <li><a href="../core/diagnostics.aspx">Diagnostics</a></li>
                <li><a class="wb-nav-instanceresetlink" href="../core/diagnostics.aspx?ResetInstance=1&UpdateAll=True">Reset Instance (AJAX)</a></li>
            </ul>
        </li>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="PHTools" runat="server" Visible="true">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown"><i class="icon-tools" title="Tools"></i></a>
            <ul class="dropdown-menu dropdown-menu-right">
                <li><a class="wb-nav-filemanlink" href="#">File Manager</a></li>
                <asp:PlaceHolder ID="PHLinkReportLink" runat="server" Visible="false">
                    <li><a href="../core/recordlinkreport.aspx">Link Report</a></li>
                </asp:PlaceHolder>
            </ul>
        </li>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="PHSupportLink" runat="server" Visible="true">
        <li class="dropdown">
            <a class="wb-nav-supportlink" href="../core/support.aspx" data-toggle="modal" data-target="#modal_remote" title="Help/Support">
                <i class="icon-question4"></i>
            </a>
        </li>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="PHUserManagement" runat="server" Visible="true">
	    <li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" title="User Management">
			    <i class="icon-users"></i>
		    </a>
            <ul class="dropdown-menu dropdown-menu-right">
                <li><a href="../core/recordlist.aspx?object=User">WebBack Users</a></li>
                <li><a href="../core/recordlist.aspx?object=WebBackGroup">WebBack Groups</a></li>
                <!--<li><a href="../core/recordlist.aspx?object=Timezone">Time Zones</a></li>-->
            </ul>
	    </li>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="PHCheckouts" runat="server">
	    <li class="dropdown">
		    <a class="dropdown-toggle wb-activity-toggler" data-toggle="dropdown" title="My Checked-Out Items">
			    <i class="icon-paragraph-justify2"></i>
			    <span class="label label-default"><%= RepActivity.Items.Count %></span>
		    </a>
		    <div class="popup dropdown-menu dropdown-menu-right">
			    <div class="popup-header">
				    <span>Pending Items</span>
			    </div>
	            <ul class="activity" id="wbcheckoutsmenu">
                    <asp:Repeater ID="RepActivity" runat="server">
                        <ItemTemplate>
		                    <li>
		                        <i class="icon-arrow-right7"></i>
		                        <div>
			                        <a href="../core/recorddetail.aspx?object=<%# Eval("objectName") %>&Id=<%# Eval("WBId") %>"><%# Server.HtmlEncode(ObjectLibrary.WBTools.StripHtml(Eval("Title"))) %></a> checked out in <a href="../core/recordlist.aspx?object=<%# Eval("objectName") %>"><%# Eval("Label") %></a> 
			                        <span class="wb-activity-date"><%# FormatDateUTC(Eval("Date"))%></span>
		                        </div>
		                    </li>
                        </ItemTemplate>
                    </asp:Repeater>              
	            </ul>
                <script type="text/javascript">
                    // moment formatting for our timestamps!
                    $('span.wb-activity-date', $('#wbcheckoutsmenu')).each(function (idx) {
                        var momentChk = moment($(this).text());
                        $(this).text(momentChk.fromNow());
                    });
                </script>
		    </div>
	    </li>
    </asp:PlaceHolder>

    <asp:XmlDataSource ID="xdsApplications" runat="server" DataFile="~/custom/menu.xml" XPath="/Menu/AppLinks/Item" />
    <asp:Repeater ID="RepApplications" runat="server" DataSourceID="xdsApplications" Visible='<%# xdsApplications.GetXmlDocument().SelectNodes("/Menu/AppLinks/Item").Count > 0 %>'>
        <HeaderTemplate>
	        <li class="dropdown">
		        <a data-toggle="dropdown" class="dropdown-toggle" title="Available Applications">
			        <i class="icon-grid"></i>
		        </a>
		        <div class="popup dropdown-menu dropdown-menu-right">
			        <div class="popup-header">
				        <span>Applications</span>
			        </div>
			        <ul class="activity">
        </HeaderTemplate>
        <ItemTemplate>
            <li><i class="icon-<%# Eval("Icon") %>"></i><div><a href="<%# Eval("Link") %>"><%# Eval("Text") %></a></div></li>
        </ItemTemplate>
        <FooterTemplate>
                    </ul>
		        </div>
	        </li>
        </FooterTemplate>
    </asp:Repeater>

</ul>