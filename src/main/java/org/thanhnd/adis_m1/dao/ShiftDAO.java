package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Shift;

public class ShiftDAO extends DAO {
	public ShiftDAO() {
		super();
	}

	public void create(Shift shift) {
		session.beginTransaction();
		session.persist(shift);
		session.getTransaction().commit();
	}

	public Shift findById(Integer id) {
		session.beginTransaction();
		Shift shift = session.get(Shift.class, id);
		session.getTransaction().commit();
		return shift;
	}
}
