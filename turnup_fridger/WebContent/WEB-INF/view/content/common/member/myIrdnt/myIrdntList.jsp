<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript">
	$(document).ready(function(){
		//기본적으로 가져오는 모든 재료 목록들. 
		//alert('${param.fridgerId}');
		 // $('[data-toggle="tooltip"]').tooltip();   
	
		$.ajax({
			"url":"/turnup_fridger/common/member/myIrdnt/allMyIrdntList.do",
			"data":{'fridgerId': '${param.fridgerId}'},
			"dataType":"json", 
			"success":function(list){
						 $.each(list, function(){
								if(this.storgePlace=="실온"){
									$("#roomTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
											.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
									} 
								else if(this.storgePlace=="냉장"){ 
									$("#coldTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
											.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
									}
								else if(this.storgePlace=="냉동"){
									$("#freezeTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
											.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
									}
						
						/* 		if($("#irdntName_col").parent().children(":nth-child(3)").text()=='위험'){
									$("#irdntName_col").prop("style","color:red;");
								}
								else if($("#irdntName_col").parent().children(":nth-child(3)").text()=='보통'){
									$("#irdntName_col").prop("style","color:black;");
								}
								else if($("#irdntName_col").parent().children(":nth-child(3)").text()=='안전'){
									$("#irdntName_col").prop("style","color:green;");
								} */
				
					 })//each
							
						
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			} 
		});//ajax
		
		//재료클릭 -> 재료 상세정보 팝업 (쿼리로 정보들 붙여서 보내기)
		$(document).on("click","#irdntName_col",function(){
			var myIrdntKey = $(this).parent().children(":first-child").text();
			//var myIrdntKey=$(this).val();
			window.open("/turnup_fridger/common/member/myIrdnt/findIrdntByKey.do?myIrdntKey="+myIrdntKey,"detail","width=500, height=700");
		
		});//
				
		//선택삭제 -> 체크박스 만들어서 체크된것만 삭제처리하게 
		$(document).on("click","#deleteOnSelect",function(){
			var irdntKeyList = [];
			$("input[name='deleteChk']:checked").each(function(){
				irdntKeyList.push($(this).parent().parent().children(":first-child").text());
			});
			
			$.ajax({
				"url":"/turnup_fridger/common/member/myIrdnt/removeMyIrdnt.do",
				"type":"POST",
				"data":{'irdntKey':irdntKeyList,'fridgerId':'${param.fridgerId}','${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"text",
				"traditional": true,
				"success":function(TEXT){
					alert(TEXT);
					window.location.reload();
				},
				"error":function(xhr, msg, code){
					if(msg=="error"&&code=="Bad Request"){
						alert("선택한 재료가 없습니다.");
					}else{
						alert("오류발생-" +msg+ ":" +code);	
					}
				}
			})			
		});
				
		//검색버튼
		$("#searchBtn").on("click",function(){
			$.ajax({
				"url":"/turnup_fridger/common/member/myIrdnt/findMyIrdntByFreshLevelAndIrdntName.do?fridgerId=${param.fridgerId}",
				"type":"post",
				"data":{'freshLevel':$("#freshLevel").val(), 'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json", 
				"success":function(list){
					$("#roomTbody").empty();
					$("#coldTbody").empty();
					$("#freezeTbody").empty();
		 			 	$.each(list, function(){
		 			 		if(this.storgePlace=="실온"){
								$("#roomTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								} 
							else if(this.storgePlace=="냉장"){ 
								$("#coldTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
							else if(this.storgePlace=="냉동"){
								$("#freezeTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
		 			 		
		 			/*  		if($("#irdntName_col").parent().children(":nth-child(3)").text()=='위험'){
		 						$("#irdntName_col").prop("style","color:red;");
		 					}
		 					else if($("#irdntName_col").parent().children(":nth-child(3)").text()=='보통'){
		 						$("#irdntName_col").prop("style","color:black;");
		 					}
		 					else if($("#irdntName_col").parent().children(":nth-child(3)").text()=='안전'){
		 						$("#irdntName_col").prop("style","color:green;");
		 					} */
		 					
							})//each	
				},//success
				"error":function(xhr, msg, code){
					alert("오류발생-" +msg+ ":" +code);
				} 
			});
		});//searchBtn
		
		$("#addIrdnt").on("click",function(){
			window.open("/turnup_fridger/common/member/myIrdnt/myIrdnt_form.do?fridgerId=${param.fridgerId}","insertIrdnt","width=500, height=500");
		});//재료추가 
		
	})//ready

</script>
<style type="text/css">
/* body{
background-image : url("/turnup_fridger/images/fridgerPic.jpg");
background-repeat : no-repeat;
} */
th, td {
    border-bottom: 1px solid #ddd;
}
td {
	padding: 5px;
}
#tbody {
	cursor: pointer;
}
#roomSection{
	background: url(/turnup_fridger/img/tpbanana.png) no-repeat ;
	background-position: bottom;
    background-size: 522px;
}
#freezeSection{
	background: url(/turnup_fridger/img/icecream2.png) no-repeat ;
	background-position: bottom;
    background-size: 290px;
}
#coldSection{
	background: url(/turnup_fridger/img/brocoli.png) no-repeat ;
	background-position: bottom;
    background-size: contain;
}
</style>
</head>
<body>

<div style="text-align:center;"><h2>${param.fridgerName} 속</h2><br></div><hr>
<div class="container">
<div style="text-align:center;">
신선도
	<select name="freshLevel" id="freshLevel">
		<option value="전체">전체</option>
		<option value="안전">안전</option>
		<option value="보통">보통</option>
		<option value="위험">위험</option>
	</select>&emsp;
재료명 
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" class="btn btn-default" id="searchBtn">검색</button><br>
</div><br>

<div id="buttons" style="text-align:center;">
<a href="#" data-toggle="tooltip" title="재료 추가">
<button type="button" class="btn btn-warning" id="addIrdnt" style="width:50px;height:50px;font-size:25px;">+</button>
</a>&emsp;&emsp;&emsp;
<a href="#" data-toggle="tooltip" title="선택재료 삭제"><button type="button" class="btn btn-warning" id="deleteOnSelect" style="width:50px;height:50px;font-size:25px;">-</button></a><br><br>
<h4 style="color:lightgray;">재료를 클릭하면 상세정보를 보실 수 있습니다.</h4>
</div>
<br>

<!--************************************************modale  -->


<!--************************************************modale  -->

<div id="roomSection" style="width:30%; float:left; height:600px; border-style:ridge; margin:10px;">
<h5 style="color:gray;margin-left:5px;">실온</h5>
<div style="overflow-x:hidden; overflow-y:scroll; width: 300px;height:500px;margin-left: auto;margin-right: auto;">
<table id = "room" class="table table-hover table-condensed" style="width:280px;">
	<thead>
		<tr>
			<th>key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id = "roomTbody"></tbody>
</table>
</div>
</div>

<div id="freezeSection" style="width:30%; float:left; height:600px;border-style:ridge;margin:10px;">
<h5 style="color:gray;margin-left:5px;">냉동</h5>
<div style="overflow-x:hidden; overflow-y:scroll; width: 300px;height:500px;margin-left: auto;margin-right: auto;">
<table id = "freeze" class="table table-hover table-condensed" style="width:280px;">
	<thead>
		<tr>
			<th>key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id = "freezeTbody"></tbody>
</table>
</div>
</div>

<div id="coldSection" style="width:30%; float:left; height:600px;border-style:ridge;margin:10px;">
<h5 style="color:gray;margin-left:5px;">냉장</h5>
<div style="overflow-x:hidden; overflow-y:scroll; width: 300px;height:500px;margin-left: auto;margin-right: auto;">
<table id = "cold" class="table table-hover table-condensed" style="width:280px;">
	<thead>
		<tr>
			<th>key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id = "coldTbody"></tbody>
</table>
</div>
</div>

</div>
</body>
</html>