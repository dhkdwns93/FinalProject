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
		location.href="/turnup_fridger/boardnotice/boardnotice_view.do";
	}else{   
		//취소
	    return false;
	}
};

</script>
<style type="text/css">
form{
	display:inline
}
</style>
<style type="text/css">
span, td, th {
	padding: 5px;
}

span.error {
	font-size: small;
	color: red;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>공시사항 등록</h1><br>
<hr>
	<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeAdd.do?" method="post" enctype="multipart/form-data">		
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<table>
			<tr>
				<td>제목</td>
			</tr>
			<tr>		
				<td><input type="text" name="title"value="${boardNotice.title}" placeholder="제목을 입력해주세요" class="form-control">
					<span class="error"><form:errors path="boardNotice.title" delimiter="&nbsp;" /></span>
				</td>
			</tr>
			<tr>
				<td>말머리</td>
			</tr>
			<tr>
				<td><select name="items" id="items">
						<option>공지사항</option>
						<option>뉴스</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>사진</td>
			</tr>
			<tr>
				<td><input type="file" name="upImage"></td>
			</tr>

			<tr>
				<td>내용</td>
			</tr>
			<tr>
				<td>
					<textarea name="txt" row="5" cols="70" placeholder="내용을 입력해주세요" class="form-control">${boardNotice.txt}</textarea>
					<span class="error"><form:errors path="boardNotice.txt" delimiter="&nbsp;" /></span>
				</td>
			</tr>
	</table>
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return insert_event();">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
		</button>
	</form>
	<form action="${initParam.rootPath}/boardnotice/boardNoticeList.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
		</button>
	</form>  
</div>
</body>
</html>