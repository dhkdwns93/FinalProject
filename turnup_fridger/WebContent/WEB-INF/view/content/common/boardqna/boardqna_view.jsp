<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">

//게시물 삭제
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_list.do";
	}else{   
		//취소
	    return false;
	}
};

//댓글 삭제
function delete_event2(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};


//댓글 등록
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};

/* 
function popup(frm){
	window.name="parentPage";
	window.open("/turnup_fridger/common/boardqna/commentqna_upload.do","commentupload","width=500, height=400");

} */

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

<h1>QnA 게시판 > ${requestScope.boardQnA.memberId}님의 질문 </h1><br>
<hr>

<div id="table" style="width:800px;">
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">
	<tr>
		<td>제목</td>
		<td>${requestScope.boardQnA.boardQnATitle}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td><fmt:formatDate value="${requestScope.boardQnA.boardQnAdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${requestScope.boardQnA.memberId}</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td>
			${requestScope.boardQnA.boardQnATxt}
		</td>
	</tr>
</table>
</div>
<form action="${initParam.rootPath}/common/boardqna/boardQnAUploadView.do" method="post">
	<input type="hidden" name="boardQnAId" id="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
		<!-- 회원만 수정 가능  -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<button>수정하기</button>
		</sec:authorize>
	<sec:csrfInput/>
</form>

<form action="${initParam.rootPath}/common/boardqna/boardQnARemove.do" method="post">
	<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
	<input type="submit" value="삭제하기" onclick="return delete_event();">
	<sec:csrfInput/>
</form>

<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="post">
	<input type="submit" value="목록으로"/>
	<sec:csrfInput/>
</form>


<hr>

<!-- 댓글 목록 -->
댓글 목록<br>
<c:forEach var="list" items="${requestScope.boardQnA.commentQnAList}">
<c:if test="${list.commentQnAId == 0}">
댓글이 없습니다.
</c:if>
<c:if test="${list.commentQnAId != 0}">

<div id="table" style="width:800px;">
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">	
<thead>
    <tr>
        <th>작성자</th>
        <th>내용</th>
        <th>작성일</th>
        <th>수정</th>
        <th>삭제</th>
    </tr>
 </thead>
<tbody>
	<tr>
		<td>
			<!-- 사용자 등록일 경우  -->
			<c:if test="${list.adminId == null}">
				${list.memberId}
			</c:if>
			<!-- 관리자 등록일 경우 -->
			<c:if test="${list.adminId != null}">
				관리자(${list.adminId})
			</c:if>	
		</td>
		<td>${list.commentQnATxt}</td>
		<td><fmt:formatDate value="${list.commentQnADate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		<td>
<%-- 		
	     	<form name="commentQnAUpload" method="post" >
						<input type="hidden" name="commentQnAId" id="commentQnAId" value="${list.commentQnAId}">
						<input type="hidden" name="commentQnATxt" id="commentQnATxt" value="${list.commentQnATxt}">
						<input type="hidden" name="memberId" id="memberId" value="${list.memberId}">
						<input type="hidden" name="boardQnAId" id="boardQnAId" value="${list.boardQnAId}">
						
				<!-- 작성자가 관리자이면 관리자 댓글 수정가능 -->
				<c:if test="${list.adminId != null}">		
					 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN')">
							<a href="javascript:popup();"><input type="button" id="button" value="수정하기"></a>
					 </sec:authorize>
				</c:if>
				
				<!-- 작성자가 사용자이면 사용자 댓글 수정 -->
				<c:if test="${list.adminId == null}">
					 <sec:authorize access="hasRole('ROLE_MEMBER')">
					 	<input type="hidden" name="memberId" id="memberId" value="${boardQnA.memberId}">
						<input type="hidden" name="loginId" id="loginId" value="<sec:authentication property="principal.memberId"/>">
					 	<!-- <a href="javascript:popup();"><input type="button" value="수정하기"></a> -->
					 	<button onclick="popup();">수정</button>
					 </sec:authorize>
				</c:if>
				
				
			<sec:csrfInput/>
			</form>		 --%>
			<form action="${initParam.rootPath}/common/commentqna/commentQnAUploadView.do" method="post">
						<input type="hidden" name="commentQnAId" id="commentQnAId" value="${list.commentQnAId}">
						<input type="hidden" name="commentQnATxt" id="commentQnATxt" value="${list.commentQnATxt}">
						<input type="hidden" name="memberId" id="memberId" value="${list.memberId}">
						<input type="hidden" name="boardQnAId" id="boardQnAId" value="${list.boardQnAId}">	
				<!-- 작성자가 관리자이면 관리자 댓글 수정가능 -->
				<c:if test="${list.adminId != null}">		
					 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
							<input type="submit" value="수정하기">
					 </sec:authorize>
				</c:if>
				<!-- 작성자가 사용자이면 사용자 댓글 수정 -->
				<c:if test="${list.adminId == null}">
					 <sec:authorize access="hasRole('ROLE_MEMBER')">
					 	<input type="submit" value="수정하기">
					 </sec:authorize>
				</c:if>
			<sec:csrfInput/>
			</form>		

		</td>
		<td>
		     <form action="${initParam.rootPath}/common/commentqna/commentQnARemove.do" method="post">
				<input type="hidden" name="boardQnAId" value="${list.boardQnAId}">
				<input type="hidden" name="commentQnAId" value="${list.commentQnAId}">
				
				<!-- 작성자가 관리자이면 관리자/사용자 댓글 삭제 가능 -->
				<c:if test="${list.adminId != null}">		
					 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
							<input type="submit" value="삭제하기" onclick="return delete_event2();">
					 </sec:authorize>
				</c:if>
				
				<!-- 작성자가 사용자이면 사용자 댓글만 삭제 가능 -->
				<c:if test="${list.adminId == null}">
					 <sec:authorize access="isAuthenticated()">
					 	<input type="submit" value="삭제하기" onclick="return delete_event2();">
					 </sec:authorize>
				</c:if>				
				<sec:csrfInput/>
			</form>
			
			
		</td>
	</tr>   
 </tbody>
</table>
</div>	
</c:if>
</c:forEach>


<!-- 댓글등록 -->
<hr>
댓글작성
<form action="${initParam.rootPath}/common/commentqna/commentQnAAdd.do" method="post">


<!-- 회원 등록  -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
	<table border="1" style="text-align:center">
	<thead id="thead">
	    <tr>
	        <th>내용</th>
	        <th>작성자</th>
	    </tr>
	 </thead>
	<tbody id="tbody">
		<tr>
			<td><textarea name="commentQnATxt" row="120" cols="70" placeholder="내용을 입력해주세요"></textarea><span class="error"><form:errors path="commentQnA.commentQnATxt" delimiter="&nbsp;"/></td>
			<td><input type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"/>"></td>
		</tr>   
	 </tbody>
	</table>
	<input type="hidden" name="adminId" value="">
	<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
	<input type="submit" value="등록하기" onclick="insert_event();">
</sec:authorize>




<!-- 관리자 등록  -->
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
	<table border="1" style="text-align:center">
	<thead id="thead">
	    <tr>
	        <th>내용</th>
	        <th>작성자</th>
	    </tr>
	 </thead>
	<tbody id="tbody">
		<tr>
			<td><textarea name="commentQnATxt" row="120" cols="70" placeholder="내용을 입력해주세요"></textarea><span class="error"><form:errors path="commentQnA.commentQnATxt" delimiter="&nbsp;"/></td>
			<td><input type="text" name="adminId" readonly value="<sec:authentication property="principal.adminId"/>"></td>
		</tr>   
	 </tbody>
	</table>
	<input type="hidden" name="memberId" value="">
	<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
	<input type="submit" value="등록하기" onclick="insert_event();">
</sec:authorize>
<sec:csrfInput/>
</form>

</body>
</html>