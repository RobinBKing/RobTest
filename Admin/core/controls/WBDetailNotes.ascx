<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="~/core/controls/WBDetailNotes.ascx.cs" Inherits="WebBack.core.controls.WBDetailNotes" %>
<div id="wbdetailnotes">
    <div class="form-group">
        <label>Add a note to this record:</label>
        <div class="row">
            <div class="col-sm-10">
                <asp:TextBox ID="TxtNoteInput" CssClass="form-control wb-notes-input" MaxLength="400" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-2">
                <a class="btn btn-block btn-xs btn-default wb-notes-add" href="#">Add</a>
            </div>
        </div>
    </div>
    <!-- notes list has a template and will be filled via javascript -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h6 class="panel-title">Existing Notes</h6>
        </div>
        <ul class="wb-notes-list list-group">
            <!-- populated with javascript -->
        </ul>
        <!-- list template for the actual results -->
        <ul class="wb-notes-template" style="display:none!important;">
            <li class="list-group-item" data-id='{id}'>
                <div class="row">
                    <div class="col-md-3"><strong>{name}</strong></div>
                    <div class="col-md-6">{text}</div>
                    <div class="col-md-3 text-muted">{date}</div>
                    <%= WebBackInstance.ConfigAllowNoteDelete ? "<a href='#' class='btn btn-xs btn-icon btn-link note-delete'><i class='icon-close'></i></a>" : "" %>
                </div>
            </li>
        </ul>
    </div>
</div>