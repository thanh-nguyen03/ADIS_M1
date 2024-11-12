package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Client;

public class ClientDAO extends DAO {
	public ClientDAO() {
		super();
	}

	public void create(Client client) {
		try {
			getSession().beginTransaction();
			getSession().persist(client);
			getSession().getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			getSession().getTransaction().rollback();
		}
	}
}
