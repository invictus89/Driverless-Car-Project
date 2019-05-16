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
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=rbeyz68rf5&submodules=geocoder"></script>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<style>
#box1 {
	position: absolute;
	top: 207px;
	right: 652px;
	color: black;
	font-weight: bold;
	background-color: white;
	opacity: 0.5;
	display: none;
}

#box2 {
	position: absolute;
	top: 230px;
	right: 650px;
	color: black;
	font-weight: bold;
	background-color: white;
	opacity: 0.5;
	display: none;
	top: 230px;
}

#fo {
	position: absolute;
	top: 260px;
	right: 710px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#rf {
	position: absolute;
	top: 290px;
	right: 650px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
	transform: rotate(-45deg);
}

#lf {
	position: absolute;
	top: 290px;
	right: 770px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
	transform: rotate(45deg);
}

#bw {
	position: absolute;
	top: 380px;
	right: 710px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
}

#rb {
	position: absolute;
	top: 350px;
	right: 650px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
	transform: rotate(45deg);
}

#lb {
	position: absolute;
	top: 350px;
	right: 770px;
	opacity: 0.5;
	outline: 0;
	border-radius: 50%;
	transform: rotate(-45deg);
}

#st {
	position: absolute;
	top: 320px;
	right: 710px;
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
		<div class="col-lg-4 col-xs-6">
			<div class="small-box bg-aqua">
				<div class="inner">
					<h3>150</h3>
					<p style="display: inline-block">차량 수</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-xs-6">
			<div class="small-box bg-green">
				<div class="inner">
					<h3>30</h3>
					<p>운전자 수</p>
				</div>
				<div class="icon">
					<i class="ion ion-stats-bars"></i>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-xs-6">
			<div class="small-box bg-orange">
				<div class="inner">
					<h3 style="text-align: center;">차량 등록</h3>
					<p>얼른하셈</p>
				</div>
				<div class="icon">
					<i class="ion ion-pie-graph"></i>
				</div>
			</div>
		</div>
	</div>
	<!-- MAP -->
	<div class="row"
		style="margin-left: 30px; margin-right: 15px; margin-bottom: 20px">
		<div class="col-6" id="map" style="height: 360px;"></div>

		<div class="col-6">

			<img
				src="http://mblogthumb1.phinf.naver.net/20120331_64/s1kate_1333198045027MYyER_JPEG/IMG_0081.JPG?type=w2"
				width="100%" height="360px" />
			<%-- <img src="${contextPath}/stream/camera/1" width="100%" height="360px" /> --%>
		</div>
	</div>

	<script>
		var t1x, t1y, t2x, t2y, t3x, t3y;

		var hx = 37.331017;
		var m1x = 37.369117;
		var m2x = 37.460659;
		var d2x = 37.482277;
		var m3x = 37.455704;
		var d3x = 37.480828;

		var hy = 126.937448;
		var m1y = 126.869631;
		var m2y = 126.890344;
		var d2y = 126.878965;
		var m3y = 126.797329;
		var d3y = 126.749652;

		var hm1x = (m1x - hx) / 7;
		var hm1y = (m1y - hy) / 7;

		var m21x = (m2x - m1x) / 10;
		var m21y = (m2y - m1y) / 10;
		var dm2x = (d2x - m2x) / 4;
		var dm2y = (d2y - m2y) / 4;

		var m31x = (m3x - m1x) / 10;
		var m31y = (m3y - m1y) / 10;
		var dm3x = (d3x - m3x) / 4;
		var dm3y = (d3y - m3y) / 4;

		t1x = hx - 0.001;
		t1y = hy;
		t2x = hx - 0.001;
		t2y = hy + 0.001;
		t3x = hx - 0.001;
		t3y = hy + 0.002;

		var mapOptions = {
			center : new naver.maps.LatLng(37.418287, 126.848446),
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

		var t1 = {
			url : './resources/images/truck_b.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};
		var truck1 = new naver.maps.Marker({
			position : new naver.maps.LatLng(t1x, t1y),
			map : map,
			icon : t1
		});

		var t2 = {
			url : './resources/images/truck_g.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var truck2 = new naver.maps.Marker({
			position : new naver.maps.LatLng(t2x, t2y),
			map : map,
			icon : t2
		});

		var t3 = {
			url : './resources/images/truck_r.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var truck3 = new naver.maps.Marker({
			position : new naver.maps.LatLng(t3x, t3y),
			map : map,
			icon : t3
		});

		var h1 = {
			url : './resources/images/dest_b.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var home = new naver.maps.Marker({
			position : new naver.maps.LatLng(hx, hy),
			map : map,
			icon : h1
		});

		var d2 = {
			url : './resources/images/dest_r.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var dest2 = new naver.maps.Marker({
			position : new naver.maps.LatLng(d2x, d2y),
			map : map,
			icon : d2
		});

		var d3 = {
			url : './resources/images/dest_g.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(16, 32)
		};

		var dest3 = new naver.maps.Marker({
			position : new naver.maps.LatLng(d3x, d3y),
			map : map,
			icon : d3
		});

		var m1 = {
			url : './resources/images/marker_b.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(0, 32)
		};

		/* var marker11 = new naver.maps.Marker({
			position : new naver.maps.LatLng(37.344197, 126.860334),
			map : map,
			icon : m1
		}); */

		var marker1 = new naver.maps.Marker({
			position : new naver.maps.LatLng(m1x, m1y),
			map : map,
			icon : m1
		});

		var m2 = {
			url : './resources/images/marker_r.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(0, 32)
		};

		var marker2 = new naver.maps.Marker({
			position : new naver.maps.LatLng(m2x, m2y),
			map : map,
			icon : m2
		});

		var m3 = {
			url : './resources/images/marker_g	.png',
			size : new naver.maps.Size(32, 32),
			origin : new naver.maps.Point(0, 0),
			anchor : new naver.maps.Point(0, 32)
		};

		var marker3 = new naver.maps.Marker({
			position : new naver.maps.LatLng(m3x, m3y),
			map : map,
			icon : m3
		});

		for (var i = 0; i < 25; i++) {
			(function(i) {
				setTimeout(function() {
					if (i < 8) {
						console.log(i);
						t3x = hx + hm1x * i - 0.002;
						t3y = hy + hm1y * i + 0.002;

						t2x = hx + hm1x * i;
						t2y = hy + hm1y * i;
					} else if (i < 18) {
						console.log(i);
						t3x = m1x + m21x * (i - 7);
						t3y = m1y + m21y * (i - 7);

						t2x = m1x + m31x * (i - 7);
						t2y = m1y + m31y * (i - 7);
					} else if (i < 22) {
						console.log(i);
						t3x = m2x + dm2x * (i - 17);
						t3y = m2y + dm2y * (i - 17);

						t2x = m3x + dm3x * (i - 17);
						t2y = m3y + dm3y * (i - 17);
					} else {
						t3x = d2x;
						t3y = d2y;

						t2x = d3x;
						t2y = d3y;
					}
					truck2.setPosition(new naver.maps.LatLng(t2x, t2y));
					truck3.setPosition(new naver.maps.LatLng(t3x, t3y));

					naver.maps.Service.reverseGeocode({
						location : new naver.maps.LatLng(t2x, t2y),
					}, function(status, response) {
						if (status !== naver.maps.Service.Status.OK) {
							return alert('Something wrong!');
						}
						var result = response.result, // 검색 결과의 컨테이너
						items = result.items; // 검색 결과의 배열
						console.log(items[0].address);
						$("#table-1 tr:eq(1) td:eq(3)").text(items[0].address);
					});
					
					naver.maps.Service.reverseGeocode({
						location : new naver.maps.LatLng(t3x, t3y),
					}, function(status, response) {
						if (status !== naver.maps.Service.Status.OK) {
							return alert('Something wrong!');
						}
						var result = response.result, // 검색 결과의 컨테이너
						items = result.items; // 검색 결과의 배열
						console.log(items[0].address);
						$("#table-1 tr:eq(2) td:eq(3)").text(items[0].address);
					});
				}, 1000 * i);
			})(i);
		}
	</script>

	<form>
		<p id="box1"></p>
		<div class="custom-control custom-switch" id="box2">
			<input type="checkbox" class="custom-control-input" id="switch1"
				checked data-toggle="toggle"> <label
				class="custom-control-label" for="switch1">Auto</label>
		</div>

		<div id="hide">
			<button type="button" id="fo">
				<i class="fas fa-arrow-circle-up fa-3x"></i>
			</button>

			<button type="button" id="bw">
				<i class="fas fa-arrow-circle-down fa-3x"></i>
			</button>

			<button type="button" id="lf">
				<i class="fas fa-arrow-circle-left fa-3x"></i>
			</button>

			<button type="button" id="rf">
				<i class="fas fa-arrow-circle-right fa-3x"></i>
			</button>

			<button type="button" id="lb">
				<i class="fas fa-arrow-circle-left fa-3x"></i>
			</button>

			<button type="button" id="rb">
				<i class="fas fa-arrow-circle-right fa-3x"></i>
			</button>

			<button type="button" id="st">
				<i class="fas fa-ban fa-3x"></i>
			</button>
		</div>
	</form>

	<div class="row" style="margin-left: 20px;">
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
							<div class="progress-bar progress-bar-warning" style="width: 40%"></div>
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
							<div class="progress-bar progress-bar-success" style="width: 90%"></div>
						</div>
					</td>
					<td>18'C / 10%</td>
					<td>-</td>
				</tr>
			</tbody>
		</table>
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
				$("label").text("Auto");
				//alert($("#switch1").prop("checked"));
			} else if (state == "Manual") {
				$("#switch1").prop("checked", false);
				$("#hide").show();
				$("label").text("Manual");
				//alert($("#switch1").prop("checked"));
			}
		});

		$("label").click(function() {
			if (state == "Auto") {
				$("#table-1 tr:eq(" + no + ") td:eq(4)").text("Manual");
				state = $("#table-1 tr:eq(" + no + ") td:eq(4)").text();
				$(this).text("Manual");
			} else if (state == "Manual") {
				$("#table-1 tr:eq(" + no + ") td:eq(4)").text("Auto");
				state = $("#table-1 tr:eq(" + no + ") td:eq(4)").text();
				$(this).text("Auto");
			}
			$("#hide").toggle();
		});
	</script>

</body>
</html>
