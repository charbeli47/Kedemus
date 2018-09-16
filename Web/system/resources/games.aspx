<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="games.aspx.cs" Inherits="Web.resources.games" %>
<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Web Content
                        <small><%=book.title %> / Posters</small>
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
                                    <table id="example1" class="table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Folder</th>
                                                <th>Thumb</th>
                                                <th>Title</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr>
                                                <td><%=results[i].id %></td>
                                                <td><a href="../Media/Posters/<%=results[i].bookId %>/<%=results[i].InteractiveFile %>" target="_blank"><%=results[i].InteractiveFile %></a></td>
                                                <td><input type="file" name="thumbnailupload" data-id="<%=results[i].id %>"/><img src="../Media/<%=results[i].thumb %>" style="height:100px" /><img src="img/ajax-loader.gif" style="height:40px;display:none" id="editLoader<%=results[i].id %>" /></td>
                                                <td><a href="#" id="title<%=i %>" data-type="text" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Posters" data-title="Title"><%=HttpUtility.HtmlEncode(results[i].title) %></a></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Books", "delete"))
               {%><a href="#" class="btn btn-block btn-primary" style="color:white" onclick="DeleteRow(<%=results[i].id %>)"><i class="fa fa-plus" style="color:white;"></i> Delete</a><%} %>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                               <th>ID</th>
                                                <th>Folder</th>
                                                <th>Thumb</th>
                                                <th>Title</th>
                                                <th></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div>
                    </div>

                </section><!-- /.content -->
<!-- DATA TABES SCRIPT -->
        

        <script type="text/javascript">
            $(function () {
                $("#example1").dataTable({ bPaginate: false });
            });
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
            <%for (int i = 0; i < results.Count; i++) {%>
            $('#title<%=i%>').editable();
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
                        url: "resources/uploadGameImage.ashx",
                        data: { img: imRes, id: imId, field: "Img" }
                    })
.done(function (msg) {
                        getSubPage('games.aspx','<%=Request["pageId"] %>');
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
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Add new Record</h4>
                    </div>
                    <form action="resources/addGame.ashx" id="submitForm" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="pageId" value="<%=Request["pageId"] %>" />
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Folder (*.zip containing index.html as the startup page):</span>
                                    <input name="GameFile" type="file" class="form-control">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Thumb:</span>
                                    <input name="Thumb" type="file" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Title:</span>
                                    <input name="title" type="text" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <input type="submit" class="btn btn-primary pull-left" id="submitBtn" value="Save"/><img src="img/ajax-loader.gif" style="height:30px;display:none" class="pull-left" id="loader" />
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
                $.post("resources/DeleteRow.ashx", { table: "Posters", tableId: id },
                    function (data) {
                        getSubPage('games.aspx','<%=Request["pageId"] %>');
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
                        getSubPage('games.aspx', '<%=Request["pageId"] %>');
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

