<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="books.aspx.cs" Inherits="Web.books" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
   
    <div style="background-color:#4fb9e1;padding:1%;height:60px">
   
        <span style="color:white;font-size:40px;font-weight:bold;position:absolute;left:45%;margin-top:5px" id="cat"><%=lang=="en"?"BOOKS":"LIVRES" %></span>
        
    </div>
    <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
                                
                                <div class="tab-content">
                                   <ul id="cat" class="product_list grid row homefeatured tab-pane">
                                        <%foreach (var item in results)
                                            { %>
                                        <li class="ajax_block_product col-xs-12 col-sm-3 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == levelId?("href='book-"+item.id+"'"):"" %> title="<%=item.title%>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.thumb %>" alt="<%=item.title %>" title="<%=item.title %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.id %>" src="../Media/<%=item.thumb %>" alt="<%=item.title %>" title="<%=item.title %>" itemprop="image" />
                                                        </a>
                                                        <a class="quick-view" <%=student.levelId == levelId ? "href='book-" + item.id + "'" : "" %> rel="">
                                                            <span style="font-size:15px;"><%=item.title %></span>
                                                        </a>
                                                        <%if (item.StudentLibraries.Where(x=>x.studentId == student.id).Count() == 0 && student.levelId == levelId)
                                                            { %>
                                                        <a class="sale-box" onclick="AddToLibrary('<%=item.id %>', this)">
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
