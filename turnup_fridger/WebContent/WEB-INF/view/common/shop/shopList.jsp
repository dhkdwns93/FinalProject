<%@page import="kr.co.turnup_fridger.vo.Shop"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% request.setAttribute("shop", new Shop(1, "이마트몰", "http://emart.ssg.com/", "emart.png")); 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
h2{
	text-align: center;
}
table{
	border:1;
	border-collapse:collapse;
	text-align: center;
	align: center;
	margin:auto;
}
</style>
</head>
<body>
<h2> 쇼핑몰 목록 </h2>
<!--  -->
<table border="1" style="border-collapse:collapse; text-align:center;"  align="center">
	<tr>
		<td><img alt="" src="${initParam.rootPath}/img/${requestScope.shop.shopImg}" width="100" height="102"></td>
		<td>							<!-- location 값 yes로 주면 새탭으로 열기 -->
			<a href="#" onClick="window.open('${requestScope.shop.shopAddress}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)">${requestScope.shop.shopName}</a>
		</td>
		<td></td>
	</tr>
	<c:forEach items="${requestScope.shopList }" var="shop">
		<tr>
			<td><img alt="" src="${initParam.rootPath}/img/${shop.shopImg}" width="100" height="102"></td>
			<td><a href="#" onClick="window.open('${shop.shopAddress}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)">${shop.shopName }</a></td>
			 <!-- 관리자만 보이는 삭제버튼 -->
			 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN')">
				<td><button type="button" id="delBtn">삭제</button></td>
			</sec:authorize>
		</tr>
	</c:forEach>
</table>
</body>
</html>