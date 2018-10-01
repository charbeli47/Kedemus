<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="students.aspx.cs" Inherits="Web.system.resources.students" %>
<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Settings
                        <small><%=school.title %> / Students</small>
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
                                     <%if(Web.Permissions.Check(int.Parse(Request["opId"]), "Students", "add"))
                                       {%>
                                     
                                    <h3 class="box-title"><div style="width:100px;float:left;margin-bottom:-25px"><a class="btn btn-block btn-primary" data-toggle="modal" data-target="#excel-modal" style="color:white;"><i class="fa fa-plus" style="color:white;"></i> Add new</a></div><div style="float:left;margin-left:10px"><a class="btn btn-block btn-primary" href="resources/downloadStudentsExcel.ashx?sId=<%=Request["pageId"] %>&p=true" target="_blank" style="color:white;width:200px"><i class="fa fa-plus" style="color:white;"></i> Download Students</a></div></h3><%} %>
                                </div><!-- /.box-header -->
                                <div class="box-body table-responsive">
                                    <div class="row"><div class="col-xs-6"></div><div class="col-xs-6"><div class="dataTables_filter" id="example1_filter"><label>Search: <input type="text" aria-controls="example1" id="searchTable" value="<%=searchKey %>"></label>
                                        <button onclick="searchTable(document.getElementById('searchTable').value)">Search</button></div></div></div>
                                    <table id="example1" data-order='[[ 0, "desc" ]]' class="table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Address</th>
                                                <th>Access Code</th>
                                                <th>Level</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr>
                                                <td><%=results[i].id %></td>
                                                <td><%=results[i].FirstName %></td>
                                                <td><%=results[i].LastName %></td>
                                                <td><%=results[i].Email %></td>
                                                <td><%=results[i].Phone %></td>
                                                <td><%=results[i].Address %></td>
                                                <td><%=results[i].AccessCode %></td>
                                                <td><a href="#" id="levelId<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Students" data-title="Level"><%=HttpUtility.HtmlEncode(results[i].BooksLevel!=null?results[i].BooksLevel.title:"") %></a></td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Address</th>
                                                <th>Access Code</th>
                                                <th>Level</th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                    <%var ppSize = page * pageSize; if (ppSize > resultCount) ppSize = resultCount; %>
                                    <div class="row"><div class="col-xs-6"><div class="dataTables_info" id="example1_info">Showing <%=((page - 1) * pageSize) + 1 %> to <%= ppSize%> of <%= resultCount %> entries</div></div><div class="col-xs-6"><div class="dataTables_paginate paging_bootstrap"><ul class="pagination"><li class="prev"><a href="#!students.aspx" onclick="getSearchedSubPage('<%=searchKey %>','students.aspx','<%=page - 1 %>','<%=pageId %>')">← Previous</a></li><li class="next"><a href="#!students.aspx" onclick="getSearchedSubPage('<%=searchKey %>','students.aspx','<%=page + 1 %>','<%=pageId %>')">Next → </a></li></ul></div></div></div>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div>
                    </div>

                </section><!-- /.content -->
<!-- DATA TABES SCRIPT -->
        

        <script type="text/javascript">
            $(function () {
                $("#example1").dataTable({ bPaginate: false, bInfo: false, bFilter: false });
            });
            function searchTable(s)
            {
                getSearchedSubPage(s,'students.aspx','<%=page %>', '<%=pageId%>');
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
            <% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Students", "edit"))
               {%>
            <%for(int i=0;i<results.Count;i++){%>
            $('#levelId<%=i%>').editable({
                type: 'select',
                title: 'Select Level',
                placement: 'right',
                value: '<%=results[i].levelId%>',
                source: [
                    <%=levelsList%>
                ]
                /*
                //uncomment these lines to send data on server
                ,pk: 1
                ,url: '/post'
                */
            });
            
            <%} }%>
        });
    </script>

<div class="modal fade" id="excel-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Bulk import using Excel</h4>
                    </div>
                    <form action="resources/addStudents.ashx" id="excelForm" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="pageId" value="<%=Request["pageId"]%>" />
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Level:</span>
                                    <select name="levelsSelect" id="levelsSelect" class="form-control" runat="server"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">File(look at the example below for columns header):</span>
                                    <input name="studentsfile" type="file" class="form-control">
                                </div>
                                <img src="../../img/studentsFile.png" style="width:500px"/>
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
            
            $('#excelForm').on('submit', (function (e) {
                if ($("#levelsSelect").val() != "-1") {
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
                            getSearchedSubPage('<%=searchKey%>','students.aspx','<%=page %>', '<%=pageId%>');
                            document.getElementById("submitBtn").disabled = false;
                            $("#loader").hide();
                            $(".modal-backdrop").hide();
                        },
                        error: function (data) {
                            console.log("error");
                            console.log(data);
                        }
                    });
                }
                else {
                    alert("Please select a Level");
                }
            }));

        </script>

