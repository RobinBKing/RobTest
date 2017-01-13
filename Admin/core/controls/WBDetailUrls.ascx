<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBDetailUrls.ascx.cs" Inherits="WebBack.core.controls.WBDetailUrls" %>
<div id="wbdetailurls" class="panel panel-default">
    <div class="panel-heading">
        <h6 class="panel-title panel-title-large">Page URLs</h6>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label>Add a new URL for this record:</label>
            <div class="row wb-urls-inputrow">
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtUrlInput" CssClass="form-control wb-urls-input" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <a class="btn btn-block btn-xs btn-default wb-urls-add" href="#">Add</a>
                </div>
            </div>
            <div class="wb-urls-existing">
                <ul class="wb-urls-list">
                    <!-- populated with javascript -->
                </ul>
                <!-- list template for the actual results -->
                <ul class="wb-urls-template" style="display:none!important;">
                    <li data-id="{id}">
                        <span class="wb-urls-text text-info"><strong>{pageurl}</strong></span>
                        <div class="wb-ranking-handle"><i class="icon-sort"></i></div>
                        <a class="wb-urls-delete btn btn-xs btn-icon btn-link" title="Delete Url" href="#"><i class="icon-close"></i></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="wb-urls-statusecho"></div>
    </div>
</div>
