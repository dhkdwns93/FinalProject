<%@page import="kr.co.turnup_fridger.vo.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
	session.setAttribute("member",
			new Member("qms1109", "shh", "서현화", "판교", "qms1109@hanmail.net", "010-4184-1109", "F"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>turnup-fridger</title>
<script src="scripts/jquery.js"></script>
<script src="scripts/bootstrap.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/landing-page.css" rel="stylesheet">
</head>

<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
	<div class="container topnav">
		<tiles:insertAttribute name="head" />
	</div>
</nav>

<!-- 메뉴바 -->
<div class="container subnav">
	<tiles:insertAttribute name="menu" />
</div>

<!-- content -->
<div class="intro-header">
	<div class="container">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="intro-message">
						<tiles:insertAttribute name="content" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- footer -->
<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<tiles:insertAttribute name="footer" />
			</div>
		</div>
	</div>
</footer>