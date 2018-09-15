<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="books.aspx.cs" Inherits="Web.books" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <%--<div id="slider_row">
                <div id="top_column" class="center_column">
                    <div id="homepage-slider">
                        <ul id="homeslider" style="max-height: 560px;">
                            <%foreach (var img in banners)
                                { %>
                            <li class="homeslider-container">
                                <a href="#">
                                    <img src="../Media/<%=img.thumb %>" width="1920" height="560" />
                                </a>
                            </li>
                            <%} %>
                        </ul>
                    </div>

                    <%--<div id="htmlcontent_top">
                        <ul class="htmlcontent-home clearfix row">
                            <li class="htmlcontent-item-1 col-xs-4">
                                <a href="index.php?id_category=5&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div1">
                                            <h2>Today's<br />
                                                Top 50 eBooks</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="htmlcontent-item-2 col-xs-4">
                                <a href="index.php?id_category=6&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div2">
                                            <h2>Recommended Reading</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="htmlcontent-item-3 col-xs-4">
                                <a href="index.php?id_category=7&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div3">
                                            <h2>-50%</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>--%>
    <div style="background-color:#4fb9e1;padding:1%;">
        <img src="../img/humberger.png"  onclick="$('#subGames').slideToggle()" style='cursor:pointer;height:30px'/>
        <span style="color:white;font-size:40px;font-weight:bold;<%=lang=="ar"?"font-family:Web-Font-Ar":""%>;position:absolute;left:45%;margin-top:5px" id="cat"><%=lang=="en"?"READINGS":"قرائات" %></span>
        <div style="position:absolute;width:300px;display:none;background-color:white;z-index:999999;" id="subGames">
            <ul id="home-page-tabs" class="nav nav-tabs clearfix">
                                    <%foreach (var category in categories.Where(x=>x.ForGame!=true).ToList())
                                        { %>
                                    <li class="cat-<%=category.id %>" style="width:100%;margin:0px;background-color:#d4d4d4;border-bottom:1px solid #cccccc"><a data-toggle="tab" href="#cat-<%=category.id %>" class="cat-<%=category.id %>" style="color:black;text-decoration:none;font-size:20px;<%=lang=="ar"?"font-family:Web-Font-Ar":""%>" onclick="$('#cat').html('&nbsp;&nbsp;&nbsp;<%=lang=="en"?category.title:category.artitle %>')"><%=lang=="en"?category.title:category.artitle %></a></li>
                                    
                                    <%} %>
                <%if (student.School.showGame != false)
                    { %>
                <%foreach (var category in categories.Where(x => x.ForGame == true).ToList())
    { %>
                <li class="cat-0" style="width:100%;margin:0px;background-color:#d4d4d4;border-bottom:1px solid #cccccc"><a href="games?levelId=<%=levelId %>&categoryId=<%=category.id %>" style="color:black;text-decoration:none;font-size:20px;<%=lang=="ar"?"font-family:Web-Font-Ar":""%>" class="cat-0"><%=lang == "en" ? category.title : category.artitle %></a></li><%}
    } %>
                
                                </ul>
        </div>
    </div>
    <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
                                
                                <div class="tab-content">
                                    <%foreach (var category in categories.Where(x=>x.ForGame!=true).ToList())
                                        {
                                            var items = category.ItemsCategories.Where(x=>x.Book.ItemsLevels.Where(y=>y.LevelId == levelId).Count()>0 && x.Book.SchoolBooks.Where(z=>z.schoolId == student.schoolId).Count()>0 && x.Book.isAvailable == true);%>
                                    <ul id="cat-<%=category.id %>" class="product_list grid row homefeatured tab-pane">
                                        <%foreach (var item in items)
                                            { %>
                                        <li class="ajax_block_product col-xs-12 col-sm-3 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == levelId?("href='book-"+item.BookId+"'"):"" %> title="<%=lang=="en"?item.Book.title:item.Book.artitle %>n" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.Book.thumb %>" alt="<%=lang=="en"?item.Book.title:item.Book.artitle %>" title="<%=lang=="en"?item.Book.title:item.Book.artitle %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.BookId %>" src="../Media/<%=item.Book.thumb %>" alt="<%=lang=="en"?item.Book.title:item.Book.artitle %>" title="<%=lang=="en"?item.Book.title:item.Book.artitle %>" itemprop="image" />
                                                        </a>
                                                        <a class="quick-view" <%=item.Book.ItemsLevels.Where(x => x.LevelId == student.levelId).Count() > 0 ? "href='book-" + item.BookId + "'" : "" %> rel="">
                                                            <span style="font-size:15px;<%=lang=="ar"?"font-family:Web-Font-Ar":""%>"><%=lang == "en" ? item.Book.title : item.Book.artitle %></span>
                                                        </a>
                                                        <%if (item.Book.StudentLibraries.Where(x=>x.studentId == student.id).Count() == 0 && student.levelId == levelId)
                                                            { %>
                                                        <a class="sale-box" onclick="AddToLibrary('<%=item.BookId %>', this)">
                                                            <span class="sale-label">Add to Library</span>
                                                        </a>
                                                        <%} %>
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    <%--<div itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="content_price">
                                                        <span itemprop="price" class="price product-price product-price-new">$112.20 </span>
                                                        <meta itemprop="priceCurrency" content="USD" />
                                                        <span class="old-price product-price">$121.96
</span>
                                                        <span class="price-percent-reduction">-8%</span>
                                                    </div>--%>
                                                    <%--<h5 itemprop="name">
                                                        <a class="product-name" <%=student.levelId == levelId?("href='book-"+item.BookId+"'"):"" %> title="<%=lang=="en"?item.Book.title:item.Book.artitle %>" itemprop="url">
                                                            <span class="list-name"><%=lang=="en"?item.Book.title:item.Book.artitle %></span>
                                                            <span class="grid-name"><%=lang=="en"?item.Book.title:item.Book.artitle %></span>
                                                        </a>
                                                    </h5>
                                                    <p class="product-desc" itemprop="description">
                                                        <span class="list-desc">Well, reading books as a hobby was always a noble, pleasant and very useful kind of activity. It gives knowledge, exerts on the process of development of your personality. For a long period of time books were very rare and because of such confines only some “esoteric” people could afford them.</span>
                                                        <span class="grid-desc">Well, reading books as a hobby was...</span>
                                                    </p>--%>
                                                    <%--<div class="button-container">
                                                        <span class="ajax_add_to_cart_button btn btn-default disabled">
                                                            <span>Add to cart</span>
                                                        </span>
                                                        <a itemprop="url" class="lnk_view btn btn-default" href="http://livedemo00.template-help.com/prestashop_53956/index.php?id_product=3&amp;controller=product&amp;id_lang=1" title="View">
                                                            <span>More</span>
                                                        </a>
                                                    </div>
                                                    <div class="product-flags">
                                                        <span class="online_only">Online only</span>
                                                    </div>
                                                    <span itemprop="offers" itemscope itemtype="http://schema.org/Offer" class="availability">
                                                        <span class="out-of-stock">
                                                            <link itemprop="availability" href="http://schema.org/OutOfStock" />
                                                            Out of stock
</span>
                                                    </span>--%>
                                                </div>
                                            </div>
                                        </li>
                                        <%} %>
                                    </ul>
                                    <%} %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <script>
        function AddToLibrary(bookId, f)
        {
            $.post("../AddToLibrary.ashx", { bookId: bookId }, function (msg) {
                if(msg == "success")
                {
                    f.children[0].style.backgroundColor = "#4fa172";
                }
                else {
                    alert("An error has occured, Please try again later!");
                }
            });
        }
        
    </script>
</asp:Content>
