package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.exceptions.AppointmentBookedException;
import org.thanhnd.adis_m1.model.Appointment;
import org.thanhnd.adis_m1.model.Client;

import java.util.List;

public class AppointmentDAO extends DAO {
	public AppointmentDAO() {
		super();
	}

	public boolean save(Appointment appointment) {
		try {
			getSession().beginTransaction();

			// Check if the client is already booked the shift
			List<Appointment> appointments = getSession().createQuery("from Appointment where client.id = :clientId or doctorShift.shift.id = :shiftId", Appointment.class)
				.setParameter("clientId", appointment.getClient().getId())
				.setParameter("shiftId", appointment.getDoctorShift().getShift().getId())
				.getResultList();

			if (appointment.getId() == null && !appointments.isEmpty()) {
				getSession().getTransaction().rollback();
				throw new AppointmentBookedException("Client is already booked the shift");
			}

			if (!appointment.getServices().isEmpty()) {
				appointment.getServices().forEach(service -> {
					service.setAppointment(appointment);
					getSession().persist(service);
				});
			}

			getSession().persist(appointment);
			getSession().flush();
			getSession().getTransaction().commit();
			return true;
		} catch (Exception e) {
			getSession().getTransaction().rollback();
			throw e;
		}
	}

	public List<Appointment> getAppointmentList(Client c) {
		return getSession().createQuery("from Appointment where client.id = :clientId", Appointment.class)
			.setParameter("clientId", c.getId())
			.getResultList();
	}
}
