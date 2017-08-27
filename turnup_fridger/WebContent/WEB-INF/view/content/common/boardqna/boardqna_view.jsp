<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	//줄 바꿈
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">

//게시물 삭제 확인
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_list.do";
	}else{   
		//취소
	    return false;
	}
};

//댓글 삭제 확인
function delete_event2(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};

//댓글 등록 확인
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};
//댓글 글자수 확인
function checkLength(commentQnATxt) {
    if (commentQnATxt.value.length > 100 ) {
    	commentQnATxt.blur();
    	commentQnATxt.value = commentQnATxt.value.substring(0, 100);
        alert('더 이상 입력이 불가능 합니다.');
        commentQnATxt.focus();
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
/* input 정렬 */
input {
   vertical-align:middle;  
}
.textarea_test {
    resize:none;
    line-height:30px;
    width:100%;
    overflow-y:hidden;
    height:100%;
}

</style>
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div class="right-box-sidemenu">
	<div id="table" style="width:auto; margin-left: auto; margin-right: auto;">
		<br><br>
		<h1>QnA 게시판 ></h1> <h2> ${requestScope.boardQnA.memberId}님의 질문</h2><br>
		<hr>
		<%-- 목록으로 이동 버튼 --%>
		<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="post">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
			</button>
			<sec:csrfInput/>
		</form>
		<%-- 글 수정 버튼 --%>
		<div style="float:right">
			<form action="${initParam.rootPath}/common/boardqna/boardQnAUploadView.do" method="post">
					<input type="hidden" name="boardQnAId" id="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
					<!-- 회원만 수정 가능  -->
					<sec:authorize access="hasRole('ROLE_MEMBER')">
						<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						</button>
					</sec:authorize>
				<sec:csrfInput/>
			</form>
			<%-- 글 삭제 버튼 --%>
			<form action="${initParam.rootPath}/common/boardqna/boardQnARemove.do" method="post">
				<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
				<sec:csrfInput/>
			</form>
		</div>
		<table class="table table-bordered" style="width:100%; border:1; text-align:center;">
			<tr>
				<td style="width:10%;" >제목</td>
				<td style="width:85%;text-align:left;">${requestScope.boardQnA.boardQnATitle}</td>
			</tr>
			<tr>
				<td style="width:10%;">작성날짜</td>
				<td style="width:85%;text-align:left;"><fmt:formatDate value="${requestScope.boardQnA.boardQnAdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
			</tr>
			<tr>
				<td style="width:10%;">작성자</td>
				<td style="width:85%;text-align:left;">${requestScope.boardQnA.memberId}</td>
			</tr>	
			<tr>
				<td style="width:10%;">내용</td>
				<td style="width:85%;text-align:left;">
					${fn:replace(requestScope.boardQnA.boardQnATxt, cn, br)}
				</td>
			</tr>
		</table>
		<%-- 댓글 목록 --%>
		<%-- 댓글 없을 때 --%>
		<c:if test="${empty list}">
		<h3>댓글 목록</h3>
		<hr>
		댓글이 없습니다.<br><br><br>
		</c:if>
		<%-- 댓글 있을 때 --%>
		<div>
		<c:if test="${!empty list}">
		<div id="table" style="width:100%; border:1; text-align:center;">
		<div style="float:left">
		<h3>댓글 목록</h3>
		</div>
		<table class="table table-hover table-condensed" style="width:100%; border:1;margin-left: auto; margin-right: auto;">	
		<c:forEach var="row" items="${list}"> 
		    <tr>
		        <td style="width:80%;">
					<div style="text-align:left">
		        	<!-- 사용자 등록일 경우  -->
					<c:if test="${row.adminId == null}">
						${row.memberId}
					</c:if>
					<!-- 관리자 등록일 경우 -->
					<c:if test="${row.adminId != null}">
						관리자(${row.adminId})
					</c:if>	
		        	&nbsp;|&nbsp;<fmt:formatDate value="${row.commentQnADate}" pattern="yyyy-MM-dd a HH:mm"/><br>
		        	${row.commentQnATxt}
		        	</div>
		        </td >
		        <td style="width:20%;">
		        	<div style="text-align:right">
		        	<%-- 댓글 수정버튼 --%>
		        	<form action="${initParam.rootPath}/common/commentqna/commentQnAUploadView.do" method="post">
								<input type="hidden" name="commentQnAId" id="commentQnAId" value="${row.commentQnAId}">
								<input type="hidden" name="commentQnATxt" id="commentQnATxt" value="${row.commentQnATxt}">
								<input type="hidden" name="memberId" id="memberId" value="${row.memberId}">
								<input type="hidden" name="boardQnAId" id="boardQnAId" value="${row.boardQnAId}">	
						<!-- 작성자가 관리자이면 관리자 댓글 수정가능 -->
						<c:if test="${row.adminId != null}">		
							 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
								<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
			  						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								</button>
							 </sec:authorize>
						</c:if>
						<!-- 작성자가 사용자이면 사용자 댓글 수정 -->
						<c:if test="${row.adminId == null}">
							 <sec:authorize access="hasRole('ROLE_MEMBER')">
							 	<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
			  						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								</button>
							 </sec:authorize>
						</c:if>
					<sec:csrfInput/>
					</form>		
					<%-- 댓글 삭제 버튼 --%>
				    <form action="${initParam.rootPath}/common/commentqna/commentQnARemove.do" method="post">
						<input type="hidden" name="boardQnAId" value="${row.boardQnAId}">
						<input type="hidden" name="commentQnAId" value="${row.commentQnAId}">			
						<!-- 작성자가 관리자이면 관리자/사용자 댓글 삭제 가능 -->
						<c:if test="${row.adminId != null}">		
							 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
									<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event2();">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</button>
							</sec:authorize>
						</c:if>				
						<!-- 작성자가 사용자이면 사용자 댓글만 삭제 가능 -->
						<c:if test="${row.adminId == null}">
							 <sec:authorize access="isAuthenticated()">
									<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event2();">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</button>
							 </sec:authorize>
						</c:if>				
						<sec:csrfInput/>
					</form>
					</div>
		        </td>
		    </tr>
			</c:forEach>   
		</table>
		</div>	
		</c:if>		
		<!-- 댓글등록 -->
			<div id="div">
			<form action="${initParam.rootPath}/common/commentqna/commentQnAAdd.do" method="post">
				<div id="table" style="width:100%;">
				<table class="table table-bordered" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">
						<tr>
							<td style="width:15%;">작성자</td>
							<td>
								<%-- 작성자가 회원 일 때  --%>
								<sec:authorize access="hasRole('ROLE_MEMBER')">
									<input  type="text" name="memberId" class="form-control" style="float:left;width:30%" readonly value="<sec:authentication property="principal.memberId"/>">
								</sec:authorize>
								<%-- 작성자가 관리자 일 때  --%>
								<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
									<input class="form-control" type="text" name="adminId" readonly style="float:left;width:30%" value="<sec:authentication property="principal.adminId"/>">
								</sec:authorize>
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea class="form-control textarea_test" onkeyup="checkLength(this); this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
										 id="commentQnATxt" name="commentQnATxt" style="float:left;width:85%;" row="5" cols="50" placeholder="내용을 입력해주세요" wrap="physical"></textarea>			
								<div style="float:right">
							 		<input type="hidden" name="adminId" value="">
									<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
									<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="insert_event();">
										<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
									</button>
								</div>	
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div style="float:left">
									<span class="error"><form:errors path="commentQnA.commentQnATxt" delimiter="&nbsp;"/></span>
								</div>
							</td>
						</tr> 		
				</table>
				</div>	
			<sec:csrfInput/>
			</form>
			</div>
		</div>	
	</div>
</div>
</div>
</body>
</html>