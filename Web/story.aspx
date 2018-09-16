<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="story.aspx.cs" Inherits="Web.story" %>
<asp:Content ContentPlaceHolderID="header" runat="server">
    <link rel="stylesheet" href="../css/product.css" media="all" />
    <link rel="stylesheet" href="../js/product.js" media="all" />
    <link href="/dflip/css/dflip.css" rel="stylesheet" type="text/css">
    <link href="/dflip/css/themify-icons.css" rel="stylesheet" type="text/css">
        
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


<div id="columns" class="container">
 
<div class="breadcrumb clearfix">
<a class="home" href="<%=result.bookId != null ? "stories-" + result.bookId : "home" %>" title="<%=lang == "en" ? "Return to Home" : "Retour à l'accueil" %>">
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
    <
    <%if (!string.IsNullOrEmpty(result.InteractiveFile))
        { %>

<div class="col-sm-12 col-md-12 col-lg-12" style="display:none" id="slVideo">
<iframe width="100%" height="658" data-bgfit="cover" id="slplayer" data-bgposition="center center" src="/Media/Stories/<%=result.bookId + "/" + result.InteractiveFile %>" frameborder="0" allowfullscreen></iframe>
</div>
 <%}
    %>
    
    </div>
    
    
</asp:Content>
