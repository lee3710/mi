package com.hobbycam.users.model;

import java.sql.Date;

public class UsersDTO {

	private int u_idx;
	private String u_email;
	private String u_pwd;
	private String u_name;
	private String u_img;
	private String u_gender;
	private String u_point;
	private String u_tel;
	private String u_state;
	private Date u_join_data;
	
	public UsersDTO() {
		super();
	}

	public UsersDTO(int u_idx, String u_email, String u_pwd, String u_name, String u_img, String u_gender,
			String u_point, String u_tel, String u_state, Date u_join_data) {
		super();
		this.u_idx = u_idx;
		this.u_email = u_email;
		this.u_pwd = u_pwd;
		this.u_name = u_name;
		this.u_img = u_img;
		this.u_gender = u_gender;
		this.u_point = u_point;
		this.u_tel = u_tel;
		this.u_state = u_state;
		this.u_join_data = u_join_data;
	}

	public int getU_idx() {
		return u_idx;
	}

	public void setU_idx(int u_idx) {
		this.u_idx = u_idx;
	}

	public String getU_email() {
		return u_email;
	}

	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public String getU_pwd() {
		return u_pwd;
	}

	public void setU_pwd(String u_pwd) {
		this.u_pwd = u_pwd;
	}

	public String getU_name() {
		return u_name;
	}

	public void setU_name(String u_name) {
		this.u_name = u_name;
	}

	public String getU_img() {
		return u_img;
	}

	public void setU_img(String u_img) {
		this.u_img = u_img;
	}

	public String getU_gender() {
		return u_gender;
	}

	public void setU_gender(String u_gender) {
		this.u_gender = u_gender;
	}

	public String getU_point() {
		return u_point;
	}

	public void setU_point(String u_point) {
		this.u_point = u_point;
	}

	public String getU_tel() {
		return u_tel;
	}

	public void setU_tel(String u_tel) {
		this.u_tel = u_tel;
	}

	public String getU_state() {
		return u_state;
	}

	public void setU_state(String u_state) {
		this.u_state = u_state;
	}

	public Date getU_join_data() {
		return u_join_data;
	}

	public void setU_join_data(Date u_join_data) {
		this.u_join_data = u_join_data;
	}
	
}
