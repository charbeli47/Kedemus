<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="Web.product" %>
<asp:Content ContentPlaceHolderID="header" runat="server">
    <link rel="stylesheet" href="../css/product.css" media="all" />
    <link rel="stylesheet" href="../js/product.js" media="all" />
    <link href="/dflip/css/dflip.css" rel="stylesheet" type="text/css">
    <link href="/dflip/css/themify-icons.css" rel="stylesheet" type="text/css">
        <%if (!string.IsNullOrEmpty(result.background)) { %>
<style>
    body, .columns-container{
        background-image:url(../Media/<%=result.background%>);
        background-repeat:repeat;
        background-position:center;
    }
    </style>
        <%}%>
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


<div id="columns" class="container">
 
<div class="breadcrumb clearfix">
<a class="home" href="<%=result.ItemsLevels.FirstOrDefault() != null ? "level-" + result.ItemsLevels.FirstOrDefault().LevelId : "home" %>" title="<%=lang == "en" ? "Return to Home" : "الرجوع إلى الرئيسية" %>">
<i class="fa fa-home"></i>
</a>
<span class="navigation-pipe">&gt;</span>
<%=lang == "en" ? result.title : result.artitle %>
</div>
 
 
<div class="primary_block row one-column">
 

 
<div class="pb-right-column col-sm-12 col-md-12 col-lg-12" style="padding-left:0px;padding-right:0px">
<%-- <%var slides = result.BookSlides.OrderBy(x => x.OrderIndex).ToList();
     if(slides.Count>0) { %>
    <script type="text/javascript" src="../bookSlide/extras/jquery.min.1.7.js"></script>
<script type="text/javascript" src="../bookSlide/extras/modernizr.2.5.3.min.js"></script>
<script type="text/javascript" src="../bookSlide/lib/hash.js"></script>
    <div id="canvas" style="width:896px;margin:auto">



<div class="magazine-viewport">
	
		<div class="magazine" style="margin-left:0px !important">
            <!--pages-->
            <%
                for (int i = 0; i < slides.Count; i++)
                { %>
            <div><img src="../Media/<%=slides[i].img %>" style="height:100%" class="page-<%=i + 1 %>"></div>
            <%} %>
            <!--end pages-->

			<!-- Next button -->
			<div ignore="1" class="next-button"></div>
			<!-- Previous button -->
			<div ignore="1" class="previous-button"></div>
		</div>
	
</div>

	

<script type="text/javascript">

function loadApp() {

 	$('#canvas').fadeIn(1000);

 	var flipbook = $('.magazine');

 	// Check if the CSS was already loaded
	
	if (flipbook.width()==0 || flipbook.height()==0) {
		setTimeout(loadApp, 10);
		return;
	}
	
	// Create the flipbook

	flipbook.turn({
			
			// Magazine width

			width: 896,

			// Magazine height

			height: 583,

			// Duration in millisecond

			duration: 1000,

			// Hardware acceleration

			acceleration: !isChrome(),

			// Enables gradients

			gradients: true,
			
			// Auto center this flipbook

			autoCenter: true,

			// Elevation from the edge of the flipbook when turning a page

			elevation: 50,

			// The number of pages

			pages: 12,

			// Events

			when: {
				turning: function(event, page, view) {
					
					var book = $(this),
					currentPage = book.turn('page'),
					pages = book.turn('pages');
			
					// Update the current URI

					Hash.go('page/' + page).update();

					// Show and hide navigation buttons

					disableControls(page);
					

					$('.thumbnails .page-'+currentPage).
						parent().
						removeClass('current');

					$('.thumbnails .page-'+page).
						parent().
						addClass('current');



				},

				turned: function(event, page, view) {

					disableControls(page);

					$(this).turn('center');

					if (page==1) { 
						$(this).turn('peel', 'br');
					}

				},

				missing: function (event, pages) {

					// Add pages that aren't in the magazine

					/*for (var i = 0; i < pages.length; i++)
						addPage(pages[i], $(this));*/

				}
			}

	});

	// Zoom.js

	$('.magazine-viewport').zoom({
		flipbook: $('.magazine'),

		max: function() { 
			
			return largeMagazineWidth()/$('.magazine').width();

		}, 

		when: {

			swipeLeft: function() {

				$(this).zoom('flipbook').turn('next');

			},

			swipeRight: function() {
				
				$(this).zoom('flipbook').turn('previous');

			},

			resize: function(event, scale, page, pageElement) {

				if (scale==1)
					loadSmallPage(page, pageElement);
				else
					loadLargePage(page, pageElement);

			},

			zoomIn: function () {

				$('.thumbnails').hide();
				$('.made').hide();
				$('.magazine').removeClass('animated').addClass('zoom-in');
				$('.zoom-icon').removeClass('zoom-icon-in').addClass('zoom-icon-out');
				
				if (!window.escTip && !$.isTouch) {
					escTip = true;

					$('<div />', {'class': 'exit-message'}).
						html('<div>Press ESC to exit</div>').
							appendTo($('body')).
							delay(2000).
							animate({opacity:0}, 500, function() {
								$(this).remove();
							});
				}
			},

			zoomOut: function () {

				$('.exit-message').hide();
				$('.thumbnails').fadeIn();
				$('.made').fadeIn();
				$('.zoom-icon').removeClass('zoom-icon-out').addClass('zoom-icon-in');

				setTimeout(function(){
					$('.magazine').addClass('animated').removeClass('zoom-in');
					resizeViewport();
				}, 0);

			}
		}
	});
    
	// Zoom event

	/*if ($.isTouch)
		$('.magazine-viewport').bind('zoom.doubleTap', zoomTo);
	else
		$('.magazine-viewport').bind('zoom.tap', zoomTo);*/


	// Using arrow keys to turn the page

	$(document).keydown(function(e){

		var previous = 37, next = 39, esc = 27;

		switch (e.keyCode) {
			case previous:

				// left arrow
				$('.magazine').turn('previous');
				e.preventDefault();

			break;
			case next:

				//right arrow
				$('.magazine').turn('next');
				e.preventDefault();

			break;
			case esc:
				
				$('.magazine-viewport').zoom('zoomOut');	
				e.preventDefault();

			break;
		}
	});

	// URIs - Format #/page/1 

	Hash.on('^page\/([0-9]*)$', {
		yep: function(path, parts) {
			var page = parts[1];

			if (page!==undefined) {
				if ($('.magazine').turn('is'))
					$('.magazine').turn('page', page);
			}

		},
		nop: function(path) {

			if ($('.magazine').turn('is'))
				$('.magazine').turn('page', 1);
		}
	});


	$(window).resize(function() {
		resizeViewport();
	}).bind('orientationchange', function() {
		resizeViewport();
	});

	// Events for thumbnails

	$('.thumbnails').click(function(event) {
		
		var page;

		if (event.target && (page=/page-([0-9]+)/.exec($(event.target).attr('class'))) ) {
		
			$('.magazine').turn('page', page[1]);
		}
	});

	$('.thumbnails li').
		bind($.mouseEvents.over, function() {
			
			$(this).addClass('thumb-hover');

		}).bind($.mouseEvents.out, function() {
			
			$(this).removeClass('thumb-hover');

		});

	if ($.isTouch) {
	
		$('.thumbnails').
			addClass('thumbanils-touch').
			bind($.mouseEvents.move, function(event) {
				event.preventDefault();
			});

	} else {

		$('.thumbnails ul').mouseover(function() {

			$('.thumbnails').addClass('thumbnails-hover');

		}).mousedown(function() {

			return false;

		}).mouseout(function() {

			$('.thumbnails').removeClass('thumbnails-hover');

		});

	}


	// Regions

	if ($.isTouch) {
		$('.magazine').bind('touchstart', regionClick);
	} else {
		$('.magazine').click(regionClick);
	}

	// Events for the next button

	$('.next-button').bind($.mouseEvents.over, function() {
		
		$(this).addClass('next-button-hover');

	}).bind($.mouseEvents.out, function() {
		
		$(this).removeClass('next-button-hover');

	}).bind($.mouseEvents.down, function() {
		
		$(this).addClass('next-button-down');

	}).bind($.mouseEvents.up, function() {
		
		$(this).removeClass('next-button-down');

	}).click(function() {
		
		$('.magazine').turn('next');

	});

	// Events for the next button
	
	$('.previous-button').bind($.mouseEvents.over, function() {
		
		$(this).addClass('previous-button-hover');

	}).bind($.mouseEvents.out, function() {
		
		$(this).removeClass('previous-button-hover');

	}).bind($.mouseEvents.down, function() {
		
		$(this).addClass('previous-button-down');

	}).bind($.mouseEvents.up, function() {
		
		$(this).removeClass('previous-button-down');

	}).click(function() {
		
		$('.magazine').turn('previous');

	});


	resizeViewport();

	$('.magazine').addClass('animated');

}

// Zoom icon

 $('.zoom-icon').bind('mouseover', function() { 
 	
 	if ($(this).hasClass('zoom-icon-in'))
 		$(this).addClass('zoom-icon-in-hover');

 	if ($(this).hasClass('zoom-icon-out'))
 		$(this).addClass('zoom-icon-out-hover');
 
 }).bind('mouseout', function() { 
 	
 	 if ($(this).hasClass('zoom-icon-in'))
 		$(this).removeClass('zoom-icon-in-hover');
 	
 	if ($(this).hasClass('zoom-icon-out'))
 		$(this).removeClass('zoom-icon-out-hover');

 }).bind('click', function() {

 	if ($(this).hasClass('zoom-icon-in'))
 		$('.magazine-viewport').zoom('zoomIn');
 	else if ($(this).hasClass('zoom-icon-out'))	
		$('.magazine-viewport').zoom('zoomOut');

 });

 $('#canvas').hide();


// Load the HTML4 version if there's not CSS transform
    6
yepnope({
	test : Modernizr.csstransforms,
	yep: ['../bookSlide/lib/turn.js'],
	nope: ['../bookSlide/lib/turn.html4.min.js'],
	both: ['../bookSlide/lib/zoom.min.js', '../bookSlide/js/magazine.js', '../bookSlide/css/magazine.css'],
	complete: loadApp
});

</script>


 
</div> 
    <%} %> 
<div class="clearfix product-information">
    
</div>--%>
    <div class="container-fluid" style="margin-top:20px;padding-left:0px;padding-right:0px">
                
    <div id="flipbookContainer"></div>
                    <!-- Flipbook main Js file -->
<script src="/dflip/js/dflip.js" type="text/javascript"></script>
<%
    string slides = "";
    foreach (var slide in result.BookSlides)
    {
        slides += ",'/Media/" + slide.img + "'";
    }
    if (!string.IsNullOrEmpty(slides))
    {
        slides = slides.Substring(1);
    } %>
<script>

    var flipBook;

    jQuery(document).ready(function () {

        //make sure this file is hosted in localhost or any other server
        var images = [<%=slides%>];

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
        

        flipBook = $("#flipbookContainer").flipBook(images, options);
    });

</script>
</div>
</div>
</div>  
    
    <div class="container">
        <center>
        <%if (!string.IsNullOrEmpty(result.video))
            { %>
            <div class="btn" id="btn1" style="background-color:#000000;color:white;width:300px" onclick="document.getElementById('player').src='https://player.vimeo.com/video/<%=result.video %>?title=0&byline=0&portrait=0';this.style.backgroundColor ='#000000';$('#btn2').css('background-color','#007ee1');$('#btn3').css('background-color','#007ee1');"><%=lang == "en" ? "STORY VIDEO" : "فيديو" %></div>
        <%}
            if (!string.IsNullOrEmpty(result.SignLanguageVideo))
            { %>
            <div class="btn" id="btn2" style="background-color:#007ee1;color:white;width:300px" onclick="document.getElementById('player').src='https://player.vimeo.com/video/<%=result.SignLanguageVideo %>?title=0&byline=0&portrait=0';this.style.backgroundColor='#000000';$('#btn1').css('background-color','#007ee1');$('#btn3').css('background-color','#007ee1');"><%=lang == "en" ? "SIGN LANGUAGE STORY VIDEO" : "فيديو للغة الإشارة" %></div>
            <%}
                if (result.QuestionsCategories.Count() > 0 && db.StudentScores.Where(x => x.studentId == usr.id && x.bookId == bookId).Count() == 0)
                { %>
            <div class="btn" id="btn3" style="background-color:#007ee1;color:white;width:300px" onclick="if(!isMobile.any()){document.getElementById('player').src='../assessment/index.aspx?bookId=<%=result.id %>';this.style.backgroundColor='#000000';$('#btn1').css('background-color','#007ee1');$('#btn2').css('background-color','#007ee1');}else{window.location.href='../assessment/index.aspx?bookId=<%=result.id %>';}"><%=lang == "en" ? "Assessment" : "مسابقة" %></div>
        <%} %>    
        </center>
    </div> 
    <%if (!string.IsNullOrEmpty(result.video))
        { %>

<div class="col-sm-12 col-md-12 col-lg-12" id="tVideo">
<iframe width="100%" height="658" data-bgfit="cover" id="player" data-bgposition="center center" src="https://player.vimeo.com/video/<%=result.video %>?title=0&byline=0&portrait=0" frameborder="0" allowfullscreen></iframe>
</div>
 <%}%>
    <%--<%if (!string.IsNullOrEmpty(result.SignLanguageVideo))
        { %>

<div class="col-sm-12 col-md-12 col-lg-12" style="display:none" id="slVideo">
<iframe width="100%" height="658" data-bgfit="cover" id="slplayer" data-bgposition="center center" src="https://www.youtube-nocookie.com/embed/<%=result.SignLanguageVideo %>?version=3&rel=0&autoplay=0&controls=0&loop=0&showinfo=0" frameborder="0" allowfullscreen></iframe>
</div>
 <%}
    %>--%>
    <div class="container">
        <center>
            
        <%if (result.BookInteractiveChapters != null)
            {%>
            <div class="unitesBack">
               <% foreach (var unite in result.BookInteractiveChapters.OrderBy(x=>x.OrderIndex))
                { %>
            <a data-toggle="tab" class="cat-<%=unite.id %>" id="unite<%=unite.id %>" style="font-size:56px" href="#cat-<%=unite.id %>"><%=unite.OrderIndex%></a>
        <%}%>
                </div>
            <div id="columns" class="container">
        
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
          <div class="tab-content">
            <%foreach (var unite in result.BookInteractiveChapters.OrderBy(x=>x.OrderIndex))
        { %>
            
                                    
                                    <ul id="cat-<%=unite.id %>" class="product_list grid row homefeatured tab-pane">
                                        <%foreach (var item in unite.BookChapterFiles.OrderBy(x=>x.OrderIndex))
                                            { %>
                                        <li class="ajax_block_product col-xs-12 col-sm-2 col-md-4 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" style="cursor:pointer" onclick="popupFile('<%=item.chapterId %>','<%=item.InteractiveFile%>')" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.thumb %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.chapterId %>" src="../Media/<%=item.thumb %>" itemprop="image" />
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
