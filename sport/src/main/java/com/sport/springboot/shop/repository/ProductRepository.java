package com.sport.springboot.shop.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.shop.model.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {
	
	
    @Query("from Product where product_name like %:pname%")
	public List<Product> findByName(@Param ("pname")String name);
    
    @Query("from Product where product_name = :pname")
	public Product findByName1(@Param ("pname")String name);
    
    @Query(nativeQuery=true, value="SELECT * FROM ( SELECT * , ROW_NUMBER() OVER (ORDER BY product_id) as row FROM product) a WHERE row >= ?1 and row <= ?2 ")
    public List<Product> getProdByPage(@Param ("startRow")int startRow, @Param ("pageSize")int pageSize);
    
    //@Query(nativeQuery=true, value="SELECT * FROM product WHERE product_status = ?")
    @Query("from Product where product_status = :status")
    public List<Product> getProdByStatus(@Param ("status")String status);
    
   //@Query(nativeQuery=true, value="SELECT * FROM product WHERE  product_name LIKE '?1%' and product_status = ?2 ")
    @Query("from Product where product_name like %:pname% and product_status = :status")
    public List<Product> getProdByStatusByName(@Param ("pname")String name, @Param ("status")String status);
    
    //@Query(nativeQuery=true, value="SELECT * FROM product WHERE product_name LIKE '?1%' ")
//    @Query("from Product where product_name like %:pname%")
//    public List<Product> getProdByStatusByname2(@Param ("pname")String name); 此方法可
    
    @Query("from Product where product_name like %:pname%")
    public List<Product> getProdByStatusByname2(@Param ("pname")String name);

    @Query("from Product where product_status = :status and category_id =:category")
	public List<Product> getProdByStatusByCategory(String status, String category);

    @Query("from Product where category_id =:category")
	public List<Product> getProdByCategory(String category);
    
    @Query("from Product where product_name like %:pname% and product_status = :status and category_id = :category")
    public List<Product> getProdByStatusByNameByCategory(@Param ("pname")String name, String status, String category);
    
    @Query("from Product where product_name like %:pname% and category_id = :category")
	public List<Product> getProdByNameByCategory(@Param ("pname")String name, String category);
 
    


}
