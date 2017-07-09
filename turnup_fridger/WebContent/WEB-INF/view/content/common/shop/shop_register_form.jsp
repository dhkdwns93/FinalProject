<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery-3.2.1.min.js"></script>
<style type="text/css">
table{
	text-align: center;
	 margin:auto;
	 align: center;
}
input{
	border:none;
	border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
</style>
<script type="text/javascript">
	// 등록한 이미지 미리보기
	$(function() {
		$("#shopImg").on('change', function() {
			readURL(this);
		});
	});

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#blah').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
</head>
<body>
<form action="${initParam.rootPath}/shop/addShop.do" method="post" enctype="multipart/form-data">

<table border="1" style="border-collapse:collapse; text-align:center;" width="200">

	<tr>
		<td rowspan="3"><img id="blah" src="#" alt="shop Image" width="100" height="102"></td>
		<td colspan="2"><input type="file" id="shopImg" name="upImage"></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><input type="text" name="shopName" placeholder="shop name">
			<span class="error"><form:errors path="shop.shopName" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<td>url</td>
		<td><input type="url" name="shopAddress" placeholder="shop url">
			<span class="error"><form:errors path="shop.shopAddress" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<td colspan="3"><input type="submit" value="등록"></td>
	</tr>
</table>
<sec:csrfInput />
</form>
</body>
</html>