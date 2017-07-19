<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
</script>
<script type="text/javascript">
//게시물 수정
function update_event(){
	
	var memberId = $('input[name=memberId]').val();
	var writer = $('input[name=writer]').val();

	if(writer != memberId)
	{
		alert("권한이 없습니다.");
		return false;
	}

	
	return location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	
};
//게시물 삭제(회원)
function delete_event(){
	
	var memberId = $('input[name=memberId]').val();
	var writer = $('input[name=writer]').val();
	if(writer != memberId)
	{
		alert("권한이 없습니다.");
		return false;
	}
	
	if(confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_list.do";
	}else{   
		//취소
	    return false;
	}
};

//게시물 삭제(관리자)
function delete_event2(){
	if(confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_list.do";
	}else{   
		//취소
	    return false;
	}
};

//댓글 등록
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};


//댓글 삭제(회원)
function comment_delete_event(){
	
	if (confirm("삭제 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
}; 

//댓글 삭제(관리자)
function comment_delete_event2(){
	
	if (confirm("삭제 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
}; 

/* 
function popup(frm){
	window.name="opener";
	window.open("/turnup_fridger/common/boardfree/commentfree_upload.do","commentupload","width=500, height=400");

}
 */
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
th{
text-align:center
}
h1{display:inline}
h2{display:inline}
#div{
	height: auto; 
	min-height: 100px; 
	overflow: auto;
	background-color:#dcdcdc;
	width: 100%;
}
</style>

</head>
<body>
<c:if test="${requestScope.error != null}">
	<script type="text/javascript">alert('권한이 없습니다.')</script>
</c:if>

<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>

<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>자유 게시판 ></h1><h2> ${boardFree.memberId}님의 글</h2><br>
<hr>
	<form action="${initParam.rootPath}/common/boardfree/boardFreeList.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">	
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		</button>
	</form>
<div style="float:right"><!-- 오른쪽 정렬 -->
<!-- 회원 수정폼 -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
	<form action="${initParam.rootPath}/common/boardfree/boardFreeUploadView.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="hidden" name="boardFreeId" id="boardFreeId" value="${boardFree.boardFreeId}">
		<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
		<input type="hidden" name="writer" value="${boardFree.memberId}">
		<input type="hidden" name="adminId" value="">
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return update_event();">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
		</button>
	</form>
</sec:authorize>


<!-- 회원 권한 폼 -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
<form action="${initParam.rootPath}/common/boardfree/boardFreeRemove.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
	<input type="hidden" name="writer" value="${boardFree.memberId}">	
	<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
	<input type="hidden" name="adminId" value="">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
	</button>
</form>
</sec:authorize>


<!-- 관리자 권한 폼 -->
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<form action="${initParam.rootPath}/common/boardfree/boardFreeRemove.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
	<input type="hidden" name="writer" value="${boardFree.memberId}">
	<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"></sec:authentication>">
	<input type="hidden" name="memberId" value="">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event2();">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
	</button>
</form>
</sec:authorize>
</div>

<table class="table table-bordered" style="width:100%; border:1; text-align:center">
	<tr>
		<td>제목</td>
		<td>${boardFree.boardFreeTitle}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td><fmt:formatDate value="${boardFree.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${boardFree.memberId}</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td style="width:70%">
			${boardFree.boardFreeTxt}
		</td>	
	</tr>
	<tr>
		<td>조회수</td>
		<td>
			${boardFree.boardFreeHits}
		</td>	
	</tr>
</table>
<hr>
<div>
<!-- 댓글 목록 -->
<c:if test="${empty commentFree}">
<h3>댓글 목록</h3><br>
댓글이 없습니다.
</c:if>
<!-- 댓글 있을 때   -->
<c:if test="${!empty commentFree}">
<div id="table" style="width:100%; border:1; text-align:center">
<div style="float:left">
<h3>댓글 목록</h3><br>
</div>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">	
<thead>
    <tr>
        <th style="width:10%;">작성자</th>
        <th style="width:50%;">내용</th>
        <th style="width:20%;">작성일</th>
        <th style="width:10%;">수정</th>
        <th style="width:10%;">삭제</th>
    </tr>
 </thead>
<tbody>
<c:forEach var="list" items="${commentFree}">
	<tr>
		<td>
			${list.memberId}
		</td>
		<td>
			${list.commentFreeTxt}
		</td>
		<td>
			<fmt:formatDate value="${list.commentFreedate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		<td>
			<sec:authorize access="hasRole('ROLE_MEMBER')">
		     	<form  action="${initParam.rootPath}/common/commentfree/commentFreeUploadView.do" method="post">
		     	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="commentFreeId" id="commentFreeId" value="${list.commentFreeId}">
					<input type="hidden" name="commentFreeTxt" id="commentFreeTxt" value="${list.commentFreeTxt}">
					<input type="hidden" name="writer" id="writer" value="${list.memberId}">
					<input type="hidden" name="memberId" id="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="boardFreeId" id="boardFreeId" value="${list.boardFreeId}">
					<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return comment_upload_event();">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					</button>					
				</form>	
			</sec:authorize> 
		</td>
		<td>
			<!-- 회원 권한 폼 -->
			<sec:authorize access="hasRole('ROLE_MEMBER')">
		     <form action="${initParam.rootPath}/common/commentfree/commentFreeRemove.do" method="post">
		     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="commentFreeId" value="${list.commentFreeId}">
				<input type="hidden" name="boardFreeId" value="${list.boardFreeId}">
				<input type="hidden" name="writer" value="${list.memberId}">
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"/>">
				<input type="hidden" name="adminId" value="">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return comment_delete_event();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
			 </form>
			 </sec:authorize>
			
			<!-- 관리자 권한 폼 -->
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		     <form action="${initParam.rootPath}/common/commentfree/commentFreeRemove.do" method="post">
		     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="commentFreeId" value="${list.commentFreeId}">
				<input type="hidden" name="boardFreeId" value="${list.boardFreeId}">
				<input type="hidden" name="writer" value="${list.memberId}">
				<input type="hidden" name="memberId" value="">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"/>">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return comment_delete_event2();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
			 </form>			
			</sec:authorize>
		</td>
	</tr>   
	</c:forEach>
 </tbody>
</table>		
<p style="text-align:center">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=1&boardFreeId=${requestScope.boardFreeId}">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.beginPage - 1}&boardFreeId=${requestScope.boardFreeId}">◀</a>
		</c:when>
		<c:otherwise>
				◀	
		</c:otherwise>
	</c:choose>
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 page가 현재페이지가 아니라면 링크처리. -->
		<c:forEach begin="${requestScope.pageBean.beginPage}" end="${requestScope.pageBean.endPage}" var="page">
			<c:choose>
				<c:when test="${requestScope.pageBean.page != page}"> <%-- 현재패이지가 아니라면 --%>
					<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=${page}&boardFreeId=${requestScope.boardFreeId}">&nbsp;${page}&nbsp;</a>
				</c:when>
				<c:otherwise>
					&nbsp;[${page}]&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>

	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup}">
			<%-- 다음페이지 그룹이 있디면 : nextPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.endPage + 1}&boardFreeId=${requestScope.boardFreeId}">▶</a>
		</c:when>
		<c:otherwise>
				▶		
		</c:otherwise>
	</c:choose>			
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.totalPage}&boardFreeId=${requestScope.boardFreeId}">마지막페이지</a>
</p>
</div>
</c:if>
<!-- 댓글 등록 -->
<div id="div">
<form action="${initParam.rootPath}/common/commentfree/commentFreeAdd.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
 <sec:authorize access="hasRole('ROLE_MEMBER')">
	<div id="table" style="width:100%;">
	<table class="table table-bordered" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="memberId" readonly class="form-control" style="float:left;width:30%" value="<sec:authentication property="principal.memberId"/>">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="commentFreeTxt" class="form-control" style="float:left;width:90%;" row="5" cols="70" placeholder="내용을 입력해주세요"></textarea>	
					<div style="float:right"><!-- 오른쪽 정렬 -->
				 		<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
				 		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="insert_event();">
							<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
						</button>
					</div>	
				</td>
			</tr>	
			<tr>
				<td></td>
				<td>
					<span class="error"><form:errors path="list.commentFreeTxt" delimiter="&nbsp;"/></span>	
				</td>
			</tr>
	</table>
	</div>
	</sec:authorize>
	</form>
	</div>
</div>
</div>
</body>
</html>