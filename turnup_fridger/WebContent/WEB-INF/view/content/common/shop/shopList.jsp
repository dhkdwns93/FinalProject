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
	
	// 쇼핑몰 목록 불러오기
/* 		$.ajax({
			"url": "${initParam.rootPath}/shop/findShopList.do",
			"dataType" : "json",
			"success" : function(shopList){
				var list = ""; 
				$.each(shopList, function(){
					list += "<tr><td id='shopid'>"+this.shopId+"</td><td>"+this.upImage+"</td><td><a href='#' onClick='window.open('"+this.shopAddress+"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)'>"+this.shopName+"</a></td><td><button type='button' id='delBtn'>삭제</button></td></tr>";
				});
				$("#tbody").html(list);
			},
			"error":function(xhr, msg, code){
				alert('error!'+code);
			}
		}); */
	
	// 개수 불러오기
	$.ajax({
		"url": "${initParam.rootPath}/shop/findShopCount.do",
		"success":function(num){
			$("#count").text('총 '+num+' 개의 쇼핑몰이 있습니다.');
		}
	});
	
	// 삭제
	$("tbody").on("click", "#delBtn", function(){
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
				"url":"${initParam.rootPath}/shop/removeShop.do",
				"data":"shopId="+$(this).parent().parent().children(":first-child").text(),
				"success": function(result){
					alert('삭제되었습니다');
					window.location.reload(); // 삭제 후 목록 새로고침
				} // success
			}); // ajax
		}; // if
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
p{
	text-align: center;
}

</style>
</head>
<body>
<p id="shopCount"><span id="count"></span></p>
<div style="width:100%; height:500px; overflow:auto">
<table class="table table-hover">
	<tr> 
		<td>NO</td>
		<td colspan="3">Shop</td>
	</tr>
	<c:forEach items="${requestScope.list }" var="shop">
		<tr>
			<td>${shop.shopId }</td>
			<td><img alt="${shop.shopImg }" src="${initParam.rootPath}/up_image/${shop.saveImg}" width="100" height="102"></td>
			<td><a href="#" onClick="window.open('${shop.shopAddress}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=1000px, height=600px ,top=10, left=10', bottom=10, right=10)">${shop.shopName }</a></td>
			 <!-- 관리자만 보이는 삭제버튼 -->
			 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<td><button type="button" id="delBtn">삭제</button></td>
			</sec:authorize>
		</tr>
	</c:forEach>
</table>
</div>
</body>
</html>