<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8"  />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>王成</title>
		<link href="${ctx}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
		<script src="${ctx}/static/jquery/jquery-3.2.0.min.js"></script>
		<script src="${ctx}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
		<link href="${ctx}/static/admin/dashboard.css" rel="stylesheet">
	</head>
	<body>
		
		<%@ include file="top.jsp" %>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-3 col-md-2 sidebar">
					<%@include file="left.jsp"%>
				</div>
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				