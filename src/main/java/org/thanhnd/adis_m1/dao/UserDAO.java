package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Client;
import org.thanhnd.adis_m1.model.User;


public class UserDAO extends DAO {

	public UserDAO() {
		super();
	}

	public Object checkLogin(User user) {
		try {
			// find by username
			User u = getSession().createQuery("from User where username = :username", User.class)
				.setParameter("username", user.getUsername()).uniqueResult();
			if (u != null) {
				// check password
				if (u.getPassword().equals(user.getPassword())) {
					if (u.getRole().equals("Client")) {
						return getSession().createQuery("from Client where id = :id", Client.class)
							.setParameter("id", u.getId()).uniqueResult();
					} else {
						return u;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}