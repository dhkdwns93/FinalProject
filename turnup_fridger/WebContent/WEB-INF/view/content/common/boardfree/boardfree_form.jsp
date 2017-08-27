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
//등록 확인
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};
//글자수 확인 
function checkLength(txt) {
    if (boardFreeTxt.value.length > 1000 ) {
    	boardFreeTxt.blur();
    	boardFreeTxt.value = boardFreeTxt.value.substring(0, 1000);
        alert('더 이상 입력이 불가능 합니다.');
        boardFreeTxt.focus();
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
th{
	width:10%;
}
td{
	width:70%;
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
	<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
	<br><br>
	<h1>자유 게시판 ></h1><h2> 게시물 등록</h2><br>
	<hr>
		<form action="${initParam.rootPath}/common/boardfree/boardFreeAdd.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<table>
				<tr>
					<th>작성자</th>
					<td>
						<input class="form-control" style="float:left;width:40%;" type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"></sec:authentication>">
						<br><br>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="form-control" style="float:left;width:50%;" type="text" name="boardFreeTitle" value="${boardFree.boardFreeTitle}" placeholder="제목을 입력해주세요">
						<span class="error"><form:errors path="boardFree.boardFreeTitle" delimiter="&nbsp;"/></span>
						<br><br>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="form-control textarea_test"style="float:left;width:100%;" onkeyup="checkLength(this); this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
						id="boardFreeTxt" name="boardFreeTxt" rows="20" cols="60" placeholder="내용을 입력해주세요" wrap="physical">${boardFree.boardFreeTxt}</textarea>
						<span class="error"><form:errors path="boardFree.boardFreeTxt" delimiter="&nbsp;"/></span>
					</td>
				</tr>	
				<br>	
			</table>
			<%-- 등록 버튼 --%>
						<input type="hidden" name="boardFreeHits" value="0">
						<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return insert_event();">
							<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
						</button>
			</form>
			<%-- 뒤로가기 버튼(목록으로 이동) --%>
			<form action="${initParam.rootPath}/common/boardfree/boardFreeList.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
				</button>
			</form>
	</div>
</div>
</body>
</html>