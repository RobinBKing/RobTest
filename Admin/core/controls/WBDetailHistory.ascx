<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WBDetailHistory.ascx.cs" Inherits="WebBack.core.controls.WBDetailHistory" %>
<div id="wbdetailhistory">
    <!-- notes list has a template and will be filled via javascript -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h6 class="panel-title">Record History</h6>
        </div>

        <!-- list template for the actual results -->
        <ul class="wb-detailhistory list-group">
            <asp:Repeater ID="historyRep" runat="server">
                <ItemTemplate>
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-md-3"><strong><%# Eval("UserName")%></strong></div>
                            <div class="col-md-6"><%# Eval("Action")%></div>
                            <div class="col-md-3 text-muted wb-detail-historydate"><%# Eval("Date") is DateTime ? ((DateTime)Eval("Date")).ToString("u") : "" %></div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>

        </ul>
    </div>
</div>