<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
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
h1{display:inline}
h2{display:inline}
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
th{
	width:10%;
}
td{
	width:70%;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>QnA 게시판 ></h1><h2> 질문 등록</h2><br>
<hr>
<form action="${initParam.rootPath}/common/boardqna/boardQnAAdd.do" method="POST">
<table style="width:100%;">
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
			<input class="form-control" style="float:left;width:50%;" type="text" name="boardQnATitle" value="<sec:authentication property="principal.memberId"></sec:authentication>님의 질문입니다." readOnly>
			<br><br>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea class="form-control textarea_test" onkeyup="this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
				name="boardQnATxt" row="5" cols="70" placeholder="내용을 입력해주세요">${boardQnA.boardQnATxt}</textarea>
			<span class="error"><form:errors path="boardQnA.boardQnATxt" delimiter="&nbsp;"/></span>
		</td>
	</tr>	
</table>
<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return insert_event();">
	<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
</button>
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="POST">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
	</button>
	<sec:csrfInput/>
</form>
</div>
</body>
</html>