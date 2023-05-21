<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.BlogHelper.*"%>
<%@ page import="com.BlogEntities.*"%>
<%@ page import="com.BlogDAO.*"%>
<%@ page import="com.BlogHelper.*"%>
<%@ page import="java.util.*"%>

<%@ page errorPage="ErrorPage.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index Page</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/MyStyle.css" rel="stylesheet"></link>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 89%, 54% 100%, 24% 90%, 0 100%, 0 0);
}
.index-background {
	background: url(img/techblogdipen.avif);
	background-size: cover;
	background-attachment: fixed;
}

</style>
</head>
<body>
<div class="container-fluid  primary-background">
	<%@include file="Normalnavbar.jsp"%>

	<div class="container-fluid p-0 m-0">
		<div class="jumbotron index-background text-white banner-background">
			<div class="container">
				<h1 class="display-3">Welcome to Tech BLOG</h1>
				<p>A programming language is a system of notation for writing
					computer programs.[1] Most programming languages are text-based
					formal languages, but they may also be graphical. They are a kind
					of computer language.</p>
				<p>The description of a programming language is usually split
					into the two components of syntax (form) and semantics (meaning),
					which are usually defined by a formal language.</p>
				<a href="RegisterPage.jsp" class="btn primary-background text-dark btn-outline-light btn-lg">
					<span class="fa fa-user-plus"></span><b>Try it out !!</b>
				</a> <a href="LoginPage.jsp" class="btn btn-outline-light primary-background text-dark btn-lg"> <span
					class="fa fa-user-circle fa-spin"></span><b>Login</b>
				</a>
			</div>
		</div>
	</div>
	
	<div class="container-fluid primary-background" id="index-container"></div>

	<div class="container-fluid primary-background" id="search-container">

		<!-- Display the search results -->
		<%
		ArrayList<Posts> results = (ArrayList<Posts>) request.getAttribute("results");
		if (results != null) {
		%>
		<p>
			Search results for:
			<%=request.getParameter("query")%></p>
		<%
		for (Posts p : results) {
		%>
		<div class="col-md-6 mt-2">
			<div class="card bg-secondary">
				<img class="card-img-top" src="Blog_pics/<%=p.getpPic()%>"
					alt="pics/default.png"
					style="height: 150px; overflow: hidden;">
				<div class="card-body">
					<b><%=p.getpTitle()%></b>
					<p style="height: 150px; overflow: hidden;"><%=p.getpContent()%></p>
				</div>
				<div class="card-footer primary-background text-center">
					<%
					LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
					%>
					<a href="LoginPage.jsp" class="btn btn-outline-light btn-sm"><i
						class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ldao.countLikeOnPost(p.getpId())%></span></a>

					<a href="#" class="btn  btn-outline-light btn-sm"><i
						class="fa fa-commenting-o"></i><span>5</span></a> <a
						href="showBlogPage.jsp?pId=<%=p.getpId()%>"
						class="btn  btn-outline-light btn-sm"> Read More...</a>

				</div>
			</div>
		</div>
		<%
		}
		}
		%>
	</div>
</div>
</body>
</html>