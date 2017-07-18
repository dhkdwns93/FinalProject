<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_find_irdnt_form
작성자 :  김경혜
최초 작성일 170707
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Turnup-fridger Add-DislikeIngredient</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"${initParam.rootPath}/findIrdntByName.do",
			"type":"POST",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#tbody").empty();
				$.each(list, function(idx){
					$("#tbody").append($("<tr>").prop("id","irdnt_col")
					.append($("<td class='table-text'>").append("<input type='hidden' id='irdntId' name='irdntId' value="+this.irdntId+">"+(idx+1)))
					.append($("<td class='table-text'>").append("<input type='hidden' id='irdntName2' name='irdntName2' value="+this.irdntName+">"+(this.irdntName)))
					.append($("<td class='table-text'>").append(this.irdntCategory))
					.append($("<td class='table-text'>").append("<button type='button' id='selectIrdntBtn' value='d' class='ccbtn'><i class='glyphicon glyphicon-plus'>재료추가</i></button>")));
				 });//end of each
			}//success
		});//end of ajax
	});//end of searhBtn
	
	$("tbody#tbody").on("click","button#selectIrdntBtn",function(){
		var irdntId=$(this).parent().parent().children(":first-child").children().val();
		var irdntName=$(this).parent().parent().children(":nth-child(2)").children().val();
		
		//form name= usePopup로 보내는거야
		//myDislikeIrdntId
		if(!opener.document.usePopup.myDislikeIrdntId.length){
			opener.document.usePopup.myDislikeIrdntId.value=irdntId;
		}else{
			opener.document.usePopup.myDislikeIrdntId[0].value=irdntId;
		}
		//myDislikeIrdntName
		if(!opener.document.usePopup.myDislikeIrdntName.length){
			opener.document.usePopup.myDislikeIrdntName.value=irdntName;
		}else{
			opener.document.usePopup.myDislikeIrdntName[0].value=irdntName;
		}
		
		window.close();
	});//end of selectIrdntBtn
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

/* 테이블 text */
.table-text{
	padding-top:1px;
	padding-bottom:1px;
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
	color: #4d4d4d;
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
</style>
</head>
<body>

	<div class="container">

		<div class="popup-body">
			<h1 class="modal-title font-Viner_Hand_ITC">Add Dislike Ingredient</h1>
			<hr>
			<div class="ccfield-prepend">
				<span><label for="name" class="form-text">재료명</label></span>
				<input type="text" name ="irdntName" id="irdntName" class="ccformfield" placeholder="등록을 원하시는 재료명을 입력해주세요.">
				<button type="button" id="searchBtn"class="ccbtn"><span class="glyphicon glyphicon-ok" aria-hidden="true"> Search</span></button><br><br>
			</div>
				<div id="result" class="ccfield-prepend">
					<table style="border:1 solid #808080; width:500px">
						<thead>
							<tr>
								<th class="table-text"><span class="form-text">번호</span></th>
								<th class="table-text"><span class="form-text">재료명</span></th>
								<th class="table-text"><span class="form-text">카테고리</span></th>
								<th class="table-text"><span class="form-text">추가</span></th>
							</tr>	
						</thead>
						<tbody id="tbody"></tbody>
					</table>
				</div>
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