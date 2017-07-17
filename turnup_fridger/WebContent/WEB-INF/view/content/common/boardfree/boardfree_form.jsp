<%@ page contentType="text/html;charset=UTF-8"%>
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
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};
</script>
<style type="text/css">
span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small;
	color: red;
}
form{display:inline}
h1{display:inline}
h2{display:inline}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>

<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>자유 게시판 ></h1><h2> 게시물 등록</h2><br>
<hr>
<form action="${initParam.rootPath}/common/boardfree/boardFreeAdd.do" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<table>
		<tr>
			<th>작성자</th>
			<td><input class="form-control" style="float:left;width:40%;" type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"></sec:authentication>"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input class="form-control" type="text" name="boardFreeTitle" value="${boardFree.boardFreeTitle}" placeholder="제목을 입력해주세요">
				<span class="error"><form:errors path="boardFree.boardFreeTitle" delimiter="&nbsp;"/></span>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="form-control" name="boardFreeTxt" row="5" cols="70" placeholder="내용을 입력해주세요">${boardFree.boardFreeTxt}</textarea>
				<span class="error"><form:errors path="boardFree.boardFreeTxt" delimiter="&nbsp;"/></span>
			</td>
		</tr>	
	</table>
				<input type="hidden" name="boardFreeHits" value="0">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return insert_event();">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
				</button>
	</form>
	<form action="${initParam.rootPath}/common/boardfree/boardFreeList.do" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
		</button>
	</form>
</div>
</body>
</html>