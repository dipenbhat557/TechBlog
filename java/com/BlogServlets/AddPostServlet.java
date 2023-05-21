package com.BlogServlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import com.BlogEntities.*;
import com.BlogHelper.ConnectionProvider;
import com.BlogHelper.Helper;
import com.BlogDAO.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		int cId = Integer.parseInt(request.getParameter("cId"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		Part part = request.getPart("profile");
		
		//getting current user id
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		int userId = user.getId();
		
		Posts p = new Posts(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cId, userId);
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		
		if(dao.savePost(p)) {
			String path = request.getRealPath("/")+"Blog_pics"+File.separator+part.getSubmittedFileName();
			Helper.saveFile(part.getInputStream(),path);
			out.println("done");
			
		}
		else {
			out.println("Something went wrong");
		}
	}
}
