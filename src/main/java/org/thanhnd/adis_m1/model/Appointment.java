package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "tbl_appointment")
public class Appointment {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private LocalDateTime startTime;
	private LocalDateTime endTime;

	@ManyToOne
	@JoinColumn(name = "client_id", referencedColumnName = "id")
	private Client client;

	@ManyToOne
	@JoinColumn(name = "doctor_shift_id", referencedColumnName = "id")
	private DoctorShift doctorShift;

	public Appointment() {
	}

	public Appointment(Integer id, LocalDateTime startTime, LocalDateTime endTime, Client client, DoctorShift doctorShift) {
		this.id = id;
		this.startTime = startTime;
		this.endTime = endTime;
		this.client = client;
		this.doctorShift = doctorShift;
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

	public LocalDateTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalDateTime endTime) {
		this.endTime = endTime;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public DoctorShift getDoctorShift() {
		return doctorShift;
	}

	public void setDoctorShift(DoctorShift doctorShift) {
		this.doctorShift = doctorShift;
	}

	@Override
	public String toString() {
		return "Appointment{" +
			"id=" + id +
			", startTime=" + startTime +
			", endTime=" + endTime +
			", client=" + client +
			", doctorShift=" + doctorShift +
			'}';
	}
}
