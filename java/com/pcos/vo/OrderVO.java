package com.pcos.vo;

public class OrderVO {
   private String orderNo, name, zipcode, address1, address2, phone, payment, comments, email, productCode, orderDate, productName, orderStat;
   public String getOrderStat() {
	return orderStat;
}

public void setOrderStat(String orderStat) {
	this.orderStat = orderStat;
}

private int amount, price;

   public OrderVO() {}
   
   public String getOrderDate() {
	return orderDate;
}

public void setOrderDate(String orderDate) {
	this.orderDate = orderDate;
}

public String getProductName() {
	return productName;
}

public void setProductName(String productName) {
	this.productName = productName;
}

public String getOrderNo() {
      return orderNo;
   }
   public void setOrderNo(String orderNo) {
      this.orderNo = orderNo;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
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
   public String getPhone() {
      return phone;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }
   public String getPayment() {
      return payment;
   }
   public void setPayment(String payment) {
      this.payment = payment;
   }
   public String getComments() {
      return comments;
   }
   public void setComments(String comments) {
      this.comments = comments;
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

   public int getAmount() {
      return amount;
   }

   public void setAmount(int amount) {
      this.amount = amount;
   }

   public int getPrice() {
      return price;
   }

   public void setPrice(int price) {
      this.price = price;
   }

}