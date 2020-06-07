package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.Reply;
import com.tutulei.xunmi.entity.PostsEntity;
import com.tutulei.xunmi.entity.ReplyEntity;
import com.tutulei.xunmi.repository.PostsRepository;
import com.tutulei.xunmi.repository.ReplyRepository;
import com.tutulei.xunmi.view.ReplyMsg;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@RestController
public class ReplyController {
    private final ReplyRepository repository;
    private final PostsRepository postsRepository;
    ReplyController(ReplyRepository replyRepository,PostsRepository postsRepository){
        this.repository = replyRepository;
        this.postsRepository = postsRepository;}

    //列出帖子或者回复的回复（type: 0代表帖子，1代表回复）
    @GetMapping("/listReply")
    public List<Reply> ListReply(@Param("parentId")Integer parentId, @Param("parentType")Integer parentType) {
        byte t = 1;
        byte f = 0;
        Byte pt = (parentType == 1) ? t : f;
        List<ReplyEntity> replyEntities = repository.findByReplyParentAndReplyParentType(parentId,pt);
        List<Reply> replies = new ArrayList<>();
        for (ReplyEntity replyEntity : replyEntities) {
            Reply reply = new Reply();
            BeanUtils.copyProperties(replyEntity, reply);
            replies.add(reply);
        }
        return replies;
    }
    //回复
    @PostMapping("/reply")
    public boolean Reply(@RequestBody ReplyMsg replyMsg) {
        if(replyMsg.getReplyParentType() == 1){
            ReplyEntity replyEntity = repository.findByReplyId(replyMsg.getReplyParent());
            if(replyEntity==null){
                return false;
            }
        }else if(replyMsg.getReplyParentType() == 0){
            PostsEntity postsEntity = postsRepository.findByPostsId(replyMsg.getReplyParent());
            if(postsEntity==null){
                return false;
            }
        }
        Timestamp time = new Timestamp(System.currentTimeMillis());
        ReplyEntity replyEntity = new ReplyEntity();
        BeanUtils.copyProperties(replyMsg, replyEntity);
        replyEntity.setReplyCtime(time);
        replyEntity.setReplyLikes(0);
        replyEntity.setReplyDislikes(0);
        repository.save(replyEntity);
        updatePostsUpdateTime(replyMsg.getReplyParent(),replyMsg.getReplyParentType(),time);
        return true;
    }

    //通过id获取一个帖子或者回复的回复数量
    @GetMapping("/getReplyCount")
    public Integer GetReplyCount(@Param("parentId")Integer parentId,@Param("parentType")Integer parentType) {
        Integer count = 0;
        if(parentType==0){
            List<Reply> rply1 = ListReply(parentId,parentType);
            for(Reply r:rply1){
                Integer rCount = GetReplyCount(r.getReplyId(),1);
                count = count + rCount;
            }
            count = count + repository.countByReplyParentAndReplyParentType(parentId,parentType);
        }else if(parentType==1){
            count = repository.countByReplyParentAndReplyParentType(parentId,parentType);
        }else{
            count = -1;
        }
        return count;
    }


    private void updatePostsUpdateTime(Integer id,Integer type,Timestamp time){
        if(type == 1){

        }
    }
}
