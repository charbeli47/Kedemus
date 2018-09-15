<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pdfViewer.aspx.cs" Inherits="Web.pdfViewer" %>

<!DOCTYPE html>
<html>
<head>
    <title>jQuery Viewer Example</title>
	<style type="text/css">
		body {
			background: #0000FF;
		}
		#container {
			margin-left: auto;
			margin-right: auto;
			width: 800px;
		}
		#controls {
			/*position: absolute;*/
			width: 99%;
			height: 50px;
			border: black solid 1px;
			overflow: hidden;
			z-index: 500;
			background: #FF0000;
		}
		#controls h1 {
			font-size: 18px;
			font-weight: bold;
			text-align: center;
		}
		#page {
			background: white;
			border: black solid 1px;
			display: inline-block;
		}
		#pageNum {
			text-align: center;
			margin: auto 0;
			color: white;
		}
	</style>
</head>
<body>

<div id="container">
	<form id='controls'>
		<input style="float: left;" type="button" name="Prev" value="Prev Page" id='prevBtn' />
		<input style="float: right;" type="button" name="Next" value="Next Page" id='nextBtn' />
		<h1>Page <span class="pageNum">1</span> of <span class="documentName">awjune</span></h1>
	</form>
	<div id='page' style=""></div>
	<div id="pageNum">Page <span class="pageNum">1</span></div>
</div>

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	var documentName = "awjune";
	var page = 1;
	var maxPages = 39;
	function loadPage() {
		// First we check the file exists by getting it's header.
		$.ajax({
			// Files are contained in the same directory as this file because things can get complicated with fonts not loading
			url : page + ".html",
			type : "HEAD",
			error : function() {
				// File not found, display an error message?
				$("#page").html("<div style='text-align: center'><b>Error:</b> File not found.</div>");
			},
			success : function() {
				// File is there let's load it into the element
				$("#page").load(page + ".html", function() {
					$("#controls").css("width", $("#page").width());
					$("#pageNum").css("width", $("#page").width());
					// Run our font adjustment code if it exists for the given page
					if(window["fontAdjustments" + page] !== undefined) {
						window["fontAdjustments" + page]();
					}
				});
			}
		});
	}
	function updatePageNum() {
		$(".pageNum").html(page);
		$(".documentName").html(documentName);
		window.location.hash = page.toString(); // this will trigger a window.hashchange event
	}
	$(document).ready(function() {
		$("#nextBtn").click(function() {
			page = page+1 <= maxPages ? page+1 : maxPages;
			updatePageNum();
		});
		$("#prevBtn").click(function() {
			page  = page-1 > 0 ? page-1 : 1;
			updatePageNum();
		});
		$(window).on("hashchange", function() {
			if(window.location.hash != "" && window.location.hash != page) {
				var newPage = parseInt(window.location.hash.replace("#", ""));
				if(isNaN(newPage) || newPage < 1) {
					window.location.hash = "1";
				}
				else if(newPage > maxPages) {
					window.location.hash = maxPages.toString();
				}
				else {
					page = newPage;
					loadPage();
				}
			}
		});
		loadPage();
	});
</script>
</body>
</html>
