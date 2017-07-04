<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
 <script type="text/javascript">
$(document).ready(function () {
	//냉장고목록검색 페이지 디폴트는 전체 목록번호순으로 
	$.ajax({
		"url":"/turnup_fridger/fridger/show/list.do",
        "dataType": "json",
        "success": function(list){
        	$("tbody").empty();
	        $.each(list, function(){
	        	 $("tbody").append($("<tr>").prop("class","row_title").append($("<td>").append(this.fridgerId))
						 .append($("<td>").append(this.fridgerName))
						 .append($("<td>").append(this.memberId))
						 .append($("<td>").append($("<a>").prop("href","/turnup_fridger/fridger/join.do").append($("<button>").prop("type","button").append("JOIN")))))
							.append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","4").append(" 정보가보여용")));
	        })
        				
			/* var txt ="";
	        $.each(list, function(){
	        		txt += "<tr> <td>"+this.id+"</td><td>"+this.name+"</td><td>"+this.email+"</td><td>"+this.mileage+"</td><td>"+(this.marriage?"기혼":"미혼")+"</td> </tr>";
	        		$("tbody").html(txt);	// 내용을 바꿔줌~~~~~ (갱신)
	        });	// end of $.each
			*/
	        				
			/*
	        $("tbody").empty();
	        $.each(list, function(){
	        $("tbody").append($("<tr>").append($("<td>").append(this.id))
	        							 .append($("<td>").append(this.name))
	        							 .append($("<td>").append(this.email))
	        							 .append($("<td>").append(this.mileage))
	        							 .append($("<td>").append(this.marriage?"기혼":"미혼"))); 
	        });	// end of each
	        */
		}	//end of each
	}); //end of ajax
	
	
	$("#searchByIdBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/fridger/show/fridgerById.do",
			/* "type" : "post", */
			"data" : {fridgerId : $("input#fridgerId").val()},
	        "dataType": "json",
	        "beforeSend":function(){	
				if(!$("input#fridgerId").val()){
					alert("조회할 냉장고ID를 입력하세요");
					return false;
				}
			},
	        "success": function(fridger){
	        	$("tbody").empty();
	        	 $("tbody").append($("<tr>").prop("class","row_title").append($("<td>").append(fridger.fridgerId))
						 				.append($("<td>").append(fridger.fridgerName))
						 				.append($("<td>").append(fridger.memberId))
						 				.append($("<td>").append($("<a>").prop("href","/turnup_fridger/fridger/join.do").append($("<button>").prop("type","button").append("JOIN")))))
						.append($("<tr>").prop("class","collapse out").prop("id", "info"+ fridger.fridgerId).append($("<td>").prop("colspan","4").append(" 정보가보여용")));

	        },
	        "error":function(xhr, msg, code){
				//매개변수 : 1. XMLHttpRequest, 2.응답메세지(success/error), 3. HTTP응답 메세지(모두)
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}); //end of click for searchById
	
	
	$("#searchByNameBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/fridger/show/fridgerByName.do",
			/* "type" : "post", */
			"data" : {fridgerName : $("input#fridgerName").val()},
	        "dataType": "json",
	        "beforeSend":function(){	
				if(!$("input#fridgerName").val()){
					alert("조회할 냉장고이름를 입력하세요");
					return false;
				}
			},
	        "success": function(list){
	        	/* $("tbody").empty();
	        	var txt ="";
		        $.each(list, function(){
		        		txt += "<tr> <td>"+this.fridgerId+"</td><td>"+this.fridgerName+"</td><td>"+this.memberId+"</td><td>"
		        				+"<a href='/turnup_fridger/fridger/join.do'><button type='button'>JOIN</button></a>"+"</td> </tr>";
		        		$("tbody").html(txt);
		        });	// end of $.each */
		        
		        $("tbody").empty();
		        $.each(list, function(){
		        	 $("tbody").append($("<tr>").prop("class","row_title").append($("<td>").append(this.fridgerId))
							 .append($("<td>").append(this.fridgerName))
							 .append($("<td>").append(this.memberId))
							 .append($("<td>").append($("<a>").prop("href","/turnup_fridger/fridger/join.do").append($("<button>").prop("type","button").append("JOIN")))))
			.append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","4").append(" 정보가보여용")));
		        });	// end of each
	        },
	        "error":function(xhr, msg, code){
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}); //end of click for searchByName
	
	
	$("#searchByOwnerBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/fridger/show/fridgerByOwner.do",
			/* "type" : "post", */
			"data" : {memberId : $("input#memberId").val()},
	        "dataType": "json",
	        "beforeSend":function(){	
				if(!$("input#memberId").val()){
					alert("조회할 회원ID를 입력하세요");
					return false;
				}
			},
	        "success": function(list){
	        	/* $("tbody").empty();
	        	var txt ="";
		        $.each(list, function(){
		        		txt += "<tr> <td>"+this.fridgerId+"</td><td>"+this.fridgerName+"</td><td>"+this.memberId+"</td><td>"
		        				+"<a href='/turnup_fridger/fridger/join.do'><button type='button'>JOIN</button></a>"+"</td> </tr>";
		        		$("tbody").html(txt);
		        });	// end of $.each */
		        
		        $("tbody").empty();
		        $.each(list, function(){
		        	 $("tbody").append($("<tr>").prop("class","row_title").append($("<td>").append(this.fridgerId))
												 .append($("<td>").append(this.fridgerName))
												 .append($("<td>").append(this.memberId))
												 .append($("<td>").append($("<a>").prop("href","/turnup_fridger/fridger/join.do").append($("<button>").prop("type","button").append("JOIN")))))
								.append($("<tr>").prop("class","collapse out").prop("id", "info"+ this.fridgerId).append($("<td>").prop("colspan","4").append(" 정보가보여용")));
						
		        });	// end of each
	        },
	        "error":function(xhr, msg, code){
			alert("오류발생-" + code);
			}
		});	//end of ajax
	}); //end of click for searchByOwnerBtn
	
	
	
	
	 $(document).on("click",".row_title",function(){
		
		$(".row_title").css("background-color", "white");
		$(this).css("background-color", "lightblue");
		//한번에 여러개 냉장고 정보 열어서 비교가능함
		//$(".row_title").next().addClass("out").removeClass("in");

		if($(this).next().hasClass("out")) {
			$(".row_title").next().addClass("out").removeClass("in");
	    	$(this).next().addClass("in");
	    	$(this).next().removeClass("out");
	    } else {
	    	$(".row_title").next().addClass("out").removeClass("in");
	    	$(this).next().addClass("out");
	    	$(this).next().removeClass("in");
	    }
		
		if($(this).is("[id^=info]")){	// 인포를 보여주는 row 라면 ajax 실행 하지 않는다!
			return false;
		}/* 
		 
		$("tbody>tr").css("background-color", "white");
		$(this).css("background-color", "lightblue");
		$("tr.collapse").addClass("out").removeClass("in");
 */
	   
	    var fridgerId = $(this).children(":first-child").text();
		var ownerId = $(this).children(":nth-child(3)").text();
	    alert(ownerId);
	    
		$.ajax({
			"url":"/turnup_fridger/fridger/show/detail.do",
			/* "type" : "post", */
			"data" : {fridgerId : fridgerId},
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
		
		
		/* 
		$.ajax({
			"url":"/turnup_fridger/fridger/show/fridger/detail.do",
			//"type":"POST",
			"data":{fridgerId : $(this).children(":first-child").text()},
			"dataType":"json",
			"success": function(obj){
				//alert(obj.productId);
				var arr = [];
				for(var a in obj){
					arr.push(obj[a]);
				}
				//var txt = arr.join("/");
				//alert(txt);
				//$("#product_info_layer").text(arr.join("/")).show();
				$(this).empty();
				$("#product_info_layer").append(arr.join("/")).show();
				
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" + code);
			} 
		})// end of ajax
		*/
	}) 
	
});
 </script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

 
</head>
<body>
	<div id="search">
	냉장고ID로 조회
		<input type="text" name="fridgerId" id="fridgerId">
		<!-- <input type="button" value="조회" id="searchByIdBtn"> -->
		<button type="button" class="btn btn-default" id="fridgerId">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
		<br>
		
	냉장고 이름으로 조회
		<input type="text" name="fridgerName" id="fridgerName">
		<!-- <input type="button" value="조회" id="searchByNameBtn"> -->
		<button type="button" class="btn btn-default" id="searchByNameBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
		<br>
		
	냉장고 주인으로 조회
		<input type="text" name="memberId" id="memberId">
		<!-- <input type="button" value="조회" id="searchByOwnerBtn"> -->
	    <button type="button" class="btn btn-default" id="searchByOwnerBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
		<br>
	</div>



	<div id="table" style="width:800px;">
		<table id="fridgerList" class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:10%;">목록번호</th>
					<th style="width:60%;">냉장고명</th>
					<th style="width:20%;">냉장고주인</th>
					<th style="width:10%;">공유그룹</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
	</div>
</body>
</html>