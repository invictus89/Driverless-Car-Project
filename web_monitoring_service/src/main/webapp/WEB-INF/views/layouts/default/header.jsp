<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- begin #header -->
<div id="header"
	class="header navbar navbar-default navbar-fixed-top navbar-inverse">
	<!-- begin container-fluid -->
	<div class="container-fluid">
		<!-- begin mobile sidebar expand / collapse button -->
		<div class="navbar-header">
			<a href="#" class="navbar-brand" style="width: 60px;"><span
				class="navbar-logo"></span></a>
			<button type="button" class="navbar-toggle"
				data-click="sidebar-toggled">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<!-- end mobile sidebar expand / collapse button -->

		<!-- begin header navigation right -->
		<ul class="nav navbar-nav navbar-right">
			<li>
				<form class="navbar-form full-width">
					<div class="form-group">
						<input type="text" class="form-control"
							placeholder="Enter keyword">
						<button type="submit" class="btn btn-search">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
			</li>
		</ul>
		<!-- end header navigation right -->
	</div>
	<!-- end container-fluid -->
</div>
<!-- end #header -->