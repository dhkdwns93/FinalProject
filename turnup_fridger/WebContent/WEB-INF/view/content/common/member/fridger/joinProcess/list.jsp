<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<%-- <link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet"> --%>
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
 <script type="text/javascript">
$(document).ready(function (){
	getIntro();
	
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
		       //alert(txt);
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
		       	
		       	$(this).text("승인완료");
		       	getRequestList();
				getResponseList();
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
				$(this).text("거절완료");
		   		getRequestList();
				getResponseList();
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
					alert("초대신청이 완료되었습니다.")
					$("#inviteFridgerModal").modal("hide");
					$(".errorWell").find(".error").empty();
					$(".errorWell").hide();
					resetInviteModal();
					getRequestList();
					getResponseList();
				
				}else{
					$(".errorWell").find(".error").text(text);
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
	// 냉장고 가입신청 
	$(document).on("click","#joinBtn", function(){
		//alert($(this).parent().parent().children(":nth-child(3)").text());
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/request.do",
			"type":"post",
			"data":{'processFridgerId' : $(this).val(),
					'processState':10,
					'respMemberId': $(this).parent().parent().children(":nth-child(3)").text(),
					'${_csrf.parameterName}':'${_csrf.token}'
					},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("가입신청하시겠습니까?") != true){
					return false;
				}
				console.log($(".errorWell").find(".error"));
				$(".errorWell").find(".error").empty();
				$(".errorWell").hide();
			},
			"success": function(text){
				if(text == "0"){
					alert("가입신청이 완료되었습니다.")
					$("#joinFridgerModal").modal("hide");
					$(".errorWell").find(".error").empty();
					$(".errorWell").hide();
					resetJoinModal();
					getRequestList();
					getResponseList();
					
				}else{
					$(".errorWell").find(".error").text(text);
					$(".errorWell").show();
					//회색차유ㅠ
				}
			}
			
		});	//end of ajax
	});	// end of click on joinBtn
		
	
		
	
	$('#inviteFridgerModal').on('hide.bs.modal', function (e) {
		resetInviteModal();
		
	})
	
	$('#joinFridgerModal').on('hide.bs.modal', function (e) {
		resetJoinModal();
		
		
	})
			
	
});


function resetInviteModal(){
	document.getElementById("inviteForm").reset();
	$("#fridgerList_tbody").empty();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}

function resetJoinModal(){
	document.getElementById("joinForm").reset();
	$("#fridgerList_tbody").empty();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}


function getIntro(){
	$.ajax({
		"url":"/turnup_fridger/common/member/fridger/joinProcess/intro.do",
		"dataType":"json",
		"success": function(map){
			 showCount(map.allFridgerCount, map.allFridgerGroupCount);
        	    
		}
	});
}

function showCount(allFridgerCount, allFridgerGroupCount){
    
    var countFridger = 0;
    var countFridgerGroup = 0;
    var id = setInterval(frame, 10);
    function frame() {
        if (countFridger >= allFridgerCount) {
            clearInterval(id);
        } else {
        	countFridger++; 
            $("#allFridgerCount").text(countFridger);
    	          
        }
        
        if (countFridgerGroup >= allFridgerGroupCount) {
            clearInterval(id);
        } else {
        	countFridgerGroup++; 
            $("#allFridgerGroupCount").text(countFridgerGroup);    
        }
    }
}


function getRequestList(){
	$("#listHeader").hide();
	$("#listTable").hide();
	$("#listTable").fadeIn();
	
	$.ajax({
				"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/request.do",
				"type":"post",
				"data":{'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json",
				"success": function(list){
		        	$("tbody").empty();
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

			        	
			        	$("tbody").append($("<tr>").append($("<td>").append(this.processNo))
												 .append($("<td>").append(this.fridger.fridgerName))
												 .append($("<td>").append(processStateStr))
												 .append($("<td>").append(getTimeStamp(this.reqDate)))
												 .append($("<td>").append((this.respDate == null ? "":getTimeStamp(this.respDate))))
												 .append($("<td>").append(this.reqMemberId))
												 .append($("<td>").append(this.respMemberId))
												 );
 						if(this.respDate != null){

 							$("tbody").children(":last-child").append($("<td>").append("완료됨"));
 						}else{
 							$("tbody").children(":last-child").append($("<td>").append($("<button>").prop("type","button").prop("id", "cancelBtn").prop("class","btn btn-default").append("요청취소")));
 						}
			 
 						
	        });	// end of each        
		}
	});
}	
	
	
function getResponseList(){
	$("#listHeader").hide();
	$("#listTable").hide();
	$("#listTable").fadeIn();
	
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/joinProcess/show/list/response.do",
			"type":"post",
			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success": function(list){
	        	$("tbody").empty();
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
		        	
		        
		        	 $("tbody").append($("<tr>").append($("<td>").append(this.processNo))
											 .append($("<td>").append(this.fridger.fridgerName))
											 .append($("<td>").append(processStateStr))
											 .append($("<td>").append(getTimeStamp(this.reqDate)))
											 .append($("<td>").append((this.respDate == null ? "":getTimeStamp(this.respDate))))
											 .append($("<td>").append(this.reqMemberId))
											 .append($("<td>").append(this.respMemberId))
											 .append($("<td>").append($("<button>").prop("type","button").prop("id", "acceptBtn").prop("class","btn btn-warning").prop("value",this.processNo).append("승인"))
													 		  .append($("<button>").prop("type","button").prop("id", "rejectBtn").prop("class","btn btn-default").prop("value",this.processNo).append("거절"))));
		        	 	 
		        if(this.processState == 11 || this.processState == 21){
		        	 $("tbody>tr:nth-child("+i+")").children(":last-child").html("승인함");
		        }else if(this.processState == 12 || this.processState == 22){
		        	 $("tbody>tr:nth-child("+i+")").children(":last-child").html("거절함");
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

#listTable{
display: none;
}

.errorWell{
display: none;
}

button{
margin-left: 2px;
margin-right: 2px;
}

</style>


<div>
<!-- 가입펌 -->
<jsp:include page="/WEB-INF/view/content/common/member/fridger/join_form.jsp"/>
<!-- 초대폼 -->
<jsp:include page="/WEB-INF/view/content/common/member/fridger/invite_form.jsp"/>

</div>
	
<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/fridgerSideMenu.jsp"/>
<div class='right-box-sidemenu'>

<div class='inner-page' style="margin-top: 60px">

<div id="listHeader" style="position: relative" align="center">

<!-- 지금,<span style="font-size: 35px">Turnup Fridger</span>에서는  <br> -->
 <img src="/turnup_fridger/images/logo-letter2.png">에서 <br> 
지금까지 <span id="allFridgerCount" style="font-size: 35px"><!-- 냉장고 수 --></span>개의 냉장고를<br>
<span id="allFridgerGroupCount" style="font-size: 35px"><!-- 냉장고 수 --></span>명의 회원이 공유하고 있습니다.<br>
<br>
<hr>
<br>
가족 구성원끼리 냉장고를 공유하여 관리하세요. <br>
더욱 효율적으로 냉장고를 관리할 수 있을 것입니다.


<div id="inviteModal" style="position: absolute; border:1px solid lightgray; border-radius:5px; padding:20px; width:300px; height:220px; top:320px; left:35px; text-align: center;">
	<h3 style="font-weight: bold;">냉장고로 초대하기</h3>
	당신의 냉장고를 공유할 <br>
	회원을 초대합니다. <br>
	<br>
	<button type="button" class="btn btn-warning" id="inviteModalBtn" style="background-color:#f7c42d; color:#ffffff; width:70px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">INVITE</button>
</div>
<div id="joinModal" style="position: absolute; border:1px solid lightgray; border-radius:5px; padding:20px; width:300px; height:220px; top:320px; right:35px; text-align: center;">
	<h3 style="font-weight: bold;">냉장고에 가입하기</h3>
	공유를 원하는 다른 회원의 <br>
	냉장고에 가입합니다.<br>
	<br>
	<button type="button" class="btn btn-default" id="joinModalBtn" style="background-color:#ccccb3; color:white; border:5px; border-color:#999966; width:70px; margin: 2px; text-shadow:none;  font-weight: bold">JOIN</button>
</div>
</div>


<p>

  <!-- table -->
   	<div id="listTable" style="width:850px;">
 		<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:18%;">냉장고명</th>
					<th style="width:12%;">처리상태</th>
					<th style="width:12%;">요청일</th>
					<th style="width:12%;">응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:21%;">처리</th>
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
