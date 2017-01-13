<%@ Page language="c#" AutoEventWireup="True" MasterPageFile="~/core/WBSite.Master" Codebehind="~/core/diagnostics.aspx.cs" Inherits="WebBack.core.Diagnostics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <h3>
        Diagnostics
        <small>Developers only</small>
    </h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">

    <div class="block">
        <ul class="nav nav-pills">
            <li><a class="btn btn-xs btn-default" href="?ErrorLog=1"><i class="icon-warning"></i> Error Log</a></li>
            <li><a class="btn btn-xs btn-default" href="?ListTest=1"><i class="icon-checkmark4"></i> List Test</a></li>
            <li><a class="btn btn-xs btn-default" href="?FieldTest=1"><i class="icon-checkmark4"></i> Field Test</a></li>
            <li><a class="btn btn-xs btn-default" href="?Populate=1"><i class="icon-table2"></i> Batch Populate</a></li>
            <li><a class="btn btn-xs btn-default" href="?LogLinks=1"><i class="icon-checkmark4"></i> Log All Links</a></li>
            <li><a class="btn btn-xs btn-default" href="?ResetInstance=1&UpdateAll=True"><i class="icon-spinner8"></i> Reset Instance</a></li>
        </ul>
    </div>

    <div class="block">
         <asp:Literal ID="diagnosticsreport" runat="server"></asp:Literal>

        <asp:PlaceHolder ID="PHErrorLog" runat="server" Visible="false">
            <!-- BEGIN ErrorLog / ?errorlog=1 to activate -->
            <script type="text/javascript">
                $(document).ready(function () {
                    // hide the bodies to start...
                    $('.diag-errorlog-body', $('#diag-errorlog')).hide();
                    // click headers to toggle the error bodies
                    $('#diag-errorlog').on('click', '.diag-errorlog-header', function () {
                        $(this).next('.diag-errorlog-body').slideToggle();
                    });
                });
            </script>
            <h3>Error Log</h3>
            <asp:Repeater ID="RepErrorLog" runat="server">
                <HeaderTemplate>
                    <div id="diag-errorlog">
                </HeaderTemplate>
                <ItemTemplate>
                        <h4 class="diag-errorlog-header"><%# Eval("Label") %> - <%# Eval("Notes") %> - <%# Eval("ErrorTime") %></h4>
                        <div class="diag-errorlog-body">
                            <pre>
WBID:      <%# Eval("WBID") %>
ArchiveID: <%# Eval("ArchiveID") %>

<%# Eval("Error") %>
                            </pre>
                        </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            <!-- END ErrorLog -->
        </asp:PlaceHolder>
         
         <asp:PlaceHolder ID="PHListTest" runat="server" Visible="false">
            <!-- BEGIN ListTest / ?listtest=1 to activate -->
            <h3>List Test <small class="display-block">Basic validation of DB tables and AJAX listing code for all WebBack objects</small></h3>
            <asp:Repeater ID="RepListTest" runat="server">
                <HeaderTemplate>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>&nbsp;</th>
                                    <th>Label</th>
                                    <th>Object Name</th>
                                    <th>Table Name</th>
                                    <th>Est#Recs</th>
                                    <th>DB Check <span class="tip" title="(L)ive / (Q)ueued / (A)rchived"><i class="icon-question"></i></span></th>
                                    <th>AJAX Data</th>
                                    <th><span class="diag-listajax-run btn btn-xs btn-info tip" title="Execute list page AJAX call for the live records on every type">Test All AJAX</span></th>
                                </tr>
                            </thead>
                            <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class="diag-listajax-row">
                        <td><%# Container.ItemIndex+1 %></td>
                        <td><%# Eval("Label") %></td>
                        <td class="diag-listajax-col-name""><%# Eval("Name") %></td>
                        <td><%# Eval("Table") %></td>
                        <td><%# Eval("RecordCount") %></td>
                        <td>
                            <!-- db check -->
                            <span class="label label-<%# ((int)Eval("DBLive")==1) ? "success" : ((int)Eval("IsSystem")==1) ? "default" : "danger" %>">L</span>
                            <span class="label label-<%# ((int)Eval("DBQueued")==1) ? "success" : ((int)Eval("IsSystem")==1) ? "default" : "danger" %>">Q</span>
                            <span class="label label-<%# ((int)Eval("DBArchived")==1) ? "success" : ((int)Eval("IsSystem")==1) ? "default" : "danger" %>">A</span>
                        </td>
                        <td>
                            <a class="diag-listajax-link" target="_blank" href="ajax/jqdt/jqdtAjaxProcessor.aspx?object=<%# Eval("Name") %>&status=active&language=<%# WebBack.WBAppHelper.DefaultLanguageID %>&t=0">View</a> |
                            <a class="diag-listajax-link" target="_blank" href="ajax/jqdt/jqdtAjaxProcessor.aspx?object=<%# Eval("Name") %>&status=active&language=<%# WebBack.WBAppHelper.DefaultLanguageID %>&t=1">Trace</a>
                        </td>
                        <td>
                            <span class="diag-listajax-result label label-default">Untested</span>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                            </tbody>
                        </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <script type="text/javascript">
                $(document).ready(function () {
                    // click event to kick off the ajax tests
                    $('.diag-listajax-run').click(function () {
                        if ($(this).hasClass('disabled')) {
                            return;
                        }
                        else {
                            $(this).addClass('disabled');
                            diagAjaxTest_LoopStart($('tr.diag-listajax-row'));
                        }
                    });
                });

                // start the diagnostics ajax testing loop
                function diagAjaxTest_LoopStart(rowItems) {
                    rowItems.each(function () {
                        // reset all the flags to start our test
                        if ($('td.diag-listajax-col-name', $(this)).text().toLowerCase() != 'webbackobject') {
                            $(this).addClass('js-untested');
                        }
                        // reset our labels
                        var outlabel = $('.diag-listajax-result', $(this));
                        outlabel.removeClass('label-success label-danger').addClass('label-default').html('Untested');
                    });

                    // reset is complete, start the test
                    diagAjaxTest_LoopNext(rowItems);
                }

                // run a test on the next untested item on the page
                function diagAjaxTest_LoopNext(rowItems) {
                    var testRow = rowItems.filter('.js-untested').first();
                    if (testRow.length == 0) {
                        // no untested items left! we are finished
                        diagAjaxTest_LoopEnd();
                    }
                    else {
                        // get our output status item ref...
                        var testOutLabel = $('.diag-listajax-result', testRow);

                        // assemble our test request
                        var testUrl = $('.diag-listajax-link', testRow).attr('href');
                        var xhrTest = $.ajax({
                            url: testUrl,
                            type: 'GET',
                            async: true,
                            cache: false,
                            dataType: 'json'
                        });

                        // success handler
                        xhrTest.done(function (jsonData) {
                            // count the rows and report our status!
                            var happyRowCount = 0;
                            if (jsonData['data'] != null) {
                                happyRowCount = jsonData['data'].length;
                            }
                            testOutLabel.addClass('label-success').html('OK: ' + happyRowCount + ' rows');
                        });

                        // fail handler ... just warn the user it failed
                        xhrTest.fail(function () {
                            testOutLabel.addClass('label-danger').html('*Error*');
                        });

                        // every time we finish, we strip the testing marker and kick off the next loop with slight delay
                        xhrTest.always(function () {
                            testRow.removeClass('js-untested');
                            setTimeout(function () {
                                diagAjaxTest_LoopNext(rowItems);
                            }, 250);
                        });
                    }
                }

                // finish the ajax testing process
                function diagAjaxTest_LoopEnd() {
                    $('.diag-listajax-run').removeClass('disabled');
                    var ajaxErrCount = $('span.diag-listajax-result.label-danger').length;
                    alert('AJAX testing complete with ' + ajaxErrCount + ' error(s).');
                }

            </script>
            <!-- END ListTest section -->
         </asp:PlaceHolder>

         <asp:PlaceHolder ID="PHFieldTest" runat="server" Visible="false">
             <asp:Repeater ID="RepFieldsTest" runat="server">
                <HeaderTemplate>
                     <h3>Missing Core Fields</h3>
                    <a href="?FieldTest=True&AddFields=True">Add All Missing Fields</a>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Table Name</th>
                                    <th>Field Name</th>                               
                                </tr>
                            </thead>
                            <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("TableName") %></td>
                        <td><%# Eval("MissingField") %></td>                      
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                            </tbody>
                        </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
         </asp:PlaceHolder>


        <asp:PlaceHolder ID="PHPopulate" runat="server" Visible="false">
            <!-- BEGIN Batch Populate / ?populate=1 to activate -->
            <div class="callout callout-info">
                <h5>Batch Populate</h5>
                <p>A new WebBack record will be created for each value you enter (linebreak-delimited), and the value will be assigned to the specified column.</p>
            </div>

            <div class="form form-horizontal">

                <div class="panel panel-default">

                    <div class="panel-heading">
                        <h6 class="panel-title">Data Input</h6>
                    </div>

                    <div class="panel-body">

                        <asp:Literal ID="LitPopulateResults" runat="server"></asp:Literal>
                        <asp:Literal ID="LitPopulateError" runat="server"></asp:Literal>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">WebBack Table</label>
                            <div class="col-sm-10">
                                <asp:DropDownList ID="DDLPopulateTable" runat="server" CssClass="form-control" DataValueField="Name" DataTextField="TableName"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Value Column</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="TxtPopulateColumn" runat="server" CssClass="form-control">Title</asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Values<br />(one per line)</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="TxtPopulateValues" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="16"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-actions text-right">
                            <asp:Button ID="BtnPopulateSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="BtnPopulateSubmit_Click" />
                        </div>
                    </div>

                </div>

            </div>
            <!-- END Batch Populate -->
        </asp:PlaceHolder>

        
         <asp:PlaceHolder ID="PHLinkLog" runat="server" Visible="false">
            <!-- BEGIN ListTest / ?loglink=1 to activate -->
            <h3>List Test <small class="display-block">Log All Links by Object</small></h3>
            <asp:Repeater ID="RepLinkLog" runat="server">
                <HeaderTemplate>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>&nbsp;</th>
                                    <th>Label</th>
                                    <th>Object Name</th>                                   
                                    <th><span class="diag-listajax-run btn btn-xs btn-info tip" title="Log All Links for each object">Log All Links</span></th>
                                </tr>
                            </thead>
                            <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr class="diag-listajax-row">
                        <td><%# Container.ItemIndex+1 %></td>
                        <td><%# Eval("Label") %></td>
                        <td class="diag-listajax-col-name""><%# Eval("Name") %></td>                        
                        <td>
                            <!-- db check -->
                           <a class="diag-listajax-link" target="_blank" href="ajax/WBAjaxPage.aspx?action=linkchecker_loglink&name=<%# Eval("Name") %>&t=0">Test</a>
                        </td>
                        <td>
                            <span class="diag-listajax-result label label-default">Untested</span>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                            </tbody>
                        </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <script type="text/javascript">
                $(document).ready(function () {
                    // click event to kick off the ajax tests
                    $('.diag-listajax-run').click(function () {
                        if ($(this).hasClass('disabled')) {
                            return;
                        }
                        else {
                            $(this).addClass('disabled');
                            diagAjaxTest_LoopStart($('tr.diag-listajax-row'));
                        }
                    });
                });

                // start the diagnostics ajax testing loop
                function diagAjaxTest_LoopStart(rowItems) {
                    rowItems.each(function () {
                        // reset all the flags to start our test
                        if ($('td.diag-listajax-col-name', $(this)).text().toLowerCase() != 'webbackobject') {
                            $(this).addClass('js-untested');
                        }
                        // reset our labels
                        var outlabel = $('.diag-listajax-result', $(this));
                        outlabel.removeClass('label-success label-danger').addClass('label-default').html('Untested');
                    });

                    // reset is complete, start the test
                    diagAjaxTest_LoopNext(rowItems);
                }

                // run a test on the next untested item on the page
                function diagAjaxTest_LoopNext(rowItems) {
                    var testRow = rowItems.filter('.js-untested').first();
                    if (testRow.length == 0) {
                        // no untested items left! we are finished
                        diagAjaxTest_LoopEnd();
                    }
                    else {
                        // get our output status item ref...
                        var testOutLabel = $('.diag-listajax-result', testRow);

                        // assemble our test request
                        var testUrl = $('.diag-listajax-link', testRow).attr('href');
                        var xhrTest = $.ajax({
                            url: testUrl,
                            type: 'GET',
                            async: true,
                            cache: false,
                            dataType: 'json'
                        });

                        // success handler
                        xhrTest.done(function (jsonData) {
                            // count the rows and report our status!
                            var happyRowCount = 0;
                            if (jsonData['data'] != null) {
                                happyRowCount = jsonData['data'].length;
                            }
                            testOutLabel.addClass('label-success').html('OK: ' + happyRowCount + ' rows');
                        });

                        // fail handler ... just warn the user it failed
                        xhrTest.fail(function () {
                            testOutLabel.addClass('label-danger').html('*Error*');
                        });

                        // every time we finish, we strip the testing marker and kick off the next loop with slight delay
                        xhrTest.always(function () {
                            testRow.removeClass('js-untested');
                            setTimeout(function () {
                                diagAjaxTest_LoopNext(rowItems);
                            }, 250);
                        });
                    }
                }

                // finish the ajax testing process
                function diagAjaxTest_LoopEnd() {
                    $('.diag-listajax-run').removeClass('disabled');
                    var ajaxErrCount = $('span.diag-listajax-result.label-danger').length;
                    alert('AJAX testing complete with ' + ajaxErrCount + ' error(s).');
                }

            </script>
            <!-- END ListTest section -->
         </asp:PlaceHolder>
    </div>
</asp:Content>

