<%@page import="kr.co.turnup_fridger.vo.Shop"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* setTimeout("location.reload()",1000); // 일정시간마다 새로고침*/
	
	// 개수 불러오기
	$.ajax({
		"url": "${initParam.rootPath}/shop/findShopCount.do",
		"success":function(num){
			$("#count").text('총 '+num+' 개의 쇼핑몰이 있습니다.');
		}
	});
});
</script>
<style type="text/css">

table{
	border:1;
	border-collapse:collapse;
	text-align: center;
	align: center;
	margin:auto;
}
p, h3{
	text-align: center;
}

</style>
</head>
<body>
<h3> 클릭하시면 해당 사이트로 연결됩니다</h3>
<br><br>
<p id="shopCount"><span id="count"></span>
<div class="container">
<div style="width:100%; height:500px; overflow:auto">
<table class="table table-hover">
	<tr> 
		<td>NO</td>
		<td colspan="3">Shop</td>
	</tr>
	<c:forEach items="${requestScope.list }" var="shop">
		<tr>
			<td>${shop.shopId }</td>
			<td><img alt="${shop.shopImg }" src="${initParam.rootPath}/img/${shop.shopImg}" width="100" height="102"></td>
			<td><a href="#" onClick="window.open('${shop.shopAddress}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)">${shop.shopName }</a></td>
		</tr>
	</c:forEach>
</table>
</div>
</div>
</body>
</html>