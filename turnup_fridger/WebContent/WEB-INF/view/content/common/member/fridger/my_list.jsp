<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal.memberId" var="memberId"/>
 
 <script type="text/javascript">
$(document).ready(function () {

	var memberId = ${memberId}
	//냉장고목록검색 페이지 디폴트는 전체 목록번호순으로 
	$.ajax({
		"url":"/turnup_fridger/common/member/fridger/show/byOwner.do",
		"type":"post",
		"data":{'memberId': memberId , '${_csrf.parameterName}':'${_csrf.token}'},
        "dataType": "json",
        "success": function(list){
        	$("tbody").empty();
	        $.each(list, function(){
	        	 $("tbody").append($("<tr>").append($("<td>").append(this.fridgerId))
										 .append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
										 .append($("<td>").append(this.memberId))
										 .append($("<td>").append($("<button>").prop("type","button").prop("id","removeBtn").prop("value",this.fridgerId).append("삭제")))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정")))
												 .append($("<td>").append($("<button>").prop("type","button").prop("id","moveInBtn").prop("value",this.fridgerId).append("열어보기"))))
												 .append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));
        				
	        });	// end of each
	      
		}
	}); //end of ajax
	
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
	
	
	// 냉장고 수정
	$(document).on("click","#updateBtn", function(){
		alert($(this).val());
		window.open(
				"${ initParam.rootPath }/common/member/fridger/update_chk.do?fridgerId="+$(this).val(),
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
		
	});	// end of click on requstBtn
	
	// 냉장고 삭제
	$(document).on("click","#removeBtn", function(){
		alert($(this).val());
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/remove.do",
			"type":"post",
			"data":{'fridgerId' : $(this).val(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("삭제하시겠습니까?") != true){
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
	});	// end of click on requstBtn
	
	
	//
	$(document).on("click", "#moveInBtn", function(){
		window.location.href="${initParam.rootPath}/common/member/myIrdnt/myIrdntList.do?fridgerId="+$(this).val();
	});
	
	
	
	$(document).on("click", "#shareFridgerBtn", function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/show/mine/shared.do",
			"dataType": "json",
	        "success": function(list){
	        	$("tbody").empty();
		        $.each(list, function(){
		        	 $("tbody").append($("<tr>").append($("<td>").append(this.fridgerId))
											 .append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
											 .append($("<td>").append(this.memberId))
											 .append($("<td>").append($("<button>").prop("type","button").prop("id","removeBtn").prop("value",this.fridgerId).append("삭제")))
													 .append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("value",this.fridgerId).append("수정")))
													 .append($("<td>").append($("<button>").prop("type","button").prop("id","moveInBtn").prop("value",this.fridgerId).append("열어보기"))))
													 .append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","5").append(" 정보가보여용")));
	        				
		        });	// end of each
		      
			}
		}); //end of ajax
	})

});
 </script>



<h3>조회</h3>
	
<hr>
<button type="button" id="shareFridgerBtn">내 공유 냉장고</button>
<a href="${initParam.rootPath}/common/member/fridger/register_form2.do"><button type="button">냉장고등록</button></a>
<a href="${initParam.rootPath}/common/member/fridger/invite_form.do"><button type="button">초대하러가기</button></a>


	<div id="table" style="width:800px;">
		<table id="fridgerList" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:40%;">냉장고명</th>
					<th style="width:15%;">냉장고주인</th>
					<th style="width:10%;">가입</th>
					<th style="width:10%;">변경</th>
					<th style="width:10%;">드루올랭?</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>
