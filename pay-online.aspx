<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="pay-online.aspx.vb" Inherits="RobTest.pay_online" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Tablet and mobile view starts -->
    <div class="show-for-tab-mobile-only mobile-space">
        <div class="top-banner with-image clearfix animated fadeIn">
            <span class="top-banner-bg about-banner-bg"></span>
            <div class="medium-4 columns banner-picture"></div>
            <div class="medium-8 columns banner-content sub-blue-slide">
                <div class="banner-content-block">
                    <h1>Pay Online</h1>
                    <div class="show-for-small-only">
                        <form action="#">
                            <select class="select_redirect">
                                <option>Select One...</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Tablet and mobile View ends -->
    <!-- Subpage Cntent area starts -->
    <div class="sub-full-width animated fadeIn">
        <span class="sub-page-bg about-bg"></span>
        <div class="sub-content tab-2-col blue-gradient clearfix">
            <div class="large-4 medium-5 columns sub-picture hide-for-small-only animated fadeIn">
            </div>
            <div class="large-8 medium-7 small-12 columns content-area animated fadeIn">
                <div class="content-detail">
                    <div class="content-block custom-bar mCustomScrollbar _mCS_1 mCS_no_scrollbar">
                        <div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0">
                            <div id="mCSB_1_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position: relative; top: 0; left: 0;" dir="ltr">

                                <h1>Pay Online</h1>

                                <h2>ONLINE BILL PAY</h2>
                                <p>For your convenience, Lyons Dougherty, LLC accepts payments online, including Visa, MasterCard, American Express, and Discover. Lyons Dougherty, LLC is dedicated to providing the highest level of service to our clients and this process is fast, free and secure. Paying online will eliminate writing a check and is an excellent time saver. If you would like to pay your invoice or make a retainer payment online, simply use the appropriate link below.</p>
                                <p><a href="https://secure.lawpay.com/pages/lyonsdoughertyllc/operating" target="_blank">Click here to pay your Lyons Dougherty invoice online.</a></p>
                                <p><a href="https://secure.lawpay.com/pages/lyonsdoughertyllc/trust" target="_blank">Click here to make a Retainer payment online.</a></p>
                                <p><em>Please note: In order to make a Retainer payment you must have a signed Engagement Agreement or a Retainer Agreement between you and Lyons Dougherty, LLC.</em></p>
                                <p>Lyons Dougherty, LLC is affiliated with Chadds Ford Abstract, Inc. For more information on their title services, visit them online at <a href="http://www.chaddsfordabstract.com/" target="_blank">www.chaddsfordabstract.com.</a></p>
                            </div>
                            <div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;">
                                <div class="mCSB_draggerContainer">
                                    <div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;" oncontextmenu="return false;">
                                        <div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
                                    </div>
                                    <div class="mCSB_draggerRail"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Subpage Content area ends -->
</asp:Content>
