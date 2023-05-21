package com.BlogServlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.BlogDAO.*;
import com.BlogEntities.Posts;
import com.BlogHelper.*;

public class DeletePostServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	
	public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		int uId = Integer.parseInt(request.getParameter("uId"));
		
//		out.println(pId);
//		out.println(uId);
		
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		Posts post = dao.getPostBypId(pId);
		if(post.getUserId()==uId) {
			dao.deletePost(pId);
			
			out.println("done");
		}
		else {
			out.println("Sorry!! The action can't be performed.. ");
		}
	}
}
