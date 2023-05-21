<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="ErrorPage.jsp"%>
<%@ page import="com.BlogEntities.*"%>
<%@ page import="com.BlogDAO.*"%>
<%@ page import="com.BlogHelper.*"%>
<%@ page import="java.util.*"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("LoginPage.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
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

.new-background {
	background: url(img/techblogdipen.avif);
	background-size: cover;
	background-attachment: fixed;
}


</style>
</head>
<body>
	<div class="card new-background">
		<div class="card-header">
			<nav class="navbar navbar-expand-lg navbar-dark primary-background">
				<a class="navbar-brand text-dark" href="index.jsp"><span
					class="	fa fa-asterisk"></span>Tech Blog</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item active"><a class="nav-link text-dark"
							href="index.jsp"><span class="	fa fa-home"></span>Home <span
								class="sr-only">(current)</span> </a></li>

						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle text-dark" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"><span class="	fa fa-check-circle-o"></span>
								Categories </a>

							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="#" onclick="getPosts(0,this)">All
									Categories</a>
								<%
								PostDao pdao = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list1 = pdao.getAllCategories();
								for (Category c : list1) {
								%>
								<a href="#" onclick="getPosts(<%=c.getcId()%>,this)"
									class="dropdown-item"><%=c.getName()%></a>
								<%
								}
								%>

							</div></li>

						<li class="nav-item"><a class="nav-link text-dark" href="ContactUs.jsp"><span
								class="	fa fa-address-book"></span>Contact Us</a></li>

						<li class="nav-item"><a class="nav-link text-dark" href="#"
							data-toggle="modal" data-target="#add-post-modal"><span
								class="	fa fa-asterisk"></span>Do Post</a></li>

					</ul>

					<ul class="navbar-nav mr-right">
						<li class="nav-item "><a class="nav-link text-dark" href="#!"
							data-toggle="modal" data-target="#profile-modal"><span
								class="fa fa-user-secret"></span><%=user.getName()%></a></li>
						<li class="nav-item"><a class="nav-link text-dark" href="LogOutServlet"><span
								class="fa fa-user-circle"></span>Log Out</a></li>
					</ul>

				</div>
			</nav>
		</div>

		<!-- navbar ended -->

		<%
		Message m = (Message) session.getAttribute("msg");
		if (m != null) {
		%>
		<div class="alert <%=m.getCssClass()%>" role="alert">
			<%=m.getContent()%>
		</div>
		<%
		session.removeAttribute("msg");
		}
		%>

		<!-- Main body of the page-->

		<main>
			<div class="card-body">
				<div class="container-fluid">
					<div class="row mt-4">
						<!-- first column -->
						<div class="col-md-2">
							<!-- categories -->
							<div class="list-group ">
								<a href="#" onclick="getPosts(0,this)"
									class="c-link list-group-item list-group-item-action active">
									All Posts </a>
								<%
								for (Category c : list1) {
								%>
								<a href="#" onclick="getPosts(<%=c.getcId()%>,this)"
									class="c-link list-group-item list-group-item-action"><%=c.getName()%></a>
								<%
								}
								%>
							</div>
						</div>
						<!-- second column -->
						<div class="col-md-10">
							<!-- posts-->
							<div class="container text-center" id="loader">
								<i class="fa fa-refresh fa-4x fa-spin"></i>
								<h3 class="mt-4">Loading...</h3>
							</div>
							<div class="container-fluid" id="post-container">
							
							</div>
							</div>
					</div>
				</div>
			</div>
			<div class="card-footer text-center primary-background mb-2">
			<a href="ContactUs.jsp">Contact Us</a>
			<h6><b>Copyright &copy 2023 TechBlog</b></h6>
			</div>
		</main>


		<!-- profile modal-->

		<!-- Modal -->
		<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header primary-background text-white text-center">
						<h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container text-center">
							<img src="pics/<%=user.getProfile()%>" class="img-fluid"
								style="border-radius: 95%; max-width: 150px">
							<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
							<div id="profile-details">
								<table class="table">

									<tbody>
										<tr>
											<th scope="row">ID</th>
											<td><%=user.getId()%></td>

										</tr>
										<tr>
											<th scope="row">Email</th>
											<td><%=user.getEmail()%></td>

										</tr>
										<tr>
											<th scope="row">Gender</th>
											<td><%=user.getGender()%></td>

										</tr>
										<tr>
											<th scope="row">Status</th>
											<td><%=user.getAbout()%></td>

										</tr>

										<tr>
											<th scope="row">Registered On</th>
											<td><%=user.getDateTime().toString()%></td>

										</tr>

									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- profile edit -->
					<div id="profile-edit" style="display: none; margin-left: 20px;">
						<h3 class="mt-2 text-center">Please edit carefully</h3>
						<form action="EditServlet" method="post"
							enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td>ID :</td>
									<td><%=user.getId()%></td>
								</tr>

								<tr>
									<td>Name :</td>
									<td><input type="text" class="form-control"
										name="user_name" value="<%=user.getName()%>"></td>
								</tr>

								<tr>
									<td>Email :</td>
									<td><input type="email" class="form-control"
										name="user_email" value="<%=user.getEmail()%>"></td>
								</tr>

								<tr>
									<td>Password :</td>
									<td><input type="password" class="form-control"
										name="user_password" value="<%=user.getPassword()%>"></td>
								</tr>

								<tr>
									<td>Gender :</td>
									<td><%=user.getGender().toUpperCase()%></td>
								</tr>

								<tr>
									<td>About :</td>
									<td><textarea rows="3" class="form-control"
											name="user_about">
									<%=user.getAbout()%>
									</textarea></td>
								</tr>

								<tr>
									<td>New profile:</td>
									<td><input type="file" class="form-control" name="image"></td>
								</tr>
							</table>

							<div class="container text-center">
								<button type="submit" class="btn primary-background text-center">Save
									Changes</button>
							</div>
						</form>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" id="edit-profile-button"
							class="btn primary-background">Edit</button>
					</div>
				</div>
			</div>
		</div>


		<!-- add post modal -->

		<div class="modal fade" id="add-post-modal" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Provide the
							post details</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="add-post-form" action="AddPostServlet" method="post">

							<div class="form-group">
								<select class="form-control" name="cId">
									<option selected disabled>Select Categories</option>
									<%
									ArrayList<Category> list = pdao.getAllCategories();
									for (Category c : list) {
									%>
									<option value="<%=c.getcId()%>"><%=c.getName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="form-group">
								<input name="pTitle" type="text" placeholder="Enter post title"
									class="form-control">
							</div>

							<div class="form-group">
								<textarea name="pContent" class="form-control"
									placeholder="Enter your content" style="height: 200px;"></textarea>
							</div>

							<div class="form-group">
								<textarea name="pCode" class="form-control"
									placeholder="Enter your program (if any)"
									style="height: 200px;"></textarea>
							</div>

							<div class="form-group">
								<label>Select your pic : </label> <input name="profile"
									type="file">
							</div>

							<div class="container text-center">
								<button type="submit" class="btn btn-outline-primary">Post</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>
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

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>


	<script src="js/Myjs.js"></script>

	<script>
		$(document).ready(function() {
			let editStatus = false;
			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$("#profile-details").hide();
					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$("#profile-details").show();
					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit");
				}
			});
		});
	</script>
	<!--post js-->
	<script>
		$(document).ready(function() {
			$("#add-post-form").on('submit', function(event) {
				event.preventDefault();
				console.log("you have clicked on submit...");
				let form = new FormData(this);
				//requesting server
				$.ajax({
					url : "AddPostServlet",
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data);
						if (data.trim() == 'done') {
							swal("Good job!", "Saved Successfully", "success");
						} else {
							swal("Error!", "Something went wrong !!", "error");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						swal("Error!", "Something went wrong !!", "error");
					},
					processData : false,
					contentType : false
				})
			})

		})
	</script>
	<!-- -loading post using ajax -->
	<script>

//getting posts
isGettingPosts = false;
function getPosts(catId, temp) {
	if (isGettingPosts) {
		return;
	}

	isGettingPosts = true;

	$("#loader").show();
	$("#post-container").hide();
	$(".c-link").removeClass('active');

	$.ajax({
		url: "Load_posts.jsp",
		data: { cId: catId },
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			$("#loader").hide();
			$("#post-container").show();
			$("#post-container").html(data);
			$(temp).addClass('active');
			isGettingPosts = false;
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(data)
			isGettingPosts = false;
		}
	})
}


//getting all posts
$(document).ready(function(event) {
	let allPostRef = $(".c-link")[0];

	getPosts(0, allPostRef);
})

</script>
	
</body>
</html>