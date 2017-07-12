<%@page import="kr.co.turnup_fridger.vo.Member"%>
<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
</head>
<body>
<div id="map" style="width:750px;height:500px;"></div>
<sec:authentication property="principal.memberAddress" var="ma"/>
<input type="hidden" id="address" value="${ma}">

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a48481878cc565128cd84abd9fda8053&libraries=services"></script>
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우
var infowindow = new daum.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도 생성
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체 생성
var ps = new daum.maps.services.Places(); 

// 키워드로 장소 검색 - 세션에 저장된 회원의 주소이용
ps.keywordSearch($("#address").val()+'편의점' , placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수
function placesSearchCB (status, data, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 검색된 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가
        var bounds = new daum.maps.LatLngBounds();

        for (var i=0; i<data.places.length; i++) {
            displayMarker(data.places[i]);    
            bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위 재설정
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시
    var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(place.latitude, place.longitude) 
    });

    // 마커 클릭이벤트
    daum.maps.event.addListener(marker, 'click', function() {
        // 마커 클릭시 장소명, 전화번호, 주소
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title +' '+ place.phone +'<br>'+ place.address + '</div>');
        infowindow.open(map, marker);
    });
}
</script>

</body>
</html>