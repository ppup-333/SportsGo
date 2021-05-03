package com.sport.springboot.shop.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.shop.model.Product;
import com.sport.springboot.shop.repository.ProductRepository;
import com.sport.springboot.shop.service.ProductService;

@Service 
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductRepository productDao;

	@Override
	public Product save(Product product) {
		return productDao.save(product);
	}

	@Override
	public void delete(Integer product_id) {
		productDao.deleteById(product_id);
	}


	@Override
	public void update(Product product) {
		 productDao.save(product);
	}

	@Override
	public List<Product> getAllProducts() {
		return productDao.findAll();
	}
	
	@Override
	public Product get(Integer product_id) {
		Optional<Product> optional = productDao.findById(product_id);
		Product product = null;
		if (optional.isPresent()) {
			product = optional.get();
		} else {
			throw new RuntimeException("Product(id=" + product_id + ")不存在");
		}
		return product;
	}
	
//	@Autowired
//	EntityManager entityManager;
//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Product> getByName(String pname) {
//		String hql = "from Product p where p.product_name like :name";
//		List<Product> list = entityManager.createQuery(hql).setParameter("name", "%"+pname+"%").getResultList();		
//		return list;
//	}

	@Override
	public List<Product> getByName(String pname) {
		return productDao.findByName(pname);
	}

	@Override
	public List<Product> getProdByPage(int startRow, int pageSize) {
		return productDao.getProdByPage(startRow, pageSize);
	}

	@Override
	public List<Product> getProdByStatus(String status) {
		return productDao.getProdByStatus(status);
	}

	@Override
	public List<Product> getProdByStatusByName(String pname, String status) {
		return productDao.getProdByStatusByName(pname, status);
	}

	@Override
	public List<Product> getProdByStatusByname2(String pname) {
		return productDao.getProdByStatusByname2(pname);
	}

	@Override
	public List<Product> getProdByStatusByCategory(String status, String category) {
		return productDao.getProdByStatusByCategory(status, category);
	}

	@Override
	public List<Product> getProdByCategory(String category) {
		return productDao.getProdByCategory(category);
	}

	@Override
	public List<Product> getProdByStatusByNameByCategory(String pname, String status, String category) {
		return productDao.getProdByStatusByNameByCategory(pname, status, category);
	}

	@Override
	public List<Product> getProdByNameByCategory(String pname, String category) {
		return productDao.getProdByNameByCategory(pname, category);
	}

	@Override
	public Product getByName1(String pname) {
		return productDao.findByName1(pname);
	}

}
