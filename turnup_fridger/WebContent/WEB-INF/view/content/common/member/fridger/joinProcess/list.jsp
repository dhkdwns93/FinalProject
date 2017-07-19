<%@ page contentType="text/html;charset=UTF-8"%>

<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<%-- <link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet"> --%>
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
 <script type="text/javascript">
$(document).ready(function (){
	getRequestList();
	getResponseList();
	
	
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
		       window.location.reload();
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
	
	// 냉장고 그룹 초대 폼
	$(document).on("click","#inviteModalBtn", function(){
		$("#inviteFridgerModal").modal("show");
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/mine.do",
			"type":"post",
			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType": "json",
		    "success": function(list){
		        	$("#inviteFridgerList").empty();
			        $.each(list, function(){
			        	$("#inviteFridgerList").append($("<option>").prop("value",this.fridgerId).text(this.fridgerName));
			        });	// end of each
		     },
		    "error":function(xhr, msg, code){
					alert("오류발생-" + code);
			}
		}); //end of ajax
	});	// end of click on requstBtn
	
	// 냉장고 그룹 초대 처리
	$(document).on("click", "#inviteFormBtn",function(){

		 var formData = $("#inviteForm").serializeArray();
		console.log(formData)
		$.ajax({
			"url": "${initParam.rootPath }/common/member/fridger/invite.do",
			"type": "post",
			"data": formData,
			"dataType":"text",
			"beforeSend":function(){
				console.log($(".errorWell").find(".error"));
				$(".errorWell").find(".error").empty();
				$(".errorWell").hide();
			},
			"success": function(text){
				if(text == "0"){
					//alert("완료!")
					$("#inviteFridgerModal").modal("hide");
					$(".errorWell").find(".error").empty();
					$(".errorWell").hide();
					resetInviteModal();
					window.location.reload();
				
				}else{
					alert("실패!")
					$(".errorWell").find(".error").append(text);
					$(".errorWell").show();
					//회색차유ㅠ
				}
			}
		})
	})
	
	
	
	
	
	// 냉장고 그룹 가입 폼
	$(document).on("click","#joinModalBtn", function(){
		$("#joinFridgerModal").modal("show");
		
		
	});	// end of click on requstBtn
	
	// 냉장고 그룹 가입 처리
	$(document).on("click","#joinBtn", function(){
		 var formData = $("#inviteForm").serializeArray();
			console.log(formData)
			$.ajax({
				"url": "${initParam.rootPath }/common/member/fridger/invite.do",
				"type": "post",
				"data": formData,
				"dataType":"text",
				"beforeSend":function(){
					console.log($(".errorWell").find(".error"));
					$(".errorWell").find(".error").empty();
					$(".errorWell").hide();
				},
				"success": function(text){
					if(text == "0"){
						//alert("완료!")
						$("#joinFridgerModal").modal("hide");
						$(".errorWell").find(".error").empty();
						$(".errorWell").hide();
						resetJoinModal();
						window.location.reload();
					
					}else{
						alert("실패!")
						$(".errorWell").find(".error").append(text);
						$(".errorWell").show();
						//회색차유ㅠ
					}
				}
			})
		
	});	// end of click on requstBtn
		
	
		
	

	$('#inviteFridgerModal').on('hide.bs.modal', function (e) {
		resetInviteModal();
	})
	
	$('#requestFridgerModal').on('hide.bs.modal', function (e) {
		resetRequestModal();
	})
			
	
});


function resetInviteModal(){
	document.getElementById("inviteForm").reset();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}
function resetJoinModal(){
	document.getElementById("joinFridgerModal").reset();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}

function getRequestList(){
	$.ajax({
				"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/request.do",
				"type":"post",
				"data":{'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json",
				"success": function(list){
		        	$("#requestTable>tbody").empty();
			        $.each(list, function(index){
			        	var processStateStr ="";
			        	var i = index+1;
			        	/* console.log(this.processNo+","+i); */
				        	/*처리상태: 10-가입승인대기,11-가입승인완료, 12-가입승인거절,20-초대승인대기,21-초대승인완료, 22-초대승인거절*/
			        	if(this.processState == 10){
			        		processStateStr = "가입승인대기";
			        	}else if(this.processState == 11){
			        		processStateStr = "가입승인완료";
			        	}else if(this.processState == 12){
			        		processStateStr = "가입승인거절";
			        	}else if(this.processState == 20){
			        		processStateStr = "초대승인대기";
			        	}else if(this.processState == 21){
			        		processStateStr = "초대승인완료";
			        	}else if(this.processState == 22){
			        		processStateStr = "초대승인거절";
			        	}		        	

			        	
			        	$("#requestTable>tbody").append($("<tr>").append($("<td>").append(this.processNo))
												 .append($("<td>").append(this.fridger.fridgerName))
												 .append($("<td>").append(processStateStr))
												 .append($("<td>").append(getTimeStamp(this.reqDate)))
												 .append($("<td>").append((this.respDate == null ? "":getTimeStamp(this.respDate))))
												 .append($("<td>").append(this.reqMemberId))
												 .append($("<td>").append(this.respMemberId))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id", "cancelBtn").prop("class","btn btn-default").append("요청취소"))));
 
	        });	// end of each        
		}
	});
}	
	
	
function getResponseList(){
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/response.do",
			"type":"post",
			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success": function(list){
	        	$("#responseTable>tbody").empty();
		        $.each(list, function(index){
		        	var i = index+1;
		        	var processStateStr ="";
		        	/* console.log(this.processNo+","+i); */
		        	console.log(this.processState);
		        	
		        	if(this.processState == 10){
		        		processStateStr = "가입승인대기";
		        	}else if(this.processState == 11){
		        		processStateStr = "가입승인완료";
		        	}else if(this.processState == 12){
		        		processStateStr = "가입승인거절";
		        	}else if(this.processState == 20){
		        		processStateStr = "초대승인대기";
		        	}else if(this.processState == 21){
		        		processStateStr = "초대승인완료";
		        	}else if(this.processState == 22){
		        		processStateStr = "초대승인거절";
		        	}		        	
		        	
		        
		        	 $("#responseTable>tbody").append($("<tr>").append($("<td>").append(this.processNo))
											 .append($("<td>").append(this.fridger.fridgerName))
											 .append($("<td>").append(processStateStr))
											 .append($("<td>").append(getTimeStamp(this.reqDate)))
											 .append($("<td>").append((this.respDate == null ? "":getTimeStamp(this.respDate))))
											 .append($("<td>").append(this.reqMemberId))
											 .append($("<td>").append(this.respMemberId))
											 .append($("<td>").append($("<button>").prop("type","button").prop("id", "acceptBtn").prop("class","btn btn-warning").prop("value",this.processNo).append("승인"))
													 		  .append($("<button>").prop("type","button").prop("id", "rejectBtn").prop("class","btn btn-default").prop("value",this.processNo).append("거절"))));
		        	 	 
		        if(this.processState == 11 || this.processState == 21){
		        	 $("#responseTable>tbody>tr:nth-child("+i+")").children(":last-child").html("승인함");
		        }else if(this.processState == 12 || this.processState == 22){
		        	 $("#responseTable>tbody>tr:nth-child("+i+")").children(":last-child").html("거절함");
		        }

		        });	// end of each
			}
		});
		
		
}


/*  날짜포맷변환  */
function getTimeStamp(millis) {
  var d = new Date(millis);
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}

</script>

<style>
.errorWell{
display: none;
}

</style>



<div>
<!-- 가입펌 -->
<jsp:include page="/WEB-INF/view/content/common/member/fridger/list.jsp"/>
<!-- 초대폼 -->
<jsp:include page="/WEB-INF/view/content/common/member/fridger/invite_form.jsp"/>

</div>

<div class="container">

<h1> 공유 관리</h1>

가족 구성원끼리 냉장고를 공유하여 관리하세요. 더욱 효율적으로 냉장고를 관리할 수 있을 것입니다.

<button type="button" class="btn btn-warning" id="inviteModalBtn" style="background-color:#f7c42d; color:#ffffff; width:70px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">INVITE</button>
<button type="button" class="btn btn-default" id="joinModalBtn" style="background-color:#ccccb3; color:white; border:5px; border-color:#999966; width:70px; margin: 2px; text-shadow:none;  font-weight: bold">JOIN</button>
<br>
<p>
<div role="tabpanel" style="padding-top: 30px;">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#requestTab" aria-controls="home" role="tab" data-toggle="tab">REQUEST</a></li>
    <li role="presentation"><a href="#responseTab" aria-controls="profile" role="tab" data-toggle="tab">RESPONSE</a></li>
   </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="requestTab" align="center">
    <div class="container">
		<div style="width:1000px;" >
		<table id="requestTable" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:20%;">냉장고명</th>
					<th style="width:10%;">처리상태</th>
					<th style="width:10%;">최초요청일</th>
					<th style="width:10%;">승인응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:25%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
		</div>
	</div>
	</div>
    
    
    <div role="tabpanel" class="tab-pane" id="responseTab" align="center">
    	<div style="width:1000px;">
		<table id="responseTable" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:20%;">냉장고명</th>
					<th style="width:10%;">처리상태</th>
					<th style="width:10%;">최초요청일</th>
					<th style="width:10%;">승인응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:25%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
		</div>
    </div>
    </div>
    
    
</div>
	</div>
	</div>