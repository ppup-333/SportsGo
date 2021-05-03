package com.sport.springboot.users.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.users.model.UserAuthList;

public interface UserAuthListRepository extends JpaRepository<UserAuthList, String> {

	@Query(nativeQuery = true, value = "select * from user_auth_list where account = ?1 and auth_code = '02'")
	public List<UserAuthList> chkUserAuth(@Param("account") String account);
	
//	@Query(nativeQuery = true, value = "select * from user_auth_list where account='test1001'and auth_code = '02'")
//	public List<UserAuthList> chkUserAuth2();
}
