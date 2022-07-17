package com.hobbycam.users.model;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.hobbycam.VO.UserVO;

public class UsersDAOImple implements UsersDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;

	public static final int NOT_ID = 1;
	public static final int NOT_PWD = 2;
	public static final int LOGIN_OK = 3;
	public static final int ERROR = -1;
	public static final int DEL = -2;

	public UsersDAOImple(SqlSessionTemplate sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

	/** email Join */
	// email Check
	@Override
	public int getEmailCount(String email) {
		int result=sqlMap.selectOne("selectEmailCount",email);

		return result;
	}

	// name Check
	@Override

	public int getNameCount(String name) {
		int result=sqlMap.selectOne("selectNameCount",name);
		
		return result;
	}
	
	
	public int getTel(String tel) {
			int result=sqlMap.selectOne("selectTel",tel)==null?
				0:1;
	
		return result;
	}
	
	
	/**email Join*/
	@Override
	public int setUser(UsersDTO dto) {
		int emailCheck=getEmailCount(dto.getU_email());
		int nameCheck=getNameCount(dto.getU_name());

		if(emailCheck==0&&nameCheck==0) {
			int count=sqlMap.insert("insertUser",dto);

			return count;
		} else {
			return -1;
		}
	}

	/** Login */
	@Override
	public int getLoginPwd(String email, String pwd) {


		UsersDTO dto=sqlMap.selectOne("selectPwd",email);
		
		if(dto==null) {
			return NOT_ID;
		}
		
		String u_pwd=dto.getU_pwd();
		String u_state=dto.getU_state();

		
		if(u_state.equals("탈퇴")) {
			return DEL;
		}

		if (u_pwd == null || u_pwd.equals("")) {
			return NOT_ID;
		} else if (!u_pwd.equals(pwd)) {
			return NOT_PWD;
		} else if (u_pwd.equals(pwd)) {
			return LOGIN_OK;
		} else {
			return ERROR;
		}
	}
	
	
	public UsersDTO getUserName(String email) {
		UsersDTO dto =sqlMap.selectOne("selectUserName",email);
		
		return dto;
	}

	// getusername
	@Override

	public Integer getUserTidx(int idx){
		Integer u_tidx=sqlMap.selectOne("selectUserTidx",idx); 
		
		return u_tidx;
	}
	

	
	@Override
	public UsersDTO getUserEmail(String u_tel, String u_gender) {
	
		UsersDTO dto=new UsersDTO();
		dto.setU_tel(u_tel);
		dto.setU_gender(u_gender);
		
		UsersDTO udto=sqlMap.selectOne("selectUserEmail",dto);
		
		return udto;
	}
	
	public int getPwdCount(String email) {
		String u_state=sqlMap.selectOne("selectState",email);
		if(u_state==null||u_state.equals("")) {
			return NOT_ID;
		} else if(u_state.equals("탈퇴")){
			return DEL;
		} else {
			return LOGIN_OK;
		}
		
	}
	
	
	@Override
	public int updateUserPwd(UsersDTO dto) {
		int count=sqlMap.update("updateUserPwd",dto);
		return count;
	}
	
	@Override
	public UsersDTO getUserInfo(int idx) {
		UsersDTO dto=sqlMap.selectOne("selectUserInfo",idx);

		return dto;
	}

	@Override

	public int updateUserInfo(UsersDTO dto) {
		int count=sqlMap.update("UpdateUserInfo",dto);

		return count;
	}

	@Override

	public int deleteUserInfo(int idx) {
		int count=sqlMap.update("DeleteUserInfo",idx);
		return count;
	}
	
	

	public int userDel(int idx) {
		int count = sqlMap.update("usersDel", idx);
		return count;
	}

	@Override
	public UserVO getUser(int uIdx) {
		return sqlMap.selectOne("getUser", uIdx);

	}

	@Override
	public int updateUPoint(int uIdx, int newUPoint) {
		Map<String, Object> map = new HashMap<>();
		map.put("uIdx", uIdx);
		map.put("newUPoint", newUPoint);
		return sqlMap.update("updateUPoint", map);
	}

	@Override
	public int addUPoint(int uIdx, int point) {
		Map<String, Object> map = new HashMap<>();
		map.put("uIdx", uIdx);
		map.put("point", point);
		return sqlMap.update("addUPoint", map);
	}

	@Override
	public int subUPoint(int uIdx, int point) {
		Map<String, Object> map = new HashMap<>();
		map.put("uIdx", uIdx);
		map.put("point", point);
		return sqlMap.update("subUPoint", map);
	}
}
