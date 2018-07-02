package com.pcos.vo;

public class MemberVO {
	String email, name, gender, skintype, phone, zipcode, address1, address2, regstat;
	int ageYear;
	
	public MemberVO() {}
	public MemberVO(String email, String name, String gender, String skintype, String phone, String zipcode,
			String address1, String address2, String regstat, int ageYear) {
		this.email = email;
		this.name = name;
		this.gender = gender;
		this.skintype = skintype;
		this.phone = phone;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.regstat = regstat;
		this.ageYear = ageYear;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	public String getRegstat() {
		return regstat;
	}
	
	public void setRegstat(String regstat) {
		this.regstat = regstat;
	}
	
	public int getAgeYear() {
		return ageYear;
	}
	
	public void setAgeYear(int ageYear) {
		this.ageYear = ageYear;
	}
	
	@Override
	public String toString() {
		return "MemberVO [email=" + email + ", name=" + name + ", gender=" + gender + ", skintype=" + skintype
				+ ", phone=" + phone + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2
				+ ", regstat=" + regstat + ", ageYear=" + ageYear + "]";
	}
}
