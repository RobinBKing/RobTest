<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WBAjaxAssociations.aspx.cs" EnableEventValidation="false" EnableViewState="false" Inherits="WebBack.core.ajax.WBAjaxAssociations" ValidateRequest="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>AJAX Association Result</title>
    <meta name="robots" content="noindex,nofollow" />
</head>
<body>
    <form id="form1" runat="server">

        <div id="associator_resp">
            <ul class="listitems">

                <asp:Repeater Id="RepItemsTop" runat="server" OnItemDataBound="AssociationItemDataBound">
                    <ItemTemplate>
                        <li class="wb-ass-nesting-item" data-id="<%# Eval("Id")%>" id="ass_nest_<%# destObj %>_<%# assocName %>_<%# Eval("ID") %>" data-wbrankecho="<%# Eval("AssocRank") %>" data-wbnestparent="<%# Eval("_nestParent") %>" data-wbnestid="<%# Eval("_nestID") %>">
                            <div class="wb-ass-nesting-box">
                                <div class='wb-ass-ranked-handle'><i class='icon-sort'></i></div>
                                <div class="wb-ass-existing-title"><%# Eval(wbObj2.ListField)%></div>
                                <asp:Literal ID="controlLit" runat="server"></asp:Literal>
                                <a class="wb-ass-existing-delete btn btn-xs btn-icon btn-link" href="#" title="Delete Association"><i class="icon-close"></i></a>
                            </div>

                            <asp:Repeater ID="RepItemsNested" runat="server" OnItemDataBound="AssociationItemDataBound">
                                <HeaderTemplate><ul></HeaderTemplate>
                                <ItemTemplate>
                                    <li class="wb-ass-nesting-item" data-id="<%# Eval("Id")%>" id="ass_nest_<%# destObj %>_<%# assocName %>_<%# Eval("ID") %>" data-wbrankecho="<%# Eval("AssocRank") %>" data-wbnestparent="<%# Eval("_nestParent") %>" data-wbnestid="<%# Eval("_nestID") %>">
                                        <div class="wb-ass-nesting-box">
                                            <div class='wb-ass-ranked-handle'><i class='icon-sort'></i></div>
                                            <div class="wb-ass-existing-title"><%# Eval(wbObj2.ListField)%></div>
                                            <asp:Literal ID="controlLit" runat="server"></asp:Literal>
                                            <a class="wb-ass-existing-delete btn btn-xs btn-icon btn-link" href="#" title="Delete Association"><i class="icon-close"></i></a>
                                        </div>

                                        <asp:Repeater ID="RepItemsNested" runat="server" OnItemDataBound="AssociationItemDataBound">
                                            <HeaderTemplate><ul></HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="wb-ass-nesting-item" data-id="<%# Eval("Id")%>" id="ass_nest_<%# destObj %>_<%# assocName %>_<%# Eval("ID") %>" data-wbrankecho="<%# Eval("AssocRank") %>" data-wbnestparent="<%# Eval("_nestParent") %>" data-wbnestid="<%# Eval("_nestID") %>">
                                                    <div class="wb-ass-nesting-box">
                                                        <div class='wb-ass-ranked-handle'><i class='icon-sort'></i></div>
                                                        <div class="wb-ass-existing-title"><%# Eval(wbObj2.ListField)%></div>
                                                        <asp:Literal ID="controlLit" runat="server"></asp:Literal>
                                                        <a class="wb-ass-existing-delete btn btn-xs btn-icon btn-link" href="#" title="Delete Association"><i class="icon-close"></i></a>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate></ul></FooterTemplate>
                                        </asp:Repeater>

                                    </li>
                                </ItemTemplate>
                                <FooterTemplate></ul></FooterTemplate>
                            </asp:Repeater>

                        </li>
                    </ItemTemplate>
                </asp:Repeater>

            </ul>
            <div class="dropdownoptions">
                <asp:DropDownList Id="newoptionsddl" runat="server" class="newoptionsddl"></asp:DropDownList>
            </div>
        </div>

    </form>
</body>
</html>
