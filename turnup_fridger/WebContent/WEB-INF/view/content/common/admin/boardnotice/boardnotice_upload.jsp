<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
$(document).ready(function(){
	$("#img").on("click",function(){
		$("#image").empty().append("<input type='file' name='upImage'>");
	});
});
function modify_event(){
	if (confirm("수정 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardnotice/boardnotice_view.do";
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
<h1>공지사항 수정</h1>
<hr>
<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeUploadForm.do" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<th>제목</th>
		<td>
			<input style="float:left;width:50%;" type="text" name="title" value="${boardNotice.title}" placeholder="제목을 입력해주세요" class="form-control">
			<span class="error"><form:errors path="boardNotice.title" delimiter="&nbsp;"/></span>
			<br><br>
		</td>
	</tr>
	<tr>
		<th>말머리</th>
		<td>
			<select class="form-control" style="float:left;width:30%;" name="items" id="items">
				<option>공지사항</option>
				<option>뉴스</option>
			</select>
			<br><br>
		</td>
	</tr>
		<c:if test="${boardNotice.saveImg == null}">
		<tr>
			<th>사진</th>
			<td>
				<input type="file" name="upImage">
				<br>
			</td>
		</tr>
		</c:if>		
		<c:if test="${boardNotice.saveImg != null}">
		<tr>	
			<th>사진</th>
			<td>
				<div id="image">
					<input type="hidden" name="img" value="${boardNotice.img}">
					<input type="hidden" name="saveImg" value="${boardNotice.saveImg}">
					${boardNotice.img}
					<button type="button" class="btn btn-default btn-lg" id="img"  style="border:0;outline:0;">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					</button>
				</div>
				<br>
			</td>
		</tr>
		</c:if>
	<tr>	
		<th>내용</th>
		<td>
			<textarea class="form-control textarea_test"style="float:left;width:70%;" onkeyup="this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
					name="txt" row="5" cols="70" placeholder="내용을 입력해주세요" class="form-control">${boardNotice.txt}</textarea>
			<span class="error"><form:errors path="boardNotice.txt" delimiter="&nbsp;"/></span>
		</td>
	</tr>	
</table>
	<input type="hidden" name="id" value="${boardNotice.id}">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return modify_event();">
		<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
	</button>
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/boardnotice/boardNoticeView.do" method="post">
    <input type="hidden" name="id" value="${boardNotice.id}">
    <button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
	</button>
<sec:csrfInput/>
</form>
</div>
</div>
</body>
</html>