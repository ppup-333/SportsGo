package com.sport.springboot.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.users.model.UserCity;

public interface UserCityRepository extends JpaRepository<UserCity, String> {

}
