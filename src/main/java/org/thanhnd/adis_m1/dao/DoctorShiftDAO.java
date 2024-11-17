package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.DoctorShift;
import org.thanhnd.adis_m1.model.Shift;

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
		session.beginTransaction();
		List<DoctorShift> doctorShifts = session.createQuery("from DoctorShift d where d.shift.startTime >= :start and d.shift.endTime <= :end", DoctorShift.class)
			.setParameter("start", start)
			.setParameter("end", end)
			.getResultList();
		session.getTransaction().commit();
		return doctorShifts;
	}

	public List<DoctorShift> searchShift(Shift shift, String doctor, String doctorDegree) {
		if (doctorDegree.equals("All")) {
			doctorDegree = "";
		}

		session.beginTransaction();
		StringBuilder queryBuilder = new StringBuilder("from DoctorShift d where d.shift = :shift");

		if (doctor != null && !doctor.isEmpty()) {
			queryBuilder.append(" and d.doctor.name like :doctor");
		}
		if (!doctorDegree.isEmpty()) {
			queryBuilder.append(" and d.doctor.degree = :doctorDegree");
		}

		var query = session.createQuery(queryBuilder.toString(), DoctorShift.class)
			.setParameter("shift", shift);

		if (doctor != null && !doctor.isEmpty()) {
			query.setParameter("doctor", "%" + doctor + "%");
		}
		if (!doctorDegree.isEmpty()) {
			query.setParameter("doctorDegree", doctorDegree);
		}

		List<DoctorShift> doctorShifts = query.getResultList();
		session.getTransaction().commit();
		return doctorShifts;
	}
}
