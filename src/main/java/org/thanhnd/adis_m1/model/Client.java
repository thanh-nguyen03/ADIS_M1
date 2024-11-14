package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tbl_client")
public class Client extends User {
	private Integer age;
	private String phone;

	public Client() {
	}

	public Client(User user, Integer age, String phone) {
		super(user.getId(), user.getUsername(), user.getPassword(), user.getFullName(), user.getRole());
		this.age = age;
		this.phone = phone;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}


}