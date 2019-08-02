<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="${contextPath}/resources/assets/plugins/switchery/switchery.min.css" rel="stylesheet" />	
<style>
	a.disabled {
	  pointer-events: none;
	  cursor: default;
	}
	
	.form-horizontal.form-bordered .form-group {
		border-bottom: 1px solid #2d353c;
	}
	
	.form-horizontal.form-bordered .form-group>div {
		border-left: 1px solid #2d353c;
	}
	
	.form-horizontal.form-bordered .form-group>.control-label {
		border-right: 1px solid #2d353c;
	}
	
	.btn-default.active {
	    background: #FFC107;
	}
	
	
</style>

<!-- begin page-header -->
<h1 class="page-header" style="color:white;">자율주행 설정 <small>Autonomous car manipulation</small></h1>
<!-- end page-header -->

<div class="row">
	<div class="col-md-8 col-sm-12" style="width:690px;">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
				</div>
				<h4 class="panel-title">Viewer</h4>
			</div>
			<div class="panel-body">
				<img id="video" src="${contextPath}/resources/images/no-image.png" width="640" />
			</div>
		</div>
	</div>
	
	<div class="col-md-4 col-sm-12" style="width:480px;">
		<form class="form-horizontal form-bordered text-white">
			<div class="form-group">
				<label class="col-md-3 control-label text-white">Autonomous</label>
				<div class="col-md-9" style="padding-bottom:0px">
					<input id="auto-mode" type="checkbox" data-render="switchery" data-theme="red" />
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-3 control-label text-white">Status</label>
				<input type="hidden" id="refresh-time"/>
				<div id="status-pan" class="col-md-9" style="padding-bottom: 0px;padding-top: 20px;">
					<i class="fa fa-unlink f-s-18 text-danger"> </i> Disconnected
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-3 control-label text-white">Direction</label>
				<div id="dir-pan" class="col-md-9" style="padding-bottom: 0px;padding-top: 20px;"></div>
			</div>
			<div class="form-group" id="manipulate-pan">
				<label class="col-md-3 control-label text-white">Manipulation</label>
				<div class="col-md-9">
					<a class="btn btn-icon btn-circle btn-lg disabled"><i class="fa"></i></a>
					<a id="btn-up" data-direction="FORWARD" class="btn btn-default btn-icon btn-circle btn-lg btn-dir"><i class="fa fa-long-arrow-up"></i></a>
					<a class="btn btn-icon btn-circle btn-lg disabled"><i class="fa"></i></a><br>
					<p style="margin-top:3px;">
						<a href="javascript:;" id="btn-left" data-direction="LEFT" class="btn btn-default btn-icon btn-circle btn-lg btn-dir"><i class="fa fa-long-arrow-left"></i></a>
						<a id="btn-down" data-direction="BACK" class="btn btn-default btn-icon btn-circle btn-lg btn-dir"><i class="fa fa-long-arrow-down"></i></a>
						<a id="btn-right" data-direction="RIGHT"  class="btn btn-default btn-icon btn-circle btn-lg btn-dir"><i class="fa fa-long-arrow-right"></i></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(direction)
					</p>
					<p>
						<a id="btn-stop" data-direction="STOP" class="btn btn-default btn-icon btn-circle btn-lg btn-dir" style="width:150px;"><i class="fa fa-minus"></i></a>
						&nbsp;&nbsp;&nbsp;(stop)
					</p>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-12" style="padding-bottom: 0px;padding-top: 20px;">
					<div class="panel panel-inverse">
						<div class="panel-heading">
							<div class="panel-heading-btn">
								<a href="javascript:clear();" class="btn btn-xs btn-icon btn-circle btn-info" ><i class="fa fa-repeat"></i></a>
								<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
								<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
								<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
							</div>
							<h4 class="panel-title">Log</h4>
						</div>
						<div class="panel-body bg-black">
							<div id="logger" class="p-10" data-scrollbar="true" data-height="200px" >
							<!-- logger -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<script src="${contextPath}/resources/assets/plugins/switchery/switchery.min.js"></script>
<script src="${contextPath}/resources/assets/js/form-slider-switcher.demo.min.js"></script>	
<script>
	
	var update = new Date();
	
	Date.prototype.timeNow = function () {
	    return ((this.getHours() < 10)?"0":"") + this.getHours() +":"+ ((this.getMinutes() < 10)?"0":"") + this.getMinutes() +":"+ ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
	}
	
	function clear() {
		$("#logger").empty();
	}
	
	function updateScroll(){
	    var element = document.getElementById("logger");
	    element.scrollTop = element.scrollHeight;
	}
	
	function manipulate(id) {
		$(".btn-dir").removeClass('active');
		$("#"+id).addClass('active');
	}
	
	function setDirection(dir) {
		
		var left = `<i class="fa fa-arrow-left f-s-18 text-warning"> </i> left`;
		var right = `<i class="fa fa-arrow-right f-s-18 text-warning"> </i> right`;
		var back = `<i class="fa fa-arrow-down f-s-18 text-warning"> </i> back`;
		var forward = `<i class="fa fa-arrow-up f-s-18 text-warning"> </i> forward`;
		var stop = `<i class="fa fa-circle f-s-15 text-warning"> </i> stop`;
		
		switch(dir) {
		case 'LEFT': $("#dir-pan").html(left); break;
		case 'RIGHT': $("#dir-pan").html(right); break;
		case 'FORWARD': $("#dir-pan").html(forward); break;
		case 'BACK': $("#dir-pan").html(back); break;
		case 'STOP': $("#dir-pan").html(stop); break;
		}
	}
	
	function setStatus(isConnected) {
		var connect = `<i class="fa fa-chain f-s-18 text-primary"> </i> Connected`;
		var disconnect = `<i class="fa fa-unlink f-s-18 text-danger"> </i> Disconnected`;
		$("#status-pan").html(isConnected == 1 ? connect : disconnect);		
	}
	
	$(function () {
		App.init();
		FormSliderSwitcher.init();
		
		if(!window.WebSocket) {
			alert('웹 소켓을 지원하지 않는 브라우저 입니다.');
			return;
		}
		
		// Connection check
		setInterval(function () {
			// connected
			if(Math.abs(update - new Date()) > 2000) {
				//setStatus(0);
				$("#video").attr('src', '${contextPath}/resources/images/no-image.png');
			}
			else {
				if ($("#video").attr('src') != 'camera/1') {
					$("#video").attr('src', 'camera/1');
				}
			}
		}, 1000);
		
		$("#auto-mode").change(function () {
			
			if ($("#video").attr('src') != 'camera/1') return ;
			
			autoMode = 0;
			direction = '';
			if($(this).is(":checked")) {
				$("#manipulate-pan").hide();
				autoMode = 1;
				direction = '';	
			}
			else {
				$("#manipulate-pan").show();
				autoMode = 0;
				direction = 'STOP';	// 수동 조작 모드 시, 일단 정지한다.
			}
			
			msg = JSON.stringify({
				msgType: "CONTROL",
				target: 1,
				isAutoMode: autoMode,
				direction: direction
			});
			socket.send(msg);
		});
		
		/*
		* car control & status websocket 
		*/
		var socket = new WebSocket("ws://70.12.109.136/autocar/car");
		
		socket.onopen = function(){
			console.log('websocket is connected');
			
			msg = JSON.stringify({
					"msgType": "STATUS_SUB",
					"target": 1
			});
			socket.send(msg);
			
			msg = JSON.stringify({
				"msgType": "LOG_SUB",
				"target": 1
			});
			socket.send(msg);
			
		}
		
		socket.onmessage = function(msg){
			//console.log('message : ', msg.data);
			data = JSON.parse(msg.data)
			if(data.msgType=="STATUS"){
				
				// direction 
				setDirection(data.direction);
				
				// status
				setStatus(data.connected);
			}
			else if(data.msgType=="LOG"){
				
				var newDate = new Date();
				$("#logger").append("["+newDate.timeNow()+"] "+data.content+"<br>");
				updateScroll();
			}
			update = new Date();
			
		}
		
		socket.onclose = function(){
			console.log('websocket is disconnected.');
		}
		
		socket.onerror = function(err){
			console.log("[ERROR]", err);
		}
		
		$('.btn-dir').click(function(){
			
			// 자율 주행 모드 혹은 서버와의 연결 안되어있을 때, 수동 조작 불가
			if($("#auto-mode").is(":checked") || $("#video").attr('src') != 'camera/1') return ;
			
			direction = $(this).data('direction');
			setDirection(direction);
			
			msg = JSON.stringify({
				msgType: "CONTROL",
				target: 1,
				isAutoMode: 0,
				direction: direction
			});
			socket.send(msg);
		});
		
		/*
		* End of websocket 
		*/
	});
	
	// 키보드 이벤트 처리
	document.onkeyup = function(e) {
		if($("#auto-mode").is(":checked") || $("#video").attr('src') != 'camera/1') return ;
		
		switch(e.which) {
		case 32: // space
			manipulate('btn-stop');
			$("#btn-stop").click();
			break;
		case 37: // left
			manipulate('btn-left');
			$("#btn-left").click();
			break;
		case 38: // up
			manipulate('btn-up');
			$("#btn-up").click();
			break;
		case 39: // right
			manipulate('btn-right');
			$("#btn-right").click();
			break;
		case 40: // down
			manipulate('btn-down');
			$("#btn-down").click();
			break;
		}
	};
	
	
</script>
