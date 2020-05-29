package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<UserEntity,Integer> {
    UserEntity findByUserPasswordAndUserPhone(String pwd,String phone);
    UserEntity findByUserPhone(String phone);
    UserEntity findByUserName(String name);
    UserEntity findByUserId(int userId);

    @Query(value = "select user_name from user where user_id = :userId",nativeQuery = true)
    String findUserNameByUserId(@Param("userId") int userId);
}
