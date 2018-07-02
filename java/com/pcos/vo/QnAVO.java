package com.pcos.vo;

public class QnAVO {
	private String qnano;
	private String title;
	private String contents,recontents;
	private String email;
	private String replstat;
	private String regdate;
	
	public QnAVO(String qnano, String title, String contents, String recontents, String email, String replstat, String regdate) {
		this.qnano = qnano;
		this.title = title;
		this.contents = contents;
		this.recontents=recontents;
		this.email = email;
		this.replstat = replstat;
		this.regdate = regdate;
	}

	public String getRecontents() {
		return recontents;
	}

	public void setRecontents(String recontents) {
		this.recontents = recontents;
	}

	public QnAVO() {}
	
	public String getQnano() {
		return qnano;
	}

	public void setQnano(String qnano) {
		this.qnano = qnano;
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

	public String getReplstat() {
		return replstat;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public void setReplstat(String replstat) {
		this.replstat = replstat;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "QnAVO [qnano=" + qnano + ", title=" + title + ", contents=" + contents + ", email=" + email
				+ ", replstat=" + replstat + ", regdate=" + regdate + "]";
	}
	
}
