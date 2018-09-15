<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Web._default" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html;charset=utf-8" />
        <title>Welcome</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- Daterange picker -->
        <link href="css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="css/AdminLTE.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
       
        <script>
document.addEventListener('DOMContentLoaded', function () {
  if (Notification.permission !== "granted")
    Notification.requestPermission();
            });

            function notifyMe() {
                if (Notification.permission !== "granted")
                    Notification.requestPermission();
                else
                {
                    var notification = new Notification('Welcome', {
                        icon: 'http://maizonpub.com/images/logo-shrink.png',
      body: "Welcome to Z CMS",
    });

                /*notification.onclick = function() {
                    window.open("");
                };*/

            }

            }
            notifyMe();
</script>

    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a id="A1" href="~/" runat="server" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                System
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        
                       
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="logout.aspx?logout=1" class="dropdown-toggle">
                                <span>Logout</span>
                            </a>
                            
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="<%=((Web.cms_user)Session["CMSUser"]).img!="" && ((Web.cms_user)Session["CMSUser"]).img!=null?"../Media/" + ((Web.cms_user)Session["CMSUser"]).img:"img/avatar5.png" %>" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, <%=((Web.cms_user)Session["CMSUser"]).username %></p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
                    <%--<form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
                        </div>
                    </form>--%>
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        
                        <% if (Web.Permissions.Check(op.id, "Content", "view") || Web.Permissions.Check(op.id, "Books", "view") || Web.Permissions.Check(op.id, "Home Banners", "view") || Web.Permissions.Check(op.id, "Partners", "view") || Web.Permissions.Check(op.id, "Press Room", "view") || Web.Permissions.Check(op.id, "Assessment", "view"))
                            { %>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-wrench"></i>
                                <span>Web Content</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <%if (Web.Permissions.Check(op.id, "Content", "view"))
                                  { %><li><a href="#!content.aspx" onclick="getContent('content.aspx')"><i class="fa fa-angle-double-right"></i> Content</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Books", "view"))
                                  { %><li><a href="#!bookscategories.aspx" onclick="getContent('bookscategories.aspx')"><i class="fa fa-angle-double-right"></i> Books Categories</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Books", "view"))
                                  { %><li><a href="#!bookslevels.aspx" onclick="getContent('bookslevels.aspx')"><i class="fa fa-angle-double-right"></i> Books Levels</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Books", "view"))
                                  { %><li><a href="#!books.aspx" onclick="getSearchedContent('', 'books.aspx','1')"><i class="fa fa-angle-double-right"></i> Books</a></li><%} %>
                               <%if (Web.Permissions.Check(op.id, "Assessment", "view"))
                                  { %><li><a href="#!assessmentcategories.aspx" onclick="getContent('assessmentcategories.aspx')"><i class="fa fa-angle-double-right"></i> Assessments</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Assessment", "view"))
                                  { %><li><a href="#!assessmentquestions.aspx" onclick="getContent('assessmentquestions.aspx')"><i class="fa fa-angle-double-right"></i> Assessment Questions</a></li><%} %>
                                 <%if (Web.Permissions.Check(op.id, "Home Banners", "view"))
                                  { %><li><a href="#!homebanners.aspx" onclick="getContent('homebanners.aspx')"><i class="fa fa-angle-double-right"></i> Home Banners</a></li><%} %>
                               <%if (Web.Permissions.Check(op.id, "Press Room", "view"))
                                  { %><li><a href="#!pressroom.aspx" onclick="getContent('pressroom.aspx')"><i class="fa fa-angle-double-right"></i> News</a></li><%} %>
                                
                            </ul>
                        </li>
                        <%} %>
                        <% if (Web.Permissions.Check(op.id, "CMS Users", "view") || Web.Permissions.Check(op.id, "CMS Groups", "view") || Web.Permissions.Check(op.id, "IP Security", "view") || Web.Permissions.Check(op.id, "Schools", "view") || Web.Permissions.Check(op.id, "Orders", "view"))
                            { %>
                        <li class="treeview">
                            <a href="#">
                                <i class="fa fa-wrench"></i>
                                <span>Settings</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <%if (Web.Permissions.Check(op.id, "IP Security", "view"))
       { %><li><a href="#!ips.aspx" onclick="getContent('ips.aspx')"><i class="fa fa-angle-double-right"></i> Manage Banned IPs</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Schools", "view"))
                                  { %><li><a href="#!schools.aspx" onclick="getContent('schools.aspx')"><i class="fa fa-angle-double-right"></i> Schools</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "CMS Users", "view"))
       { %><li><a href="#!cmsusers.aspx" onclick="getContent('cmsusers.aspx')"><i class="fa fa-angle-double-right"></i> CMS Users</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "CMS Groups", "view"))
       { %><li><a href="#!cmsgroups.aspx" onclick="getContent('cmsgroups.aspx')"><i class="fa fa-angle-double-right"></i> CMS Groups</a></li><%} %>
                                <%if (Web.Permissions.Check(op.id, "Logged in Sessions", "view"))
       { %><li><a href="#!loggedsessions.aspx" onclick="getContent('loggedsessions.aspx')"><i class="fa fa-angle-double-right"></i> Logged in Sessions</a></li><%} %>
                               
                            </ul>
                        </li>
                        <%} %>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

        <!-- add new calendar event modal -->


        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <!-- jQuery UI 1.10.3 -->
        <script src="js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        
        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Morris.js charts -->
        <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        <%--<script src="js/plugins/morris/morris.min.js" type="text/javascript"></script>--%>
        <!-- Sparkline -->
        <script src="js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- datepicker -->
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        
        <!-- iCheck -->
        <script src="js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="js/AdminLTE/app.js" type="text/javascript"></script>

        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <%--<script src="js/AdminLTE/dashboard.js" type="text/javascript"></script>--%>

        <!-- AdminLTE for demo purposes -->
        <script src="js/AdminLTE/demo.js" type="text/javascript"></script>
        <!-- CK Editor -->
        <script src="js/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        
        <script>
            function getContent(section) {
                $.ajax({
                    cache: false,
                    type: "GET",
                    url: "getContent.ashx",
                    contentType: "text/html;charset=utf-8",
                    dataType: 'html',
                    data: { section: section, opId:<%= op.id%> },
                    success: function (response) {
                        $(".right-side").html(response);
                    }
                });
            }
            function getSubPage(page, pageId)
            {
                $.ajax({
                    cache: false,
                    type: "GET",
                    url: "getContent.ashx",
                    contentType: "text/html;charset=utf-8",
                    dataType: 'html',
                    data: { section: page, opId:<%= op.id%>, args: "pageId="+pageId },
                    success: function (response) {
                        $(".right-side").html(response);
                    }
                });
            }
            function getSearchedContent(s, page, pageNum)
            {
                $.ajax({
                    cache: false,
                    type: "GET",
                    url: "getContent.ashx",
                    contentType: "text/html;charset=utf-8",
                    dataType: 'html',
                    data: { section: page, opId:<%= op.id%>, args: "page="+pageNum+"&key="+s },
                    success: function (response) {
                        $(".right-side").html(response);
                    }
                });
            }
            
            function getHashPage() {
                var page = window.location.hash.replace("#!", "");
                if(page!="")
                    getContent(page);
                else
                    getContent("content.aspx");
            }
            getHashPage();
        </script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>  
        <script src="js/plugins/bootstrap-editable/bootstrap-editable.js"></script>
        <script src="js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="js/plugins/datatables/jquery.dataTables.rowReordering.js" type="text/javascript"></script>
        <script src="js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script> 
        <script src="js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
        <script src="js/plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
        <script src="js/plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
        <script src="js/plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>
         <script language="JavaScript" type="text/javascript">
             //window.onbeforeunload = confirmExit;
             function confirmExit() {
                 window.open("logout.aspx");
                 return "You are about to exit the system ! Are you sure you want to leave now?";
             }
             
</script>
        
    </body>
</html>
