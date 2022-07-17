package semi.QA;

import java.sql.*;

public class QaDTO {

	private int qa_idx;
	private String id;
	private String q_subject;
	private String q_content;
	private Date q_date;
	private int q_ref;
	private int q_lev;
	private int q_recheck;
	
	public QaDTO() {
		super();
	}

	public QaDTO(int qa_idx, String id, String q_subject, String q_content, Date q_date, int q_ref, int q_lev,
			int q_recheck) {
		super();
		this.qa_idx = qa_idx;
		this.id = id;
		this.q_subject = q_subject;
		this.q_content = q_content;
		this.q_date = q_date;
		this.q_ref = q_ref;
		this.q_lev = q_lev;
		this.q_recheck = q_recheck;
	}

	public int getQa_idx() {
		return qa_idx;
	}

	public void setQa_idx(int qa_idx) {
		this.qa_idx = qa_idx;
	}

	public String getid() {
		return id;
	}

	public void setid(String id) {
		this.id = id;
	}

	public String getQ_subject() {
		return q_subject;
	}

	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public Date getQ_date() {
		return q_date;
	}

	public void setQ_date(Date q_date) {
		this.q_date = q_date;
	}

	public int getQ_ref() {
		return q_ref;
	}

	public void setQ_ref(int q_ref) {
		this.q_ref = q_ref;
	}

	public int getQ_lev() {
		return q_lev;
	}

	public void setQ_lev(int q_lev) {
		this.q_lev = q_lev;
	}

	public int getQ_recheck() {
		return q_recheck;
	}

	public void setQ_recheck(int q_recheck) {
		this.q_recheck = q_recheck;
	}
	
}
