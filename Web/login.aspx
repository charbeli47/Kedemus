﻿<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Web.login1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header" runat="server">
    <link rel="stylesheet" href="../css/authentication.css" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div id="slider_row">
<div id="top_column" class="center_column"></div>
</div>
<div id="columns" class="container">
 
<div class="breadcrumb clearfix">
<a class="home" href="home" title="Return to Home">
<i class="fa fa-home"></i>
</a>
<span class="navigation-pipe">&gt;</span>
<%=lang=="en"?"Authentication":"Authentification" %>
</div>
 
<div class="row">
<div class="large-left col-sm-6">
<div class="row">
<div id="center_column" class="center_column col-xs-12 col-sm-12">
<h1 class="page-heading"><%=lang=="en"?"Authentication":"Authentification" %></h1>
<div class="row">
<div class="col-xs-12 col-sm-12">
<form action="login" method="post" id="login_form" class="box">
<h3 class="page-subheading"><%=lang=="en"?"Login":"Connectez-vous" %></h3>
<div class="form_content clearfix">
<div class="form-group">
<label for="passwd"><%=lang=="en"?"Username":"Nom d'utilisateur" %></label>
<input class="is_required validate account_input form-control" type="text" data-validate="isPasswd" id="uname" name="uname" required value=""/>
</div>
    <div class="form-group">
<label for="passwd"><%=lang=="en"?"Password":"Password" %></label>
<input class="is_required validate account_input form-control" type="password" data-validate="isPasswd" id="passwd" name="passwd" required value=""/>
</div>
<p class="lost_password form-group">
</p>
<p class="submit">
<input type="hidden" class="hidden" name="back" value="my-account"/>
<button type="submit" id="SubmitLogin" name="SubmitLogin" class="btn btn-default btn-md">
<span>
<i class="fa fa-lock left"></i>
<%=lang=="en"?"Sign in":"Connectez-vous" %>
</span>
</button>
</p>
</div>
    <asp:Literal ID="msg" runat="server" />
</form>
</div>
</div>
</div> 

</div> 
</div> 
</div> 
</div> 
</asp:Content>
