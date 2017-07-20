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
<title>Turnup-fridger Search-Address</title>

<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- confirm창 js -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js"></script>
<script src="https://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.6.0.js" type="text/javascript"></script>
<script src="https://m-e-conroy.github.io/angular-dialog-service/javascripts/dialogs.min.js" type="text/javascript"></script>

<script type="text/javascript" src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$(function(){
			$("button#useAddressAPIBtn").postcodifyPopUp();
	});//end of useAddressAPIBtn 

	$("button#useAddressBtn").on("click",function(){
		var inputAddress=$(this).parent().children(":nth-child(3)").val();
		if(confirm(inputAddress+"를 입력하시겠습니까?")==true){
			opener.document.usePopup.memberAddress.value=inputAddress;
			window.close();
		}else{
			return false;
		}
	});//end of useAddressBtn


});
</script>
<style>
.ccfield-prepend {
	margin-bottom: 20px;
	width: 100%;
}

.ccform-addon {
	color: #bfbfbf;
	float: left;
	padding: 8px;
	width: 8%;
	height: 34px;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	text-align: center;
}

.ccformfield {
	color: #000000;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	padding: 15.5px;
	width: 60%;
	height: 34px;
	font-family: 'Lato', Arial, sans-serif;
	font-size: 14px;
	margin: 0;
}

.ccformfield {
	font-family: 'Lato', Arial, sans-serif;
}

.ccformfield-2 {
	color: #000000;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	padding: 15.5px;
	width: 20%;
	height: 34px;
	font-family: 'Lato', Arial, sans-serif;
	font-size: 14px;
	margin: 0;
}

.ccbtn {
	font-size: 13px;
	border: none;
	background: #a6a6a6;
	height: 28px;
	color: #FFFFFF;
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
}

.ccbtn:hover {
	background: #737373;
}

.ccfield-submit-part {
	text-align: center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	font-weight: bold;
	color: #4d4d4d;
}

.form-text {
	font-size: 14px;
	color: #808080;
}
/* 에러메시지 */
.error-popup {
	font-size: 100% !important;
	color: #808080 !important;
}
/* popup-body 넓이*/
.popup-body {
	width: 100%;
	display: inline-block;
	margin-top: 10%;
	margin-left: auto;
	margin-right: auto;
}
.popup-btn{
 	text-align:center;
}

/* confirm창  */
/* Fix for Bootstrap 3 with Angular UI Bootstrap */

.modal { 
	display: block;
}

/* Custom dialog/modal headers */

.dialog-header-error { background-color: #d2322d; }
.dialog-header-wait { background-color: #428bca; }
.dialog-header-notify { background-color: #eeeeee; }
.dialog-header-confirm { background-color: #333333; }
	.dialog-header-error span, .dialog-header-error h4,
	.dialog-header-wait span, .dialog-header-wait h4,
	.dialog-header-confirm span, .dialog-header-confirm h4 { color: #ffffff; }

/* Ease Display */

.pad { padding: 25px; }
</style>
</head>
<body>

	<div class="container">

		<div class="popup-body">
			<h1 class="modal-title font-Viner_Hand_ITC">Search Address</h1>
			<hr>
				<div id="postcodify">
					<div class="ccfield-prepend">
					<button type="button" id="useAddressAPIBtn" class="ccbtn"><span class="glyphicon glyphicon-search" aria-hidden="true">Click!</span></button>
					</div>
					<div id="resultSearch">
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">우편번호</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE153;</i></span>
							<input type="text" name="" class="postcodify_postcode ccformfield-2" value="" readonly="readonly">
						</div>
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">도로명주소</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE8B4;</i></span>
							<input type="text" id="inputAddress" name="inputAddress" class="postcodify_address ccformfield" value=""
								style="width: 300px" readonly="readonly">
							<button type="button" id="useAddressBtn" class="ccbtn"><span class="glyphicon glyphicon-pencil" aria-hidden="true">Use</span></button>
						</div>
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">지번주소</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE8B4;</i></span>
							<input type="text" id="inputAddress" name="inputAddress" class="postcodify_jibeon_address ccformfield"
								value="" style="width: 300px" readonly="readonly">
							<button type="button" id="useAddressBtn" class="ccbtn"><span class="glyphicon glyphicon-pencil" aria-hidden="true">Use</span></button>
						</div>
					</div>
				</div><!-- postcodify -->
				<div class="popup-btn">
					<hr>
					<button type="button" onclick="self.close()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
						<span class="glyphicon glyphicon-remove" aria-hidden="true">Close</span>
					</button>
				</div>


		</div>
		<!-- popup-body -->
	</div>
	<!-- container -->
</body>
</html>