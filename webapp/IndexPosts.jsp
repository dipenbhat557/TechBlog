<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.BlogEntities.*"%>
<%@ page import="com.BlogDAO.*"%>
<%@ page import="com.BlogHelper.*"%>
<%@ page import="java.util.*"%>

<div class="row">
	<%
	PostDao dao = new PostDao(ConnectionProvider.getConnection());

	int cId = Integer.parseInt(request.getParameter("cId"));
	List<Posts> posts = new LinkedList<Posts>();

	if (cId == 0) {
		posts = dao.getAllPosts();
	} else {
		posts = dao.getPostByCatId(cId);
	}
	if (posts.size() == 0) {
		out.println("<h3 class='display-3 text-center'>No posts in this category</h3>");
		return;
	}
	int count=1;
	for (Posts p : posts) {
		if(count<=9){
	%>
	<div class="col-md-4 mt-2">
		<div class="card text-white card-hover index-border index-ko-color">
			<img class="card-img-top" src="Blog_pics/<%=p.getpPic()%>"
				alt="Blog_pics/default.png" style="height: 150px; overflow: hidden;">
			<div class="card-body">
				<b><%=p.getpTitle()%></b>
				<p style="height: 100px; overflow: hidden;"><%=p.getpContent()%></p>
			</div>
			<div class="card-footer bg-dark text-center">
				<%
				User user = (User) session.getAttribute("currentUser");
				LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
				%>
				<a href="LoginPage.jsp" class="btn btn-outline-light btn-sm"><i
					class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ldao.countLikeOnPost(p.getpId())%></span></a>

				<a href="LoginPage.jsp" class="btn  btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"></i><span>5</span></a> <a
					href="showBlogPage.jsp?pId=<%=p.getpId()%>"
					class="btn  btn-outline-light btn-sm"> Read More...</a>

			</div>
		</div>
	</div>
	<%
		}
		count++;
	}
	%>
</div>
<style>
.index-ko-color{
background:#000000 !important;
}
.card-hover:hover {
  transform: translateY(-5px);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.9);
  border-color: bg-secondary !important; /* Add !important to override Bootstrap styles */
}
.index-border {
  border: 5px solid #000000 !important;
  border-radius: 15px;
}
</style>