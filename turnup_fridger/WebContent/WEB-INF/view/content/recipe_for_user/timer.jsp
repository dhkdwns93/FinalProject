<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function operateTimer(){ //타이머의 시간을 줄이는 부분
	var now = new Date(); //시간 비교용 변수
	var leftTime = endTime.getTime() - now.getTime(); //종료시간 까지 얼마나 남았는지 파악
	if(leftTime <= 0){ //만약 시간이 다 줄었다면
		Timer_refresh(0); //남은 시간을 0으로 출력해줌.
		clearInterval(worker); //타이머를 종료함
		alert("시간종료!");
		window.close();
	}else{ // 아닐 경우
		Timer_refresh(leftTime); //남은 시간을 출력해주는 함수를 호출.
	}
}

function n2(num){ //숫자를 2자리로 만들기 위함.
	return num > 10 ? num : "0" + num; //숫자가 10보다 작을 경우 앞에 0을 붙임.
}

function Timer_refresh(milisec){ //입력받은 값을 토대로 남은 시간을 출력해줌
	T_hour = Math.floor(milisec/3600000)%24; //남은 시간중 '시간'을 계산함.

	T_min = Math.floor(milisec/60000)%60; //남은 시간중 '분'을 계산함.
	T_sec = Math.floor(milisec/1000)%60; //남은 시간중 '초'를 계산함. 
	$('#timer').html(n2(T_hour) + " : " + n2(T_min) + " : " + n2(T_sec)); //계산한 남은 시간들을 출력함. 
}

$(document).ready(function(){
	

	$(document).on('click', '#start', function() { //시작] 버튼 클릭시
		var hour = window.parseInt($("#hourInput").val());
		var minute = window.parseInt($("#minuteInput").val());
		var second = window.parseInt($("#secondInput").val());
		 
		endTime = new Date(); //종료 될 시간을 지정하기 위한 변수
		endTime.setSeconds(endTime.getSeconds()+second); //종료될 시간을 지정
		endTime.setMinutes(endTime.getMinutes()+minute); //종료될 시간을 지정
		endTime.setHours(endTime.getHours()+hour); //종료될 시간을 지정
		worker = setInterval(operateTimer, 500); //워커라는 변수가 시계작동이라는 함수를 일정 간격마다 실행하게 만듬. 숫자 = 1/1000초
	});
	$(document).on('click', '#stop', function() { //중지 버튼 클릭시
		if(worker != null){ //워커가 null이 아닐 경우
			Timer_refresh(0); //남은 시간을 0으로 출력해줌.
			clearInterval(worker); //타이머를 종료시킴.
			worker=null; //워커 초기화
		}
	});
	$(document).on('click', '#pause', function() { //일시정지 버튼 클릭시
		if(worker != null){ //워커가 null이 아닐 경우
			if(pause == null){ //일시정지가 null일 경우
				clearInterval(worker); //일단 타이머의 시간이 흐르지 않도록 중지.
				pause = new Date(); //일시정지한 시간을 기록.
			}else{ //아닐 경우
				var tmptime = new Date(); //일시정지 해제를 위한 로컬 변수
				tmptime = tmptime - pause; //현재 시간에서 일시정지를 한 시간을 빼줍니다 결과:일시정지를 한 이후부터 지금까지 흐른 시간.
				endTime.setTime(endTime.getTime()+tmptime); //종료될 시간에 위에서 계산한 시간을 더해줍니다.
				worker = setInterval(operateTimer, 500); //다시 타이머를 작동시킵니다.
				pause = null; //다음번 일시정지를 위해서 초기화
			}
		}
	});
})


</script>
</head>
<body>
<br>
<div id="timer" style="font-size:45pt;text-align:center;">00 : 00: 00</div>
<div style="text-align:center;">
	<!-- <input type="number" id="timerInput" placeholder="시간" style="width:60px"> -->
	<input type="number" id="hourInput" placeholder="시간" style="width:60px">
	<input type="number" id="minuteInput" placeholder="분" style="width:60px">
	<input type="number" id="secondInput" placeholder="초" style="width:60px"><br><br>
	<button id="start">시작</button>
	<button id="pause">일시정지</button>
	<button id="stop">정지</button>
</div>




</body>
</html>