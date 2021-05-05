package com.sport.springboot.users.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sport.springboot.users.model.Users;

public interface UsersRepository extends JpaRepository<Users, String> {

//	@Query("select account from Users account where account.account=:account")
//	@Query("from Users u where u.account like %:account%")
//	public Users repeatAccount(@Param(value = "account") String account); 

//	@Query("from users where account=:account")
//	public Users userLogin(@Param(value = "account") String account);

	@Query("select a from Users  a where account=:account")
	public List<Users> userLogin(@Param("account") String account);
	
	@Query("from Users where account like %:account%")
	public List<Users> adminResultAct(@Param("account") String account);
	
	@Query("from Users where name like %:name%")
	public List<Users> adminResultName(@Param("name") String name);
	
	@Query("from Users where id like %:id%")
	public List<Users> adminResultId(@Param("id") String id);

}
