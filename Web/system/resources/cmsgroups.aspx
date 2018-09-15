<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cmsgroups.aspx.cs" Inherits="Web.resources.cmsgroups" %>
<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Settings
                        <small>CMS Groups</small>
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
                                     <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Groups", "add"))
                                       {%>
                                     <h3 class="box-title"><div style="width:100px;float:right;margin-bottom:-25px"><a class="btn btn-block btn-primary" data-toggle="modal" data-target="#compose-modal" style="color:white;"><i class="fa fa-plus" style="color:white;"></i> Add new</a></div><div style="clear:right"></div><br/></h3><%} %>
                                </div><!-- /.box-header -->
                                <div class="box-body table-responsive">
                                    <table id="example1" class="table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<groups.Count;i++){ %>
                                            <tr>
                                                <td><%=groups[i].id %></td>
                                                <td><a href="#" id="name<%=i %>" data-type="text" data-pk="<%=groups[i].id %>" data-url="resources/editRow.ashx?table=cms_groups" data-title="Enter name"><%=groups[i].name %></a></td>
                                                <td><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Groups", "delete"))
               {%><a href="#" class="fa fa-times" onclick="DeleteRow(<%=groups[i].id %>)"></a><%} %><% if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Groups", "edit"))
               {%>&nbsp;&nbsp;&nbsp;<%if(!groups[i].name.Contains("admin")){ %><a href="#" data-toggle="modal" data-target="#permissions-modal<%=i %>"><i class="fa fa-edit"></i> Edit Permissions</a><%} %><%} %></td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
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
            <% if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Groups", "edit"))
               {%>
            <%for(int i=0;i<groups.Count;i++){%>
            $('#name<%=i%>').editable();
           
            <%} }%>
        });
    </script>

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-envelope-o"></i> Add new User</h4>
                    </div>
                    <form action="#" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Name:</span>
                                    <input name="name" type="text" class="form-control" placeholder="Name">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="AddRow()"><i class="fa fa-plus"></i> Save</button>
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>
<%for(int i=0;i<groups.Count;i++){ %>
<div class="modal fade" id="permissions-modal<%=i %>" tabindex="<%=i %>" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-edit"></i> "<%=groups[i].name %>" Permissions</h4>
                    </div>
                    <form action="#" method="post">
                        <div class="modal-body">
                            <%  for(int j=0;j<permissions.Count;j++){
                                   var policies = permissions[j].cms_policies.Where(x=>x.groupId == groups[i].id).ToList();
                                   bool add = false;
                                   bool edit = false;
                                   bool delete = false;
                                   bool view = false;
                                   
                                   for (int k = 0; k < policies.Count; k++)
                                   {
                                       switch (policies[k].event_permitted)
                                       {
                                           case "add":
                                               add = true;
                                               break;
                                           case "edit":
                                               edit = true;
                                               break;
                                           case "delete":
                                               delete = true;
                                               break;
                                           case "view":
                                               view = true;
                                               break;
                                       }
                                   }
                                    %>
                            <div class="form-group" style="text-align:center">
                                    <div style="background-color: #eeeeee;color: #555555;border: 1px solid #cccccc;border-radius: 4px;width:90%;text-align:center;padding-top:5px;padding-bottom:5px;margin:auto"><%= permissions[j].name%></div>                                
                                <label>
                                    <input type="checkbox" id="add_<%=i %>_<%=j %>" name="add_<%=i %>_<%=j %>" <%=add == true ? "checked" : "" %> value="add|<%= permissions[j].id%>" class="flat-red"/> Add
                                </label>
                                <label>
                                    <input type="checkbox" id="edit_<%=i %>_<%=j %>" name="edit_<%=i %>_<%=j %>" <%=edit == true ? "checked" : "" %> class="flat-red" value="edit|<%= permissions[j].id%>"/> Edit
                                </label>
                                <label>
                                    <input type="checkbox" id="delete_<%=i %>_<%=j %>" name="delete_<%=i %>_<%=j %>"  <%=delete == true ? "checked" : "" %> class="flat-red" value="delete|<%= permissions[j].id%>"/> Delete
                                </label>
                                <label>
                                    <input type="checkbox" id="view_<%=i %>_<%=j %>" name="view_<%=i %>_<%=j %>"  <%=view == true ? "checked" : "" %> class="flat-red" value="view|<%= permissions[j].id%>"/> View
                                </label>
                            </div><%} %>
                        </div>
                        <div class="modal-footer clearfix">

                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="EditPermissions(<%=groups[i].id %>, <%=i %>)"><i class="fa fa-plus"></i> Save</button>
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div>
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
            function AddRow() {
                $.post("resources/AddRow.ashx", { table: "cms_groups", Rows: $("input[name='name']").val() },
                    function (data) {
                        getContent("cmsgroups.aspx");
                    });
            }
            function DeleteRow(id) {
                $.post("resources/DeleteRow.ashx", { table: "cms_groups", tableId: id },
                    function (data) {
                        getContent("cmsgroups.aspx");
                    });
            }
            function EditPermissions(id, c) {
                var col = "";
                <%
            string data = "";
            for (int i = 0; i < groups.Count; i++)
            {
                for (int j = 0; j < permissions.Count; j++)
                {

                    data += "if(c == " + i + " && document.getElementById('add_" + i + "_" + j + "').checked == true){col += document.getElementById('add_" + i + "_" + j + "').value + '!'}";
                    data += "if(c == " + i + " && document.getElementById('edit_" + i + "_" + j + "').checked == true){col +=document.getElementById('edit_" + i + "_" + j + "').value + '!'}";
                    data += "if(c == " + i + " && document.getElementById('delete_" + i + "_" + j + "').checked == true){col +=document.getElementById('delete_" + i + "_" + j + "').value + '!'}";
                    data += "if(c == " + i + " && document.getElementById('view_" + i + "_" + j + "').checked == true){col +=document.getElementById('view_" + i + "_" + j + "').value + '!'}";
                }
            }
                  %>
                <%=data%>
                $.post("resources/EditPermissions.ashx", { id: id, collec: col  },
                    function (data) {
                        //getContent("cmsgroups.aspx");
                    });
            }

        </script>

