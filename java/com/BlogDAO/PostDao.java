package com.BlogDAO;

import java.sql.*;
import com.BlogEntities.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
	Connection conn;
	
	public PostDao(Connection conn) {
		this.conn=conn;
	}
	
	public ArrayList<Category> getAllCategories(){
		ArrayList<Category> list = new ArrayList<Category>();
		
		try {
			String query = "select * from categories";
			PreparedStatement pstmt = conn.prepareStatement(query);
			ResultSet set = pstmt.executeQuery();
			while(set.next()) {
				int cId = set.getInt("cId");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cId,name,description);
				list.add(c);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean savePost(Posts p) {
		boolean f = false;
		try {
			String query = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			
			pstmt.executeUpdate();
			
			f=true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public boolean deletePost(int pId) {
		boolean f= false;
		
		try {
			String query = "delete from posts where pId = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			pstmt.executeUpdate();
			
			f=true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public List<Posts> getAllPosts() {
		
		List<Posts> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts order by pId desc");
			
			ResultSet set = pstmt.executeQuery();
			
			while(set.next()) {
				int pId = set.getInt("pId");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				
				Posts post = new Posts(pId,pTitle,pContent,pCode,pPic,date,catId,userId);
				
				list.add(post);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Posts> getPostByCatId(int catId) {
		
		List<Posts> list = new ArrayList<>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts where catId = ?");
			pstmt.setInt(1, catId);
			ResultSet set = pstmt.executeQuery();
			
			while(set.next()) {
				int pId = set.getInt("pId");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int userId = set.getInt("userId");
				
				Posts post = new Posts(pId,pTitle,pContent,pCode,pPic,date,catId,userId);
				
				list.add(post);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		
		}
		return list;
	}
	
	public Posts getPostBypId(int pId) {
		
		Posts post = null ;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts where pId = ?");
			pstmt.setInt(1, pId);
			ResultSet set = pstmt.executeQuery();
			
			while(set.next()) {
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				
				post = new Posts(pId,pTitle,pContent,pCode,pPic,date,catId,userId);
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		
		}
		return post;
	}
	
	public ArrayList<Posts> searchPosts(String query){
		ArrayList<Posts> result = new ArrayList<>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts where pTitle like ?");
			pstmt.setString(1, "%" + query + "%");
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				int pId = set.getInt("pId");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp pDate = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				
				Posts posts = new Posts(pId,pTitle,pContent,pCode,pPic,pDate,catId,userId);
				
				result.add(posts);
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String getCategoryNameByCatId(int CatId) {
		String cName = null;
		
		try {
			String query= "select name from categories where cId = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1,CatId);
			
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				cName = set.getString("name");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return cName;
	}
}