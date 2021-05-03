package com.sport.springboot.field.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sport.springboot.field.model.Field;

@Repository
public interface FieldRepository extends JpaRepository<Field, String> {

	@Query("from Field where typeId = :id")
	public List<Field> getByTypeID(@Param("id")Integer id);
	
	@Query("from Field where id = :id")
	public List<Field> findByFieldId(@Param("id")String id);
	
}
