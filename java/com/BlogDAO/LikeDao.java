package com.BlogDAO;

import java.sql.*;

import com.BlogEntities.User;
import com.BlogHelper.ConnectionProvider;


public class LikeDao {
	
	Connection conn;
	
	public LikeDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean insertLike(int pId, int uId) {
		boolean f=false;
		try {
			String query = "insert into likes(pId,uId) values(?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1,pId);
			pstmt.setInt(2,uId);
			
			pstmt.executeUpdate();
			
			f=true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public int countLikeOnPost(int pId) {
		int count = 0;
		
		try {
			String query = "select count(*) from likes where pid = ?";
			
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				count = set.getInt("count(*)");
			}
			
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}

	public boolean isLikedByUser(int pId, int uId) {
		boolean f = false;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from likes where pId = ? and uId = ?");
			
			pstmt.setInt(1,pId);
			pstmt.setInt(2, uId);
			
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				f = true;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}

	public boolean deleteLike(int pId,int uId) {
		boolean f = false;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement("delete from likes where pId=? and uId=?");
			
			pstmt.setInt(1,pId);
			pstmt.setInt(2, uId);
			
			pstmt.executeUpdate();
			
			f=true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}

}
