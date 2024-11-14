package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tbl_doctor")
public class Doctor {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(nullable = false)
	private String name;

	@Column(nullable = false)
	private String major;

	@Column(nullable = false)
	private String degree;

	@Column(nullable = false)
	private Integer yearOfExperience;

	public Doctor() {

	}

	public Doctor(Integer id, String name, String major, String degree, Integer yearOfExperience) {
		this.id = id;
		this.name = name;
		this.major = major;
		this.degree = degree;
		this.yearOfExperience = yearOfExperience;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	public Integer getYearOfExperience() {
		return yearOfExperience;
	}

	public void setYearOfExperience(Integer yearOfExperience) {
		this.yearOfExperience = yearOfExperience;
	}

	@Override
	public String toString() {
		return "Doctor{" +
			"id=" + id +
			", name='" + name + '\'' +
			", major='" + major + '\'' +
			", degree='" + degree + '\'' +
			", yearOfExperience=" + yearOfExperience +
			'}';
	}
}
