<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Page</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/MyStyle.css" rel="stylesheet"></link>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 77% 93%, 50% 100%, 23% 93%, 0 100%, 0% 35%, 0 0);
}

</style>
</head>
<body>
<%@include file="Normalnavbar.jsp" %>
	<main class="primary-background p-0 banner-background" >
		<div class="container" style="padding-bottom:40px;">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header text-center primary-background text-white mb-1" style="padding-bottom:0px;">
						<span class="fa fa-lg fa-user-plus"></span> <br>
						<p>Register Here</p>
					</div>

					<div class="card-body">
						<form action="RegisterServlet" id="reg-form" method="post">

							<div class="form-group">
								<label for="user_name" style="padding-bottom:0px;">User Name</label> <input name="name" type="text"
									class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter user name">
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input name="email"
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input name="password"
									type="password" class="form-control" id="exampleInputPassword1"
									placeholder="Password">
							</div>
							<div class="form-group">
								<label for="gender">Gender</label>
								<br> 
								<input type="radio" id="gender" value="male" name="gender">Male
								<input type="radio" id="gender" value="female" name="gender">Female
								<input type="radio" id="gender" value="others" name="gender">Others
							</div>
							
							<div class="form-group">
							<textarea name="about" class="form-control" placeholder="Enter something about yourself"></textarea>
							</div>
							<div class="form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree terms and conditions</label>
							</div><br>
							
							<div class="container text-center" id="loader" style="display:none;">
							<span class="fa fa-refresh fa-spin fa-3x"></span>
							<h4>Please wait...</h4>
							</div>
							
							<div class="container text-center ">
							<button id="submit-btn" type="submit" class="btn btn-primary primary-background">Submit</button>
							</div>
							
							<div class="container text-center mt-4">
							<h6>Already have an account ? <a href="LoginPage.jsp">Sign in</a></h6>
							</div>
						</form>
					</div>
				</div>
			</div>
			</div>
	</main>

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
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
		
		<script>
		$(document).ready(function(){
			console.log("loaded.."),
			
			$('#reg-form').on('submit',function(event){
				event.preventDefault();
				
				let form = new FormData(this);
				$('#submit.btn').hide();
				$('#loader').show();
				//send this servlet
				$.ajax({
					url:"RegisterServlet",
					type:'POST',
					data:form,
					success: function(data,textStatus,jqXHR){
						console.log(data)
						$('#submit.btn').show();
						$('#loader').hide();
						
						if(data.trim()=='Done'){
							swal("Registered Successfully...Redirecting to login page")
							.then((value) => {
							  window.location="LoginPage.jsp"
							});
						}
						else{
							swal(data);
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
						$('#submit.btn').show();
						$('#loader').hide();
						swal("Something went wrong..");
					},
					processData :false,
					contentType:false
				});
			});
		});
		
		
		</script>
</body>
</html>