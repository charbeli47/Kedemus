<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="books.aspx.cs" Inherits="Web.system.resources.books" %>

<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Web Content
                        <small>Books</small>
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
                                     <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "Books", "add"))
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
                                                <th>English Text</th>
                                                <th>Arabic Text</th>
                                                <th>Thumb</th>
                                                <th>Page Background</th>
                                                <th>Vimeo Id</th>
                                                <th>Vimeo Id (Sign Language)</th>
                                                <th>PDF File</th>
                                                <th>Is Available</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr id="<%=results[i].id %>">
                                                <td class="index"><%=results[i].id %></td>
                                                <td><a href="#" id="entitle<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="English Title"><%=HttpUtility.HtmlEncode(results[i].title) %></a></td>
                                                <td><a href="#" id="artitle<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Arabic Title"><%=HttpUtility.HtmlEncode(results[i].artitle) %></a></td>
                                                <td><a href="#" id="entext<%=i %>" data-type="textarea" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="English Text"><%=HttpUtility.HtmlEncode(results[i].text) %></a></td>
                                                <td><a href="#" id="artext<%=i %>" data-type="textarea" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Arabic Text"><%=HttpUtility.HtmlEncode(results[i].artext) %></a></td>
                                                <td><input type="file" name="thumbnailupload" data-id="<%=results[i].id %>"/><img src="../Media/<%=results[i].thumb %>" style="height:100px" /><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editLoader<%=results[i].id %>" /></td>
                                                <td><input type="file" name="backgroundupload" data-id="<%=results[i].id %>"/><img src="../Media/<%=results[i].background %>" style="height:100px" /><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editBackLoader<%=results[i].id %>" /></td>
                                                <td><a href="#" id="youtubeId<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Youtube Id"><%=HttpUtility.HtmlEncode(results[i].video) %></a></td>
                                                <td><a href="#" id="SignLanguage<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Youtube Id"><%=HttpUtility.HtmlEncode(results[i].SignLanguageVideo) %></a></td>
                                                <td><input type="file" name="pdfupload" data-id="<%=results[i].id %>"/><a href="../Media/<%=results[i].pdf %>" style="height:100px" target="_blank">View File</a><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editPdfLoader<%=results[i].id %>" /></td>
                                                <td><a href="#" id="isAvailable<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books"><%=results[i].isAvailable %></a></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Books", "delete"))
               {%>
                                                    <a href="#" class="fa fa-times" onclick="DeleteRow(<%=results[i].id %>)"></a><br />
                                                    <%} %>
                                                    <a style="cursor:pointer" data-toggle="modal" data-target="#levels-modal<%=results[i].id %>">Levels</a>
                                                    <br /><a style="cursor:pointer" data-toggle="modal" data-target="#categories-modal<%=results[i].id %>">Categories</a>
                                                    <br /><a onclick="getSubPage('slides.aspx','<%=results[i].id %>')" href="#!slides.aspx">Slides</a>
                                                    <br /><a onclick="getSubPage('bookunites.aspx','<%=results[i].id %>')" href="#!bookunites.aspx">Book Unites</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>English Title</th>
                                                <th>Arabic Title</th>
                                                <th>English Text</th>
                                                <th>Arabic Text</th>
                                                <th>Thumb</th>
                                                <th>Page Background</th>
                                                <th>Vimeo Id</th>
                                                <th>Vimeo Id (Sign Language)</th>
                                                <th>PDF File</th>
                                                <th>Is Available</th>
                                                <th></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                    <div class="row"><div class="col-xs-6"><div class="dataTables_info" id="example1_info">Showing <%=((page - 1) * pageSize) + 1 %> to <%= (page * pageSize)%> of <%= resultCount %> entries</div></div><div class="col-xs-6"><div class="dataTables_paginate paging_bootstrap"><ul class="pagination"><li class="prev"><a href="#!books.aspx" onclick='searchContent("<%=page - 1 %>")'>← Previous</a></li><li class="next"><a href="#!books.aspx" onclick='searchContent("<%=page + 1 %>")'>Next → </a></li></ul></div></div></div>
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
                getSearchedContent(s,"books.aspx","<%=page %>");
            }
            function searchContent(page)
            {
                getSearchedContent("<%=searchKey %>","books.aspx",page)
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
            <% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Books", "edit"))
               {%>
            <%for(int i=0;i<results.Count;i++){%>
            $('#entitle<%=i%>').editable();
            $('#artitle<%=i%>').editable();
            $('#entext<%=i%>').editable();
            $('#artext<%=i%>').editable();
            $('#youtubeId<%=i%>').editable();
            $('#SignLanguage<%=i%>').editable();
            $('#isAvailable<%=i%>').editable({
                type: 'select',
                title: 'choose if available',
                placement: 'right',
                value: '<%=results[i].isAvailable == true?"YES":"NO"%>',
                source: [
                    { value: 'YES', text: 'YES' },
                    { value: 'NO', text: 'NO' }
                ]
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
                        url: "resources/uploadBooksImage.ashx",
                        data: { img: imRes, id: imId, field: "thumb" }
                    })
.done(function (msg) {
    getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
    $("#editLoader" + imId).hide();
});
                }
            }
        });
        $("input[name='backgroundupload']").on("change", function () {
            var files = !!this.files ? this.files : [];
            if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
            var imId = this.attributes["data-id"].value;
            $("#editBackLoader" + imId).show();
            if (/^image/.test(files[0].type)) { // only image file
                var reader = new FileReader(); // instance of the FileReader
                reader.readAsDataURL(files[0]); // read the local file

                reader.onloadend = function () { // set image data as background of div

                    var imRes = this.result;
                    $.ajax({
                        type: "POST",
                        url: "resources/uploadBooksImage.ashx",
                        data: { img: imRes, id: imId, field: "background" }
                    })
.done(function (msg) {
    getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
    $("#editBackLoader" + imId).hide();
});
                }
            }
        });
        $("input[name='videoupload']").on("change", function () {
            var files = !!this.files ? this.files : [];
            if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
            var imId = this.attributes["data-id"].value;
            $("#editVideoLoader" + imId).show(); // only image file
                var reader = new FileReader(); // instance of the FileReader
                reader.readAsDataURL(files[0]); // read the local file

                reader.onloadend = function () { // set image data as background of div

                    var imRes = this.result;
                    $.ajax({
                        type: "POST",
                        url: "resources/uploadBooksImage.ashx",
                        data: { img: imRes, id: imId, field: "video" }
                    })
.done(function (msg) {
    getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
    $("#editVideoLoader" + imId).hide();
});
                }
            
        });
        $("input[name='pdfupload']").on("change", function () {
            var files = !!this.files ? this.files : [];
            if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
            var imId = this.attributes["data-id"].value;
            $("#editPdfLoader" + imId).show(); // only image file
                var reader = new FileReader(); // instance of the FileReader
                reader.readAsDataURL(files[0]); // read the local file

                reader.onloadend = function () { // set image data as background of div

                    var imRes = this.result;
                    $.ajax({
                        type: "POST",
                        url: "resources/uploadBooksImage.ashx",
                        data: { img: imRes, id: imId, field: "pdf" }
                    })
.done(function (msg) {
    getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
    $("#editPdfLoader" + imId).hide();
});
                }
            
        });
        
    </script>

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Add Book</h4>
                    </div>
                    <form action="resources/addBooks.ashx" id="submitForm" method="post" enctype="multipart/form-data">
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
                                    <span class="input-group-addon">English Text:</span>
                                    <textarea name="text" class="form-control" placeholder="Text"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Arabic Text:</span>
                                    <textarea name="artext" class="form-control" placeholder="Text"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Thumb:</span>
                                    <input name="thumb" type="file" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Background:</span>
                                    <input name="background" type="file" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Youtube Id:</span>
                                    <input name="youtubeId" type="text" class="form-control" placeholder="Youtube Id">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Youtube Id (Sign Language):</span>
                                    <input name="SignLanguageVideo" type="text" class="form-control" placeholder="Youtube Id (Sign Language)">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Pdf:</span>
                                    <input name="pdf" type="file" class="form-control" placeholder="Pdf">

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Is Available:</span>
                                    <input type="checkbox" name="isAvailable"/>
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
<div class="modal fade" id="categories-modal<%=row.id %>" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> <%=row.title %> / categories list</h4>
                    </div>
                    <div class="modal-body">
                      
                                     <%foreach (var category in categories)
                                                                    {
                                                                        string cheked = "";
                                                                        if (category.ItemsCategories.Where(x => x.BookId == row.id).Count() > 0)
                                                                        {
                                                                            cheked = "checked=\"checked\"";
                                                                        }
                                           %>
                                    <label class="checkbox-inline"><input type="checkbox" name="category_<%=row.id %>_<%=category.id %>" id="category_<%=row.id %>_<%=category.id %>" <%=cheked %> />
                                        <%=category.title %>
                                    </label>
                                    <%} %>
                            </div>
                    <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="SaveBooksCategories<%=row.id %>()"><i class="fa fa-plus"></i> Save</button>
                        </div>
                            </div>
                        
                </div><!-- /.modal-content -->
    </div>
<div class="modal fade" id="levels-modal<%=row.id %>" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> <%=row.title %> / levels list</h4>
                    </div>
                    <div class="modal-body">
                      
                                     <%foreach (var level in levels)
             {
                 string cheked = "";
                 if (level.ItemsLevels.Where(x => x.bookId == row.id).Count() > 0)
                 {
                     cheked = "checked=\"checked\"";
                 }
                                           %>
                                    <label class="checkbox-inline"><input type="checkbox" name="level_<%=row.id %>_<%=level.id %>" id="level_<%=row.id %>_<%=level.id %>" <%=cheked %> />
                                        <%=level.title %>
                                    </label>
                                    <%} %>
                            </div>
                    <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="SaveBooksLevels<%=row.id %>()"><i class="fa fa-plus"></i> Save</button>
                        </div>
                            </div>
                        
                </div><!-- /.modal-content -->
    </div>

<script>
    function SaveBooksCategories<%=row.id %>() {
                <%
                                                                    string list = "";
                                                                    foreach (var category in categories)
                                                                    {
                                                                        list += ",category" + category.id + ":document.getElementById('category_" + row.id + "_" + category.id + "').checked";
                                                                    }
                                                                    if (list != "")
                                                                        list = list.Substring(1);
                  %>
        $.post("resources/SaveCategoriesBooks.ashx", {bookId: <%=row.id %>, <%=list%>}, function (data) { getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");$(".modal-backdrop").hide(); })
    }
    function SaveBooksLevels<%=row.id %>() {
                <%
            string dlist = "";
            foreach (var level in levels)
                  {
                      dlist += ",level" + level.id + ":document.getElementById('level_" + row.id + "_" + level.id + "').checked";
                  }
            if (dlist != "")
                dlist = dlist.Substring(1);
                  %>
        $.post("resources/SaveLevelsBooks.ashx", {bookId: <%=row.id %>, <%=dlist%>}, function (data) { if(data == "success"){getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");$(".modal-backdrop").hide();}else{alert(data);$(".modal-backdrop").hide();} })
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
                $.post("resources/DeleteRow.ashx", { table: "Books", tableId: id },
                    function (data) {
                        getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
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
                        getSearchedContent("<%=searchKey %>","books.aspx","<%=page %>");
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


