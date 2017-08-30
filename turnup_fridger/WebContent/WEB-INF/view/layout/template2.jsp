<%@page import="kr.co.turnup_fridger.vo.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!-- 상세화면 템플릿 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>turnup-fridger</title>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
</head>


<div class="fridger">
	<div id="container">
	
		<!-- menu -->
		<nav id="head" class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
		<div class="container topnav">
			<tiles:insertAttribute name="menu" />
		</div>
		</nav>
		
		<!-- content -->
		<div id ="content2" class="">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12 content">
							<tiles:insertAttribute name="content" />
					</div>
				</div>
			</div>
		</div>
		
		<!-- footer -->
		<footer>
		<div id="foot">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<tiles:insertAttribute name="footer" />
					</div>
				</div>
			</div>
			</div>
		</footer>
	
	</div> <!-- end of container -->
</div> <!-- end of fridger -->

</html>