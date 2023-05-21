package com.BlogServlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.BlogDAO.*;
import com.BlogHelper.ConnectionProvider;

public class LikeServlet extends HttpServlet {

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

		String operation = request.getParameter("operation");
		int uId = Integer.parseInt(request.getParameter("uId"));
		int pId = Integer.parseInt(request.getParameter("pId"));

		LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());

		if (operation.equals("like")) {
			if (ldao.isLikedByUser(pId, uId)) {
				boolean f = ldao.deleteLike(pId, uId);
				out.println("deleted");
			} else {
				boolean f = ldao.insertLike(pId, uId);
				out.println("liked");
			}
		}
	}

}
