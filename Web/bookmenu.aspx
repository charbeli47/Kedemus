<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="bookmenu.aspx.cs" Inherits="Web.bookmenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
   
    <div style="background-color:#4fb9e1;padding:1%;height:60px">
   
        <span style="color:white;font-size:40px;font-weight:bold;position:absolute;left:45%;margin-top:5px" id="cat"><%=book.title %></span>
        
    </div>
    <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
                                
                                <div class="tab-content">
                                   <ul id="cat" class="product_list grid row homefeatured tab-pane">
                                        
                                        <li class="ajax_block_product col-xs-12 col-sm-4 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == book.levelId?("href='book-"+book.id+"'"):"" %> title="<%=book.title%>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=book.id %>" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <h3><%=lang=="en"?"WORKBOOK":"Classeur" %></h3>
                                                        </a>
                                                        <%--<a class="quick-view" <%=student.levelId == levelId ? "href='book-" + item.id + "'" : "" %> rel="">
                                                            <span style="font-size:15px;"><%=item.title %></span>
                                                        </a>--%>
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
                                                </div>
                                            </div>
                                        </li>
                                        <li class="ajax_block_product col-xs-12 col-sm-4 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == book.levelId?("href='games?bookId="+book.id+"'"):"" %> title="<%=book.title%>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=book.id %>" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <h3><%=lang=="en"?"Posters":"Affiches" %></h3>
                                                        </a>
                                                        <%--<a class="quick-view" <%=student.levelId == levelId ? "href='book-" + item.id + "'" : "" %> rel="">
                                                            <span style="font-size:15px;"><%=item.title %></span>
                                                        </a>--%>
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
                                                </div>
                                            </div>
                                        </li>
                                       <li class="ajax_block_product col-xs-12 col-sm-4 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == book.levelId?("href='games?bookId="+book.id+"'"):"" %> title="<%=book.title%>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=book.id %>" src="../img/exerciseBack.png" alt="<%=book.title %>" title="<%=book.title %>" itemprop="image" />
                                                            <h3><%=lang=="en"?"Stories":"Histoires" %></h3>
                                                        </a>
                                                        <%--<a class="quick-view" <%=student.levelId == levelId ? "href='book-" + item.id + "'" : "" %> rel="">
                                                            <span style="font-size:15px;"><%=item.title %></span>
                                                        </a>--%>
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
                                                </div>
                                            </div>
                                        </li>
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
