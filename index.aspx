<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="index.aspx.vb" Inherits="RobTest.index" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--    <div class="slider fullscreen" style="touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
        <ul class="slides">
            <li class="" style="opacity: 0; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;https://images.unsplash.com/photo-1464817739973-0128fe77aaa1?dpr=1&amp;auto=compress,format&amp;fit=crop&amp;w=1199&amp;h=799&amp;q=80&amp;cs=tinysrgb&amp;crop=&quot;);">
                <!-- random image -->
                <div class="caption center-align" style="opacity: 0; transform: translateY(-100px) translateX(0px);">
                    <h3>This is our big Tagline!</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
            <li class="" style="opacity: 0; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;https://ununsplash.imgix.net/photo-1414849424631-8b18529a81ca?q=75&amp;fm=jpg&amp;s=0e993004a2f3704e8f2ad5469315ccb7&quot;);">
                <!-- random image -->
                <div class="caption left-align" style="opacity: 0; transform: translateX(-100px) translateY(0px);">
                    <h3>Left Aligned Caption</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
            <li class="active" style="opacity: 1; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;https://ununsplash.imgix.net/uploads/1413259835094dcdeb9d3/6e609595?q=75&amp;fm=jpg&amp;s=6a4fc66161293fc4a43a6ca6f073d1c5&quot;);">
                <!-- random image -->
                <div class="caption right-align" style="opacity: 1; transform: translateX(0px) translateY(0px);">
                    <h3>Right Aligned Caption</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
        </ul>
        <ul class="indicators">
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item active"></li>
        </ul>
    </div>--%>
    <div class="slider" style="height: 440px; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
        <ul class="slides" style="height: 400px;">
            <li class="" style="opacity: 0; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;http://lorempixel.com/580/250/nature/1&quot;);">
                <!-- random image -->
                <div class="caption center-align" style="opacity: 0; transform: translateY(-100px) translateX(0px);">
                    <h3>This is our big Tagline!</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
            <li class="" style="opacity: 0; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;http://lorempixel.com/580/250/nature/2&quot;);">
                <!-- random image -->
                <div class="caption left-align" style="opacity: 0; transform: translateX(-100px) translateY(0px);">
                    <h3>Left Aligned Caption</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
            <li class="" style="opacity: 0; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;http://lorempixel.com/580/250/nature/3&quot;);">
                <!-- random image -->
                <div class="caption right-align" style="opacity: 0; transform: translateX(100px) translateY(0px);">
                    <h3>Right Aligned Caption</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
            <li class="active" style="opacity: 1; transform: translateX(0px) translateY(0px);">
                <img src="data:image/gif;base64,R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" style="background-image: url(&quot;http://lorempixel.com/580/250/nature/4&quot;);">
                <!-- random image -->
                <div class="caption center-align" style="opacity: 1; transform: translateY(0px) translateX(0px);">
                    <h3>This is our big Tagline!</h3>
                    <h5 class="light grey-text text-lighten-3">Here's our small slogan.</h5>
                </div>
            </li>
        </ul>
        <ul class="indicators">
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item active"></li>
        </ul>
    </div>

</asp:Content>