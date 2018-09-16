<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="stories.aspx.cs" Inherits="Web.stories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
   
    <div style="background-color:#4fb9e1;padding:1%;">
   
        <span style="color:white;font-size:40px;font-weight:bold;;position:absolute;left:45%;margin-top:5px" id="cat"><%=book.title + "(" + (book.lang=="en"?"Stories":"Histoires") + ")" %></span>
        
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
                                                        <a class="product_img_link" <%=student.levelId == book.levelId?("href='story-"+item.id+"'"):"" %> title="<%=item.title%>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.thumb %>" alt="<%=item.title %>" title="<%=item.title %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.id %>" src="../Media/<%=item.thumb %>" alt="<%=item.title %>" title="<%=item.title %>" itemprop="image" />
                                                        </a>
                                                        <a class="quick-view" <%=student.levelId == book.levelId ? "href='story-" + item.id + "'" : "" %> rel="">
                                                            <span style="font-size:15px;"><%=item.title %></span>
                                                        </a>
                                                        
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
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
