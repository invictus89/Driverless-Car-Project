<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://d3js.org/topojson.v1.min.js"></script>
<script src="https://www.kaptest.com/static/js/jquery.qtip.js"></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/countup.js/1.8.2/countUp.min.js'></script>
  
<style>
	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
	    border-color: none !important;
	    padding: 10px 15px;
	    background: #2d353c;
	    border: 0px solid black;
	    color: white;
	}
	#page-container {
		min-width:1000px !important;
	}
	svg circle {
	  fill: orange;
	  opacity: .5;
	  stroke: white;
	}
	svg circle:hover {
	  fill: #F44336;
	  stroke: #333;
	}
	
	svg text {
	  pointer-events: none;
	}
	
	svg .municipality {
	  fill: #5e6b77;
	  stroke: #a1abb5;
	  stroke-width: 1;
	}
	
	svg .municipality:hover {
	  stroke-width: 3 !important;
	}
	
	svg .municipality-label {
	  fill: white;
	  font-size: 12px;
	  text-anchor: middle;
	}
	
	svg .on {
	  stroke-width: 4 !important;
	}
	#info-box {
	  display: none;
	  position: absolute;
	  top: 0px;
	  left: 0px;
	  z-index: 1;
	  font-family: arial;
	}
		
</style>



<!-- begin page-header -->
<h1 class="page-header" style="color:white;">오늘의 적발현황 <small>자율주행 불법주차 관제 센터</small></h1>
<!-- end page-header -->

<div class="col-md-12 " style="text-align:center;">

	<div style="position:absolute;">
		<div id=visitors-donut-chart class="height-sm" style="width:300px;"></div>
	</div>

	<div class="col-md-3 col-sm-3 m-r-20" style="position:absolute;right:0px;text-align:right;">
		<div class="widget widget-stats bg-black">
			<div class="stats-title f-s-15">오늘의 적발건수</div>
			<div class="stats-number" style="font-size:45px;"><p id="total" class="count-up countupthis" numx="70" >0</p></div>
			<div class="stats-progress progress">
				<div class="progress-bar" style="width: 100%;"></div>
			</div>
			<div class="stats-desc">전일 대비 54.9% <i class="fa fa-caret-up"> </i></div>
		</div>
		<div style="text-align:left;margin-left:100px;">
			<p><i class="fa f-s-15 fa-square" style="color : #FFC107 !important;"></i> <span class=" f-s-12 text-white">약간 양호 (10 ~ 15)</span></p>
			<p><i class="fa f-s-15 fa-square text-warning"></i> <span class=" f-s-12 text-white">약간 위험 (15 ~ 20)</span></p>
			<p><i class="fa f-s-15 fa-square text-danger"></i> <span class=" f-s-12 text-white">매우 위험 (20 ~ )</span></p>
		</div>
	</div>
	
	<div id="info-box"></div>
	<div id="seoul-map" style="padding-top:50px;"></div>
</div>

<script>

	var data;
	var donut=[];
	
	var lv1 = 10;
	var lv2 = 15;
	var lv3 = 20;

	 var options = {  
       useEasing: true,
         useGrouping: true,
         separator: ',',
         decimal: '.',
         prefix: '',
         suffix: ''
     };
	
	function infoBox(sigId) {
		var obj = data.filter(function (obj) { return obj.sigId == sigId })[0];
		var cnt = obj.parkCnt;
		
		return '<div class="col-md-12 col-sm-12">'
			+'<div class="widget widget-stats" style="background:#666;border:2px solid white">'
			+'<div class="stats-info">'
			+'<h4>'+obj.sigKorNm+'</h4>'
			+'<p>'+formatNumber(cnt)+'</p>'
			+'</div>'
			+'<div class="stats-link">'
			+'</div>'
			+'</div>'
			+'</div>`';
	}
	
	function setMapColor() {
		
		data.forEach(function(obj) {
			  var cnt = obj.parkCnt;
			  var color;
			  
			  if(cnt < lv1) { color = '#5e6b77'; }
			  else if(cnt < lv2 ) { color = '#FFC107'; }
			  else if ( cnt < lv3) { color = '#f59c1a'; }
			  else { color = '#cc4d4b'; }
			  
			  $("#"+obj.sigId).css('fill',color);
		});
	}

	var colors=[
		
			];
	
	console.log("@@@!#!");
	var chart = Morris.Donut({
        element: "visitors-donut-chart",
        data: [{label : "efefef", value: 12}],
        colors: [colors],
        labelFamily: "Open Sans",
        labelColor: "rgba(255,255,255,0.4)",
        labelTextSize: "12px",
        backgroundColor: "#242a30"
    });
	
	function getData(){
		$.ajax({
			url : `${contextPath}/dashboard`, 
			type : 'post',
			dataType : 'json',
			cache : false, 
			async: false,
			success : function(d) {
				data = d.rs;
				
				var cnt = 0;
				
				var donut = [];
				
				data.forEach(function(obj) {
					cnt += obj.parkCnt;
					labelInfo = new Object();
					labelInfo.label = obj.sigKorNm;
					labelInfo.value = obj.parkCnt;
					donut.push(labelInfo);
				});
				
				chart.setData(donut);
				
				$('.countupthis').attr('numx',cnt);
				
				$('.countupthis').each(function() {
			        var num = $(this).attr('numx'); //end count
			        var nuen = $(this).text();
			        if (nuen === "") {
			          nuen = 0;
			        }
			        var counts = new CountUp(this, nuen, num, 0, 1.5, options);
			        counts.start();
			      });
				
				setMapColor();
				setTimeout(getData,1000);
			}, 
			error : function(xhr, statusText, errorThrown) { 
				console.log(`\${statusText} - \${xhr.status} , \$errorThrown`); 
			}
		}); 
	}

	$(function () {
		// app init
		App.init();
		
		getData();
		
		// map event 
		var allStates = $("#map").find("path");
		
		// map hover event 
		allStates.live("hover", function() {
			$(this).parent().find("path").attr("class","municipality");
			$(this).attr("class", "municipality on");
			
			$('#info-box').css('display','block');
			$('#info-box').html(infoBox($(this).data('info')));
			
			var pos = $(this).data('loc').split(',');
			var x = (pos[0]/1) + 100;
			var y = pos[1] - 80;
			
			$('#info-box').css('top',y+"px");
			$('#info-box').css('left',x+"px");
		});
		
		// map click event 
		allStates.live("click", function() {
			
		});
		// End of map event
		
		
	
	});
	
	// svg map width and height
	var width = 1000;
	var height = 700;
	
	// create map
	var svg = d3.select("#seoul-map").append("svg")
		.attr("width", width)
		.attr("height", height);
	
	var map = svg.append("g").attr("id", "map");
	
	var projection = d3.geo.mercator()
		.center([126.9895, 37.5651])
		.scale(115000)
		.translate([width/2, height/2]);

	var path = d3.geo.path().projection(projection);
	
	d3.json("${contextPath}/resources/seoul_municipalities_topo_simple.json", function(error, data) {
		var features = topojson.feature(data, data.objects.seoul_municipalities_geo).features;
		
		map.selectAll("path")
			.data(features)
			.enter().append("path")
			.attr("class", "municipality")
			.attr("id",function(d) { return d.properties.SIG_CD; })
			.attr("data-info",function(d) { return d.properties.SIG_CD; })
			.attr("data-loc", function(d) { return path.centroid(d) ; })
			.attr("d", path);
		
		map.selectAll("text")
			.data(features)
			.enter().append("text")
			.attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
			.attr("dy", ".35em")
			.attr("class", "municipality-label")
			.text(function(d) { return d.properties.SIG_KOR_NM; });
	});
	
	
</script>

