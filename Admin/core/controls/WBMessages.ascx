<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="WBMessages.ascx.cs" Inherits="WebBack.core.controls.WBMessages" EnableViewState="false" %>
<asp:Repeater ID="RepMessages" runat="server">
    <HeaderTemplate>
        <div class="wb-messages">
    </HeaderTemplate>
    <ItemTemplate>
            <div class="wb-message bg-<%# ((WBMessage)Container.DataItem).Type %> fade in">
                <button class="close" data-dismiss="alert" type="button">×</button>
                <%# ((WBMessage)Container.DataItem).Text %>
            </div>
    </ItemTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>
