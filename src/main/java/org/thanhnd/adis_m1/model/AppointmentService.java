package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "tbl_appointment_service")
public class AppointmentService {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private LocalDateTime startTime;
	private String result;
	private Integer price;

	@ManyToOne
	@JoinColumn(name = "appointment_id", nullable = false, referencedColumnName = "id")
	private Appointment appointment;

	@ManyToOne
	@JoinColumn(name = "doctor_service_id", nullable = false, referencedColumnName = "id")
	private DoctorService doctorService;

	public AppointmentService() {
	}

	public AppointmentService(Integer id, LocalDateTime startTime, String result, Integer price, Appointment appointment, DoctorService doctorService) {
		this.id = id;
		this.startTime = startTime;
		this.result = result;
		this.price = price;
		this.appointment = appointment;
		this.doctorService = doctorService;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public LocalDateTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalDateTime startTime) {
		this.startTime = startTime;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Appointment getAppointment() {
		return appointment;
	}

	public void setAppointment(Appointment appointment) {
		this.appointment = appointment;
	}

	public DoctorService getDoctorService() {
		return doctorService;
	}

	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}

	@Override
	public String toString() {
		return "AppointmentService{" +
			"id=" + id +
			", startTime=" + startTime +
			", result='" + result + '\'' +
			", price=" + price +
			", doctorService=" + doctorService +
			'}';
	}
}
