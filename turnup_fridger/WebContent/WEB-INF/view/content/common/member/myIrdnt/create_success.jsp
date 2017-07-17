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


<h2>등록성공!</h2>

</body>
</html>