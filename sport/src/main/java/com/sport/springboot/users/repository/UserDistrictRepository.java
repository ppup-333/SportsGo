package com.sport.springboot.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.users.model.UserDistrict;

public interface UserDistrictRepository extends JpaRepository<UserDistrict, Integer> {

}
