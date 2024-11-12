package org.thanhnd.adis_m1;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.thanhnd.adis_m1.dao.DAO;

@WebListener
public class InitListener implements ServletContextListener {
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContextListener.super.contextInitialized(sce);
//		ClientDAO clientDAO = new ClientDAO();
//		Client c = new Client(new User(null, "client", "123", "Client A", "Client"), 21, "0123456789");
//		clientDAO.create(c);
		DAO.init();
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContextListener.super.contextDestroyed(sce);
	}
}
