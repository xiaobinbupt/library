package com.library.service.toy.impl;

import java.util.Collection;
import java.util.List;

import com.library.domain.Toy;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.HibernateGenericController;
import com.library.service.toy.ToyService;

public class ToyServiceImpl implements ToyService {

	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public void addToy(Toy toy) {
		controller.save(toy);
	}

	@Override
	public void updToy(Toy toy) {
		controller.update(toy);
	}

	@Override
	public void updToyStock(long toy_id, int num) {
		String hql = "update Toy set stock = stock + " + num + " where id = "
				+ toy_id;
		controller.executeUpdate(hql, new Object[] {});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Toy> getToys(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex) {
		return controller.findBy(Toy.class, page, page_size, order_by, insc,
				ex);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Toy> getToys(int page, int page_size, String hql) {
		return controller.findBy(hql, page, page_size, new Object[] {});
	}

	@Override
	public void delToy(long id) {
		controller.deleteById(Toy.class, id);
	}

	@Override
	public Toy getById(long id) {
		return controller.get(Toy.class, id);
	}

	@Override
	public long getToysCount(Collection<HibernateExpression> ex) {
		return controller.getResultCount(Toy.class, ex);
	}

	@Override
	public long getToysCount(String hql) {
		return controller.getResultCount(hql);
	}
}
