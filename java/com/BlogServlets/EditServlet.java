package com.BlogServlets;

import java.io.IOException;
import java.io.File;

import java.io.PrintWriter;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.BlogHelper.*;
import com.BlogEntities.*;
import com.BlogDAO.*;

@MultipartConfig
public class EditServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//fetching data
		String email = request.getParameter("user_email");
		String name = request.getParameter("user_name");
		String password = request.getParameter("user_password");
		String about = request.getParameter("user_about");
		Part part = request.getPart("image");
		String imageName = part.getSubmittedFileName();
	
		//get the user from the session
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setAbout(about);
		String oldFile = user.getProfile();//getting old profile image
		
		user.setProfile(imageName);//setting new profile image
		
		//updating database
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		boolean ans = dao.updateUser(user);
		if(ans) {
			String path = request.getRealPath("/")+"Blog_pics"+File.separator+user.getProfile();
			
			String oldFilePath = request.getRealPath("/")+"Blog_pics"+File.separator+oldFile;
			if(!oldFile.equals("default.png")) {
				Helper.deleteFile(oldFilePath);
			}
			
			if(Helper.saveFile(part.getInputStream(),path)) {
				Message msg = new Message("Profile details updated..", "success", "alert-success");
				session.setAttribute("msg",msg);
			}
		}
		else {
			Message msg = new Message("Something went wrong", "error", "alert-danger");
			session.setAttribute("msg",msg);
		}
		response.sendRedirect("profile.jsp");
	}


}
