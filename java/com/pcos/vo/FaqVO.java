package com.pcos.vo;

public class FaqVO {
	private String faqno;
	private String title, contents;
	public String getFaqno() {
		return faqno;
	}
	public void setFaqno(String faqno) {
		this.faqno = faqno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "FaqVO [faqno=" + faqno + ", title=" + title + ", contents=" + contents + "]";
	}
	
	public FaqVO(){}
}
