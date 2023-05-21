<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.BlogEntities.*"%>
<%@ page import="com.BlogDAO.*"%>
<%@ page import="com.BlogHelper.*"%>
<%@ page import="java.util.*"%>
	
	<style>
.bar-hover:hover {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.6);
  border-radius : 15%;
  border-color: bg-secondary !important; 
}
</style>

	
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand bar-hover text-dark" href="index.jsp"><span class="	fa fa-asterisk"></span>Tech Blog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
				<a class="nav-link bar-hover text-dark" href="index.jsp"><span class="fa fa-home"></span>Home
						<span class="sr-only">(current)</span>
				</a></li>
				
				<li class="nav-item dropdown">
				<a
					class="nav-link dropdown-toggle bar-hover text-dark" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="	fa fa-check-circle-o"></span> Categories </a>
					
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" onclick="getPost(0,this)" href="#">All Categories</a> <%
						PostDao pdao = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list1 = pdao.getAllCategories();
						for (Category c : list1) {
						%>
						<a  class="dropdown-item" onclick="getPost(<%=c.getcId()%>,this)" href="#" ><%=c.getName()%></a>
						<%
						}
						%>
					</div></li>
									<li class="nav-item"><a class="nav-link bar-hover text-dark" href="ContactUs.jsp"><span class="	fa fa-address-book"></span>Contact Us</a></li>
					<li class="nav-item"><a class="nav-link bar-hover text-dark" href="LoginPage.jsp"><span class="fa fa-user-circle"></span>Log in</a></li>
					<li class="nav-item"><a class="nav-link bar-hover text-dark" href="RegisterPage.jsp"><span class="fa fa-user-plus"></span>Sign Up</a></li>
			</ul>
			
			<form class="form-inline my-2 my-lg-0" id="search" action="SearchServlet">
				<input name="query" class="form-control mr-sm-2" type="text"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-light my-2 my-sm-0  text-dark" type="submit">Search</button>
			</form>
			
		</div>
	</nav>

	<!--  javascripts -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"
		integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

	<script>
	let isGettingPost = false;
	function getPost(catId,temp){
		if (isGettingPost) {
			return;
		}

		isGettingPost = true;
		$(".dropdown-item").removeClass('active');
		
		$.ajax({
			url: "IndexPosts.jsp",
			data: {cId: catId},
		success: function(data,textStatus, jqXHR){
			console.log(data);
			$("#index-container").html(data);
			$(temp).addClass('active');
			isGettingPost = false;
		},
		error: function(jqXHR,textStatus,errorThrown){
            console.log(errorThrown);
            isGettingPost = false;
        }
		})
	}
	
	$(document).ready(function(event){
	const urlSearchParams = new URLSearchParams(window.location.search);
		const params = Object.fromEntries(urlSearchParams.entries());
		if(params.query) return;
		let allPostRef = $(".dropdown-item")[0];
		getPost(0,allPostRef);
	})
	</script>
	
	<script>

$(document).ready(function(){
    $("#index-container").show();
    $("#search").on('submit',function(event){
        event.preventDefault();
        let form = new FormData(this);
        $.ajax({
            url: "SearchServlet",
            type: "POST",
            data: form,
            success: function(data,textStatus,jqXHR){
                $("#search-container").show();
                $("#index-container").hide();
                document.body.innerHTML = data;
                console.log("code ran sucessfully");
            },
            error: function(jqXHR,textStatus,errorThrown){
                console.log(errorThrown);
            },
            processData: false,
            contentType: false
        });
    }); 
});

	</script>
	