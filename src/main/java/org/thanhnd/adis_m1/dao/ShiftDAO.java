package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Shift;

public class ShiftDAO extends DAO {
	public ShiftDAO() {
		super();
	}

	public void create(Shift shift) {
		try {
			getSession().beginTransaction();
			getSession().persist(shift);
			getSession().flush();
			getSession().getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			getSession().getTransaction().rollback();
		}
	}

	public Shift findById(Integer id) {
		session.beginTransaction();
		Shift shift = session.get(Shift.class, id);
		session.getTransaction().commit();
		return shift;
	}
}
