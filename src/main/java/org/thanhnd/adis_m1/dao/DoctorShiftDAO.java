package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.DoctorShift;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class DoctorShiftDAO extends DAO {
	public DoctorShiftDAO() {
		super();
	}

	public void create(DoctorShift doctorShift) {
		try {
			getSession().beginTransaction();
			getSession().persist(doctorShift);
			getSession().flush();
			getSession().getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			getSession().getTransaction().rollback();
		}
	}

	public List<DoctorShift> searchShift(LocalDate date) {
		LocalDateTime start = date.atStartOfDay();
		LocalDateTime end = date.atTime(23, 59, 59);
		System.out.println(date);
		System.out.println(start);
		System.out.println(end);
		session.beginTransaction();
		List<DoctorShift> doctorShifts = session.createQuery("from DoctorShift d where d.shift.startTime >= :start and d.shift.endTime <= :end", DoctorShift.class)
			.setParameter("start", start)
			.setParameter("end", end)
			.getResultList();
		session.getTransaction().commit();
		return doctorShifts;
	}
}
