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
    <div class="slider">
        <ul class="slides">
            <li class="">
                <img src="/img/home-slide1.jpg" />
                <div class="right-align clearfix">
                    <h5>Cutting-Edge<br>
                        Legal Solutions<br>
                        <small>for</small> Business <small>&amp;</small><br>
                        Real Estate </h5>
                    <p>
                        With over 120 years of collective experience,<br>
                        Lyons Dougherty is a trusted leader in<br>
                        providing personalized and innovative legal<br>
                        services that meet the complex demands of<br>
                        businesses and individuals.
                                                   
                    </p>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide2.jpg" />
                <div class="right-align clearfix">
                    <h5>Business
                                               
                                        <br>
                        Planning <small>AND</small><br>
                        Organizations</h5>
                    <p>
                        Our firm offers strategic advice to help<br>
                        companies achieve their goals at every<br>
                        stage of the business cycle.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/business-planning-and-organizations/" class="button">Go to Business Planning &amp; Organizations <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide3.jpg" />
                <div class="right-align clearfix">
                    <h5>Commercial<br>
                        Litigation</h5>
                    <p>
                        When business conflicts and disputes arise,<br>
                        our lawyers provide aggressive advocacy<br>
                        and practical solutions in a diverse range of<br>
                        commercial litigation matters.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/commercial-litigation/" class="button">Go to commercial litigation <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide4.jpg" />
                <div class="right-align clearfix">
                    <h5>Real Estate<br>
                        Transactions</h5>
                    <p>
                        Lyons Dougherty works with businesses and<br>
                        individuals to address the full spectrum of<br>
                        issues associated with commercial and<br>
                        residential real estate transactions.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/real-estate-transactions/" class="button">Go to real estate transactions <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide5.jpg" />
                <div class="right-align clearfix">
                    <h5>Zoning and<br>
                        Land Use<br>
                        Planning</h5>
                    <p>
                        We use a team approach to guide our<br>
                        clients through the complex laws<br>
                        governing the zoning, subdivision, and<br>
                        land development process.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/zoning-and-land-use-planning/" class="button">Go to zoning and land use planning  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide6.jpg" />
                <div class="right-align clearfix">
                    <h5>Estate<br>
                        Planning</h5>
                    <p>
                        Our estate planning attorneys work<br>
                        with clients and their families to<br>
                        develop estate plans that best serve<br>
                        their individual needs and goals.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/estate-planning/" class="button">Go to estate planning  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
            <li class="">
                <img src="/img/home-slide7.jpg" />
                <div class="right-align clearfix">
                    <h5>taxation</h5>
                    <p>
                        Our attorneys develop creative<br>
                        strategies to address the broad range<br>
                        of taxation issues faced by businesses<br>
                        and individuals.
                                                   
                    </p>
                    <div class="button-wrap"><a href="/practices/taxation/" class="button">Go to taxation  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                </div>
            </li>
        </ul>
        <%--        <div class="valign-wrapper">--%>
        <ul class="home-slide-indicators  indicators">
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
        </ul>
        <%--        </div>--%>
    </div>

</asp:Content>