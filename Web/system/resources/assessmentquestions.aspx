﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="assessmentquestions.aspx.cs" Inherits="Web.system.resources.assessmentquestions" %>

<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Web Content
                        <small>Assessment Questions</small>
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
                                     <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "Assessment", "add"))
                                       {%>
                                     <h3 class="box-title"><div style="width:100px;float:right;margin-bottom:-25px"><a class="btn btn-block btn-primary" data-toggle="modal" data-target="#compose-modal" style="color:white;"><i class="fa fa-plus" style="color:white;"></i> Add new</a></div><div style="clear:right"></div><br/></h3><%} %>
                                </div><!-- /.box-header -->
                                <div class="box-body table-responsive">
                                    <table id="example1" class="table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Category</th>
                                                <th>Title</th>
                                                <th>Type</th>
                                                <th>Audio</th>
                                                <th>Correct Answer</th>
                                                <th>Answers Layout</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<results.Count;i++){ %>
                                            <tr id="<%=results[i].id %>">
                                                <td><%=results[i].id %></td>
                                                <td><%=results[i].QuestionsCategory.title %></td>
                                                <td><%=results[i].type=="text"?results[i].title:"<img src='"+results[i].title+"' style='height:50px'/>" %></td>
                                                <td><%=results[i].type %></td>
                                                <td><audio src="<%=results[i].audio %>" controls></audio></td>
                                                <td><a href="#" id="correctAnswer<%=i %>" data-type="select" data-pk="<%=results[i].id %>" data-url="resources/editRow.ashx?table=Questions" data-title="Level"><%=results[i].correctAnswer %></a></td>
                                                <td><%=results[i].AnswersLayout %></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Assessment", "delete"))
               {%><a href="#" class="btn btn-primary" onclick="DeleteRow(<%=results[i].id %>)"><i class="fa fa-times"></i> Delete</a><br /><br /><%} %>
                                                    <a class="btn btn-primary" href="#!assessmentanswers.aspx" onclick="getSubPage('assessmentanswers.aspx','<%=results[i].id %>')">Answers</a>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                 <th>ID</th>
                                                <th>Category</th>
                                                <th>Title</th>
                                                <th>Type</th>
                                                <th>Audio</th>
                                                <th>Correct Answer</th>
                                                <th>Answers Layout</th>
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
            <% if (Web.Permissions.Check(int.Parse(Request["opId"]), "Assessment", "edit"))
               {
                
            %>
            <%for(int i=0;i<results.Count;i++){
            string correctAnswerList = "";
            foreach(var answer in results[i].QuestionsAnswers)
                correctAnswerList +=",{ value: '" + answer.text + "', text: '" + answer.text + "' }";
            if (correctAnswerList != "")
                correctAnswerList = correctAnswerList.Substring(1);
            %>
            $('#correctAnswer<%=i%>').editable({
                type: 'select',
                title: 'Level',
                placement: 'right',
                value: '<%=results[i].correctAnswer%>',
                source: [
                    <%=correctAnswerList%>
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

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Add new Question</h4>
                    </div>
                    <form action="resources/AddQuestion.ashx" id="submitForm" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Category:</span>
                                    <select name="categorySelect" id="categorySelect" class="form-control" runat="server"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Type:</span>
                                    <select name="typeSelect" id="typeSelect" class="form-control" onchange="ShowControl(this)">
                                        <option>text</option>
                                        <option>image</option>
                                        
                                    </select>
                                    <textarea name="typetext" id="typetext" type="text" class="form-control" placeholder="Enter text here"></textarea>
                                    <input name="typeimage" id="typeimage" type="file" class="form-control" style="display:none">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Audio:</span>
                                    <input name="audio" type="file" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Correct Answer:</span>
                                    <input name="correctAnswer" type="text" class="form-control" placeholder="Correct Answer">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Answers Layout:</span>
                                    <select name="AnswersLayout" id="AnswersLayout" class="form-control">
                                        <option>2type1</option>
                                        <option>2type2</option>
                                        <option>3type1</option>
                                        <option>3type2</option>
                                        <option>3type3</option>
                                        <option>4type1</option>
                                        <option>4type2</option>
                                        <option>4type3</option>
                                        <option>5type1</option>
                                        <option>5type2</option>
                                        <option>5type3</option>
                                        <option>6type1</option>
                                        <option>6type2</option>
                                        <option>7type1</option>
                                        <option>7type2</option>
                                        <option>8type1</option>
                                        <option>8type2</option>
                                    </select>
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
            function ShowControl(f)
            {
                if(f.value == "text")
                {
                    $("#typetext").show();
                    $("#typeimage").hide();
                }
                else
                {
                    $("#typetext").hide();
                    $("#typeimage").show();
                }
            }
            function DeleteRow(id) {
                $.post("resources/DeleteRow.ashx", { table: "Questions", tableId: id },
                    function (data) {
                        getContent("assessmentquestions.aspx");
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
                        getContent("assessmentquestions.aspx");
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
