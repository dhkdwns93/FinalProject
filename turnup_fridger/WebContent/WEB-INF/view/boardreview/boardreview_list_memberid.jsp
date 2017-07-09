<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
//후기 삭제
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardreview/boardreview_list.do";
	}else{   
		//취소
	    return false;
	}
};


//후기 등록
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardreview/boardreview_list.do";
	}else{   
		//취소
	    return false;
	}
};

</script>
<style type="text/css">
 form{display:inline}
 span, td, th{
	padding: 5px; 
 }
 span.error{
	font-size:small;
	color: red;
 }
</style>
</head>
<body>
<sec:authorize access="hasRole('ROLE_MEMBER')">
후기 작성
<form action="${initParam.rootPath}/boardreview/boardReviewAdd.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<table border="1" style="text-align:center" >
	<tr>
		<td>작성자</td>
		<td><input type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"></sec:authentication>"></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="boardReviewTitle" value="${boardReview.boardReviewTitle}"></td>
	</tr>
</table>
<table border="1" style="text-align:center">	
	<tr>
    	<td>레시피</td>
    	<td><!-- <input type="button" value="레시피 찾기"> --><input type="text" name="recipeId"></td>
    	<td>별점주기</td>
    	<td>			
  						 <span class="input">
						    <input type="radio" name="boardReviewStar" id="p1" value="1"><label for="p1">1</label>
						    <input type="radio" name="boardReviewStar" id="p2" value="2"><label for="p2">2</label>
						    <input type="radio" name="boardReviewStar" id="p3" value="3"><label for="p3">3</label>
						    <input type="radio" name="boardReviewStar" id="p4" value="4"><label for="p4">4</label>
						    <input type="radio" name="boardReviewStar" id="p5" value="5" checked><label for="p5">5</label>
						    <input type="radio" name="boardReviewStar" id="p6" value="6"><label for="p6">6</label>
						    <input type="radio" name="boardReviewStar" id="p7" value="7"><label for="p7">7</label>
						    <input type="radio" name="boardReviewStar" id="p8" value="8"><label for="p8">8</label>
						    <input type="radio" name="boardReviewStar" id="p9" value="9"><label for="p9">9</label>
						    <input type="radio" name="boardReviewStar" id="p10" value="10"><label for="p10">10</label>
						  </span>
		</td>
    </tr>
</table>
<table border="1">	
	<tr>
		<td>사진</td>
		<td>
			<input type="file" name="upImage">
		</td>
	</tr>


	<tr>
		<td>내용</td>
		<td><textarea name="boardReviewTxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardReview.boardReviewTxt}</textarea>
			<span class="error"><form:errors path="boardReview.boardReviewTxt" delimiter="&nbsp;"/>
		</td>
	</tr>
</table>
<input type="submit" value="등록하기" onclick="insert_event();">
</form>
</sec:authorize>

<hr>

<form action="${initParam.rootPath}/boardreview/boardReviewBySelect.do" method="post">
자유게시판 <br>

<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<select name="select" id="select">
		<option>:::선택:::</option>
		<option value="레시피">레시피</option>
		<option value="아이디">아이디</option>
	</select>
	<input type="text" name="keyword" placeholder="키워드를 입력해주세요">
	<button>검색</button>
</form>



<c:forEach var="row" items="${list}">
<table border="1" style="text-align:center">
<thead>
    <tr>
        <td>
        	레시피 : ${row.recipeInfo.recipeName} |
        	제목 : ${row.boardReviewTitle} |
        	작성자 : ${row.memberId} |
        	작성일 : <fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd"/>
        </td>
    </tr>
</thead>
 <tbody>   
    <tr>
    	<td>별점 : ${row.boardReviewStar}</td>
    </tr>
    <tr>
   		<td>
   			<c:if test="${row.imageName == null}">
 				${row.boardReviewTxt}
 			</c:if>
   			<c:if test="${row.imageName != null}">
   			  	<img width="320px" alt="${row.imageName}" src="${initParam.rootPath}/up_image/${row.imageSaveName}"><br>
   				${row.boardReviewTxt}
   			</c:if>
   		</td>
    </tr>	
	<!-- 회원 권한 폼 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
		<tr>
   			<td>
   			<form action="${initParam.rootPath}/boardreview/boardReviewUploadView.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
				<input type="hidden" name="writer" value="${row.memberId}">
				<button>수정하기</button>
			</form>
				<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
					<input type="hidden" name="writer" value="${row.memberId}">	
					<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="adminId" value="">
					<input type="submit" value="삭제하기" onclick="return delete_event();">
				</form>
			</td>
     	</tr> 
	</sec:authorize>

	
	<!-- 관리자 권한 폼 -->
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
	<tr>
   		<td>	
			<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="writer" value="${row.memberId}">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"></sec:authentication>">
				<input type="hidden" name="memberId" value="">
				<input type="submit" value="삭제하기" onclick="return delete_event();">
			</form>
		</td>
    </tr>
	</sec:authorize>
   	   
</tbody>
</table>
</c:forEach>

<hr>

<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
</body>
</html>