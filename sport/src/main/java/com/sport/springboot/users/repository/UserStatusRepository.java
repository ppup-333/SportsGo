package com.sport.springboot.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sport.springboot.users.model.UserStatus;

public interface UserStatusRepository extends JpaRepository<UserStatus, String> {

}
