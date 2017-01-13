<%@ Page Language="C#" AutoEventWireup="True" MasterPageFile="~/core/WBSite.Master" CodeBehind="~/core/globalsearch.aspx.cs" Inherits="WebBack.core.globalsearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // configure the search toggler checkbox
            $('.wb-search-inputs-toggler input').on('change', function (evt) {
                var newStatus = $(this).prop('checked');
                var allFilterBoxes = $('.wb-search-inputcols input');
                // actually set inputs correctly
                allFilterBoxes.prop('checked', newStatus);
                // flag the display-level elements for styling
                if (newStatus) {
                    allFilterBoxes.parent('span').addClass('checked');
                }
                else {
                    allFilterBoxes.parent('span').removeClass('checked');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageTitle" runat="server">
    <h1>Search</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">	

    <div class="wb-search">

        <div class="wb-search-inputs">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h6 class="panel-title">
                        <a href="#searchrefine" data-toggle="collapse">Filter by Section&hellip;</a>
                    </h6>
                    <label class="wb-search-inputs-toggler checkbox pull-right">
                        <input type="checkbox" class="styled" name="gstoggler" /> Select&nbsp;All&nbsp;&nbsp;&nbsp;&nbsp;
                    </label>
                </div>
                <div id="searchrefine" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <asp:Repeater ID="RepSections" runat="server">
                            <HeaderTemplate>
                                <div class="wb-search-inputcols clearfix">
                                    <div class="wb-search-inputcol">
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <%# ObjectLibrary.WBTools.IsSplitColumnIndex(((DataTable)RepSections.DataSource).Rows.Count,3,Container.ItemIndex) ? "</div><div class='wb-search-inputcol'>" : "" %>
                                        <div class="checkbox">
                                            <label>
                                                <input class="styled" type="checkbox" name="categories" value="<%# Eval("ObjectName") %>" <%# (strAllFilters.Contains(","+Eval("ObjectName").ToString().ToLower()+",")) ? "checked='checked'" : "" %>> <%# Eval("Label") %>
                                            </label>
                                        </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </div>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div class="wb-search-actions form-group">
                            <div class="input-group">
                                <asp:TextBox ID="TxtSearch" CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="searchbutton" CssClass="btn btn-default" OnClick="Submit_Click" Text="Submit" runat="server" />
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h2>Results<%= strSearchEcho != "" ? " for <span class='text-info'>" + strSearchEcho + "</span>" : "" %></h2>
        <% if (totalResultsCount == 0) { %>
            <p>No records matched your search.<br /><br /></p>
        <% } %>

        <asp:Repeater ID="searchTypes" OnItemDataBound="GetSearchResults" runat="server">
            <ItemTemplate>                
                <div class="panel panel-default wb-search-results">
                    <div class="panel-heading">
                        <h3 class="panel-title"><%# Eval("Label")%></h3>
                    </div>
                    <div class="table-responsive">
                        <asp:Repeater ID="results" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <a href="../core/recorddetail.aspx?object=<%# DataBinder.Eval(Container.Parent.Parent, "DataItem.ObjectName")%>&id=<%# Eval("ID") %>">
                                            <%# ObjectLibrary.WBTools.Coalesce(Eval("WBRecordTitle"), "[Untitled]") %>
                                        </a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>

