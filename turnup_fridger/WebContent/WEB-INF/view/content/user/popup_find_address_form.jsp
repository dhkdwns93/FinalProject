<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)popup_find_address_form
작성자 :  김경혜
최초 작성일 170711
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript" src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">
/* $(function(){
	$("button#useAddressAPIBtn").postcodifyPopUp();
}); */
$(document).ready(function(){
	$(function(){
			$("button#useAddressAPIBtn").postcodifyPopUp();
	});//end of useAddressAPIBtn 
	
	$("button#useAddressBtn").on("click",function(){
		var inputAddress=$(this).parent().children(":first-child").val();
		if(confirm(inputAddress+"를 입력하시겠습니까?")==true){
			opener.document.usePopup.memberAddress.value=inputAddress;
			window.close();
		}else{
			return false;
		}
	});//end of useAddressBtn
});
</script>
</head>
<body> 
<h2>주소검색</h2>
	<div id="postcodify">
		<button type="button" id="useAddressAPIBtn">주소검색</button>
		<br>
		<div id="resultSearch">
			<div class="form-group">
				우편번호 <input type="text" name="" class="postcodify_postcode" value="" readonly="readonly">
			</div>
			<div class="form-group">
				도로명주소 <input type="text" id="inputAddress" name="inputAddress" class="postcodify_address" value=""
					style="width: 300px" readonly="readonly">
				<button type="button" id="useAddressBtn">도로명주소입력</button>
			</div>
			<div class="form-group">
				지번주소 <input type="text" id="inputAddress" name="inputAddress" class="postcodify_jibeon_address"
					value="" style="width: 300px" readonly="readonly">
				<button type="button" id="useAddressBtn">지번주소입력</button>
			</div>
		</div>
		<hr>
	<button type="button" onclick="self.close()">닫기</button>
	</div>

</body>
</html>