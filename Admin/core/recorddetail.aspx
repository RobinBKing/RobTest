<%@ Page Title="" Language="C#" MasterPageFile="~/core/WBSite.Master" AutoEventWireup="True" CodeBehind="recorddetail.aspx.cs" Inherits="WebBack.core.recorddetail" ValidateRequest="false" %>
<%@ Register TagPrefix="wb" TagName="notes" Src="~/core/controls/WBDetailNotes.ascx" %>
<%@ Register TagPrefix="wb" TagName="history" Src="~/core/controls/WBDetailHistory.ascx" %>
<%@ Register TagPrefix="wb" TagName="metrics" Src="~/core/controls/WBDetailMetrics.ascx" %>
<%@ Register TagPrefix="wb" TagName="urls" Src="~/core/controls/WBDetailUrls.ascx" %>
<%@ Register TagPrefix="wb" TagName="subrecs" Src="~/core/controls/WBDetailSubRecords.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <%= (WBRequest.Object.CustomCss) ? "<link rel='stylesheet' type='text/css' href='../custom/css/custom-" + WBRequest.Object.Name + ".css'/>" : ""%>

    <!-- commented out for standard detail activity...
    <script type="text/javascript" src="../core/js/plugins/forms/listbox.js"></script>
    <script type="text/javascript" src="../core/js/plugins/forms/multiselect.js"></script>
    <script type="text/javascript" src="../core/js/plugins/forms/uploader/plupload.full.min.js"></script>
    <script type="text/javascript" src="../core/js/plugins/forms/uploader/plupload.queue.min.js"></script>
    -->
    <script type="text/javascript" src="../core/js/plugins/interface/daterangepicker.js"></script>
    <script type="text/javascript" src="../core/js/plugins/interface/timepicker.min.js"></script>
    <script type="text/javascript" src="../core/js/plugins/interface/jquery.mjs.nestedSortable.js"></script>

    <script type="text/javascript" src="../core/lib/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="../core/js/wb-associator.js?mod=20160302"></script>
    <asp:PlaceHolder ID="PHGalleryScript" runat="server" Visible="false">
        <script type="text/javascript" src="../core/js/plugins/forms/uploader/plupload.full.min.js"></script>
        <script type="text/javascript" src="../core/js/wb-gallery.js?mod=20160405"></script>
    </asp:PlaceHolder>
    <script type="text/javascript" src="../core/js/wb-detail.js?mod=20161116"></script>

    <%= (WBRequest.Object.CustomJavascript) ? " <script type='text/javascript' src='../custom/js/custom-" + WBRequest.Object.Name + ".js'></script>" : "" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <h3><%= ObjectLibrary.WBTools.GetTruncatedString(Record.GetFriendlyTitle("Edit Record"), 48, "...") %><small><%= WBRequest.Object.LongPluralName %></small></h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
    <asp:ValidationSummary ID="ctlValidationSummary" runat="server" HeaderText="<span class='label label-warning'><i class='icon-warning'></i> There are validation errors in the form below.</span>" DisplayMode="BulletList" ShowMessageBox="false" ShowSummary="true" CssClass="wb-detail-valsummary" />
    <div class="wb-detail-page" data-wb-record-stale="<%= (Record.IsStaleCheckout?"1":"0") %>" data-wb-object-name="<%= WBRequest.Object.Name %>">
        <div class="wb-detail-pagesidebar">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="wb-detail-pageactions">
                        <asp:HyperLink ID="LinkPreview" runat="server" CssClass="btn btn-block btn-info wb-detail-btn-preview" Text="Preview" NavigateUrl="#" Target="_blank" />
                        <asp:LinkButton ID="BtnPublish" runat="server" CssClass="btn btn-block btn-info wb-detail-btn-publish" Text="Publish" OnClick="BtnPublish_Click" />
                        <asp:LinkButton ID="BtnSave" runat="server" CssClass="btn btn-block btn-info wb-detail-btn-save" Text="Save Draft" OnClick="BtnSave_Click" />                       
                        <asp:LinkButton ID="BtnCancel" runat="server" CssClass="btn btn-block btn-default wb-detail-btn-cancel" Text="Cancel Changes" OnClick="BtnCancel_Click" CausesValidation="false" />
                        <asp:LinkButton ID="BtnDiscard" runat="server" CssClass="btn btn-block btn-default wb-detail-btn-discard" Text="Discard Draft" OnClick="BtnDiscard_Click" CausesValidation="false" />
                        <asp:LinkButton ID="BtnArchive" runat="server" CssClass="btn btn-block btn-danger wb-detail-btn-archive" Text="Archive" OnClick="BtnArchive_Click" CausesValidation="false" />
                    </div>
                    <div class="wb-detail-puboptions">
                        <asp:PlaceHolder ID="PHPubOptions" runat="server">                        
                            <label class="radio-info" title="Should this record appear on the website?"><input type="radio" id="radio_showweb_on" name="wbfc_wbc_showweb" class="styled wb-detail-showweb" value="on" runat="server" /> Public </label>&nbsp;&nbsp;
                            <label class="radio-info" title="Should this record be private?"><input type="radio" id="radio_showweb_off"  name="wbfc_wbc_showweb" class="styled wb-detail-showweb" value="off" runat="server" /> Private </label>
                        </asp:PlaceHolder>
                    </div>
                    <asp:PlaceHolder ID="PHPubDates" runat="server">
                        <div class="wb-detail-pubdates">
                            <div class="wb-detail-pubdate wb-detail-pubdate-active">
                                <hr />
                                <div class="wb-detail-pubdate-header">
                                    <a href="#" class="wb-detail-pubdate-close btn btn-link btn-xs btn-icon pull-right" title="Clear date/time"><i class="icon-close"></i></a>
                                    <span class="subtitle">Display On:</span>
                                </div>
                                <asp:HiddenField ID="wbfc_activedate" runat="server" />
                                <div class="row form-group">
                                    <label class="col-sm-4 control-label wb-pubdate-label">Date</label>
                                    <div class="col-sm-8"><asp:TextBox ID="TxtPubActiveDate" runat="server" CssClass="form-control input-sm datepicker" /></div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-4 control-label wb-pubdate-label">Time</label>
                                    <div class="col-sm-8"><asp:TextBox ID="TxtPubActiveTime" runat="server" CssClass="form-control input-sm timepicker" /></div>
                                </div>
                            </div>
                            <div class="wb-detail-pubdate  wb-detail-pubdate-expire">
                                <hr />
                                <div class="wb-detail-pubdate-header">
                                    <a href="#" class="wb-detail-pubdate-close btn btn-link btn-xs btn-icon pull-right" title="Clear date/time"><i class="icon-close"></i></a>
                                    <span class="subtitle">Remove By:</span>
                                </div>
                                <asp:HiddenField ID="wbfc_expiredate" runat="server" />
                                <div class="row form-group">
                                    <label class="col-sm-4 control-label wb-pubdate-label">Date</label>
                                    <div class="col-sm-8"><asp:TextBox ID="TxtPubExpireDate" runat="server" CssClass="form-control input-sm datepicker" /></div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-sm-4 control-label wb-pubdate-label">Time</label>
                                    <div class="col-sm-8"><asp:TextBox ID="TxtPubExpireTime" runat="server" CssClass="form-control input-sm timepicker" /></div>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>        
        <div class="wb-detail-pagemain panel panel-default">
            <div class="panel-body">

                <asp:PlaceHolder ID="PHDetailPage" runat="server">
                    <div class="tabbable">
                        <ul class="nav nav-pills">
                            <li class="active"><a data-toggle="tab" href="#detailmain">Main Content</a></li>
                            <li><a data-toggle="tab" href="#detailassoc">Associations</a></li>
                            <li><a data-toggle="tab" href="#detailnotes">Notes<span class="label label-default wb-notes-counter"></span></a></li>
                            <li><a data-toggle="tab" href="#detailseo">SEO</a></li>
                            <li><a data-toggle="tab" href="#detailsocialmedia">Social Media</a></li>
                            <li><a data-toggle="tab" href="#detailhistory">History</a></li>
                            <li><a data-toggle="tab" href="#detailmetrics">Metrics</a></li>

                            <asp:Repeater ID="RepLangSwap" runat="server" EnableViewState="false">
                                <HeaderTemplate>
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="Currently viewing the <%# WBAppHelper.GetWBLanguageName(Record.Language) %> version of this record">
                                            <i class="icon-earth"></i> <%# WBAppHelper.GetWBLanguageName(Record.Language) %> <b class="caret"></b>
                                        </a>
                                        <ul class="dropdown-menu">
                                </HeaderTemplate>
                                <ItemTemplate>
                                            <li>
                                                <a href="../core/recorddetail.aspx?object=<%# WBRequest.Object.Name %>&id=<%# Eval("LatestID") %>&language=<%# Eval("ID") %><%# (int)Eval("MasterID") == (int)Eval("LatestID") ? "" : "&langparent=" + Eval("MasterID") %>">
                                                    <i class="icon-<%# ((int)Eval("LatestID") > 0) ? "arrow-right3" : "plus-circle2" %>"></i>
                                                    <%# Eval("Label") %>
                                                </a>
                                            </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </ul>
                                    </li>
                                </FooterTemplate>
                            </asp:Repeater>
                        </ul>
                        <div class="tab-content pill-content">

                            <div id="detailmain" class="tab-pane fade in active">
                                <wb:subrecs ID="ctlSubRecs" runat="server" />
                                <asp:PlaceHolder ID="PHDetails" runat="server"></asp:PlaceHolder> 
                            </div>

                            <div id="detailassoc" class="tab-pane fade">
                                <asp:PlaceHolder ID="PHAssocs" runat="server"></asp:PlaceHolder>
                            </div>

                            <div id="detailnotes" class="tab-pane fade">
                                <wb:notes ID="ctlNotes" runat="server" />
                            </div>

                            <div id="detailseo" class="tab-pane fade">
                                <asp:PlaceHolder ID="PHSeo" runat="server">
                                    <wb:urls ID="ctlUrls" runat="server" />

                                    <div class="panel panel-default wb-meta-panel">
                                        <div class="panel-heading">
                                            <h6 class="panel-title panel-title-large">Meta Content</h6>
                                        </div>
                                        <div class="panel-body">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label>Title:</label>
                                                        <asp:TextBox ID="wbfc_metatitle" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label>Description:</label>
                                                        <asp:TextBox ID="wbfc_metadescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label>Keywords:</label>
                                                        <asp:TextBox ID="wbfc_metakeywords" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:PlaceHolder>
                            </div>

                            <div id="detailsocialmedia" class="tab-pane fade">
                               <asp:PlaceHolder ID="PHSocialMedia" runat="server">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label>Title:</label>
                                                <asp:TextBox ID="wbfc_wbc_socialtitle" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label>Description:</label>
                                                <asp:TextBox ID="wbfc_wbc_socialdescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <asp:PlaceHolder ID="PHSocialMedia_Image" runat="server"></asp:PlaceHolder>
                                    </div>
                               </asp:PlaceHolder>
                            </div>

                            <div id="detailhistory" class="tab-pane fade">
                                <wb:history ID="ctlHistory" runat="server" />
                            </div>

                            <div id="detailmetrics" class="tab-pane fade">
                                <wb:metrics ID="ctlMetrics" runat="server" />
                            </div>

                        </div>
                    </div>
                </asp:PlaceHolder>

            </div><!-- .panel-body -->
        </div><!-- .panel -->
    </div>
</asp:Content>
