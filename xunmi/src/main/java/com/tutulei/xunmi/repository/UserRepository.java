package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity,Integer> {
    UserEntity findByUserPasswordAndUserPhone(String pwd,String phone);
    UserEntity findByUserPhone(String phone);
    UserEntity findByUserName(String name);
    UserEntity findByUserId(int userId);
    List<UserEntity> findByUserIdIn(List<Integer> list);


    @Query(value = "select user_name from user where user_id = :userId",nativeQuery = true)
    String findUserNameByUserId(@Param("userId") int userId);

    @Transactional
    @Modifying
    @Query(value = "update user set user_name=:n,user_sex=:s,user_words=:w where user_id=:id",nativeQuery = true)
    Integer updateUserMsg(@Param("n") String name,@Param("s")byte s,@Param("w")String word,@Param("id")int id);

    @Transactional
    @Modifying
    @Query(value = "update user set user_password=:pwd where user_id=:id",nativeQuery = true)
    Integer updateUserPwd(@Param("pwd") String pwd,@Param("id")int id);


}
