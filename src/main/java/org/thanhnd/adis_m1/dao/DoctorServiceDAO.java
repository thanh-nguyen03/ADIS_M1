package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Doctor;
import org.thanhnd.adis_m1.model.DoctorService;

import java.util.List;

public class DoctorServiceDAO extends DAO {
	public DoctorServiceDAO() {
		super();
	}

	public void create(DoctorService doctorService) {
		try {
			session.beginTransaction();
			session.persist(doctorService);
			session.flush();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		}
	}

	public List<DoctorService> getDoctorServices(Doctor doctor) {
		return session.createQuery("from DoctorService where doctor.id = :doctor_id", DoctorService.class)
			.setParameter("doctor_id", doctor.getId())
			.getResultList();
	}
}
