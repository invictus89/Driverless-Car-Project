<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>불법주차단속시스템</title>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />

<!-- ================== BEGIN BASE CSS STYLE ================== -->
<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<link
	href="${contextPath}/resources/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css"
	rel="stylesheet" />
<link
	href="${contextPath}/resources/assets/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="${contextPath}/resources/assets/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="${contextPath}/resources/assets/css/animate.min.css"
	rel="stylesheet" />
<link href="${contextPath}/resources/assets/css/style.min.css"
	rel="stylesheet" />
<link
	href="${contextPath}/resources/assets/css/style-responsive.min.css"
	rel="stylesheet" />
<link href="${contextPath}/resources/assets/css/theme/default.css"
	rel="stylesheet" id="theme" />
<!-- ================== END BASE CSS STYLE ================== -->

<!-- ================== BEGIN PAGE LEVEL CSS STYLE ================== -->
<link
	href="${contextPath}/resources/assets/plugins/jquery-jvectormap/jquery-jvectormap.css"
	rel="stylesheet" />
<link
	href="${contextPath}/resources/assets/plugins/bootstrap-calendar/css/bootstrap_calendar.css"
	rel="stylesheet" />
<link
	href="${contextPath}/resources/assets/plugins/gritter/css/jquery.gritter.css"
	rel="stylesheet" />
<link href="${contextPath}/resources/assets/plugins/morris/morris.css"
	rel="stylesheet" />
<!-- ================== END PAGE LEVEL CSS STYLE ================== -->

<!-- ================== BEGIN BASE JS ================== -->
<script src="${contextPath}/resources/assets/plugins/pace/pace.min.js"></script>
<!-- ================== END BASE JS ================== -->

<!-- ================== BEGIN BASE JS ================== -->
<!--<script src="assets/plugins/jquery/jquery-1.9.1.min.js"></script> -->
<script
	src="${contextPath}/resources/assets/plugins/jquery/jquery-1.9.1.min.js"></script>

<script
	src="${contextPath}/resources/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<!--[if lt IE 9]>
		<script src="assets/crossbrowserjs/html5shiv.js"></script>
		<script src="assets/crossbrowserjs/respond.min.js"></script>
		<script src="assets/crossbrowserjs/excanvas.min.js"></script>
	<![endif]-->
<script
	src="${contextPath}/resources/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/jquery-cookie/jquery.cookie.js"></script>
<!-- ================== END BASE JS ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script src="${contextPath}/resources/assets/plugins/morris/raphael.min.js"></script>
<script src="${contextPath}/resources/assets/plugins/morris/morris.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/jquery-jvectormap/jquery-jvectormap.min.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/jquery-jvectormap/jquery-jvectormap-world-merc-en.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/bootstrap-calendar/js/bootstrap_calendar.min.js"></script>
<script
	src="${contextPath}/resources/assets/plugins/gritter/js/jquery.gritter.js"></script>
<script src="${contextPath}/resources/assets/js/dashboard-v2.min.js"></script>
<script src="${contextPath}/resources/assets/js/apps.min.js"></script>
<script src="${contextPath}/resources/js/common.js"></script>



<!-- ================== END PAGE LEVEL JS ================== -->
</head>
<body>
	<!-- begin #page-container -->
	<div id="page-container"
		class="fade page-sidebar-fixed page-header-fixed in page-sidebar-minified">

		<!-- HEADER Tiles -->
		<tiles:insertAttribute name="header" />

		<!-- MENU Tiles -->
		<tiles:insertAttribute name="menu" />

		<!-- begin #content -->
		<div id="content" class="content">

			<!-- BODY Tiles -->
			<tiles:insertAttribute name="body" />

		</div>
		<!-- end #content -->
		
		<!-- begin scroll to top btn -->
		<a href="javascript:;"
			class="btn btn-icon btn-circle btn-success btn-scroll-to-top fade"
			data-click="scroll-top"><i class="fa fa-angle-up"></i></a>
		<!-- end scroll to top btn -->
	</div>
	<!-- end page container -->
</body>
</html>
