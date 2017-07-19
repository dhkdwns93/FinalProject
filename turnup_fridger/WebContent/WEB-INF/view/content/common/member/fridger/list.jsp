<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal.memberId" var="memberId"/>
      
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
 
 <script type="text/javascript">
$(document).ready(function () {
	$('#joinFridgerModal').on('show.bs.modal', function (e) {
		getFridgerListByName("" , 1);	
	})
	//냉장고목록검색 페이지 디폴트는 전체 목록번호순으로 
	
	
	$("#searchByNameBtn").on("click", function(){
		alert($("#joinFridgerName").val());
		getFridgerListByName($("#joinFridgerName").val(), 1);
	}); //end of click on searchByName
	
	$("#searchByOwnerBtn").on("click", function(){
		alert($("#joinMemberId").val());
		getFridgerListByOwner($("#joinMemberId").val(), 1);
	}); //end of click on searchByName
	
	
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
		
	    var fridgerId = $(this).parent().children(":first-child").attr("id");
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
	
	
	
});


	

function getFridgerListByName(fridgerName, page){
	$("#fridgerList_tbody").empty();
	$("#pagingBean").empty();
	if(!page || page==0) page = 1;
	
	$.ajax({
		"url":"${initParam.rootPath}/common/member/fridger/show/byName.do",
		"type":"post",
		"data":{'fridgerName' : fridgerName,'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json",
		"success":function(map){
			$("#fridgerList_thead").show();
			$("#fridgerList_tbody").empty();
			/* <th style="width:10%;">NO</th>
			<th style="width:40%;">Fridger Name</th>
			<th style="width:20%;">Owner</th>
			<th style="width:20%;">Join</th> */
			var no = (map.pagingBean.page-1)*5
			$.each(map.list, function(){
				$("#fridgerList_tbody").append($("<tr>").append($("<td>").prop("id",this.fridgerId).append(++no))
														.append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
														.append($("<td>").append(this.memberId))
														.append($("<td>").append($("<button>").prop("type","button").prop("id","joinBtn").prop("value",this.fridgerId).append("JOIN"))))
										.append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","4").append(" 정보가보여용")));
			})//end of each
			$("#pagingBean").append($("<a href='javascript:getFridgerListByName(\""+fridgerName+"\",1)'>").append("FIRST"));
			
			if(map.pagingBean.previousPageGroup != null){
				$("#pagingBean").append($("<a href='javascript:getFridgerListByName(\""+fridgerName+"\","+(map.pagingBean.beginPage-1)+")'>").append("◀"));
			}else{
				$("#pagingBean").append("◀");
			} 
			
			for(var idx = map.pagingBean.beginPage ; idx <= map.pagingBean.endPage ; idx++){
				if(idx !=map.pagingBean.page){
		 			$("#pagingBean").append($("<a href='javascript:getFridgerListByName(\""+fridgerName+"\","+idx+")'>").append(idx));
				}else{
					$("#pagingBean").append("["+idx+"]"+"&nbsp;&nbsp;");
				}
			}
			
			
			if(map.pagingBean.nextPageGroup!=null){
				if(map.pagingBean.totalPage == map.pagingBean.endPage){
					$("#pagingBean").append($("<a href ='javascript:getFridgerListByName(\""+fridgerName+"\","+(map.pagingBean.endPage)+")'>").append("▶"));
				}else{
					$("#pagingBean").append($("<a href ='javascript:getFridgerListByName(\""+fridgerName+"\","+(map.pagingBean.endPage+1)+")'>").append("▶"));
				}
		 	}else{
		 		$("#pagingBean").append("▶");
		 	}
		 	$("#pagingBean").append($("<a href = 'javascript:getFridgerListByName(\""+fridgerName+"\","+(map.pagingBean.totalPage)+")'>").append("LAST"));
	
		},
		"error":function(errorMsg){
			alert("에러발생:"+errorMsg);
		} 
		
	})//end of ajax
}//end of getFridgerListByName

function getFridgerListByOwner(memberId, page){
	$("#fridgerList_tbody").empty();
	$("#pagingBean").empty();
	if(!page || page==0) page = 1;
	
	$.ajax({
		"url":"${initParam.rootPath}/common/member/fridger/show/byOwner.do",
		"type":"post",
		"data":{'memberId' : memberId,'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"type":"post",
		"dataType":"json",
		"success":function(map){
			$("#fridgerList_thead").show();
			$("#fridgerList_tbody").empty();
			/* <th style="width:10%;">NO</th>
			<th style="width:40%;">Fridger Name</th>
			<th style="width:20%;">Owner</th>
			<th style="width:20%;">Join</th> */
			var no = (map.pagingBean.page-1)*5
			$.each(map.list, function(){
				$("#fridgerList_tbody").append($("<tr>").append($("<td>").append(++no))
														.append($("<td>").prop("class","fridgerName_col").append(this.fridgerName))
														.append($("<td>").append(this.memberId))
														.append($("<td>").append($("<button>").prop("type","button").prop("id","joinBtn").prop("value",this.fridgerId).append("JOIN"))))
			})//end of each
			
			$("#pagingBean").append($("<a href='javascript:getFridgerListByOwner(\""+memberId+"\",1)'>").append("FIRST"));
			
			if(map.pagingBean.previousPageGroup != null){
				$("#pagingBean").append($("<a href='javascript:getFridgerListByOwner(\""+memberId+"\","+(map.pagingBean.beginPage-1)+")'>").append("◀"));
			}else{
				$("#pagingBean").append("◀");
			} 
			
			
			for(var idx = map.pagingBean.beginPage ; idx <= map.pagingBean.endPage ; idx++){
				if(idx !=map.pagingBean.page){
		 			$("#pagingBean").append($("<a href='javascript:getFridgerListByOwner(\""+memberId+"\","+idx+")'>").append(idx));
				}else{
					$("#pagingBean").append("["+idx+"]"+"&nbsp;&nbsp;");
				}
			}
			
			
			if(map.pagingBean.nextPageGroup!=null){
				if(map.pagingBean.totalPage == map.pagingBean.endPage){
					$("#pagingBean").append($("<a href ='javascript:getFridgerListByOwner(\""+memberId+"\","+(map.pagingBean.endPage)+")'>").append("▶"));
				}else{
					$("#pagingBean").append($("<a href ='javascript:getFridgerListByOwner(\""+memberId+"\","+(map.pagingBean.endPage+1)+")'>").append("▶"));
				}
				
				
		 	}else{
		 		$("#pagingBean").append("▶");
		 	}
		 	$("#pagingBean").append($("<a href = 'javascript:getFridgerListByOwner(\""+memberId+"\","+(map.pagingBean.totalPage)+")'>").append("LAST"));
	
		},
		"error":function(errorMsg){
			alert("에러발생:"+errorMsg);
		} 
		
	})//end of ajax
}//end of getFridgerListByOwner

 </script>
 <style>
 
 
 th{
 text-align: center;
 }
 
 </style>
 
 
 
<div class="container">
<!-- 
 trigger of updateFridgerModal
 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createFridgerModal">냉장고 만들기</button> -->

 <!-- start of updateFridgerModal -->
<div class="modal fade" id="joinFridgerModal" tabindex="-1" role="dialog" aria-labelledby="joinFridgerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetJoinModal()" ><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" id="joinFridgerModalLabel">냉장고 가입</h3>
      </div>
      <div class="modal-body" >
      
       <!-- 에러메시지 -->
      <div class="well errorWell">
      	<span class="error"><!-- 메시지 찍히는 곳 --></span>
      </div>   
      
      
      
	<form id="joinForm">
	<div class="search-input form-horizontal">
	<div class="form-group" style="margin: 3px;">
          <label class="col-sm-3 control-label" for="joinFridgerName">Fridger Name</label>
          <div class="col-sm-8">
		    <div class="input-group">	
		      <input  class="form-control" id="joinFridgerName" name="fridgerName" type="text" placeholder="찾으시는 냉장고 애칭을 입력하세요">
		      <span class="input-group-btn">
		        <button class="btn btn-default" type="button" id="searchByNameBtn">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
		      </span>
		    </div><!-- /input-group -->
		  </div><!-- /.col-sm-8 -->
	</div>	
	
	<div class="form-group" style="margin: 3px;">
          <label class="col-sm-3 control-label" for="joinMemberId">Fridger Owner</label>
          <div class="col-sm-8">
		    <div class="input-group">
		      <input class="form-control" type="text" name="memberId" id="joinMemberId" placeholder="찾으시는 회원 ID를 입력하세요">
		      <span class="input-group-btn">
		        <button class="btn btn-default" type="button" id="searchByOwnerBtn">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
		      </span>
		    </div><!-- /input-group -->
		  </div><!-- /.col-sm-8 -->
	</div>
   </div>
   </form>
<hr>
	
	
	<!-- 검색결과 뿌려주는 곳 -->
		<div id="table" style="width:auto; height: 300px;">
			<table id="fridgerList" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
				<thead id="fridgerList_thaed">
					<tr>
						<th style="width:10%;">NO</th>
						<th style="width:40%;">Fridger Name</th>
						<th style="width:20%;">Owner</th>
						<th style="width:20%;">Join</th>
					</tr>
				</thead>
				<tbody id="fridgerList_tbody">
					<!-- 내용 받아올 부분/페이징 -->
				</tbody>
			</table>
		</div>
	 	
		<div id="pagingBean" style = "text-align:center;"><!-- 페이지 네이션오는곳 --></div>


	 </div><!-- end of body -->
	
      <div class="modal-footer">
       <button type="button" class="btn btn-blue-grey" id="cancel" data-dismiss="modal" onclick="resetJoinModal()" style="background-color:#4c4c34; color:white; border:5px; border-color:#999966; width:100px; margin: 2px; text-shadow:none;  font-weight: bold">CLOSE</button>
      </div>
    </div>
  </div>
   </div>
</div>

<!-- end of updateFridgerModal -->