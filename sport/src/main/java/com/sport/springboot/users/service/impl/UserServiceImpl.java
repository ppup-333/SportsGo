package com.sport.springboot.users.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.repository.UsersRepository;
import com.sport.springboot.users.service.UserCityService;
import com.sport.springboot.users.service.UserDistrictService;
import com.sport.springboot.users.service.UserStatusService;
import com.sport.springboot.users.service.UsersService;

@Service
public class UserServiceImpl implements UsersService {

	@Autowired
	UsersRepository usersDao;

	@Autowired
	UserCityService userCityDao;

	@Autowired
	UserDistrictService userDistrictDao;

	@Autowired
	UserStatusService userStatusDao;

	@Override
	public Users save(Users users) {
		return usersDao.save(users);
	}

	@Override
	public Users get(String account) {
		return usersDao.getOne(account);
	}

	@Override
	public boolean getChkAccount(String account) {
		Optional<Users> optional = usersDao.findById(account);

		Users users = null;
		System.out.println("optional=" + optional);
		if (optional.isPresent()) {
			users = optional.get();
			System.out.println("users2=" + users);
			return true;
		}
		return false;
	}

	@Override
	public void update(Users users) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Users> getAllUsers() {
		// TODO Auto-generated method stub
		return usersDao.findAll();
	}

//	@Override
//	public Users userLogin(String account) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public List<Users> userLogin(String account) {
		// TODO Auto-generated method stub
		return usersDao.userLogin(account);
	}

	@Override
	public List<Users> adminResultAct(String account) {
		// TODO Auto-generated method stub
		return usersDao.adminResultAct(account);
	}

	@Override
	public List<Users> adminResultName(String name) {
		// TODO Auto-generated method stub
		return usersDao.adminResultName(name);
	}

	@Override
	public List<Users> adminResultId(String id) {
		// TODO Auto-generated method stub
		return usersDao.adminResultId(id);
	}

	@Override
	public List<Users> adminResult(Users users) {

		String url = "jdbc:sqlserver://localhost:1433;databaseName=Sport_Project";
		String userName = "otokochang";
		String password = "zxcv0988";

		String sql = "select * from users where ";

		String inputAct = users.getAccount();
		String inputName = users.getName();
		String inputId = users.getId();
		String inputCity = users.getCityCode().getCityCode();
		Integer inputDistrict = users.getUserDistrictCode().getUserDistrictCode();
		String inputAddress = users.getAddress();
		String inputStatus = users.getStatusCode().getStatusCode();

		Users userData = new Users();
		List<Users> userDataList = new ArrayList<>();

//		System.out.println("-------------"+inputCity);
//		System.out.println("-------------"+inputDistrict);

		if (!"".equals(inputAct)) {
			sql += "account like ? and ";
		}
		if (!"".equals(inputName)) {
			sql += "name like ? and ";
		}
		if (!"".equals(inputId)) {
			sql += "id like ? and ";
		}
		if (!"00".equals(inputCity)) {
			sql += "city_code like ? and ";
		}
		if (inputDistrict != 1000) {
			sql += "user_district_code like ? and ";
		}
		if (!"".equals(inputAddress)) {
			sql += "address like ? and ";
		}
		if (!"00".equals(inputStatus)) {
			sql += "status_code like ? and ";
		}

//		System.out.println("-------------");
//		System.out.println(inputCity);
//		System.out.println("-------------");
		String finalSql = sql.substring(0, sql.length() - 5);
//		System.out.println("************" + finalSql);

		try (Connection conn = DriverManager.getConnection(url, userName, password)) {
			try (PreparedStatement pstmt = conn.prepareStatement(finalSql)) {

				int i = 1;

				if (!"".equals(inputAct)) {
					pstmt.setString(i++, "%" + inputAct + "%");
				}
				if (!"".equals(inputName)) {
					pstmt.setString(i++, "%" + inputName + "%");
				}
				if (!"".equals(inputId)) {
					pstmt.setString(i++, "%" + inputId + "%");
				}
				if (!"00".equals(inputCity)) {
					pstmt.setString(i++, "%" + inputCity + "%");
				}
				if (inputDistrict != 1000) {
					pstmt.setString(i++, "%" + inputDistrict + "%");
				}
				if (!"".equals(inputAddress)) {
					pstmt.setString(i++, "%" + inputAddress + "%");
				}
				if (!"00".equals(inputStatus)) {
					pstmt.setString(i++, "%" + inputStatus + "%");
				}

				ResultSet rs = pstmt.executeQuery();

//				int n = 0;
				while (rs.next()) {
					userData = new Users();
					userData.setAccount(rs.getString("account"));
					userData.setName(rs.getString("name"));
					userData.setId(rs.getString("id"));
					userData.setGender(rs.getString("gender"));
					userData.setBirthday(rs.getString("birthday"));
					userData.setEmail(rs.getString("email"));
					userData.setCityCode(userCityDao.getCity(rs.getString("city_code")));
					userData.setUserDistrictCode(
							userDistrictDao.getDistrict(Integer.parseInt(rs.getString("user_district_code"))));
					userData.setAddress(rs.getString("address"));
					userData.setTel(rs.getString("tel"));
					userData.setMobile(rs.getString("mobile"));
					userData.setStatusCode(userStatusDao.get(rs.getString("status_code")));
					userData.setVer(Timestamp.valueOf(rs.getString("ver")));

					userDataList.add(userData);
//					userDataList.add(n, userData);
//					n++;
				
					System.out.println(rs.getString("account") + "\t" + rs.getString("name") + "\t" + rs.getString("id")
							+ "\t" + rs.getString("gender") + "\t" + rs.getString("birthday") + "\t"
							+ rs.getString("email") + "\t" + rs.getString("city_code") + "\t"
							+ rs.getString("user_district_code") + "\t" + rs.getString("address") + "\t"
							+ rs.getString("tel") + "\t" + rs.getString("mobile") + "\t" + rs.getString("status_code")
							+ "\t" + rs.getString("ver"));
				}
//				System.out.println("000000000000000" + userDataList.get(0).getCityCode().getCity());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userDataList;
	}

}
