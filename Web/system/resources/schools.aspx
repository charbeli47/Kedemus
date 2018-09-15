<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="schools.aspx.cs" Inherits="Web.system.resources.schools" %>

<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Web Content
                        <small>Schools</small>
                    </h1>
                    <%--<ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li><a href="#">Tables</a></li>
                        <li class="active">Data tables</li>
                    </ol>--%>
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="row" >
                        <div class="col-xs-12">
                            <div class="box" style="width:95%;margin-left:auto;margin-right:auto;padding:10px">
                                <div class="box-header">
                                     <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "Schools", "add"))
                                       {%>
                                     <h3 class="box-title"><div style="width:100px;float:right;margin-bottom:-25px"><a class="btn btn-block btn-primary" data-toggle="modal" data-target="#compose-modal" style="color:white;"><i class="fa fa-plus" style="color:white;"></i> Add new</a></div><div style="clear:right"></div><br/></h3><%} %>
                                </div><!-- /.box-header -->
                                <div class="box-body table-responsive">
                                    <div class="row"><div class="col-xs-6"></div><div class="col-xs-6"><div class="dataTables_filter" id="example1_filter"><label>Search: <input type="text" aria-controls="example1" id="searchTable" value="<%=searchKey %>"></label><button onclick="searchTable(document.getElementById('searchTable').value)">Search</button></div></div></div>
                                    <table id="example1" class="sort table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>English Title</th>
                                                <th>Arabic Title</th>
                                                <th>Show Games</th>
                                                <th>Thumb</th>                                                
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr id="<%=results[i].id %>">
                                                <td class="index"><%=results[i].id %></td>
                                                <td><a href="#" id="entitle<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Schools" data-title="English Title"><%=HttpUtility.HtmlEncode(results[i].title) %></a></td>
                                                <td><a href="#" id="artitle<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Schools" data-title="Arabic Title"><%=HttpUtility.HtmlEncode(results[i].artitle) %></a></td>
                                                <td><a href="#" id="showGame<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Schools" data-title="English Title"><%=results[i].showGame==true?"YES":"NO" %></a></td>
                                                <td><input type="file" name="thumbnailupload" data-id="<%=results[i].id %>"/><img src="../Media/<%=results[i].thumb %>" style="height:100px" /><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editLoader<%=results[i].id %>" /></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Schools", "delete"))
               {%>
                                                    <a href="#" class="fa fa-times" onclick="DeleteRow(<%=results[i].id %>)"></a>
                                                    <%} %>
                                                    <br /><a onclick="getSubPage('students.aspx','<%=results[i].id %>')" href="#!students.aspx">Students</a>
                                                    <br /><a style="cursor:pointer" data-toggle="modal" data-target="#books-modal<%=results[i].id %>">Enabled Books</a>
                                                    <br /><a style="cursor:pointer" data-toggle="modal" data-target="#games-modal<%=results[i].id %>">Enabled Games</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>English Title</th>
                                                <th>Arabic Title</th>
                                                <th>Show Games</th>
                                                <th>Thumb</th>                                                
                                                <th></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                    <div class="row"><div class="col-xs-6"><div class="dataTables_info" id="example1_info">Showing <%=((page - 1) * pageSize) + 1 %> to <%= (page * pageSize)%> of <%= resultCount %> entries</div></div><div class="col-xs-6"><div class="dataTables_paginate paging_bootstrap"><ul class="pagination"><li class="prev"><a href="#!Schools.aspx" onclick='searchContent("<%=page - 1 %>")'>← Previous</a></li><li class="next"><a href="#!Schools.aspx" onclick='searchContent("<%=page + 1 %>")'>Next → </a></li></ul></div></div></div>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div>
                    </div>

                </section><!-- /.content -->
<!-- DATA TABES SCRIPT -->
        

        <script type="text/javascript">
            $(function () {
                $("#example1").dataTable({bPaginate:false,  bInfo : false, bFilter: false});
            });
            function searchTable(s)
            {
                getSearchedContent(s,"schools.aspx","<%=page %>");
            }
            function searchContent(page)
            {
                getSearchedContent("<%=searchKey %>","schools.aspx",page)
            }
            </script>
<%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet">--%>

    <!-- x-editable (bootstrap version) -->
    <link href="css/bootstrap-editable/bootstrap-editable.css" rel="stylesheet"/>
    <script>
        $(document).ready(function () {
            //toggle `popup` / `inline` mode
            if ($.fn != null)
                $.fn.editable.defaults.mode = 'popup';

            //make username editable
            <% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Schools", "edit"))
               {%>
            <%for(int i=0;i<results.Count;i++){%>
            $('#entitle<%=i%>').editable();
            $('#artitle<%=i%>').editable();
            $('#showGame<%=i%>').editable({
                type: 'select',
                title: 'Show Games',
                placement: 'right',
                value: '<%=results[i].showGame == true?"YES":"NO"%>%>',
                source: [
                    { value: 'NO', text: 'NO' },
                    { value: 'YES', text: 'YES' }
                ]
                /*
                //uncomment these lines to send data on server
                ,pk: 1
                ,url: '/post'
                */
            });
            <%} }%>
        });
        $("input[name='thumbnailupload']").on("change", function () {
            var files = !!this.files ? this.files : [];
            if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
            var imId = this.attributes["data-id"].value;
            $("#editLoader" + imId).show();
            if (/^image/.test(files[0].type)) { // only image file
                var reader = new FileReader(); // instance of the FileReader
                reader.readAsDataURL(files[0]); // read the local file

                reader.onloadend = function () { // set image data as background of div

                    var imRes = this.result;
                    $.ajax({
                        type: "POST",
                        url: "resources/uploadSchoolsImage.ashx",
                        data: { img: imRes, id: imId, field: "thumb" }
                    })
.done(function (msg) {
    getSearchedContent("<%=searchKey %>","schools.aspx","<%=page %>");
    $("#editLoader" + imId).hide();
});
                }
            }
        });
        
    </script>

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Add School</h4>
                    </div>
                    <form action="resources/addSchools.ashx" id="submitForm" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">English Title:</span>
                                    <input name="title" type="text" class="form-control" placeholder="Title">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Arabic Title:</span>
                                    <input name="artitle" type="text" class="form-control" placeholder="Title">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Thumb:</span>
                                    <input name="thumb" type="file" class="form-control" placeholder="Small Image">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Show Games:</span>
                                    <input type="checkbox" name="showGame"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>
                            <input type="submit" class="btn btn-primary pull-left" value="Save" id="submitBtn"/><img src="img/ajax-loader.gif" style="height:30px;display:none" class="pull-left" id="loader" />
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>
<%foreach (var row in results)
             { %>
<div class="modal fade" id="books-modal<%=row.id %>" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" >
                <div class="modal-content">
                    
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> <%=row.title %> / Books list</h4>
                    </div>
                    <div class="modal-body">
                      
                                     <%foreach (var level in levels)
    {%>
                        <h3><%=level.title %></h3>
       <% foreach (var item in level.ItemsLevels)
        {
            string cheked = "";
            if (item.Book.SchoolBooks.Where(x => x.schoolId == row.id).Count() > 0)
            {
                cheked = "checked=\"checked\"";
            }
                                           %>
                                    <label class="checkbox-inline"><input type="checkbox" name="book_<%=row.id %>_<%=item.Book.id %>" id="book_<%=row.id %>_<%=item.Book.id %>" <%=cheked %> />
                                        <%=item.Book.title %>
                                    </label>
                                    <%}
    } %>
                            </div>
                    <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="SaveSchoolBooks<%=row.id %>()"><i class="fa fa-plus"></i> Save</button>
                        </div>
                            </div>
                        
                </div><!-- /.modal-content -->
    </div>
<script>
    function SaveSchoolBooks<%=row.id %>() {
                <%
                                                                    string list = "";
                                                                    foreach (var level in levels)
                                                                    {
                                                                        foreach(var item in level.ItemsLevels)
                                                                            list += ",book" + item.bookId + ":document.getElementById('book_" + row.id + "_" + item.bookId + "').checked";
                                                                    }
                                                                    if (list != "")
                                                                        list = list.Substring(1);
                  %>
        $.post("resources/SaveSchoolBooks.ashx", {schoolId: <%=row.id %>, <%=list%>}, function (data) { getSearchedContent("<%=searchKey %>","schools.aspx","<%=page %>");$(".modal-backdrop").hide(); })
    }
    </script>
<div class="modal fade" id="games-modal<%=row.id %>" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" >
                <div class="modal-content">
                    
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> <%=row.title %> / Games list</h4>
                    </div>
                    <div class="modal-body">
                      
                                     <%foreach (var level in levels)
    {%>
                        <h3><%=level.title %></h3>
       <% foreach (var item in level.BookGames)
        {
            string cheked = "";
            if (item.SchoolGames.Where(x => x.schoolId == row.id).Count() > 0)
            {
                cheked = "checked=\"checked\"";
            }
                                           %>
                                    <label class="checkbox-inline"><input type="checkbox" name="game_<%=row.id %>_<%=item.id %>" id="game_<%=row.id %>_<%=item.id %>" <%=cheked %> />
                                        <%=item.Folder %>
                                    </label>
                                    <%}
    } %>
                            </div>
                    <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="SaveSchoolGames<%=row.id %>()"><i class="fa fa-plus"></i> Save</button>
                        </div>
                            </div>
                        
                </div><!-- /.modal-content -->
    </div>
<script>
    function SaveSchoolGames<%=row.id %>() {
                <%
                                                                    list = "";
                                                                    foreach (var level in levels)
                                                                    {
                                                                        foreach(var item in level.BookGames)
                                                                            list += ",game" + item.id + ":document.getElementById('game_" + row.id + "_" + item.id + "').checked";
                                                                    }
                                                                    if (list != "")
                                                                        list = list.Substring(1);
                  %>
        $.post("resources/SaveSchoolGames.ashx", {schoolId: <%=row.id %>, <%=list%>}, function (data) { getSearchedContent("<%=searchKey %>","schools.aspx","<%=page %>");$(".modal-backdrop").hide(); })
    }
    </script>
<%} %>
        <script type="text/javascript">
            $(function () {

                "use strict";

                //iCheck for checkbox and radio inputs
                $('input[type="checkbox"]').iCheck({
                    checkboxClass: 'icheckbox_minimal-blue',
                    radioClass: 'iradio_minimal-blue'
                });

                //When unchecking the checkbox
                $("#check-all").on('ifUnchecked', function (event) {
                    //Uncheck all checkboxes
                    $("input[type='checkbox']", ".table-mailbox").iCheck("uncheck");
                });
                //When checking the checkbox
                $("#check-all").on('ifChecked', function (event) {
                    //Check all checkboxes
                    $("input[type='checkbox']", ".table-mailbox").iCheck("check");
                });
                //Handle starring for glyphicon and font awesome
                $(".fa-star, .fa-star-o, .glyphicon-star, .glyphicon-star-empty").click(function (e) {
                    e.preventDefault();
                    //detect type
                    var glyph = $(this).hasClass("glyphicon");
                    var fa = $(this).hasClass("fa");

                    //Switch states
                    if (glyph) {
                        $(this).toggleClass("glyphicon-star");
                        $(this).toggleClass("glyphicon-star-empty");
                    }

                    if (fa) {
                        $(this).toggleClass("fa-star");
                        $(this).toggleClass("fa-star-o");
                    }
                });

                //Initialize WYSIHTML5 - text editor
                //$("#email_message").wysihtml5();
            });
            
            function DeleteRow(id) {
                $.post("resources/DeleteRow.ashx", { table: "Schools", tableId: id },
                    function (data) {
                        getSearchedContent("<%=searchKey %>","schools.aspx","<%=page %>");
                        $(".modal-backdrop").hide();
                    });
            }
            $('#submitForm').on('submit', (function (e) {
                $("#loader").show();
                document.getElementById("submitBtn").disabled = true;
                e.preventDefault();
                var formData = new FormData(this);
                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        getSearchedContent("<%=searchKey %>","schools.aspx","<%=page %>");
                        document.getElementById("submitBtn").disabled = false;
                        $("#loader").hide();
                        $(".modal-backdrop").hide();
                    },
                    error: function (data) {
                        console.log("error");
                        console.log(data);
                    }
                });

            }));

        </script>


