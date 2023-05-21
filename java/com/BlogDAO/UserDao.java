package com.BlogDAO;

import java.sql.*;

import com.BlogEntities.User;
import com.BlogHelper.ConnectionProvider;

public class UserDao {
	
	private Connection conn;
	
	public UserDao(Connection conn) {
		this.conn = conn;
	}
	
	public boolean saveUser(User user) {
		boolean f = false;
		try {
			String query="insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			
			f=true;
			
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	//get user by useremail and password
	public User getUserByEmailandPw(String email,String password) {
		User user = new User();
		
		try {
			String query = "select * from user where email = ? and password = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2,password);
			
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				user = new User();
				String name = set.getString("name");
				user.setName(name);
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("reg_date"));
				user.setProfile(set.getString("profile"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public boolean updateUser(User user) {
		boolean f= false;
		try {
			String query = "update user set name = ?, email = ?, password = ?, about = ?, profile=? where id = ?";
			
			PreparedStatement pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAbout());
			pstmt.setString(5, user.getProfile());
			pstmt.setInt(6, user.getId());
			
			pstmt.executeUpdate();
			f=true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public User getUserByUserId(int UserId) {
		User user = new User();
		
		String query = "select * from user where id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, UserId);
			
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				user = new User();
				String name = set.getString("name");
				user.setName(name);
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("reg_date"));
				user.setProfile(set.getString("profile"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return user;
	}
	

}
