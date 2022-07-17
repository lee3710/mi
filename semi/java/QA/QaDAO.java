package semi.QA;

import java.sql.*;
import java.util.*;

public class QaDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	/**max ref QAWriter inner*/		
	public int getMaxRef() {	
		try {
			String sql="select max(q_ref) from s_qa";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int ref=0;
			if(rs.next()) {
				ref=rs.getInt(1);
			}
			
			return ref;	
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	/**QAWrite*/
	public int qaWrite(QaDTO dto) {
		try {
			conn=semi.DB.semiDB.getConn();
			int maxref=getMaxRef();
			String sql="insert into s_qa values(s_qa_qa_idx.nextval,?,?,?,sysdate,?,0,0)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getid());
			ps.setString(2, dto.getQ_subject());
			ps.setString(3, dto.getQ_content());
			ps.setInt(4, maxref+1);
			
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
				
			}
		}
	}
	
	
	/**recheck update*/
	public int qaUpCheck(int qa_idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="update s_qa set q_recheck=1 where q_ref=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, qa_idx);
			int count=ps.executeUpdate();
			
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(rs!=null)rs.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}	
	}

	
	/**QAReply - manager*/
	public int qaReply(QaDTO dto) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="insert into s_qa values(s_qa_qa_idx.nextval,?,?,?,sysdate,?,1,1)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getid());
			ps.setString(2, dto.getQ_subject());
			ps.setString(3, dto.getQ_content());
			ps.setInt(4, dto.getQ_ref());
			
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
	
	
	
	
	/**QArecheck recheck 0 select*/
	public ArrayList<QaDTO> qaReCheck(){
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select * from s_qa where q_recheck=0";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<QaDTO> arr=new ArrayList<QaDTO>();
			while(rs.next()) {
				int qa_idx=rs.getInt("qa_idx");
				String id=rs.getString("id");
				String q_subject=rs.getString("q_subject");
				String q_content=rs.getString("q_content");
				java.sql.Date q_date=rs.getDate("q_date");
				int q_ref=rs.getInt("q_ref");
				int q_lev=rs.getInt("q_lev");
				int q_recheck=rs.getInt("q_recheck");
				
				QaDTO dto=new QaDTO(qa_idx, id, q_subject, q_content, q_date, q_ref, q_lev, q_recheck);
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
	
	
	
	/**QATotal count*/
	public int qaTotalCnt() {
	try {
		conn=semi.DB.semiDB.getConn();
		String sql="select count(*) from s_qa";
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
	

	/**QA recheck0 count*/
	public int qaSunCnt() {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select count(*) from s_qa where q_recheck=0";
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
		
	
	
	
	
	
	/**QALIST recheck0 */
	public ArrayList<QaDTO> qaList2(int recheck, int cp, int ls) {
		try {
			conn=semi.DB.semiDB.getConn();
			
			int start = (cp-1)*ls+1;
			int end=cp*ls;
			String sql="select * from"
					+ "(select rownum as rnum,a.* from"
					+ "(select * from s_qa where q_recheck=0 order by q_ref desc, q_lev asc) a)b "
					+ "where rnum>=? and rnum<=?";
				
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			rs=ps.executeQuery();
			
			ArrayList<QaDTO> arr=new ArrayList<QaDTO>();
			while(rs.next()) {
				int qa_idx=rs.getInt("qa_idx");
				String id=rs.getString("id");
				String q_subject=rs.getString("q_subject");
				String q_content=rs.getString("q_content");
				java.sql.Date q_date=rs.getDate("q_date");
				int q_ref=rs.getInt("q_ref");
				int q_lev=rs.getInt("q_lev");
				int q_recheck=rs.getInt("q_recheck");
				
				QaDTO dto=new QaDTO(qa_idx, id, q_subject, q_content, q_date, q_ref, q_lev, q_recheck);
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
	
	
	/**QALIST*/
	public ArrayList<QaDTO> qaList(int cp, int ls) {
		try {
			conn=semi.DB.semiDB.getConn();
			
			int start = (cp-1)*ls+1;
			int end=cp*ls;
			String sql="select * from"
					+ "(select rownum as rnum,a.* from"
					+ "(select * from s_qa order by q_ref desc, q_lev asc) a)b "
					+ "where rnum>=? and rnum<=?";
				
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			
			rs=ps.executeQuery();
			
			ArrayList<QaDTO> arr=new ArrayList<QaDTO>();
			while(rs.next()) {
				int qa_idx=rs.getInt("qa_idx");
				String id=rs.getString("id");
				String q_subject=rs.getString("q_subject");
				String q_content=rs.getString("q_content");
				java.sql.Date q_date=rs.getDate("q_date");
				int q_ref=rs.getInt("q_ref");
				int q_lev=rs.getInt("q_lev");
				int q_recheck=rs.getInt("q_recheck");
				
				QaDTO dto=new QaDTO(qa_idx, id, q_subject, q_content, q_date, q_ref, q_lev, q_recheck);
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
	
	
	/**myQA*/
	public ArrayList<QaDTO> myQa(String userid) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select * from s_qa where q_ref IN (select q_Ref from s_qa where id=?) order by q_ref desc, q_lev asc";
			ps=conn.prepareStatement(sql);			
			ps.setString(1, userid);
			
			rs=ps.executeQuery();

			ArrayList<QaDTO> arr=new ArrayList<QaDTO>();
			
			while(rs.next()) {
				int qa_idx=rs.getInt("qa_idx");
				String id=rs.getString("id");
				String q_subject=rs.getString("q_subject");
				String q_content=rs.getString("q_content");
				java.sql.Date q_date=rs.getDate("q_date");
				int q_ref=rs.getInt("q_ref");
				int q_lev=rs.getInt("q_lev");
				int q_recheck=rs.getInt("q_recheck");
				
				QaDTO dto=new QaDTO(qa_idx, id, q_subject, q_content, q_date, q_ref, q_lev, q_recheck);
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
	

	/**QAContent*/
	public QaDTO qaContent(int idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="select * from s_qa where qa_idx=?";
			ps=conn.prepareStatement(sql);			
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			QaDTO dto=null;
			
			if(rs.next()) {
				int qa_idx=rs.getInt("qa_idx");
				String id=rs.getString("id");
				String q_subject=rs.getString("q_subject");
				String q_content=rs.getString("q_content");
				java.sql.Date q_date=rs.getDate("q_date");
				int q_ref=rs.getInt("q_ref");
				int q_lev=rs.getInt("q_lev");
				int q_recheck=rs.getInt("q_recheck");
				
				dto=new QaDTO(qa_idx, id, q_subject, q_content, q_date, q_ref, q_lev, q_recheck);
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
	
	/**QAUpdate*/
	public int qaUpdate(QaDTO dto) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="update s_qa set q_subject=?,q_content=? where qa_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getQ_subject());
			ps.setString(2, dto.getQ_content());
			ps.setInt(3, dto.getQa_idx());
			
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

	/**QADelete*/
	public int qaDelete(int idx) {
		try {
			conn=semi.DB.semiDB.getConn();
			String sql="delete from s_qa where qa_idx=?";
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
				if(conn!=null)ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	public QaDAO() {		super();	}
	
	public Connection getConn() {	return conn;	}

	public void setConn(Connection conn) {		this.conn = conn;	}

	public PreparedStatement getPs() {		return ps;	}

	public void setPs(PreparedStatement ps) {		this.ps = ps;	}

	public ResultSet getRs() {		return rs;	}

	public void setRs(ResultSet rs) {		this.rs = rs;	}

}


