<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
<%@ page import="com.BlogDAO.*" %>
<%@ page import="com.BlogEntities.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>


<!-- Display the search query -->
<p>Search results for: <%= request.getParameter("query") %></p>

<!-- Display the search results -->
<%
    ArrayList<Posts> results = (ArrayList<Posts>) request.getAttribute("results");
    for (Posts post : results) {
%>
    <div>
        <h2><%= post.getpTitle() %></h2>
        <p><%= post.getpContent() %></p>
    </div>
<%
    }
%>
</body>
</html>