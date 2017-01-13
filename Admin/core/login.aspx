<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSiteClean.Master" AutoEventWireup="True" CodeBehind="login.aspx.cs" Inherits="WebBack.core.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // configure enter key to submit
            $('.wb-login-inputs input.form-control').satEnterSubmit($('.wb-form-submit'));

            // set the default focus!
            var inputUsername = $('input.wb-login-username');
            if (inputUsername.val() == '') {
                inputUsername.focus();
            }
            else {
                $('input.wb-login-password').focus();
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">
	<!-- Login wrapper -->
	<div class="login-wrapper">

            <asp:PlaceHolder ID="LoginPH" runat="server">
			    <div class="popup-header">
				    <span class="text-semibold">User Login</span>
			    </div>
			    <div class="well wb-login-inputs">

				    <div class="form-group has-feedback">
					    <label>Username</label>
                        <asp:TextBox ID="TxtUser" CssClass="form-control wb-login-username" runat="server" />
					    <i class="icon-users form-control-feedback"></i>
				    </div>

				    <div class="form-group has-feedback">
					    <label>Password</label>
                        <asp:TextBox ID="TxtPass" TextMode="Password" CssClass="form-control wb-login-password" runat="server" />
					    <i class="icon-lock form-control-feedback"></i>
				    </div>

				    <div class="row form-actions">
					    <div class="col-xs-6">
					    </div>
					    <div class="col-xs-6">
                            <asp:LinkButton ID="BtnLoginLink" runat="server" OnClick="BtnLogin_Click" CssClass="btn btn-warning pull-right wb-form-submit"><i class='icon-menu2'></i> Log in</asp:LinkButton>
					    </div>
				    </div>

                    <a href="forgotpass.aspx">Forgot Password?</a>
			    </div>
            </asp:PlaceHolder>

            <div class="panel">
                <div class="panel-body">
                    <asp:PlaceHolder ID="LitWarnings" runat="server" Visible="false">
                        <div class="alert alert-warning fade in block-inner">
                            <button class="close" data-dismiss="alert" type="button">×</button>
                            <i class="icon-warning"></i>
                            <asp:Literal ID="LitWarningText" runat="server"></asp:Literal>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>

	</div>  
	<!-- /login wrapper -->
</asp:Content>
