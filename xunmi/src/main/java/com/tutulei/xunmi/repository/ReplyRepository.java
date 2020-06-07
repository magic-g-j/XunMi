package com.tutulei.xunmi.repository;

import com.tutulei.xunmi.entity.ReplyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReplyRepository extends JpaRepository<ReplyEntity,Integer> {
    ReplyEntity findByReplyId(int id);
    //reply_parent_type = 0 表示父级是帖子，1表示父级是回复
    @Query(value = "select COUNT(*) from reply where reply_parent = :id AND reply_parent_type = :replyType",nativeQuery = true)
    Integer countByReplyParentAndReplyParentType(@Param("id")int id,@Param("replyType")int replyType);
//    Integer countByReplyParentAndReplyParentType(Integer id,Byte replyType);

    List<ReplyEntity> findByReplyParentAndReplyParentType(int parentId,Byte type);

}
