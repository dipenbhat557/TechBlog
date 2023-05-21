<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	User user = (User)session.getAttribute("currentUser");
	if(user==null){
		response.sendRedirect("LoginPage.jsp");
	}
	%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us</title>
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
</style>
</head>


<body>
	<%@include file="Normalnavbar.jsp"%>
	
	
		<div class="jumbotron primary-background banner-background">

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-6">
				<div class="card">
				<div class="card-header my-4 text-center">
					<h2>Feedback</h2>
					</div>
					<form>
					<div class="card-body text-center">
					<div class="container my-3">
						<label for="name"><b>Name</b></label><br> <input type="text" id="name"
							name="name" placeholder="Enter your name" required> <br></div>
							<div class="container my3">
						<label for="phone"><b>Contact Number</b></label><br><input type="tel"
							id="phone" name="phone" placeholder="Enter your contact number"
							required> <br></div>
							<div class="container my-3">
							<label for="email"><b>Email</b></label><br> <input
							type="email" id="email" name="email"
							placeholder="Enter your email" required><br> 
							</div>
							<div class="container mt-4 my-3">
							<label for="message"><b>Message</b></label><br>
						<textarea id="message" name="message"
							placeholder="Enter your feedback here" required></textarea>
							</div>
						<br>
						<div class="card-footer text-center">
						<button type="submit" class="primary-background">Send</button>
						</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-header my-4 text-center">
						<h2>Contact Details</h2>
					</div>
					<div class="card-body text-center">
						<ul>
							<li class="my-3"><strong>Address:</strong> Banglore,Karnataka</li>
							<li class="my-3"><strong>Phone:</strong> 0011223344</li>
							<li class="my-3"><strong>Email:</strong> info@techblogdipen.com</li>
							<li class="my-3"><strong>Venue:</strong> <a
								style="color: rgb(1, 7, 126); text-decoration: underline;"
								href="https://www.google.com/maps/place/Jain+International+Residential+School/@12.6324194,77.4357627,15z/data=!4m6!3m5!1s0x3bcb9a769a1a6435:0x1a8b4ea915a3d8e3!8m2!3d12.6395871!4d77.4457455!16s%2Fm%2F09gl0zk">Get
									Directions</a></li>
						</ul>
					</div>
					<div class="card-footer text-center">
							<h3 class="my-3">Need Help?</h3>
							<p class="my-3">Contact our customer support team for assistance.</p>
							<a class="btn btn-contact my-4" href="https://web.whatsapp.com">Get
								in Touch</a>
					</div>
				</div>
			</div>
		</div>
	</div>


		<div class="container text-center mt-4 card">
			<h6><b>Copyright © 2023 TechBlog</b></h6>

		</div>

</div>
</body>

</html>
