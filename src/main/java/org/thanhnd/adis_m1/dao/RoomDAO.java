package org.thanhnd.adis_m1.dao;

import org.thanhnd.adis_m1.model.Room;

public class RoomDAO extends DAO {
	public RoomDAO() {
		super();
	}

	public void create(Room room) {
		session.beginTransaction();
		session.persist(room);
		session.getTransaction().commit();
	}

	public Room findById(Integer id) {
		session.beginTransaction();
		Room room = session.get(Room.class, id);
		session.getTransaction().commit();
		return room;
	}
}
