<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBSearchBar.ascx.cs" Inherits="WebBack.core.controls.WBSearchBar" %>
<div class="wb-globalsearch">
    <div class="input-group">
        <asp:TextBox ID="TxtMasterSearch" runat="server" CssClass="form-control wb-globalsearch-input" placeholder="Search Everything" />
        <asp:LinkButton ID="BtnMasterSearch" runat="server" CssClass="input-group-addon" OnClick="BtnMasterSearch_Click" CausesValidation="false"><i class="icon-search2"></i></asp:LinkButton>
    </div>

    <asp:PlaceHolder ID="PHSearchOptions" runat="server">
        <div class="wb-globalsearch-popup panel panel-default fade">
            <asp:Repeater ID="RepSections" runat="server">
                <HeaderTemplate>
                    <div class="wb-search-inputcols panel-body">
                        <h6 class="subtitle">Filter By Section:</h6>
                        <div class="wb-search-inputcol">
                </HeaderTemplate>
                <ItemTemplate>
                        <%# ObjectLibrary.WBTools.IsSplitColumnIndex(((DataTable)RepSections.DataSource).Rows.Count,3,Container.ItemIndex) ? "</div><div class='wb-search-inputcol'>" : "" %>
                            <div class="checkbox">
                                <label>
                                    <input class="styled" type="checkbox" name="gssections" value="<%# Eval("ObjectName") %>"> <%# Eval("Label") %>
                                </label>
                            </div>
                </ItemTemplate>
                <FooterTemplate>
                        </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </asp:PlaceHolder>
</div>
