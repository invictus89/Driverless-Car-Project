<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>

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
</script>
    
<header class="simulator-header">
	<nav class="navbar navbar-expand-lg fixed-top" id="mainNav">
		<a class="navbar-brand js-scroll-trigger" href="${contextPath}/start/intro#page-top" style="font-weight: 700">PLATOONING</a>
	
		<div class="collapse navbar-collapse" id="navbarResponsive">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item">
	            <a class="nav-link js-scroll-trigger active" href="#about">About</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link js-scroll-trigger" href="#">Members</a>
	          </li>
	          
         	<c:choose>
	        	<c:when test="${empty USER}">
        			<li class="nav-item dropdown">
						<a class="nav-link js-scroll-trigger dropdown-toggle" href="#" data-toggle="dropdown">
							Control
							<div class="dropdown-menu">
								<form action="${contextPath}/start/login" method="post">
									<div class="form-group">
										<input type="email" class="form-control" name="userId" id="email" placeholder="Enter email or username">
									</div>
									<div class="form-group">
										<input type="password" class="form-control" name="userPwd" id="pwd" placeholder="Enter your password">
									</div>
									<button type="submit" class="btn btn-primary">Log in</button>
								</form>
							</div></a></li>
	        	</c:when>
	        	<c:when test="${not empty USER}">
	        		<li class="nav-item">
	        		<!-- href="${contextPath}/member/profile/view" -->
						<a class="nav-link js-scroll-trigger" style="padding-right:4px" href="#"> 
								${USER.userId}</a></li>
					<li class="nav-item" >
						<a class="nav-link js-scroll-trigger" style="padding-left:4px" href="${contextPath}/start/logout"> 
							 로그아웃</a></li>
	        	</c:when>
	        </c:choose>
			
	         <!--  <li class="nav-item">
	            <a class="nav-link js-scroll-trigger" href="#">Control</a>
	          </li>  -->
	        </ul>
      	</div>
	</nav>
	
</header>




