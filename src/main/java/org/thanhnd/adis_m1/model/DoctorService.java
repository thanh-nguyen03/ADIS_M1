package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tbl_doctor_service")
public class DoctorService {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private Integer price;

	@ManyToOne
	@JoinColumn(name = "doctor_id", nullable = false)
	private Doctor doctor;

	@ManyToOne
	@JoinColumn(name = "service_id", nullable = false)
	private Service service;

	public DoctorService() {

	}

	public DoctorService(Integer id, Integer price, Doctor doctor, Service service) {
		this.id = id;
		this.price = price;
		this.doctor = doctor;
		this.service = service;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	@Override
	public String toString() {
		return "DoctorService{" +
			"id=" + id +
			", price=" + price +
			", doctor=" + doctor +
			", service=" + service +
			'}';
	}
}
