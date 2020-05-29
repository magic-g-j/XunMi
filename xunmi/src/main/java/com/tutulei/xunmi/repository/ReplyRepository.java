package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.ReplyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReplyRepository extends JpaRepository<ReplyEntity,Integer> {

    //reply_parent_type = 0 表示父级是帖子，1表示父级是回复
    @Query(value = "select COUNT(*) from reply where reply_parent = :postsId AND reply_parent_type = 0;",nativeQuery = true)
    Integer findCountByPosts(@Param("postsId") int postsId);
}
