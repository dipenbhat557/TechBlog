package com.BlogServlets;

import java.io.IOException;
import com.BlogEntities.*;
import java.io.PrintWriter;
import com.BlogDAO.*;
import com.BlogHelper.*;
import com.BlogEntities.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class LoginServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String useremail = request.getParameter("email");
		String password = request.getParameter("password");

		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		User user = dao.getUserByEmailandPw(useremail, password);

		if (user == null) {
			Message msg = new Message("Invalid Details ! Try with another", "error", "alert-danger");
			response.sendRedirect("LoginPage.jsp");
			HttpSession session = request.getSession();
			session.setAttribute("msg",msg);
		} else {
			HttpSession s = request.getSession();
			s.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
		}
	}
}
