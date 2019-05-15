/**
 * 
 */

//스크롤 위치에 따른 메뉴바 모양을 변환하는 함수

function scrollFunction() {
	var menu = $("#mainNav");
	if (document.body.scrollTop > 400 || document.documentElement.scrollTop > 400) {
		menu.addClass("navbar-shrink");
		$(".navbar-brand").css("color", "black");
		$(".nav-link").css("color", "black");
		
	} else {
		menu.removeClass("navbar-shrink");
		$(".navbar-brand").css("color", "rgba(255,255,299,.9)");
		$(".nav-link").css("color", "rgba(255,255,299,.9)");
	}
}




/*
nction scrollFunction() {
	  if (document.body.scrollTop > 150 || document.documentElement.scrollTop > 150) {
	    document.getElementById("navbar").style.padding = "30px 10px";
	    document.getElementById("logo").style.fontSize = "25px";
	  } else {
	    document.getElementById("navbar").style.padding = "80px 10px";
	    document.getElementById("logo").style.fontSize = "35px";
	  }

$(document).ready(function(){
	  $("button").click(function(){
	    alert($("div").scrollTop() + " px");
	  });
	});

$.fn.checkUserId = function() {
	var self = this;
	var idInput = this.closest('.form-group').find('input');	// 사용자 ID 입력 input
	var msgSpan = this.next();	// 처리 결과 출력 메시지 span
	var submitBtn = $(':submit');
	
	// ID 중복 체크
	self.click(function(){
		var userId = idInput.val();
		if(!userId) return alert('사용자 ID를 입력하세요');
		
		$.get('id-check/' + userId, function(data){
			if(data.result == 'ok') {
				msgSpan.html(data.message).removeClass('error');
				submitBtn.prop('disabled', false);	// submit 버튼 활성화	
				self.prop('disabled', true);	// ID 체크 버튼 비활성화
			} else {
				msgSpan.html(data.message).addClass('error');
				submitBtn.prop('disabled', true); // submit 버튼 비활성화	
			}
		});	
	});*/