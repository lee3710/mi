package semi.review;

import java.util.*;
import java.sql.*;

public class ReDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**review write*/
	public int reWrite(ReDTO dto) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="insert into s_review values(s_review_re_idx.nextval,?,?,?,?,sysdate,?,0)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getP_name());
			ps.setString(2, dto.getid());
			ps.setString(3, dto.getRe_subject());
			ps.setString(4, dto.getRe_content());
			ps.setInt(5, dto.getRe_star());
		
			int count=ps.executeUpdate();
			
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
			
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**recontent*/
	public ReDTO reContent(int idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select * from s_review where re_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			ReDTO dto=null;
			while(rs.next()) {
				int re_idx=rs.getInt("re_idx");
				String p_name=rs.getString("p_name");
				String id=rs.getString("id");
				String re_subject=rs.getString("re_subject");
				String re_content=rs.getString("re_content");
				java.sql.Date re_date=rs.getDate("re_date");
				int re_star=rs.getInt("re_star");
				int re_good=rs.getInt("re_good");
				
				dto=new ReDTO(re_idx, p_name, id, re_subject, re_content, re_date, re_star, re_good);
			}

			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	

	
	
	/**myreview*/
	public ArrayList<ReDTO> myReview(String userid) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select * from s_review where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			
			ArrayList<ReDTO> arr=new ArrayList<ReDTO>();
		
			while(rs.next()) {
				int re_idx=rs.getInt("re_idx");
				String p_name=rs.getString("p_name");
				String id=rs.getString("id");
				String re_subject=rs.getString("re_subject");
				String re_content=rs.getString("re_content");
				java.sql.Date re_date=rs.getDate("re_date");
				int re_star=rs.getInt("re_star");
				int re_good=rs.getInt("re_good");
				
				ReDTO dto=new ReDTO(re_idx, p_name, id, re_subject, re_content, re_date, re_star, re_good);
				arr.add(dto);
			}

			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	/**review search count*/
	public int reSearCnt(String p_name) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select count(*) from s_review where p_name=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, p_name);
			rs=ps.executeQuery();
			
			rs.next();
			int count=rs.getInt(1);
			
			return count==0?1:count;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		}
	
	
	/**reviewTotal count*/
	public int reTotalCnt() {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select count(*) from s_review";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			
			return count==0?1:count;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	/**reupdate*/
	public int reUpdate(ReDTO dto) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="update s_review set p_name=?, re_subject=?, re_content=?, re_star=? where re_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getP_name());
			ps.setString(2, dto.getRe_subject());
			ps.setString(3, dto.getRe_content());
			ps.setInt(4, dto.getRe_star());
			ps.setInt(5, dto.getRe_idx());
		
			int count=ps.executeUpdate();
			
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
			
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	
	/**review list*/
	public ArrayList<ReDTO> reList(int cp, int ls) {
		try {
			conn=semi.DB.semiDB.getConn();
			
			int start=(cp-1)*ls+1;
			int end=cp*ls;
			
			String sql="select * from"
					+ "(select rownum as rnum, a.*from"
					+ "(select * from s_review order by re_idx desc)a)b "
					+ "where rnum>=? and rnum<=?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			rs=ps.executeQuery();
			
			ArrayList<ReDTO> arr=new ArrayList<ReDTO>();
			while(rs.next()) {
				int re_idx=rs.getInt("re_idx");
				String p_name=rs.getString("p_name");
				String id=rs.getString("id");
				String re_subject=rs.getString("re_subject");
				String re_content=rs.getString("re_content");
				java.sql.Date re_date=rs.getDate("re_date");
				int re_star=rs.getInt("re_star");
				int re_good=rs.getInt("re_good");
				
				ReDTO dto=new ReDTO(re_idx, p_name, id, re_subject, re_content, re_date, re_star, re_good);
				arr.add(dto);
			}
			
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	/**ReviewGood*/
	public int ReviewGood(int idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="update s_review set re_good=re_good+1 where re_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			int count=ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	/**ReviewDelete*/
	public int reDelete(int idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="delete from s_review where re_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			int count=ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	

	/**reviewsearch*/
	public ArrayList<ReDTO> reSearch(String pname,int cp, int ls){
		try {
			conn=semi.DB.semiDB.getConn();			

			int start=(cp-1)*ls+1;
			int end=cp*ls;
			
			String sql="select * from"
					+ "(select rownum as rnum, a.*from"
					+ "(select * from s_review where p_name=? order by re_idx desc)a)b "
					+ "where rnum>=? and rnum<=?";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, pname);
			ps.setInt(2, start);
			ps.setInt(3, end);

			rs=ps.executeQuery();
			
			ArrayList<ReDTO> arr=new ArrayList<ReDTO>();
			while(rs.next()) {
				int re_idx=rs.getInt("re_idx");
				String p_name=rs.getString("p_name");
				String id=rs.getString("id");
				String re_subject=rs.getString("re_subject");
				String re_content=rs.getString("re_content");
				java.sql.Date re_date=rs.getDate("re_date");
				int re_star=rs.getInt("re_star");
				int re_good=rs.getInt("re_good");
				
				ReDTO dto=new ReDTO(re_idx, p_name, id, re_subject, re_content, re_date, re_star, re_good);
				arr.add(dto);
			}
			
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	
	/**review search - product test */
	public ArrayList<String> rePro() {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select p_name from s_product";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<String> str=new ArrayList<String>();
			
			while(rs.next()) {
				String pname=rs.getString("p_name");
				str.add(pname);
			}
			
			return str; 
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	
}
