<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>

<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"><script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	
	<title>도로 위의 기차</title>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=rbeyz68rf5"></script>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand" href="${contextPath}/driverless"> <i
			class="fas fa-globe-americas"></i> 도로 위의 기차
		</a>
		<button class="navbar-toggler" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="#"> <i
						class="fas fa-list-ul"></i> 회원 수
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/gallery/list"> <i class="fas fa-images"></i>
						차량 수
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${contextPath}/board/list"> <i
						class="fas fa-calendar-alt"></i> 데이터 수
				</a></li>
			</ul>
		</div>
	</nav>
	<div class="container" id="map" style="width: 90%; height: 400px; margin-top: 20px; margin-bottom: 20px;"></div>
	
	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.3595704, 127.105399),
			zoom : 5
		};

		var map = new naver.maps.Map('map', mapOptions);
	</script>
	
	<div class="row" style="margin-left: 20px;">
		<div class="col-sm-8">
			<h2> 주행 차량 정보 </h2>	
			<table class="table">
				<thead>
				<tr>
					<th> No. </th>
					<th> 구분 </th>
					<th> 위치 </th>
					<th> 주행상태 </th>
					<th> 연료량 </th>
					<th> 온습도 </th>
					<th> 앞 차와의 거리 </th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<th> 1 </th>
					<th> main </th>
					<th> 옥천 hub </th>
					<th> 주행 중 </th>
					<th> progress bar </th>
					<th> 30'C / 20% </th>
					<th> 5m </th>
				</tr>
				</tbody>
			</table>
		</div>		
		<div class="col-sm-4">
			
		</div>
	</div>
</body>
</html>
