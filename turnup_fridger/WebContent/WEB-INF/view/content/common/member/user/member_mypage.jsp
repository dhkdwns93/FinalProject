<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
 (jsp)member_mypage
작성자 :  김경혜
최초 작성일 170704
변경이력 
170714 박연수 // 즐겨찾기목록 추가. 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#favoriteSection").hide();
	$.ajax({
		"url":"/turnup_fridger/common/member/getFavorite.do",
		//"type":"POST",
		"dataType":"json",
		"success":function(list){
			$("#favoriteSection").show();
			$("#fTbody").empty();
			
			$.each(list, function(){
				$("#fTbody").append($("<tr>").append($("<td>").append(this.recipeId))
						.append($("<td>").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detail.do?recipeId="+this.recipeId).append(this.recipeInfo.recipeName))));
				 });//each	 		 
			},//success
			
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}//error
	});
		
})

</script>
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>

<h2>마이페이지</h2><p>
<table class="table" border="1" width="500">
	<tr>
		<th>회원 ID</th>
		<th><sec:authentication property="principal.memberId"></sec:authentication></th>
	</tr>
	<tr>
		<th>이름</th>
		<th><sec:authentication property="principal.memberName"></sec:authentication></th>
	</tr>
	<tr>
		<th>주소</th>
		<th><sec:authentication property="principal.memberAddress"></sec:authentication></th>
	</tr>
	<tr>
		<th>이메일</th>
		<th><sec:authentication property="principal.memberEmail"></sec:authentication></th>
	</tr>
	<tr>
		<th>전화번호</th>
		<th><sec:authentication property="principal.memberTel"></sec:authentication></th>
	</tr>
	<tr>
		<th>성별</th>
		<th><sec:authentication property="principal.memberSex"></sec:authentication></th>
	</tr>
	<tr>
		<th>기피재료목록</th>
		<th>
			<c:forEach items="${requestScope.myDislikeIrdntNameList }" var="myDislikeIrdntName">
					<li>${myDislikeIrdntName }</li>
			</c:forEach> 
		</th>
	</tr>
</table>

<hr>
<a href="${initParam.rootPath }/common/member/member_change_info.do"><button type="button" class="btn btn-default">회원정보수정</button></a>
<a href="${initParam.rootPath }/common/member/member_delete_form.do"><button type="button" class="btn btn-default">회원탈퇴하기</button></a>
<hr>

나의 레시피 즐겨찾기 목록
<div id="favoriteSection">
	<table>
		<thead id="fThead">
			<tr>
				<th>레시피id</th>
				<th>레시피이름</th>
			</tr>		
		</thead>
		<tbody id="fTbody">
		</tbody>
	</table>
</div>
</div>
</body>
</html>