package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.FollowEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface FollowRepository extends JpaRepository<FollowEntity,Integer> {
    FollowEntity findByFollowMasterAndAndFollowSlave(int master,int slave);
    int countByFollowSlave(int slave);
    int countByFollowMaster(int master);

    @Query(value = "select follow_master from follow where follow_slave = :id",nativeQuery = true)
    List<Integer> findFollowMasterByFollowSlave(@Param("id")int slave);
    @Query(value = "select follow_slave from follow where follow_master = :id",nativeQuery = true)
    List<Integer> findFollowSlaveByFollowMaster(@Param("id")int master);



}
