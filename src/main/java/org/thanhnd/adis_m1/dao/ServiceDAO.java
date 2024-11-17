package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Service;

public class ServiceDAO extends DAO {
	public ServiceDAO() {
		super();
	}

	public void create(Service service) {
		try {
			session.beginTransaction();
			session.persist(service);
			session.flush();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		}
	}

	public Service findById(Integer id) {
		return session.find(Service.class, id);
	}
}
