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
                                                <th>Title</th>
                                                <th>Level</th>
                                                <th>Category</th>
                                                <th>Language</th>
                                                <th>Thumbnail</th>
                                                <th>PDF File</th>
                                                <th>Is Available</th>
                                                <th>Is Single Book</th>
                                                <th>Vimeo ID</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr id="<%=results[i].id %>">
                                                <td class="index"><%=results[i].id %></td>
                                                <td><a href="#" id="title<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Title"><%=HttpUtility.HtmlEncode(results[i].title) %></a></td>
                                                <td><a href="#" id="level<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Level"><%=HttpUtility.HtmlEncode(results[i].BooksLevel.title) %></a></td>
                                                <td><a href="#" id="category<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Category"><%=HttpUtility.HtmlEncode(results[i].Category.title) %></a></td>
                                                <td><a href="#" id="lang<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Language"><%=HttpUtility.HtmlEncode(results[i].lang) %></a></td>
                                                <td><input type="file" name="thumbnailupload" data-id="<%=results[i].id %>"/><img src="../Media/<%=results[i].thumb %>" style="height:100px" /><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editLoader<%=results[i].id %>" /></td>
                                                <td><input type="file" name="pdfupload" data-id="<%=results[i].id %>"/><a href="../Media/<%=results[i].pdf %>" style="height:100px" target="_blank">View File</a><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editPdfLoader<%=results[i].id %>" /></td>
                                                <td><a href="#" id="isAvailable<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books"><%=results[i].isAvailable %></a></td>
                                                <td><a href="#" id="isSingleBook<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books"><%=results[i].isSingleBook %></a></td>
                                                <td><a href="#" id="VimeoId<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Books" data-title="Vimeo ID"><%=HttpUtility.HtmlEncode(results[i].VimeoId) %></a></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Books", "delete"))
               {%>
                                                    <a href="#" class="fa fa-times" onclick="DeleteRow(<%=results[i].id %>)"></a><br />
                                                    <%} %>
                                                    <br /><a onclick="getSubPage('bookunites.aspx','<%=results[i].id %>')" href="#!bookunites.aspx">Book Unites</a>
                                                    <br /><a onclick="getSubPage('stories.aspx','<%=results[i].id %>')" href="#!stories.aspx">Book Stories</a>
                                                    <br /><a onclick="getSubPage('games.aspx','<%=results[i].id %>')" href="#!games.aspx">Book Posters</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Level</th>
                                                <th>Category</th>
                                                <th>Language</th>
                                                <th>Thumbnail</th>
                                                <th>PDF File</th>
                                                <th>Is Available</th>
                                                <th>Is Single Book</th>
                                                <th>Vimeo ID</th>
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
            $('#title<%=i%>').editable();
            $('#youtubeId<%=i%>').editable();
            $('#SignLanguage<%=i%>').editable();
            $('#VimeoId<%=i%>').editable();
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
            $('#isSingleBook<%=i%>').editable({
                type: 'select',
                title: 'choose if available',
                placement: 'right',
                value: '<%=results[i].isSingleBook == true?"YES":"NO"%>',
                source: [
                    { value: 'YES', text: 'YES' },
                    { value: 'NO', text: 'NO' }
                ]
            });
            $('#lang<%=i%>').editable({
                type: 'select',
                title: 'Language',
                placement: 'right',
                value: '<%=results[i].lang%>',
                source: [
                    { value: 'fr', text: 'Francais' },
                    { value: 'en', text: 'English' }
                ]
            });
            $('#level<%=i%>').editable({
                type: 'select',
                title: 'Level',
                placement: 'right',
                value: '<%=results[i].levelId%>',
                source: [
                    <%=levelsList%>
                ]
            });
            $('#category<%=i%>').editable({
                type: 'select',
                title: 'Category',
                placement: 'right',
                value: '<%=results[i].categoryId%>',
                source: [
                    <%=categoriesList%>
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
                                    <span class="input-group-addon">Title:</span>
                                    <input name="title" type="text" class="form-control" placeholder="Title">
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
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Language:</span>
                                    <select name="langselect" id="langselect" class="form-control">
                                        <option value="fr">Francais</option>
                                        <option value="en">English</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Level:</span>
                                    <select name="levelselect" id="levelselect" runat="server" class="form-control"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Category:</span>
                                    <select name="categoryselect" id="categoryselect" runat="server" class="form-control"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Is Single Book:</span>
                                    <input type="checkbox" name="isSingleBook"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Vimeo ID:</span>
                                    <input name="VimeoId" type="text" class="form-control" placeholder="Viemo ID">
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


