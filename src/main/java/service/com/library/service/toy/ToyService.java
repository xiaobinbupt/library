package com.library.service.toy;

import java.util.Collection;
import java.util.List;

import com.library.domain.Toy;
import com.library.hibernate.HibernateExpression;

public interface ToyService {

	public void addToy(Toy toy);

	public void updToy(Toy toy);

	public void updToyStock(long toy_id, int num);

	public List<Toy> getToys(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex);

	public List<Toy> getToys(int page, int page_size, String hql);

	public long getToysCount(Collection<HibernateExpression> ex);

	public long getToysCount(String hql);

	public void delToy(long id);

	public Toy getById(long id);
}
