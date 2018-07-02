package com.pcos.vo;


public class GradeVO {
	private String gradeno, comments;
	private double grade;
	private String regDate;
	private String email, productCode;
	private String productName;
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	private String gender,skintype,ageYear;
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSkintype() {
		return skintype;
	}
	public void setSkintype(String skintype) {
		this.skintype = skintype;
	}
	public String getAgeYear() {
		return ageYear;
	}
	public void setAgeYear(String ageYear) {
		this.ageYear = ageYear;
	}
	public String getGradeno() {
		return gradeno;
	}
	public void setGradeno(String gradeno) {
		this.gradeno = gradeno;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	
	@Override
	public String toString() {
		return "GradeVO [gradeno=" + gradeno + ", comments=" + comments + ", grade=" + grade + ", regDate=" + regDate
				+ ", email=" + email + ", productCode=" + productCode + "]";
	}
	public GradeVO() {}
	
}
