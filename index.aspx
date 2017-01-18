<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="index.aspx.vb" Inherits="RobTest.index" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="slider-out">
        <div class="home-slider">
            <%--            <div class="carousel carousel-slider clearfix">--%>
            <%--                <a class="carousel-item" href="#one!">
                    <img src="/img/home-slide1.jpg">
                </a>
                <a class="carousel-item" href="#two!">
                    <img src="/img/home-slide2.jpg">
                </a>
                <a class="carousel-item" href="#three!">
                    <img src="/img/home-slide3.jpg">
                </a>
                <a class="carousel-item" href="#four!">
                    <img src="/img/home-slide4.jpg">
                </a>--%>
            <ul class="carousel carousel-slider clearfix cb-slideshow" style="width: auto; position: relative;">
                <li class="carousel-item slide-blue animated fadeIn" aria-hidden="false">
                    <span class="animated animate-initial"></span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Cutting-Edge<br>
                                    Legal Solutions<br>
                                    <small>for</small> Business <small>&amp;</small><br>
                                    Real Estate </h1>
                                <div class="text-main animated">
                                    <p>
                                        With over 120 years of collective experience,<br>
                                        Lyons Dougherty is a trusted leader in<br>
                                        providing personalized and innovative legal<br>
                                        services that meet the complex demands of<br>
                                        businesses and individuals.
                                                   
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-green animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image2</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Business
                                               
                                        <br>
                                    Planning <small>AND</small><br>
                                    Organizations</h1>
                                <div class="text-main animated">
                                    <p>
                                        Our firm offers strategic advice to help<br>
                                        companies achieve their goals at every<br>
                                        stage of the business cycle.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/business-planning-and-organizations/" class="button">Go to Business Planning &amp; Organizations <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-red animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image3</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Commercial<br>
                                    Litigation</h1>
                                <div class="text-main animated">
                                    <p>
                                        When business conflicts and disputes arise,<br>
                                        our lawyers provide aggressive advocacy<br>
                                        and practical solutions in a diverse range of<br>
                                        commercial litigation matters.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/commercial-litigation/" class="button">Go to commercial litigation <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-purple animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image4</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Real Estate<br>
                                    Transactions</h1>
                                <div class="text-main animated">
                                    <p>
                                        Lyons Dougherty works with businesses and<br>
                                        individuals to address the full spectrum of<br>
                                        issues associated with commercial and<br>
                                        residential real estate transactions.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/real-estate-transactions/" class="button">Go to real estate transactions <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-light-purple animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image5</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Zoning and<br>
                                    Land Use<br>
                                    Planning</h1>
                                <div class="text-main animated">
                                    <p>
                                        We use a team approach to guide our<br>
                                        clients through the complex laws<br>
                                        governing the zoning, subdivision, and<br>
                                        land development process.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/zoning-and-land-use-planning/" class="button">Go to zoning and land use planning  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-dark-green animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image6</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">Estate<br>
                                    Planning</h1>
                                <div class="text-main animated">
                                    <p>
                                        Our estate planning attorneys work<br>
                                        with clients and their families to<br>
                                        develop estate plans that best serve<br>
                                        their individual needs and goals.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/estate-planning/" class="button">Go to estate planning  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="carousel-item slide-bottle-green animated fadeIn" aria-hidden="true">
                    <span class="animated animate-initial">image7</span>
                    <div class="slide-wrap clearfix">
                        <div class="l4 m5 s12 col picture-area"></div>
                        <div class="l8 m7 s12 col caption-area animated">
                            <div class="text">
                                <h1 class="animated">taxation</h1>
                                <div class="text-main animated">
                                    <p>
                                        Our attorneys develop creative<br>
                                        strategies to address the broad range<br>
                                        of taxation issues faced by businesses<br>
                                        and individuals.
                                                   
                                    </p>
                                    <div class="button-wrap"><a href="/practices/taxation/" class="button">Go to taxation  <i class="fa fa-caret-right" aria-hidden="true"></i></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
            <%--            </div>--%>
        </div>
    </div>
</asp:Content>