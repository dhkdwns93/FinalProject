<%@page import="kr.co.turnup_fridger.vo.Shop"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 쇼핑몰 목록 불러오기
	var shopid = 1;
		$.ajax({
			"url": "${initParam.rootPath}/shop/findShopList.do",
			"dataType" : "json",
			"success" : function(shopList){
				var list = ""; 
				$.each(shopList, function(){
					shopid = this.shopId
					list += "<tr><td>"+this.shopImg+"</td><td><a href='#' onClick='window.open('"+this.shopAddress+"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)'>"+this.shopName+"</a></td><td><button type='button'>삭제</button></td></tr>";
				});
				$("#tbody").html(list);
			},
			"error":function(xhr, msg, code){
				alert('error!'+code);
			}
		});
	// 개수 불러오기
	$.ajax({
		"url": "${initParam.rootPath}/shop/findShopCount",
		"success":function(num){
			$("#count").text(num+'개의 쇼핑몰이 있습니다.');
		}
		
	});
	
	$("#delBtn").on("click", function(){
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
				"url":"${initParam.rootPath}/shop/removeShop.do",
				"data":"shopId="+shopid,
				"success": function(){
					alert('삭제되었습니다');
				}
			});
		}
	});
	
});
</script>
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
#shopCount{
	text-align: center;
}
</style>
</head>
<body>
<h2> 쇼핑몰 목록 </h2>
<div id="shopCount"><span id="count"></span>개의 쇼핑몰이 있습니다</div>
<table>
<tbody id="tbody">

</tbody>
</table>
<%-- <table border="1" style="border-collapse:collapse; text-align:center;"  align="center">
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
</table> --%>
</body>
</html>