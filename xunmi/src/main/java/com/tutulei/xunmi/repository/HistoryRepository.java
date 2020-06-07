package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.bean.History;
import com.tutulei.xunmi.entity.HistoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

public interface HistoryRepository extends JpaRepository<HistoryEntity,Integer> {

    @Query(value = "select history_subject from history where history_user = :userId GROUP BY history_subject ORDER BY COUNT(history_subject) DESC LIMIT 5",nativeQuery = true)
    List<Integer> findHistorySubjectByHistoryUser(@Param("userId")int userId);

    List<HistoryEntity> findByHistoryUserOrderByHistoryCtimeDesc(int userId);

    @Transactional
    @Modifying
    @Query(value = "update history set history_ctime=:t where user_id=:id",nativeQuery = true)
    Integer updateUserPwd(@Param("t")Timestamp pwd, @Param("id")int id);

    HistoryEntity findByHistoryPostsAndHistoryUser(int postsId,int userId);
}
