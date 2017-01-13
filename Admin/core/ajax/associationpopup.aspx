<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="associationpopup.aspx.cs" Inherits="WebBack.core.ajax.associationpopup" EnableViewState="false" EnableEventValidation="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>WebBack Associations</title>
</head>
<body>

    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h4 class="modal-title"><i class="icon-shuffle"></i> Associate Records</h4>
    </div>

    <div class="modal-body with-padding">
        <div class="wb-ass-popup" data-name="<%= assocName %>">
            <p class="wb-ass-popup-controls clearfix">
                <a class="pull-right btn btn-xs btn-success" href="#">Add</a>
                <span class="wb-ass-popup-echo pull-right text-success">Association created</span>
                Select item and click "add" to associate.
            </p>

            <asp:Repeater ID="RepItems" runat="server">
                <HeaderTemplate><select name="asspopupitems" size="15"></HeaderTemplate>
                <ItemTemplate><option value="<%# Eval("ID") %>"><%# Eval("WB_CleanTitle") %></option></ItemTemplate>
                <FooterTemplate></select></FooterTemplate>
            </asp:Repeater>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                // click event for the add button!
                $('div.wb-ass-popup').on('click', 'a', function (evt) {
                    // gather refs and info
                    var myPopup = $(this).closest('div.wb-ass-popup');
                    var mySel = myPopup.find('select');
                    var myVal = mySel.val();
                    // look up the ass panel on the main page based on the assoc name
                    var myAssName = myPopup.attr('data-name');
                    var parentPanel = $('div.wb-ass-panel[data-name="' + myAssName + '"]');
                    var parentSel = $('select', parentPanel);
                    if (myVal != '') {
                        // select the appropriate value in the parent selector...
                        parentSel.val(myVal).trigger('change');
                        // then click the add button programmatically!
                        $('a.wb-ass-choices-add', parentPanel).click();
                        // now remove the option from our popup selection list
                        $('option[value="' + myVal + '"]', mySel).remove();
                        // send a message to the user
                        var myEchoMessage = $('span.wb-ass-popup-echo', myPopup);
                        myEchoMessage.fadeIn(150).delay(1500).fadeOut();
                    }
                    
                    return false;
                });

                // hook up events so a double click on select  fires a single click on the 'add' button
                $('div.wb-ass-popup').on('dblclick', 'select', function (evt) {
                    $('a', $(this).closest('div.wb-ass-popup')).click();
                });
            });
        </script>
    </div>

    <div class="modal-footer">
	    <button class="btn btn-default" data-dismiss="modal">Close</button>
    </div>

</body>
</html>