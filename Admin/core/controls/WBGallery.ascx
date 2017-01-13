<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WBGallery.ascx.cs" Inherits="WebBack.core.controls.WBGallery" EnableViewState="false" %>
<asp:Repeater ID="RepItems" Runat="server" OnItemDataBound="RepItems_ItemDataBound">
	<HeaderTemplate>
        <div class="wbg-panel panel panel-default <%# GalleryConfig.HasImage == 1 ? "wbg-panel-images" : "wbg-panel-noimages" %> <%# WBRequest.Status==WBRecordStatus.ARCHIVED ? "wbg-panel-readonly" : "" %>">
            <div class="panel-body">
                <div class="wbg-box">
                    <ul class="wbg-list" data-wbg-object="<%# WBRequest.Object.Name %>" data-wbg-wbid="<%# WBID %>" data-wbg-name="<%# Name %>" data-wbg-hasimage="<%# GalleryConfig.HasImage == 1 ? "true" : "false" %>">
    </HeaderTemplate>
	<ItemTemplate>
		<li class="wbg-item" id="wbg-item-<%# Eval("ID") %>" data-wbg-id="<%# Eval("ID") %>" style="<%# (Container.ItemIndex==0 ? "display:none!important;" : "") %>">
			<div class="wbg-handle"><i class="icon-sort"></i></div>
			<a class="wbg-deletebutton btn btn-xs btn-icon btn-link" href="#" title="Delete Item"><i class="icon-close"></i></a>
			<div class="wbg-displaypanel">
                <div class="row">
                    <div class="wbg-displayimage col-sm-3" data-wbg-imgroot="/images/_wbmanaged/gallery/<%# WBID %>/">
                        <asp:PlaceHolder ID="PHImageThumb" runat="server">
                            <a class="wbg-imagethumblink" href="/images/_wbmanaged/gallery/<%# WBID %>/<%# Eval("Image") %>" target="_blank">
                                <img class="wbg-imagethumb" src="/images/_wbmanaged/gallery/<%# WBID %>/<%# Eval("ImageThumb") %>" alt="" />
                            </a>
                        </asp:PlaceHolder>
                    </div>
                    <div class="col-sm-9">
				        <div class="wbg-titleecho"><%# Eval(TitleColumn) %>&nbsp;</div>
				        <a class="wbg-editbutton btn btn-xs btn-default" href="#">Edit Item</a>
                    </div>
                </div>
			</div>
			<div class="wbg-editpanel wbg-nochanges form-horizontal">
                <asp:Repeater ID="RepFields" runat="server" OnItemDataBound="RepFields_ItemDataBound">
                    <ItemTemplate>
                        <div class="wbg-field form-group row" data-wbg-column="<%# Eval("Column") %>" data-wbg-type="<%# Eval("Type") %>" data-wbg-fkeyobject="<%# WBTools.GetSafeString(Eval("FKeyObject")).ToString().ToLower().Trim() %>">
                            <asp:PlaceHolder ID="PH_string" runat="server" Visible="false">
                                <label class="wbg-label control-label col-sm-3"><%# Eval("Label") %></label>
                                <div class="wbg-field-input col-sm-9">
                                    <input class="wbg-text form-control" type="text" 
                                        id="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>" 
                                        name="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>" 
                                        value="<%# DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()) %>" />
                                </div>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PH_text" runat="server" Visible="false">
                                <label class="wbg-label control-label col-sm-3"><%# Eval("Label") %></label>
                                <div class="wbg-field-input col-sm-9">
                                    <textarea class="wbg-text form-control" rows="6" 
                                        id="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>"
                                        name="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>"
                                        ><%# DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()) %></textarea>
                                </div>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PH_checkbox" runat="server" Visible="false">
                                <label class="wbg-label control-label col-sm-3"><%# Eval("Label") %></label>
                                <div class="wbg-field-input col-sm-9">
                                    <input class="wbg-checkbox" type="checkbox" 
                                        id="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>"
                                        name="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>" value="1" 
                                        <%# DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()).ToString().ToLower() == "true" || DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()).ToString() == "1" ? "checked='checked'" : "" %> />
                                </div>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PH_fkey" runat="server" Visible="false">
                                <label class="wbg-label control-label col-sm-3"><%# Eval("Label") %></label>
                                <div class="wbg-field-input col-sm-9">
                                    <span class="wbg-select-loading">Loading&hellip;</span>
                                    <select class="wbg-select wbg-select-preinit form-control <%# (Eval("Column")==TitleColumn) ? "wbg-select-istitle" : "" %>" 
                                        id="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>" 
                                        name="wbg-<%# DataBinder.Eval(Container.Parent.Parent,"DataItem.ID") %>-<%# Eval("Column").ToString().ToLower() %>"
                                        data-initial-value="<%# DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()) %>">
                                        <option value="<%# DataBinder.Eval(Container.Parent.Parent,"DataItem."+Eval("Column").ToString()) %>" selected>N/A</option>
                                    </select>
                                </div>
                            </asp:PlaceHolder>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
				<a class="wbg-savebutton btn btn-xs btn-info" href="#" >Save</a>
				<span class="wbg-statusecho"></span>
			</div>
		</li>
	</ItemTemplate>
	<FooterTemplate>
                    </ul>
                    <div class="wbg-actions">
                        <a class="wbg-addbutton btn btn-xs btn-success" href="#">Add New Item</a>
                        <a class="wbg-uploadbutton btn btn-xs btn-success" href="#">Add New Image(s)</a>
                        <span class="wbg-uploadstatus"><!-- populated by javascript --></span>
                    </div>
                    
                </div>
            </div>
        </div>
    </FooterTemplate>
</asp:Repeater>
