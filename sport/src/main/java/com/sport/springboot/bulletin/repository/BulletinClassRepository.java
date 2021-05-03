package com.sport.springboot.bulletin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sport.springboot.bulletin.model.BulletinClass;
@Repository
public interface BulletinClassRepository extends JpaRepository<BulletinClass, Integer> {

}
