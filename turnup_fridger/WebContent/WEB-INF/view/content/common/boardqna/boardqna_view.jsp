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

</style>
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
	<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
		<br><br>
		<h1>QnA 게시판 ></h1> <h2> ${requestScope.boardQnA.memberId}님의 질문</h2><br>
		<hr>
		<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="post">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
			</button>
			<sec:csrfInput/>
		</form>
		<div style="float:right"><!-- 오른쪽 정렬 -->
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
			
			<form action="${initParam.rootPath}/common/boardqna/boardQnARemove.do" method="post">
				<input type="hidden" name="boardQnAId" value="${requestScope.boardQnA.boardQnAId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
				<sec:csrfInput/>
			</form>
		</div>
		<table class="table table-bordered" style="width:100%; border:1; text-align:center">
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
				<td style="width:70%">
					${fn:replace(requestScope.boardQnA.boardQnATxt, cn, br)}
				</td>
			</tr>
		</table>
		<!-- 댓글 목록 -->
		<!-- 댓글 없을 때   -->
		<c:if test="${empty list}">
		<h3>댓글 목록</h3>
		<hr>
		댓글이 없습니다.<br><br><br>
		</c:if>
		<!-- 댓글 있을 때   -->
		<div>
		
		<c:if test="${!empty list}">
		<div id="table" style="width:100%; border:1; text-align:center">
		<div style="float:left">
		<h3>댓글 목록</h3>
		<hr>
		</div>
		<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">	
		<thead>
		    <tr>
		        <th style="width:10%;text-align:center;">작성자</th>
		        <th style="width:52%;text-align:center;">내용</th>
		        <th style="width:22%;text-align:center;">작성일</th>
		        <th style="width:8%;text-align:center;">수정</th>
		        <th style="width:8%;text-align:center;">삭제</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach var="row" items="${list}"> 
			<tr>
				<td>
					<!-- 사용자 등록일 경우  -->
					<c:if test="${row.adminId == null}">
						${row.memberId}
					</c:if>
					<!-- 관리자 등록일 경우 -->
					<c:if test="${row.adminId != null}">
						관리자(${row.adminId})
					</c:if>	
				</td>
				<td style="width:50%;">
					${row.commentQnATxt}
				</td>
				<td>
					<fmt:formatDate value="${row.commentQnADate}" pattern="yyyy-MM-dd a HH:mm"/>
				</td>
				<td>
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
				</td>
				<td>
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
				</td>
			</tr>
			</c:forEach>   
		 </tbody>
		</table>
		</div>	
		</c:if>
		
		<!-- 댓글등록 -->
			<div id="div">
			<form action="${initParam.rootPath}/common/commentqna/commentQnAAdd.do" method="post">
			<!-- 회원 등록  -->
			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<div id="table" style="width:100%;">
				<table class="table table-bordered" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">
						<tr>
							<td style="width:15%;">작성자</td>
							<td>
								<input  type="text" name="memberId" class="form-control" style="float:left;width:30%" readonly value="<sec:authentication property="principal.memberId"/>">
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea name="commentQnATxt" class="form-control" style="float:left;width:85%;" row="5" cols="70" placeholder="내용을 입력해주세요"></textarea>			
								<div style="float:right"><!-- 오른쪽 정렬 -->
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
			</sec:authorize>
					
			<!-- 관리자 등록  -->
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<div id="table" style="width:100%;">
				<table class="table table-bordered" style="width:100%; border:1; text-align:center;margin-left: auto; margin-right: auto;">
						<tr>
							<td style="width:15%;">작성자</td>
							<td>
								<input class="form-control" type="text" name="adminId" readonly style="float:left;width:30%" value="<sec:authentication property="principal.adminId"/>">
							</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea class="form-control" name="commentQnATxt" style="float:left;width:85%;" row="5" cols="70" placeholder="내용을 입력해주세요"></textarea>		
								<div style="float:right"><!-- 오른쪽 정렬 -->
							 		<input type="hidden" name="memberId" value="">
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
			</sec:authorize>
			<sec:csrfInput/>
			</form>
			</div>
		</div>	
	</div>
</div>
</body>
</html>