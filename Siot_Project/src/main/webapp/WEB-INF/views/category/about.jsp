<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCR6ZmwrH-gZf-S3UsqARKX8vMgJD9PIP0" ></script>

<div id="about">
	<div class="aboutImg">
		<img src="../images/main/mainAbout.jpg">
	</div>
	<div class="aboutTxt">
		<span>ABOUT US</span>
		<p>
			한복이 당신의 생활에서 가까워지기 위해.<br>우리는 그동안 많은 시도를 해왔습니다.
		</p>
		<p>
			<br>한복이란 한복자체의 하나의 스타일이 아닙니다.
		</p>
		<p></p>
		<p>한복은 문화입니다.</p>
		<p></p>
		<p>
			그안의 스타일이 존재하죠.<br>우리는 보여드리고 싶어요
		</p>
		<p>
			<br>한한복이 가진 다양한 스타일의 가능성을
		</p>
	</div>
	<div id="designer">
		<div class="designerWrap">
			<div class="designerBox">
				<div class="designerOne">
					<img src="../images/main/CEO.jpg">
					<div class="textWrap">
						<strong>대표/디자이너</strong> <span>CNe choi</span>
					</div>
				</div>
				<p>감성을 담아 디자인하다.</p>
				<p>모든 최상의 영감은 완벽한 자연에서 온다고 확신합니다</p>
			</div>
			<div class="designerBox">
				<div class="designerOne">
					<img src="../images/main/DESIGNER.jpg">
					<div class="textWrap">
						<strong>디자이너/CS</strong> <span>LeeSeul</span>
					</div>
				</div>
				<p>도전하기 쉬운.</p>
				<p>씨네와는 반대로 수수하고 여성스런,도전하기 쉬운 한복을 만듭니다.</p>
			</div>
		</div>
	</div>
	<div id="marketImg">
		<img src="../images/main/marketImg.jpg">
	</div>
	<div id="showRoom">
		<div class="reserve">
			<div class="reserveTxt">
				<h5>쇼룸 방문예약</h5>
				<p>직접 오셔서 옷들을 입어보시고 주문하실수 있습니다.</p>
			</div>
			<div class="emptyBoard">
				<div class="fasBox">
					<i class="fas fa-exclamation-triangle"></i>
				</div>
				<p>연결된 게시판이(가) 없습니다.</p>
			</div>
		</div>
		<div id="map"></div>
	</div>
	<div id="aboutInfo">
		<h6>SIOT PROJECT</h6>
		<p>
			대표번호:010-3222-9103<br>운영시간(한국) 11:00~19:00,주말/공휴일은 제외.
		</p>
	</div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script type="text/javascript"> $(document).ready(function() {
	var myLatlng = new google.maps.LatLng(37.492061,126.719891); // 위치값 위도 경도 
	var Y_point = 37.492061; // Y 좌표 
	var X_point = 126.719891; // X 좌표
	var zoomLevel = 18; // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼 
	var markerTitle = "작업실";// 현재 위치 마커에 마우스를 오버을때 나타나는 정보 
	var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기 
	// 말풍선 내용
	//var contentString = '<div></div>';
	var myLatlng = new google.maps.LatLng(Y_point, X_point); 
	var mapOptions = { zoom: zoomLevel, center: myLatlng, mapTypeId: google.maps.MapTypeId.ROADMAP } 
	var map = new google.maps.Map(document.getElementById('map'), mapOptions); 
	var marker = new google.maps.Marker({ position: myLatlng, map: map, title: markerTitle });
	var infowindow = new google.maps.InfoWindow( {  maxWizzzdth: markerMaxWidth } );
	google.maps.event.addListener(marker, 'click', function() {
		infowindow.open(map, marker); 
		}); 
	}); 
	</script>


