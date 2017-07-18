<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table {
text-align:center;
}

form{display:inline}
input:focus {
  outline: none;
}
</style>
<meta charset="UTF-8">
<title>관리자 재료 관리</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function getList(page){
	$("#tbody").empty();
	$("#pageBean").empty();
	
	if(!page) page = 1;
	
	$.ajax({
		"url":"/turnup_fridger/common/admin/irdntManage/allIrdntList.do",
		"data":"page="+page,
		"dataType":"json", 
		"success":function(map){
			$.each(map.list, function(){
				$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
				.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").prop("class","btn btn-default btn-lg").prop("style","border:0;outline:0;")
						.append($("<span>").prop("class","glyphicon glyphicon-pencil").prop("aria-hidden","true"))))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","deleteBtn").prop("class","btn btn-default btn-lg").prop("style","border:0;outline:0;")
						.append($("<span>").prop("class","glyphicon glyphicon-trash").prop("aria-hidden","true")))));
			 	});//each
			
			 	$("#pageBean").append($("<a href='javascript:getList(1)'>").append("첫페이지"));
			
			 	if(map.pageBean.previousPageGroup!=null){
			 		$("#pageBean").append($("<a href='javascript:getList("+(map.pageBean.beginPage-1)+")'>").append("◀"));
			 		//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.beginPage-1).append("◀"));
				}else{
					$("#pageBean").append("◀");
				} 	
			 	for(var index = map.pageBean.beginPage ; index < map.pageBean.endPage ; index++){
			 		if(index !=map.pageBean.page){
			 			$("#pageBean").append($("<a href='javascript:getList("+index+")'>").append(index));
						//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+index).append(index));
					}else{
						$("#pageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.pageBean.nextPageGroup!=null){
			 		$("#pageBean").append($("<a href ='javascript:getList("+(map.pageBean.endPage+1)+")'>").append("▶"));
			 		//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.endPage+1).append("▶"));
			 	}else{
			 		$("#pageBean").append("▶");
			 	}
			 	
			 	$("#pageBean").append($("<a href = 'javascript:getList("+(map.pageBean.totalPage)+")'>").append("마지막 페이지"));
			 	//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.totalPage).append("마지막 페이지"));
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 
	})//ajax
	
};

function getSearchList(page){
	$("#tbody").empty();
	$("#pageBean").empty();
	
	if(!page) page = 1;
	
	$.ajax({
		"url":"/turnup_fridger/common/admin/irdntManage/findIrdntByKeyword.do",
		"data":{'irdntCategory' : $("#irdntCategory").val(), 'irdntName' : $("#irdntName").val(),'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json", 
		"success":function(map){
			$.each(map.list, function(){
				$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
				.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").append("수정")))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","deleteBtn").append("삭제"))));
			 	});//each
			
			 	$("#pageBean").append($("<a href='javascript:getSearchList(1)'>").append("첫페이지"));
			
			 	if(map.pageBean.previousPageGroup!=null){
			 		$("#pageBean").append($("<a href='javascript:getSearchList("+(map.pageBean.beginPage-1)+")'>").append("◀"));
			 		//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.beginPage-1).append("◀"));
				}else{
					$("#pageBean").append("◀");
				} 	
			 	for(var index = map.pageBean.beginPage ; index < map.pageBean.endPage ; index++){
			 		if(index !=map.pageBean.page){
			 			$("#pageBean").append($("<a href='javascript:getSearchList("+index+")'>").append(index));
						//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+index).append(index));
					}else{
						$("#pageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.pageBean.nextPageGroup!=null){
			 		$("#pageBean").append($("<a href ='javascript:getSearchList("+(map.pageBean.endPage+1)+")'>").append("▶"));
			 		//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.endPage+1).append("▶"));
			 	}else{
			 		$("#pageBean").append("▶");
			 	}
			 	
			 	$("#pageBean").append($("<a href = 'javascript:getSearchList("+(map.pageBean.totalPage)+")'>").append("마지막 페이지"));
			 	//$("#pageBean").append($("<a>").prop("href", "/turnup_fridger/common/admin/irdntManage/allIrdntList.do?page="+map.pageBean.totalPage).append("마지막 페이지"));
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 
	})//ajax
	
}
	$(document).ready(function(){
		getList(1);	
				
		$("#searchBtn").on("click",function(){
			getSearchList(1);
		});//searchBtn

		$(document).on("click","#updateBtn",function(){
			var irdntId = $(this).parent().parent().children(":first-child").text();
			window.open("/turnup_fridger/common/admin/irdntManage/findIrdntById.do?irdntId="+irdntId,"updateIrdnt","width=500, height=550");

		});

		$(document).on("click","#deleteBtn",function(){
			var irdntId = $(this).parent().parent().children(":first-child").text();	
			$.ajax({
				"url":"/turnup_fridger/common/admin/irdntManage/removeIrdnt.do",
				"type":"POST",
				"data":{'irdntId':irdntId,'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"text",
				"success":function(TEXT){
					alert(TEXT);
					document.location.reload();
				},
				"error":function(errorMsg){
					alert("오류다!")
				}
			})
		});//deleteBtn
		
		$("#insertBtn").on("click",function(){
			window.open("/turnup_fridger/common/admin/irdntManage/irdnt_form.do","insertIrdnt","width=500, height=500");
		})//insertBtn
	});

</script>
</head>
<body>

	<div style= "text-align: center;">
	<h2 style="font-weight:bold;">재료 목록</h2><hr><br>
	카테고리  
	<select name="irdntCategory" id="irdntCategory">
		<option value="전체">전체</option>
		<c:forEach items="${requestScope.irdntCategory}" var="irdntCategory">
			<option value="${irdntCategory}">${irdntCategory}</option>
		</c:forEach>
	</select>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	
	재료명 
	<input type="text" name ="irdntName" id="irdntName">
	<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" id="searchBtn">
	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
	</button>
	
	</div>
	
	<br>	
	<div id="result" class="tableList" style="width:1000px; ">
		<table class="table table-hover table-condensed" style="width:100%;">
			<thead style="text-align:center;">
				<tr>
				<th>재료id</th>
				<th>재료명</th>
				<th>카테고리</th>
				<th>실온보관기간</th>
				<th>냉장보관기간</th>
				<th>냉동보관기간</th>
				<th>비고</th>
				<th>수정</th>
				<th>삭제</th>
				</tr>	
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div><br>
	
	<div style="text-align:center;"><button type="button" id="insertBtn" class="btn btn-warning">재료추가</button></div><br>
	<div id="pageBean" style="text-align:center;"></div>

</body>
</html>