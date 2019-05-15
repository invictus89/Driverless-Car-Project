<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>

<html>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="resources/dist/css/skins/_all-skins.min.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="resources/plugins/jvectormap/jquery-jvectormap.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=rbeyz68rf5"></script>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<style>
#box1 {
	position: absolute;
	top: 207px;
	right: 120px;
	color: black;
	font-weight: bold;
	background-color: white;
	opacity: 0.5;
	display: none;
}

#box2 {
	position: absolute;
	top: 230px;
	right: 120px;
	color: black;
	font-weight: bold;
	background-color: white;
	opacity: 0.5;
	display: none;
}

#up {
	position: absolute;
	top: 260px;
	right: 130px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#right {
	position: absolute;
	top: 300px;
	right: 90px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#left {
	position: absolute;
	top: 300px;
	right: 170px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#down {
	position: absolute;
	top: 340px;
	right: 130px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#hide {
	display: none;
}
</style>
<title>Train On The Road</title>
</head>
<body>
	<!-- NAVIGATION BAR -->
	<nav class="navbar navbar-expand-sm bg-purple navbar-dark">
		<a class="navbar-brand" href="${contextPath}/driverless"> <i
			class="fas fa-truck"> </i> <i class="fas fa-truck"></i> <i
			class="fas fa-truck"> </i> Train On The Road
		</a>
		<button class="navbar-toggler" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
	</nav>

	<!-- STATE CARD -->
	<div class="row"
		style="padding-top: 15px; padding-left: 30px; padding-right: 30px">
		<div class="col-lg-3 col-xs-6">
			<div class="small-box bg-aqua">
				<div class="inner">
					<h3>150</h3>
					<p style="display: inline-block">차량 수</p>
				</div>
			</div>
		</div>
		<div class="col-lg-3 col-xs-6">
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
			</div>
		</div>
		<div class="col-lg-3 col-xs-6">
			<div class="small-box bg-yellow">
				<div class="inner">
					<h3>44</h3>
					<p>User Registrations</p>
				</div>
				<div class="icon">
					<i class="ion ion-person-add"></i>
				</div>
			</div>
		</div>
		<div class="col-lg-3 col-xs-6">
			<div class="small-box bg-red">
				<div class="inner">
					<h3>65</h3>
					<p>Unique Visitors</p>
				</div>
				<div class="icon">
					<i class="ion ion-pie-graph"></i>
				</div>
			</div>
		</div>
	</div>
	<!-- MAP -->
	<div class="container" id="map"
		style="width: 90%; height: 350px; margin-bottom: 20px;"></div>

	<script>
		var mapOptions = {
			center : new naver.maps.LatLng(37.430312, 126.933117),
			zoom : 5,
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

	<form>
		<p id="box1"></p>
		<div class="custom-control custom-switch" id="box2">
			<input type="checkbox" class="custom-control-input" id="switch1"
				checked data-toggle="toggle"> <label
				class="custom-control-label" for="switch1">Auto</label>
		</div>

		<div id="hide">
			<button type="button" id="up">
				<i class="fas fa-arrow-circle-up fa-3x"></i>
			</button>

			<button type="button" id="down">
				<i class="fas fa-arrow-circle-down fa-3x"></i>
			</button>

			<button type="button" id="left">
				<i class="fas fa-arrow-circle-left fa-3x"></i>
			</button>

			<button type="button" id="right">
				<i class="fas fa-arrow-circle-right fa-3x"></i>
			</button>
		</div>
	</form>

	<div class="row" style="margin-left: 20px;">
		<div class="col-sm-8">
			<h4>주행 차량 정보</h4>
			<table id="table-1"
				class="table table-bordered table-hover text-center">
				<thead>
					<tr>
						<th style="width: 10px">#</th>
						<th>구분</th>
						<th>차량번호</th>
						<th>위치</th>
						<th>주행상태</th>
						<th>연료량</th>
						<th>온습도</th>
						<th>앞 차와의 거리</th>
					</tr>
				</thead>
				<tbody>
					<%--<c:forEach var="board" items="${pi.list}">--%>
					<tr>
						<td>1</td>
						<td><span class="badge bg-red">main</span></td>
						<td>33무7693</td>
						<td>경부고속도로</td>
						<td>Manual</td>
						<td>
							<div class="progress progress-xs">
								<div class="progress-bar progress-bar-danger" style="width: 20%"></div>
							</div>
						</td>
						<td>23'C / 33%</td>
						<td>-</td>
					</tr>
					<tr>
						<td>2</td>
						<td><span class="badge bg-blue">sub</span></td>
						<td>02누4012</td>
						<td>경부고속도로</td>
						<td>Auto</td>
						<td>
							<div class="progress progress-xs">
								<div class="progress-bar progress-bar-warning"
									style="width: 40%"></div>
							</div>
						</td>
						<td>21'C / 23%</td>
						<td>5m</td>
					</tr>
					<tr>
						<td>3</td>
						<td><span class="badge bg-red">main</span></td>
						<td>05마4546</td>
						<td>남부순환로</td>
						<td>Auto</td>
						<td>
							<div class="progress progress-xs">
								<div class="progress-bar progress-bar-success"
									style="width: 90%"></div>
							</div>
						</td>
						<td>18'C / 10%</td>
						<td>-</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-4">
			<img src="${contextPath}/stream/camera/1" width="360" height="270" />
		</div>
	</div>

	<script>
		var no, car_no, state;
		
		$("#table-1 tr").click(function() {

			var str = ""
			var tdArr = new Array(); // 배열 선언

			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();

			// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
			td.each(function(i) {
				tdArr.push(td.eq(i).text());
			});

			// td.eq(index)를 통해 값을 가져올 수도 있다.
			no = td.eq(0).text();
			car_no = td.eq(2).text();
			state = td.eq(4).text();

			$("#box1").show();
			$("#box1").text(car_no);
			$("#box2").show();

			if (state == "Auto") {
				$("#switch1").prop("checked", true);
				$("#hide").hide();
				//alert($("#switch1").prop("checked"));
			} else if (state == "Manual") {
				$("#switch1").prop("checked", false);
				$("#hide").show();
				//alert($("#switch1").prop("checked"));
			} else {
				alert("???");
			}
		});		

		$("label").click(function() {
			if (state == "Auto") {
				$("#table-1 tr:eq("+no+") td:eq(4)").text("Manual");
				state = $("#table-1 tr:eq("+no+") td:eq(4)").text();
			} else if (state == "Manual") {
				$("#table-1 tr:eq("+no+") td:eq(4)").text("Auto");
				state = $("#table-1 tr:eq("+no+") td:eq(4)").text();
			} else {
				alert("???");
			}
			$("#hide").toggle();
		});

	</script>

</body>
</html>
