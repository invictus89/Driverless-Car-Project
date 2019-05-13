<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>

<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="resources/dist/css/skins/_all-skins.min.css">
<!-- Morris chart -->
<link rel="stylesheet" href="resources/plugins/morris.js/morris.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="resources/plugins/jvectormap/jquery-jvectormap.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="resources/plugins/bootstrap-datepicker/bootstrap-datepicker.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="resources/plugins/bootstrap-daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

<title>도로 위의 기차</title>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=rbeyz68rf5"></script>
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
	</nav>

	<!-- Main content -->
	<section class="content">
		<!-- Small boxes (Stat box) -->
		<div class="row">
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-aqua">
					<div class="inner">
						<h3>150</h3>
						<p>New Orders</p>
					</div>
					<div class="icon">
						<i class="ion ion-bag"></i>
					</div>
					<a href="#" class="small-box-footer">More info <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-green">
					<div class="inner">
						<h3>
							53<sup style="font-size: 20px">%</sup>
						</h3>
						<p>Bounce Rate</p>
					</div>
					<div class="icon">
						<i class="ion ion-stats-bars"></i>
					</div>
					<a href="#" class="small-box-footer">More info <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-yellow">
					<div class="inner">
						<h3>44</h3>

						<p>User Registrations</p>
					</div>
					<div class="icon">
						<i class="ion ion-person-add"></i>
					</div>
					<a href="#" class="small-box-footer">More info <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
			<!-- ./col -->
			<div class="col-lg-3 col-xs-6">
				<!-- small box -->
				<div class="small-box bg-red">
					<div class="inner">
						<h3>65</h3>

						<p>Unique Visitors</p>
					</div>
					<div class="icon">
						<i class="ion ion-pie-graph"></i>
					</div>
					<a href="#" class="small-box-footer">More info <i
						class="fa fa-arrow-circle-right"></i></a>
				</div>
			</div>
		</div>
	</section>

	<div class="container" id="map"
		style="width: 90%; height: 400px; margin-bottom: 20px;"></div>

	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.430312, 126.933117),
			zoom : 6,
			scaleControl : true,
			logoControl : false,
			mapDataControl : false,
			zoomControl : false,
			zoomControlOptions : {
				style : naver.maps.ZoomControlStyle.LARGE
			}
		};

		var map = new naver.maps.Map('map', mapOptions);

		var marker1 = {
			url : '${contextPath}/resources/images/marker1.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var marker2 = {
			url : '${contextPath}/resources/images/marker2.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var marker3 = {
			url : '${contextPath}/resources/images/marker3.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var marker1 = new naver.maps.Marker({
			position : new naver.maps.LatLng(37.331017, 126.937448),
			map : map,
			icon : marker1
		});

		var marker2 = new naver.maps.Marker({
			position : new naver.maps.LatLng(37.482277, 126.878965),
			map : map,
			icon : marker2
		});

		var marker3 = new naver.maps.Marker({
			position : new naver.maps.LatLng(37.520928, 126.990363),
			map : map,
			icon : marker3
		});
	</script>

	<div class="row" style="margin-left: 20px;">
		<div class="col-sm-8">
			<h2>주행 차량 정보</h2>
			<table class="table">
				<thead>
					<tr>
						<th>No.</th>
						<th>구분</th>
						<th>위치</th>
						<th>주행상태</th>
						<th>연료량</th>
						<th>온습도</th>
						<th>앞 차와의 거리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>main</td>
						<td>군포 hub</td>
						<td>주행 중</td>
						<td>progress bar</td>
						<td>30'C / 20%</td>
						<td>5m</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-4">
			<img src="${contextPath}/stream/camera/1" width="350" height="350" />
		</div>
	</div>
</body>
</html>
