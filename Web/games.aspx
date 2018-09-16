<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="games.aspx.cs" Inherits="Web.games" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
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

                    
                </div>
            </div>--%>
    <div style="background-color:#4fb9e1;padding:1%;">
        
        <span style="color:white;font-size:40px;font-weight:bold;position:absolute;left:45%;margin-top:5px" id="cat"><%=book.title %> (Posters)</span>
        
    </div>
    <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
                                
                                <div class="tab-content">
                                    
                                    <ul class="product_list grid row homefeatured tab-pane">
                                        <%foreach (var item in gamesList)
                                            { %>
                                        <li class="ajax_block_product col-xs-12 col-sm-2 col-md-4 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=student.levelId == book.levelId?("onclick=\"popupGame(\'"+item.bookId +"\',\'"+item.InteractiveFile +"\')\""):"" %> title="<%=item.InteractiveFile %>" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.thumb %>" alt="<%=item.InteractiveFile %>" title="<%=item.InteractiveFile %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.bookId %>" src="../Media/<%=item.thumb %>" alt="<%=item.InteractiveFile %>" title="<%=item.InteractiveFile %>" itemprop="image" />
                                                        </a>
                                                        <a class="quick-view" <%=student.levelId == book.levelId?("onclick=\"popupGame(\'"+item.bookId +"\',\'"+item.InteractiveFile +"\')\""):"" %> rel="" style="cursor:pointer">
                                                            <span><%=item.InteractiveFile %></span>
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
    <div id="GameContainer" style="width:80%;height:70%;display:none"></div>
    <script>
        function popupGame(bookId, folder) {
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                window.location.href = "../Media/Posters/" + bookId + "/" + folder;
            }
            else {
                var iframe = "<div style='width:100%;height:5%;color:white;font-weight:bold;cursor:pointer;text-align:right;' onclick='bpop.close()'>X</div><iframe width='100%' height='100%' src='../Media/Posters/" + bookId + "/" + folder + "' frameborder='0' allowfullscreen ></iframe>";
                $("#GameContainer").html(iframe);
                bpop = $("#GameContainer").bPopup({ fadeSpeed: 'slow', followSpeed: 1500, modalColor: 'Black', onClose: function () { $("#GameContainer").html(""); } });
            }
        }
    
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
