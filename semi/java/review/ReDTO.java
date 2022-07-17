package semi.review;

import java.sql.*;

public class ReDTO {

	private int re_idx;
	private String p_name;
	private String id;
	private String re_subject;
	private String re_content;
	private Date re_date;
	private int re_star;
	private int re_good;
	

	public ReDTO() {
		super();
	}
	
	public ReDTO(int re_idx, String p_name, String id, String re_subject, String re_content, Date re_date,
			int re_star, int re_good) {
		super();
		this.re_idx = re_idx;
		this.p_name = p_name;
		this.id = id;
		this.re_subject = re_subject;
		this.re_content = re_content;
		this.re_date = re_date;
		this.re_star = re_star;
		this.re_good = re_good;
	}

	public int getRe_idx() {
		return re_idx;
	}

	public void setRe_idx(int re_idx) {
		this.re_idx = re_idx;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getid() {
		return id;
	}

	public void setid(String id) {
		this.id = id;
	}

	public String getRe_subject() {
		return re_subject;
	}

	public void setRe_subject(String re_subject) {
		this.re_subject = re_subject;
	}

	public String getRe_content() {
		return re_content;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	public Date getRe_date() {
		return re_date;
	}

	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}

	public int getRe_good() {
		return re_good;
	}

	public void setRe_good(int re_good) {
		this.re_good = re_good;
	}

	public int getRe_star() {
		return re_star;
	}

	public void setRe_star(int re_star) {
		this.re_star = re_star;
	}


}
