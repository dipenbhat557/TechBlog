<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.BlogEntities.*"%>
<%@ page import="com.BlogDAO.*"%>
<%@ page import="com.BlogHelper.*"%>
<%@ page import="java.util.*"%>

<div class="row">
	<%
	Thread.sleep(1000);
	PostDao dao = new PostDao(ConnectionProvider.getConnection());

	int cId = Integer.parseInt(request.getParameter("cId"));
	List<Posts> posts = new LinkedList<Posts>();

	if (cId == 0) {
		posts = dao.getAllPosts();
	%>
	<div class="container card primary-background">
		<h4>All Posts</h4>
	</div>
	<%
	} else {
	%>
	<div class="container card primary-background">
		<h4><%=dao.getCategoryNameByCatId(cId)%></h4>
	</div>
	<%
	posts = dao.getPostByCatId(cId);
	}
	if (posts.size() == 0) {
	out.println("<h3 class='display-3 text-center'>No posts in this category</h3>");
	return;
	}
	for (Posts p : posts) {
	%>

	<div class="col-md-4 mt-3">
		<div class="card my-border card-hover" style="border-width: 2px;">
			<img class="card-img-top rounded-top"
				src="Blog_pics/<%=p.getpPic()%>" alt="Blog_pics/default.png"
				style="height: 100px; overflow: hidden;">
			<div class="card-body bg-secondary">
				<b><%=p.getpTitle()%></b>
				<p style="height: 150px; overflow: hidden;"><%=p.getpContent()%></p>
			</div>

			<div class="card-footer primary-background text-center  rounded">
				<%
				User user = (User) session.getAttribute("currentUser");
				LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
				%>
					<a href="#"
							onclick="doLike(<%=p.getpId()%>,<%=user.getId()%>)"
							class="btn btn-outline-light btn-sm"><i
							class="fa fa-thumbs-o-up"></i>
							<span class="like-counter"><%=ldao.countLikeOnPost(p.getpId())%></span></a>
					<a href="#" class="btn  btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>5</span></a>
					<a href="showBlogPage.jsp?pId=<%=p.getpId()%>" class="btn  btn-outline-light btn-sm"> Read More...</a>
			</div>
		</div>
	</div>
	<%
	}
	%>
</div>

<script src="js/Myjs.js"></script>
