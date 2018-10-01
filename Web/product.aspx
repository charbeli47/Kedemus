<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="Web.product" %>
<asp:Content ContentPlaceHolderID="header" runat="server">
    <link rel="stylesheet" href="../css/product.css" media="all" />
    <link rel="stylesheet" href="../js/product.js" media="all" />
    <link href="/dflip/css/dflip.css" rel="stylesheet" type="text/css">
    <link href="/dflip/css/themify-icons.css" rel="stylesheet" type="text/css">
        
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


<div id="columns" class="container">
 
<div class="breadcrumb clearfix">
<a class="home" href="<%=result.levelId != null ? "level-" + result.levelId : "/" %>" title="<%=lang == "en" ? "Return to Home" : "Retour à l'accueil" %>">
<i class="fa fa-home"></i>
</a>
<span class="navigation-pipe">&gt;</span>
<%=result.title %>
</div>
 
 
<div class="primary_block row one-column">
 

 
<div class="pb-right-column col-sm-12 col-md-12 col-lg-12" style="padding-left:0px;padding-right:0px">

    <div class="container-fluid" style="margin-top:20px;padding-left:0px;padding-right:0px">
                
    <div id="flipbookContainer"></div>
                    <!-- Flipbook main Js file -->
<script src="/dflip/js/dflip.js" type="text/javascript"></script>
<%
    /*string slides = "";
    foreach (var slide in result.BookSlides)
    {
        slides += ",'/Media/" + slide.img + "'";
    }
    if (!string.IsNullOrEmpty(slides))
    {
        slides = slides.Substring(1);
    }*/ %>
<script>

    var flipBook;

    jQuery(document).ready(function () {

        //make sure this file is hosted in localhost or any other server
        //var images = [];

        var options = {
            webgl:false,
            height: 800,
            duration: 800,
            <%--<%if (result.isArabic == true) {%>
            direction:2,
            <%}%>--%>
            autoEnableOutline:false //auto open the outline/bookmarks tab
        };

        /**
         * outline is basically a array of json object as:
         * {title:"title to appear",dest:"url as string or page as number",items:[]}
         * items is the same process again array of json objects
         */
        

        flipBook = $("#flipbookContainer").flipBook("/Media/<%=result.pdf%>", options);
    });

</script>
</div>
</div>
</div>  
    
    <div class="container">
        <center>
           
        </center>
    </div> 
    
    <%if (result.isSingleBook!=null && result.isSingleBook == true)
        { %>

<div class="col-sm-12 col-md-12 col-lg-12" id="slVideo">
<iframe width="100%" height="658" data-bgfit="cover" id="slplayer" data-bgposition="center center" src="https://kedemos.brandseducation.com/iframe.aspx?q=<%=result.VimeoId %>" frameborder="0" allowfullscreen></iframe>
</div>
 <%}
    %>
    <div class="container">
        <center>
            
        <%if (result.BookUnites != null && result.BookUnites.Count>0)
            {%>
            <div class="unitesBack">
               <% foreach (var unite in result.BookUnites.OrderBy(x=>x.OrderIndex))
                { %>
            <a data-toggle="tab" class="cat-<%=unite.id %>" id="unite<%=unite.id %>" style="font-size:33px;padding:5px" href="#cat-<%=unite.id %>"><%=unite.title%></a>
        <%}%>
                </div>
            <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
          <div class="tab-content">
            <%foreach (var unite in result.BookUnites.OrderBy(x=>x.OrderIndex))
        { %>
            
                                    
                                    <ul id="cat-<%=unite.id %>" class="product_list grid row homefeatured tab-pane">
                                        <%
                                            var files = unite.BookUniteFiles.OrderBy(x => x.OrderIndex).ToList();
                                            for (int i=0;i<files.Count;i++)
                                            {
                                                var item = files[i];%>
                                        <li class="ajax_block_product col-xs-12 col-sm-2 col-md-3 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" style="cursor:pointer" onclick="popupFile('<%=item.uniteId %>','<%=item.InteractiveFile%>')" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../img/exerciseBack.png" alt="EXERCICE <%= i+1%>" title="EXERCICE <%= i+1%>" itemprop="image" style="margin-top: -26px;"/>
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.id %>" src="../img/exerciseBack.png" alt="EXERCICE <%= i+1%>" title="EXERCICE <%= i+1%>" itemprop="image" />
                                                            <h3 style="margin-top:-120px">EXERCICE <%= i+1%></h3>
                                                        </a>
                                                        
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
                                                </div>
                                            </div>
                                        </li>
                                        <%} %>
                                    </ul>
                                    
                                
    <%}%>
              </div>
                                </div></div></div></div></div>
        <%}%>    
        </center>
    </div>
    </div>
    <div id="GameContainer" style="width:80%;height:70%;display:none"></div>
    <%--<div id="GameContainer" style="width:80%;height:600px;display:none"></div>
    <script>
        function popupGame(bookId, folder) {
            var iframe = "<div style='width:100%;height:5%;color:white;font-weight:bold;cursor:pointer;text-align:right;padding-top:2%' onclick='bpop.close()'>X</div><iframe width='100%' height='80%' src='../Media/Games/" + bookId + "/"+folder+"' frameborder='0' allowfullscreen ></iframe>";
            $("#GameContainer").html(iframe);
            bpop = $("#GameContainer").bPopup({ fadeSpeed: 'slow', followSpeed: 1500, modalColor: 'Black', onClose: function () { $("#GameContainer").html(""); } });
        }
    </script>--%>
    <script>
        function popupFile(uniteId, folder) {
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                window.location.href = "../Media/Unites" + uniteId + "/" + folder;
            }
            else {
                var iframe = "<div style='width:100%;height:5%;color:white;font-weight:bold;cursor:pointer;text-align:right;' onclick='bpop.close()'>X</div><iframe width='100%' height='100%' src='../Media/Unites/" + uniteId + "/" + folder + "' frameborder='0' allowfullscreen ></iframe>";
                $("#GameContainer").html(iframe);
                bpop = $("#GameContainer").bPopup({ fadeSpeed: 'slow', followSpeed: 1500, modalColor: 'Black', onClose: function () { $("#GameContainer").html(""); } });
            }
        }
        var isMobile = {
            Android: function () {
                return navigator.userAgent.match(/Android/i);
            },
            BlackBerry: function () {
                return navigator.userAgent.match(/BlackBerry/i);
            },
            iOS: function () {
                return navigator.userAgent.match(/iPhone|iPad|iPod/i);
            },
            Opera: function () {
                return navigator.userAgent.match(/Opera Mini/i);
            },
            Windows: function () {
                return navigator.userAgent.match(/IEMobile/i);
            },
            any: function () {
                return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
            }
        };
        
    </script>
</asp:Content>
