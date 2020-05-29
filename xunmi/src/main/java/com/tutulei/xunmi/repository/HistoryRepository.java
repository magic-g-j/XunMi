package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.bean.History;
import com.tutulei.xunmi.entity.HistoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HistoryRepository extends JpaRepository<HistoryEntity,Integer> {

    @Query(value = "select history_subject from history where history_user = :userId GROUP BY history_subject ORDER BY COUNT(history_subject) DESC LIMIT 5",nativeQuery = true)
    List<Integer> findHistorySubjectByHistoryUser(@Param("userId")int userId);

    @Query(value = "select history_posts,history_ctime from history where history_user = :userId ORDER BY history_ctime DESC",nativeQuery = true)
    List<HistoryEntity> findHistoryPostsByHistoryUser(int userId);

    HistoryEntity findByHistoryPostsAndHistoryUser(int postsId,int userId);
}
