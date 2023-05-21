package com.BlogHelper;

import java.sql.*;

public class ConnectionProvider {
	private static Connection conn;
	public static Connection getConnection() {
		try {
			
			if(conn == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BlogWeb","root","Mume@143");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}