<%@ Page language="c#" AutoEventWireup="True" MasterPageFile="~/core/WBSiteClean.Master" CodeBehind="~/core/ForgotPass.aspx.cs" Inherits="WebBack.core.ForgotPass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // enter key to submit
            $('.wb-login-inputs input.form-control').satEnterSubmit($('.wb-form-submit'));
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageContent" runat="server">
	<!-- Login wrapper -->
	<div class="login-wrapper">
            <asp:Placeholder ID="ChangePassPH" runat="server">
			    <div class="popup-header">
				    <span class="text-semibold"><asp:Literal ID="pageheader" runat="server" Text="Change Password"></asp:Literal></span>
			    </div>
			    <div class="well wb-login-inputs">
                    <asp:Panel Id="ResetPanel" runat="server">
				        <div class="form-group has-feedback">
					        <label>Username</label>
                            <asp:TextBox ID="TxtUser" CssClass="form-control" runat="server" />
					        <i class="icon-users form-control-feedback"></i>
				        </div>

				        <div class="form-group has-feedback">
					        <label>Email</label>					
                            <asp:TextBox ID="TxtEmail" CssClass="form-control" runat="server" />
					        <i class="icon-email form-control-feedback"></i>
				        </div>
                    </asp:Panel>

                    <asp:Panel ID="ConfirmPanel" visible=false runat="server">
                        <div class="form-group has-feedback">
                        <label>New Password</label>	
                	    <asp:TextBox ID="TxtNewPassword"  TextMode="Password" CssClass="form-control" runat="server" />
                            </div>
					 <div class="form-group has-feedback">
                        <label>Confirm Password</label>	
					    <asp:textbox id="TxtConfirmPassword" TextMode="Password" CssClass="form-control" runat="server" />
                         </div>
                    </asp:Panel>

				    <div class="row form-actions">
					    <div class="col-xs-6">
					    </div>
					    <div class="col-xs-6">                        
                            <asp:LinkButton ID="BtnSubmit" runat="server" CssClass="btn btn-warning pull-right wb-form-submit">Submit</asp:LinkButton>
					    </div>
				    </div>

			    </div>
            </asp:Placeholder>
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
        
        	