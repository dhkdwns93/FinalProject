<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">

<div>
<canvas id="typeChart" style="width: 285px; height: 142px;"></canvas>
</div>



<div>
	<canvas id="placeChart" style="width: 285px; height: 142px;"></canvas>
</div>