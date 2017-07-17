<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	console.log(window.opener.location);	
	window.opener.location.reload;
	self.close();
});
</script>

</head>
<body>
등록성공! 

<a href = "/turnup_fridger/common/admin/irdntManage/irdntList.do"><button>전체목록보기</button></a>

</body>
</html>