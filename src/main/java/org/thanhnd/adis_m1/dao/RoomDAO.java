package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Room;

public class RoomDAO extends DAO {
	public RoomDAO() {
		super();
	}

	public void create(Room room) {
		try {
			getSession().beginTransaction();
			getSession().persist(room);
			getSession().flush();
			getSession().getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			getSession().getTransaction().rollback();
		}
	}

	public Room findById(Integer id) {
		session.beginTransaction();
		Room room = session.get(Room.class, id);
		session.getTransaction().commit();
		return room;
	}
}
