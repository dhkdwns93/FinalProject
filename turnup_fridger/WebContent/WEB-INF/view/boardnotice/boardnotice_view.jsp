<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger2/boardnotice/boardnotice_list.do";
	}else{   
		//취소
	    return false;
	}
};
</script>
</head>
<body>
<table border="1" style="text-align:center">
	<tr>
		<td>말머리</td>
		<td>${boardNotice.items}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${boardNotice.title}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td><fmt:formatDate value="${boardNotice.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>관리자</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td>
			<c:if test="${boardNotice.img != null}">
				<img width="320px" alt="${boardNotice.img}" src="${initParam.rootPath}/up_image/${boardNotice.saveImg}"><br>
			</c:if>
				${boardNotice.txt}
		</td>
	</tr>
</table>
<form action="${initParam.rootPath}/boardnotice/boardNoticeUploadView.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" id="id" value="${boardNotice.id}">
	<button>수정하기</button>
	<sec:csrfInput/>
</form>

<form action="${initParam.rootPath}/boardnotice/boardNoticRemove.do" method="post">
	<input type="hidden" name="id" value="${boardNotice.id}">
	<input type="submit" value="삭제하기" onclick="return delete_event();">
	<sec:csrfInput/>
</form>

<form action="${initParam.rootPath}/boardnotice/boardNoticeList.do" method="post">
	<input type="submit" value="뒤로가기"/>
	<sec:csrfInput/>
</form>

</body>
</html>