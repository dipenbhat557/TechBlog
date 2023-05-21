<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Something went wrong</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/MyStyle.css" rel="stylesheet"></link>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background{
clip-path: polygon(50% 0%, 100% 0, 100% 89%, 54% 100%, 24% 90%, 0 100%, 0 0);
}
</style>
</head>
<body>
<div class="container text-center">
<img src="img/blue-screen.png" class="image-fluid">
<h3>Sorry.. Something went wrong !!</h3>
<%= exception %><br>
<a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
</div>
</body>
</html>