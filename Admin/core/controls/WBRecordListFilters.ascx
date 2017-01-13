<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBRecordListFilters.ascx.cs" Inherits="WebBack.core.controls.WBRecordListFilters" %><asp:Repeater ID="RepFilters" runat="server" OnItemDataBound="PopulateSingleFilter" EnableViewState="false">
    <HeaderTemplate>
        <div class='row form-group'>
    </HeaderTemplate>
    <ItemTemplate>
        <%# (Container.ItemIndex > 0 && Container.ItemIndex % 2 == 0) ? "</div><div class='row form-group'>" : "" %>
            <div class="wb-listfilter col-md-6" data-filterid="<%# ((ObjectLibrary.WebBackFilter)Container.DataItem).ID %>" data-filtervalue='<asp:Literal ID="LitDefaultValue" runat="server" />'>
                <input ID="FilterCheckBox" type="checkbox" class="wb-filterelement" runat="server" visible="false" />&nbsp;

                <label><%# ((ObjectLibrary.WebBackFilter)Container.DataItem).Title %></label>

                <asp:TextBox ID="FilterDateText" runat="server" CssClass="form-control wb-filterelement datepicker" Visible="false"></asp:TextBox>
                <asp:DropDownList ID="FilterDropDown" runat="server" CssClass="form-control wb-filterelement" Visible="false"></asp:DropDownList>
                <asp:ListBox ID="FilterMultiSelect" runat="server" CssClass="form-control wb-filterelement" Visible="false"></asp:ListBox>
            </div>
    </ItemTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>
