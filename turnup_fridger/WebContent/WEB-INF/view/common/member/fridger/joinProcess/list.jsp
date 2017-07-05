<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

 <script type="text/javascript">
$(document).ready(function (){
	$.ajax({
		"url":"/turnup_fridger/common/member/fridger/joinProcess/list/request.do",
		"dataType":"json",
		"success": function(list){
        	$("tbody").empty();
	        $.each(list, function(){
	        	
	        	
	        	 $("tbody").append($("<tr>").append($("<td>").append(this.processNo))
										 .append($("<td>").append(this.processFridgerId))
										 .append($("<td>").append(this.processState))
										 .append($("<td>").append(this.reqDate))
										 .append($("<td>").append(this.respDate))
										 .append($("<td>").append(this.reqMemberId))
										 .append($("<td>").append(this.respMemberId)));
        				
	        	 if(this.processState == 10 || this.processState == 20){
	        		 $("tbody").children(":last-child").append($("<td>").append($("<button>").prop("type","button").prop("id","cancelBtn").prop("value",this.fridgerId).append("취소")));
		        }  	 
	        });	// end of each
		}
	});
	
	$(document).on("click", "#cancelBtn" function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/cancel.do",
			"type":"post",
			"data":{'processNo' : $(this).parent().parent().children(":first-child").text(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("취소하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(txt){
		       alert(txt);
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});
});
</script>
<body>
	<div id="table" style="width:900px;">
		<table id="joinProcessList" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:30%;">냉장고명</th>
					<th style="width:20%;">처리상태</th>
					<th style="width:10%;">최초요청일</th>
					<th style="width:10%;">승인응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:5%;">취소</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>
</body>
</html>