<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cmsusers.aspx.cs" Inherits="Web.resources.cmsusers" %>
<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Settings
                        <small>CMS Users</small>
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
                                      <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Users", "add"))
                                       {%>
                                     <h3 class="box-title"><div style="width:100px;float:right;margin-bottom:-25px"><a class="btn btn-block btn-primary" data-toggle="modal" data-target="#compose-modal" style="color:white;"><i class="fa fa-plus" style="color:white;"></i> Add new</a></div><div style="clear:right"></div><br/></h3><%} %>
                                </div><!-- /.box-header -->
                                <div class="box-body table-responsive">
                                    <table id="example1" class="table table-bordered table-striped" >
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Password</th>
                                                <th>Group</th>
                                                <th>Status</th>
                                                <th>Date Login</th>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Address Line</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%for(int i=0;i<users.Count;i++){ %>
                                            <tr>
                                                <td><%=users[i].id %></td>
                                                <td><a href="#" id="username<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter username"><%=users[i].username %></a></td>
                                                <td><a href="#" id="password<%=i %>" data-type="password" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter password">[hidden]</a></td>
                                                <td><a href="#" id="cmsgroup<%=i %>" data-type="select" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Select Group"><%=users[i].cms_groups.name %></a></td>
                                                <td><a href="#" id="status<%=i %>" data-type="select" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Select Status"><%=users[i].status==1?"active":"pending" %></a></td>
                                                <td><%=users[i].date_login %></td>
                                                <td><a href="#" id="firstname<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter first name"><%=users[i].firstname %></a></td>
                                                <td><a href="#" id="lastname<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter last name"><%=users[i].lastname %></a></td>
                                                <td><a href="#" id="phone<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter phone"><%=users[i].phone %></a></td>
                                                <td><a href="#" id="email<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter email"><%=users[i].email %></a></td>
                                                <td><a href="#" id="address<%=i %>" data-type="text" data-pk="<%=users[i].id %>" data-url="resources/editRow.ashx?table=cms_user" data-title="Enter address line"><%=users[i].address %></a></td>
                                                <td><%if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Users", "delete"))
                                       {%><a class="fa fa-times" onclick="DeleteRow(<%=users[i].id %>)"></a><%} %></td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Password</th>
                                                <th>Group</th>
                                                <th>Status</th>
                                                <th>Date Login</th>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Address Line</th>
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
                $("#example1").dataTable();
            });
            </script>
<%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet">--%>

    <!-- x-editable (bootstrap version) -->
    <link href="css/bootstrap-editable/bootstrap-editable.css" rel="stylesheet"/>
    <script>
        $(document).ready(function () {
            //toggle `popup` / `inline` mode
            if($.fn!=null)
                $.fn.editable.defaults.mode = 'popup';

            //make username editable
            <%if (Web.Permissions.Check(int.Parse(Request["opId"]), "CMS Users", "edit"))
              {%>
            <%for (int i = 0; i < users.Count; i++)
              {%>
            $('#username<%=i%>').editable();
            $('#password<%=i%>').editable();
            $('#firstname<%=i%>').editable();
            $('#lastname<%=i%>').editable();
            $('#phone<%=i%>').editable();
            $('#email<%=i%>').editable();
            $('#address<%=i%>').editable();
            //make status editable
            $('#cmsgroup<%=i%>').editable({
                type: 'select',
                title: 'Select Group',
                placement: 'right',
                value: 1,
                source: [
                    <%=groupsList%>
                ]
                /*
                //uncomment these lines to send data on server
                ,pk: 1
                ,url: '/post'
                */
            });
            $('#status<%=i%>').editable({
                type: 'select',
                title: 'Select Group',
                placement: 'right',
                value: 1,
                source: [
                    { value: 0, text: 'pending' },
                    { value: 1, text: 'active' }
                ]
                /*
                //uncomment these lines to send data on server
                ,pk: 1
                ,url: '/post'
                */
            });
            <%}
              }%>
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
                                    <span class="input-group-addon">Username:</span>
                                    <input name="username" type="text" class="form-control" placeholder="Username">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Password:</span>
                                    <input name="password"  type="password" class="form-control" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">First Name:</span>
                                    <input name="firstname" type="text" class="form-control" placeholder="First Name">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Last Name:</span>
                                    <input name="lastname" type="text" class="form-control" placeholder="Last Name">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Phone:</span>
                                    <input name="phone" type="text" class="form-control" placeholder="Phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Email:</span>
                                    <input name="email" type="text" class="form-control" placeholder="Email">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Address Line:</span>
                                    <input name="address" type="text" class="form-control" placeholder="Address Line">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">CMS Group:</span>
                                    <select name="selectgroup" id="selectgroup" runat="server"  class="form-control"></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Status:</span>
                                    <select name="selectstatus" id="selectstatus" runat="server"  class="form-control"><option value="0">Pending</option><option value="1">Valid</option></select>
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
                $.post("resources/AddRow.ashx", { table: "cms_user", Rows: $("input[name='username']").val() + "|" + $("input[name='password']").val() + "|" + $("select[name='selectgroup']").val() + "|" + $("select[name='selectstatus']").val() + "|" + $("input[name='firstname']").val() + "|" + $("input[name='lastname']").val() + "|" + $("input[name='phone']").val() + "|" + $("input[name='email']").val() + "|" + $("input[name='address']").val() },
                    function (data) {
                        getContent("cmsusers.aspx");
                    });
            }
            function DeleteRow(id) {
                $.post("resources/DeleteRow.ashx", {table:"cms_user", tableId: id},
                    function (data) {
                        getContent("cmsusers.aspx");
                    });
            }
            
        </script>