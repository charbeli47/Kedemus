<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="content.aspx.cs" Inherits="Web.system.resources.content" %>

<!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Web Content
                        <small>Content</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Content</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                    <form id="submitFrm" enctype="application/x-www-form-urlencoded" action="resources/SaveContentData.ashx">
                    <div class='row'>
                        <div class='col-md-12'>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>About Us</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <textarea name="AboutUs" id="AboutUs" runat="server" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Email</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    <input type="text" class="form-control" name="Email" id="Email" runat="server" placeholder="Email"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Address Line</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="AddressLine" id="AddressLine" runat="server" placeholder="English Address Line"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Phone</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="tel" class="form-control" name="Phone" id="Phone" runat="server" placeholder="Phone"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Fax</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="tel" class="form-control" name="Fax" id="Fax" runat="server" placeholder="Fax"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Longitude</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="Longitude" id="Longitude" runat="server" placeholder="Longitude"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Latitude</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="Latitude" id="Latitude" runat="server" placeholder="Latitude"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Smtp Server</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="SmtpServer" id="SmtpServer" runat="server" placeholder="Smtp Server"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Smtp Port</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="SmtpPort" id="SmtpPort" runat="server" placeholder="Smtp Port"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>IS SSL</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="checkbox" class="form-control" name="IsSSL" id="IsSSL" runat="server" placeholder="IS SSL"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>System Email</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="SystemEmail" id="SystemEmail" runat="server" placeholder="System Email"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>System Email Password</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="SystemEmailPassword" id="SystemEmailPassword" runat="server" placeholder="System Email Password"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Info Email</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="InfoEmail" id="InfoEmail" runat="server" placeholder="Info Email"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Smart Learning Video (Youtube Id)</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <input type="text" class="form-control" name="SmartLearningVideo" id="SmartLearningVideo" runat="server" placeholder="Smart Learning Video (Youtube Id)"/>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Meta Description</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <textarea name="Description" id="Description" runat="server" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    
                                </div>
                            </div>
                            <div class='box'>
                                <div class='box-header'>
                                    <h3 class='box-title'>Meta Keywords</h3>
                                    <!-- tools box -->
                                    <div class="pull-right box-tools">
                                    </div><!-- /. tools -->
                                </div><!-- /.box-header -->
                                <div class='box-body pad'>
                                    
                                        <textarea name="Keywords" id="Keywords" runat="server" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    
                                </div>
                            </div>
                            
                           
                            <input type="submit" class="btn btn-primary pull-left" value="Save"/>
                            <%--<button type="button" class="btn btn-primary pull-left" data-dismiss="modal" onclick="SaveData()"><i class="fa fa-plus"></i> Save</button>--%>
                        </div><!-- /.col-->
                    </div><!-- ./row -->
                        </form>


                </section><!-- /.content -->
<script type="text/javascript">
            $(function() {
                // Replace the <textarea id="editor1"> with a CKEditor
                // instance, using default configuration.
                //CKEDITOR.replace('editor1');
                //bootstrap WYSIHTML5 - text editor
               
                $(".textarea").wysihtml5();
            });
            $('#submitFrm').on('submit', (function (e) {
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
                        getContent("content.aspx");
                    },
                    error: function (data) {
                        console.log("error");
                        console.log(data);
                    }
                });

            }));
        </script>