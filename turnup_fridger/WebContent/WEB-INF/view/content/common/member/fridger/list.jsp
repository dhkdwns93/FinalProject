<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

 <script type="text/javascript">
$(document).ready(function () {
	//냉장고목록검색 페이지 디폴트는 전체 목록번호순으로 
	$.ajax({
		"url":"/turnup_fridger/common/member/fridger/show/list.do",
        "dataType": "json",
        "success": function(list){
        	$("tbody").empty();
	        $.each(list, function(){
	        	 $("tbody").append($("<tr>").append($("<td>").append(this.fridgerId))
										 .append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
										 .append($("<td>").append(this.memberId))
										 .append($("<td>").append($("<button>").prop("type","button").prop("id","requestBtn").prop("value",this.fridgerId).append("가입")))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정"))))
												 .append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));
        				
	        });	// end of each
	      
		}
	}); //end of ajax
	
	
	$("#searchByIdBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/byId.do",
			"type" : "post",
			"data" : {'fridgerId' : $("input#fridgerId").val(), '${_csrf.parameterName}':'${_csrf.token}'},
	        "dataType": "json",
	        "beforeSend":function(){	
				if(!$("input#fridgerId").val()){
					alert("조회할 냉장고ID를 입력하세요");
					return false;
				}
			},
	        "success": function(fridger){
	        	$("tbody").empty();
	        	 $("tbody").append($("<tr>").append($("<td>").append(fridger.fridgerId))
						 				.append($("<td>").prop("class","fridgerName_col").append(fridger.fridgerName))
						 				.append($("<td>").append(fridger.memberId))
						 				.append($("<td>").append($("<button>").prop("type","button").prop("id","requestBtn").prop("value",this.fridgerId).append("JOIN")))
										 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정"))))
												 .append($("<tr>").prop("class","collapse out").prop("id", "info"+ fridger.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));

	        },
	        "error":function(xhr, msg, code){
				//매개변수 : 1. XMLHttpRequest, 2.응답메세지(success/error), 3. HTTP응답 메세지(모두)
			alert("오류발생-" +msg+ ":" +code);
			}
		});	//end of ajax
	}); //end of click on searchById
	
	
	$("#searchByNameBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/byName.do",
			"type" : "post",
			"data" : {'fridgerName' : $("input#fridgerName").val(), '${_csrf.parameterName}':'${_csrf.token}'},

	        "dataType": "json",
	        "beforeSend":function(){	
				if(!$("input#fridgerName").val()){
					alert("조회할 냉장고이름를 입력하세요");
					return false;
				}
			},
	        "success": function(list){

		        $("tbody").empty();
		        $.each(list, function(){
		        	 $("tbody").append($("<tr>").append($("<td>").append(this.fridgerId))
												 .append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
												 .append($("<td>").append(this.memberId))
												.append($("<td>").append($("<button>").prop("type","button").prop("id","requestBtn").prop("value",this.fridgerId).append("JOIN"))) 
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정"))))
												 .append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));
		        });	// end of each
	        },
	        "error":function(xhr, msg, code){
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}); //end of click on searchByName
	
	
	$(".searchByOwnerBtn").on("click", function(){
		var memberId = $(this).parent().children("input#memberId").val();
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/byOwner.do",
			/* "type" : "post", */
			"data" : {'memberId' :  memberId,  '${_csrf.parameterName}':'${_csrf.token}'},
	        "dataType": "json",
	        "beforeSend":function(){	
	        	
				if(memberId===''){
					alert("조회할 회원ID를 입력하세요");
					return false;
				}
			},
	        "success": function(list){
	
		        $("tbody").empty();
		        $.each(list, function(){
		        	 $("tbody").append($("<tr>").append($("<td>").append(this.fridgerId))
												 .append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
												 .append($("<td>").append(this.memberId))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","requestBtn").prop("value",this.fridgerId).append("JOIN")))										
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정"))))
								.append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));
						
		        });	// end of each
	        },
	        "error":function(xhr, msg, code){
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}); //end of click on searchByOwnerBtn
	
	
	
	/*냉장고명 클릭시 냉장고 공유 멤버 보여주기*/
	 $(document).on("click",".fridgerName_col",function(){
		
		$(".fridgerName_col").parent().css("background-color", "white");
		$(this).parent().css("background-color", "lightblue");
		//한번에 여러개 냉장고 정보 열어서 비교가능함
		//$(".fridgerName_col").next().addClass("out").removeClass("in");

		if($(this).parent().next().hasClass("out")) {
			$(".fridgerName_col").parent().next().addClass("out").removeClass("in");
	    	$(this).parent().next().addClass("in");
	    	$(this).parent().next().removeClass("out");
	    } else {
	    	$(".fridgerName_col").parent().next().addClass("out").removeClass("in");
	    	$(this).parent().next().addClass("out");
	    	$(this).parent().next().removeClass("in");
	    }
		
	    var fridgerId = $(this).parent().children(":first-child").text();
		var ownerId = $(this).parent().children(":nth-child(3)").text();
	    //alert(ownerId);
	    
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/detail.do",
			"type":"post",
			"data" : {'fridgerId' : fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
	        "dataType": "json",
	        "success": function(list){
	        	$("#info"+fridgerId).children(":first-child").empty();
	        	var txt = "";
		        $.each(list, function(){
		        	if(this.groupMemberId == ownerId){
		        		txt += this.groupMemberId+"(주인)<br>";
		        	}else{
		        		txt += this.groupMemberId+"<br>";
		        	}
		        	
		        });	// end of each
		        $("#info"+fridgerId).children(":first-child").html("[이 냉장고를 공유하고 있는 회원목록]<br>"+txt);
	        },
	        "error":function(xhr, msg, code){
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}) // end of click on fridgerName_col
	
	
	// 냉장고 가입신청 
	$(document).on("click","#requestBtn", function(){
		alert($(this).parent().parent().children(":nth-child(3)").text());
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
			},
			"success": function(txt){
		       alert(txt);
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});	// end of click on requstBtn
	
	// 냉장고 수정
	$(document).on("click","#updateBtn", function(){
		alert($(this).val());
		window.open(
				"${ initParam.rootPath }/common/member/fridger/update_chk.do?fridgerId="+$(this).val(),
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
		
	});	// end of click on requstBtn
});
 </script>

<h3>조회</h3>
	<div id="search">
	냉장고ID로 조회
		<span><input type="text" name="fridgerId" id="fridgerId">
		<!-- <input type="button" value="조회" id="searchByIdBtn"> -->
		<button type="button" class="btn btn-default" id="searchByIdBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
    	</span>
		<br>
		
	냉장고 이름으로 조회
		<span><input type="text" name="fridgerName" id="fridgerName">
		<!-- <input type="button" value="조회" id="searchByNameBtn"> -->
		<button type="button" class="btn btn-default" id="searchByNameBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
    	</span>
		<br>
		
	냉장고 주인으로 조회
	<sec:authentication property="principal.memberId" var="memberId"/>
		<span><input type="text" name="memberId" id="memberId" placeholder="현재회원 : ${ memberId }">
		<!-- <input type="button" value="조회" id="searchByOwnerBtn"> -->
	    <button type="button" class="btn btn-default searchByOwnerBtn" id="searchByOwnerBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
    	</span>
    	
		<br>
		<sec:authentication property="principal.memberId" var="memberId"/>
		내 냉장고 조회 : ${ memberId }
		<span><input type="hidden" name="memberId" id="memberId" value="${ memberId }">
	    <button type="button" class="btn btn-default searchByOwnerBtn" id="searchByOwnerBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
    	</span>
    	
		<br>
	</div>
<hr>
<a href="${initParam.rootPath}/common/member/fridger/register_form2.do"><button type="button">냉장고등록</button></a>

<a href="${initParam.rootPath}/common/member/fridger/invite_form.do"><button type="button">초대하러가기</button></a>


	<div id="table" style="width:800px;">
		<table id="fridgerList" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:50%;">냉장고명</th>
					<th style="width:15%;">냉장고주인</th>
					<th style="width:10%;">가입</th>
					<th style="width:10%;">변경</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>