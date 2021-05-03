package com.sport.springboot.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.users.model.UserAuth;

public interface UserAuthRepository extends JpaRepository<UserAuth, String> {

}
