package com.hobbycam.review.model;

import java.sql.Date;

public class ReviewVO {

	private int review_idx;
	private int lesson_record_idx;
	private int star_point;
	private String review_cont;
	private Date review_date;
	
	private int lesson_schedule_idx;
	private int u_idx;
	private int lesson_idx;
	private int t_idx;
	private String lesson_subj;
	private String lesson_thumbnail;
	private String t_name;
	
	public ReviewVO() {
		super();
	}

	public ReviewVO(int review_idx, int lesson_record_idx, int star_point, String review_cont, Date review_date,
			int lesson_schedule_idx, int u_idx, int lesson_idx, int t_idx, String lesson_subj, String lesson_thumbnail,
			String t_name) {
		super();
		this.review_idx = review_idx;
		this.lesson_record_idx = lesson_record_idx;
		this.star_point = star_point;
		this.review_cont = review_cont;
		this.review_date = review_date;
		this.lesson_schedule_idx = lesson_schedule_idx;
		this.u_idx = u_idx;
		this.lesson_idx = lesson_idx;
		this.t_idx = t_idx;
		this.lesson_subj = lesson_subj;
		this.lesson_thumbnail = lesson_thumbnail;
		this.t_name = t_name;
	}

	public int getReview_idx() {
		return review_idx;
	}

	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}

	public int getLesson_record_idx() {
		return lesson_record_idx;
	}

	public void setLesson_record_idx(int lesson_record_idx) {
		this.lesson_record_idx = lesson_record_idx;
	}

	public int getStar_point() {
		return star_point;
	}

	public void setStar_point(int star_point) {
		this.star_point = star_point;
	}

	public String getReview_cont() {
		return review_cont;
	}

	public void setReview_cont(String review_cont) {
		this.review_cont = review_cont;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public int getLesson_schedule_idx() {
		return lesson_schedule_idx;
	}

	public void setLesson_schedule_idx(int lesson_schedule_idx) {
		this.lesson_schedule_idx = lesson_schedule_idx;
	}

	public int getU_idx() {
		return u_idx;
	}

	public void setU_idx(int u_idx) {
		this.u_idx = u_idx;
	}

	public int getLesson_idx() {
		return lesson_idx;
	}

	public void setLesson_idx(int lesson_idx) {
		this.lesson_idx = lesson_idx;
	}

	public int getT_idx() {
		return t_idx;
	}

	public void setT_idx(int t_idx) {
		this.t_idx = t_idx;
	}

	public String getLesson_subj() {
		return lesson_subj;
	}

	public void setLesson_subj(String lesson_subj) {
		this.lesson_subj = lesson_subj;
	}

	public String getLesson_thumbnail() {
		return lesson_thumbnail;
	}

	public void setLesson_thumbnail(String lesson_thumbnail) {
		this.lesson_thumbnail = lesson_thumbnail;
	}

	public String getT_name() {
		return t_name;
	}

	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	
}
