package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Appointment;

public class AppointmentDAO extends DAO {
	public AppointmentDAO() {
		super();
	}

	public boolean create(Appointment appointment) {
		try {
			getSession().beginTransaction();
			getSession().persist(appointment);
			getSession().flush();
			getSession().getTransaction().commit();
			return true;
		} catch (Exception e) {
			getSession().getTransaction().rollback();
		}
		return false;
	}
}
