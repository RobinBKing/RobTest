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
    <div class="slider fullscreen">
        <ul class="slides">
            <li class="slide-blue">
                <img src="/img/home-slide1.jpg" />
                <div class="caption-area ">
                    <div class="caption">
                        <h4 class="text-headline">Cutting-Edge<br>
                            Legal Solutions<br>
                            <small>for</small> Business <small>&amp;</small><br>
                            Real Estate</h4>
                        <p class="text-body">
                            With over 120 years of collective experience,<br>
                            Lyons Dougherty is a trusted leader in<br>
                            providing personalized and innovative legal<br>
                            services that meet the complex demands of<br>
                            businesses and individuals.
                        </p>
                    </div>
                </div>
            </li>
            <li class="slide-green">
                <img src="/img/home-slide2.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">Planning <small>AND</small><br>
                            Organizations</h4>
                        <p class="text-body">
                            Our firm offers strategic advice to help<br>
                            companies achieve their goals at every<br>
                            stage of the business cycle.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/business-planning-and-organizations/" class="btn">Go to Business Planning &amp; Organizations <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="slide-red">
                <img src="/img/home-slide3.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">Commercial<br>
                            Litigation</h4>
                        <p class="text-body">
                            When business conflicts and disputes arise,<br>
                            our lawyers provide aggressive advocacy<br>
                            and practical solutions in a diverse range of<br>
                            commercial litigation matters.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/commercial-litigation/" class="btn">go to commercial litigation <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="slide-purple">
                <img src="/img/home-slide4.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">Real Estate<br>
                            Transactions</h4>
                        <p class="text-body">
                            Lyons Dougherty works with businesses and<br>
                            individuals to address the full spectrum of<br>
                            issues associated with commercial and<br>
                            residential real estate transactions.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/real-estate-transactions/" class="btn">Go to real estate transactions <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="slide-light-purple">
                <img src="/img/home-slide5.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">Zoning and<br>
                            Land Use<br>
                            Planning</h4>
                        <p class="text-body">
                            We use a team approach to guide our<br>
                            clients through the complex laws<br>
                            governing the zoning, subdivision, and<br>
                            land development process.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/zoning-and-land-use-planning/" class="btn">Go to zoning and land use planning  <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="slide-dark-green">
                <img src="/img/home-slide6.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">Estate<br>
                            Planning</h4>
                        <p class="text-body">
                            Our estate planning attorneys work<br>
                            with clients and their families to<br>
                            develop estate plans that best serve<br>
                            their individual needs and goals.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/estate-planning/" class="btn">Go to estate planning  <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="slide-bottle-green">
                <img src="/img/home-slide7.jpg" />
                <div class="caption-area">
                    <div class="caption">
                        <h4 class="text-headline">taxation</h4>
                        <p class="text-body">
                            Our attorneys develop creative<br>
                            strategies to address the broad range<br>
                            of taxation issues faced by businesses<br>
                            and individuals.
                        </p>
                        <div class="button-wrap">
                            <a href="/practices/taxation/" class="btn">Go to taxation  <i class="fa fa-caret-right"></i></a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="home-slide-indicators  indicators">
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
            <li class="indicator-item"></li>
        </ul>
        <footer class="page-footer clearfix">
            <div class="container">
                <div class="row">
                    <div class="col l12 m12 s12">
                        <div class="footer-copyright">
                            <p>© 2017 Rob King. <a href="/disclaimer.aspx">Disclaimer/Terms of Use</a> | <a href="/sitemap.aspx">Sitemap</a> | <a href="http://www.saturnodesign.com/" target="_blank">Saturno Design</a> | 421 SW Hall Street, Portland, OR 97201 | Phone <a href="tel:+1-503-478-1830">503-478-1830</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>

</asp:Content>