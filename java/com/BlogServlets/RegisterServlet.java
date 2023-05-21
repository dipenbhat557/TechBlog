package com.BlogServlets;

import java.io.IOException;
import java.io.PrintWriter;
import com.BlogDAO.*;
import com.BlogHelper.*;
import com.BlogEntities.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		processRequest(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		processRequest(request,response);
	}
	
	public void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
			Thread.sleep(2000);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//fetching all form data
		String check =request.getParameter("check");
		if(check==null) {
			out.println("Please agree terms and conditions");
		}
		else {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String gender = request.getParameter("gender");
			String about = request.getParameter("about");
			
			User user = new User(name,email,password,gender,about);
			
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			if(dao.saveUser(user)) {
				out.println("Done");
			}
			else {
				out.println("Error");
			}
		}
	}
}
