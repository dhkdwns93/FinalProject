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
				"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/request.do",
				"type":"post",
				"data":{'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json",
				"success": function(list){
		        	$("#requestTable>tbody").empty();
			        $.each(list, function(index){
			        	
			        	var i = index+1;
			        	console.log(this.processNo+","+i);
			        	 $("#requestTable>tbody").append($("<tr>").append($("<td>").append(this.processNo))
												 .append($("<td>").append(this.processFridgerId))
												 .append($("<td>").append(this.processState))
												 .append($("<td>").append(this.reqDate))
												 .append($("<td>").append(this.respDate))
												 .append($("<td>").append(this.reqMemberId))
												 .append($("<td>").append(this.respMemberId))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id", "cancelBtn").append("요청취소"))));
 
	        });	// end of each        
		}
	});
	
	
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/response.do",
			"type":"post",
			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success": function(list){
	        	$("#responseTable>tbody").empty();
		        $.each(list, function(index){
		        	var i = index+1;
		        	console.log(this.processNo+","+i);
		        	 $("#responseTable>tbody").append($("<tr>").append($("<td>").append(this.processNo))
											 .append($("<td>").append(this.processFridgerId))
											 .append($("<td>").append(this.processState))
											 .append($("<td>").append(this.reqDate))
											 .append($("<td>").append(this.respDate))
											 .append($("<td>").append(this.reqMemberId))
											 .append($("<td>").append(this.respMemberId))
											 .append($("<td>").append($("<button>").prop("type","button").prop("id", "acceptBtn").prop("value",this.processNo).append("승인"))
													 		  .append($("<button>").prop("type","button").prop("id", "rejectBtn").prop("value",this.processNo).append("거절"))));
		        	
		        if(this.processState == 11 || this.processState == 21){
		        	 $("#responseTable>tbody>tr:nth-child("+i+")").children(":last-child").html("승인함");
		        }else if(this.processState == 12 || this.processState == 22){
		        	 $("#responseTable>tbody>tr:nth-child("+i+")").children(":last-child").html("거절함");
		        }

		        });	// end of each
			}
		});
	
	$(document).on("click", "#cancelBtn", function(){
		//alert($(this).parent().parent().children(":first-child").text());

		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/cancel.do",
			"type":"post",
			"data":{'processNo' : $(this).parent().parent().children(":first-child").text(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("취소 하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(txt){
		       alert(txt);
		       window.location.reload();
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});
	
	
	$(document).on("click", "#acceptBtn", function(){
		console.log($(this).parent().parent().children(":first-child").text());
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/accept.do",
			"type":"post",
			"data":{'processNo' : $(this).parent().parent().children(":first-child").text(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("승인하시겠습니까?") != true){
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
	
	$(document).on("click", "#rejectBtn", function(){
		console.log($(this).parent().parent().children(":first-child").text());
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/reject.do",
			"type":"post",
			"data":{'processNo' : $(this).parent().parent().children(":first-child").text(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("거절하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(txt){
		       alert(txt);
		       window.location.reload();
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});
	
});
</script>
<body>
<p>
<div id="buttons">
	<button type="button" id="requestListBtn">요청 리스트</button>
	<button type="button" id="responseListBtn">응답 리스트</button>
</div>
<hr>
	<div style="width:1000px;">
		<table id="requestTable" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:30%;">냉장고명</th>
					<th style="width:15%;">처리상태</th>
					<th style="width:10%;">최초요청일</th>
					<th style="width:10%;">승인응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:10%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>
	
	
	<div style="width:1000px;">
		<table id="responseTable" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:30%;">냉장고명</th>
					<th style="width:15%;">처리상태</th>
					<th style="width:10%;">최초요청일</th>
					<th style="width:10%;">승인응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:10%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>
	
</body>
</html>