package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Doctor;

public class DoctorDAO extends DAO {
	public DoctorDAO() {
		super();
	}

	public void create(Doctor doctor) {
		session.beginTransaction();
		session.persist(doctor);
		session.getTransaction().commit();
	}

	public Doctor findById(Integer id) {
		session.beginTransaction();
		Doctor doctor = session.get(Doctor.class, id);
		session.getTransaction().commit();
		return doctor;
	}
}
