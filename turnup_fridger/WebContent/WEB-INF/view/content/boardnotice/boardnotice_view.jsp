<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
//삭제 확인
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/admin/boardnotice/boardnotice_list.do";
	}else{   
		//취소
	    return false;
	}
};
</script>
<style type="text/css">
form{display:inline}
h1{display:inline}
h2{display:inline}
</style>
</head>
<body>

<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div class="right-box-sidemenu">
	<div style="width:auto; margin-left: auto; margin-right: auto;"><br><br>
		<div class="form-inline form-group" >
		<h1>공지사항 ></h1><h2>&nbsp;${boardNotice.items}</h2>
		<hr>
		<form action="${initParam.rootPath}/boardnotice/boardNoticeList.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
			</button>
		</form>
		
		<!-- 관리자  -->
		<div style="float:right">
			<!-- 관리자만 수정 가능 -->
			 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
			<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeUploadView.do?" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="id" id="id" value="${boardNotice.id}">
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
				  	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				</button>
			</form>
			</sec:authorize>
			<!-- 관리자만 삭제 가능 -->
			 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
			<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticRemove.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="id" value="${boardNotice.id}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
			</form>
			</sec:authorize>
		</div>
			<table class="table table-bordered" style="width:100%; border:1; text-align:center">
				<tr>
					<td style="width:10%;">말머리</td>
					<td style="width:85%;text-align:left">${boardNotice.items}</td>
				</tr>
				<tr>
					<td style="width:10%;">제목</td>
					<td style="width:85%;text-align:left">${boardNotice.title}</td>
				</tr>
				<tr>
					<td style="width:10%;">작성날짜</td>
					<td style="width:85%;text-align:left"><fmt:formatDate value="${boardNotice.date}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td style="width:10%;">작성자</td>
					<td style="width:85%;text-align:left">관리자</td>
				</tr>	
				<tr>
					<td style="width:10%;">내용</td>	
					<td>
						<c:if test="${boardNotice.img != null}">
							<div style="float:center;">
								<img width="70%" alt="${boardNotice.img}" src="${initParam.rootPath}/img/board/${boardNotice.img}"><br>
							</div>
						</c:if>
						<div style="width:85%;text-align:left">
							${fn:replace(boardNotice.txt, cn, br)}
						</div>	
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</div>
</body>
</html>