package org.thanhnd.adis_m1.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tbl_doctor_shift")
public class DoctorShift {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	private Integer shiftPrice;
	private Integer maxNumberOfPatients;

	@ManyToOne
	@JoinColumn(name = "doctor_id", referencedColumnName = "id")
	private Doctor doctor;

	@ManyToOne
	@JoinColumn(name = "shift_id", referencedColumnName = "id")
	private Shift shift;

	@ManyToOne
	@JoinColumn(name = "room_id", referencedColumnName = "id")
	private Room room;

	public DoctorShift() {
	}

	public DoctorShift(Integer id, Integer shiftPrice, Integer maxNumberOfPatients, Doctor doctor, Shift shift, Room room) {
		this.id = id;
		this.shiftPrice = shiftPrice;
		this.maxNumberOfPatients = maxNumberOfPatients;
		this.doctor = doctor;
		this.shift = shift;
		this.room = room;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getShiftPrice() {
		return shiftPrice;
	}

	public void setShiftPrice(Integer shiftPrice) {
		this.shiftPrice = shiftPrice;
	}

	public Integer getMaxNumberOfPatients() {
		return maxNumberOfPatients;
	}

	public void setMaxNumberOfPatients(Integer maxNumberOfPatients) {
		this.maxNumberOfPatients = maxNumberOfPatients;
	}

	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public Shift getShift() {
		return shift;
	}

	public void setShift(Shift shift) {
		this.shift = shift;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}
}
