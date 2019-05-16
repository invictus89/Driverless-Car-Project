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
$(function(){
	$(".dropdown").click(function(){
		$(".dropdown-menu").css('top', 'auto').css('left', 'auto');
	});
	$('.dropdown .dropdown-menu').on({
	    "click":function(e){
	      e.stopPropagation();
	    }
	});
});