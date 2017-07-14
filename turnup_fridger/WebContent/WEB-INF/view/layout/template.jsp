<%@page import="kr.co.turnup_fridger.vo.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

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
</head>
<body>
<div id="container">
<!-- Navigation -->
<nav id="head" class="navbar navbar-default navbar-fixed-top topnav " role="navigation">
   <div class="container topnav">
      <tiles:insertAttribute name="head" />
   </div>
</nav>

<!-- 메뉴바 -->
<div id ="menu" class="intro-header">
   <div class="container">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="intro-message">
                  <tiles:insertAttribute name="menu" />
               </div>
            </div>
         </div>
      </div>
   </div>
</div>


<!-- content -->

<div id="content" class="container subnav">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="intro-content">

               <tiles:insertAttribute name="content" />

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
</div>

</body>
</html>