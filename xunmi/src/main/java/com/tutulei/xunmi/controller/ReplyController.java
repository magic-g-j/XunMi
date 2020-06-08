package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.Reply;
import com.tutulei.xunmi.entity.PostsEntity;
import com.tutulei.xunmi.entity.ReplyEntity;
import com.tutulei.xunmi.entity.UserEntity;
import com.tutulei.xunmi.repository.PostsRepository;
import com.tutulei.xunmi.repository.ReplyRepository;
import com.tutulei.xunmi.repository.UserRepository;
import com.tutulei.xunmi.view.ReplyMsg;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/reply")
public class ReplyController {
    private final ReplyRepository repository;
    private final PostsRepository postsRepository;
    private final UserRepository userRepository;

    ReplyController(ReplyRepository replyRepository,PostsRepository postsRepository,UserRepository userRepository){
        this.repository = replyRepository;
        this.postsRepository = postsRepository;
        this.userRepository = userRepository;
    }

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
            UserEntity userEntity = userRepository.findByUserId(reply.getReplyCreator());
            reply.setReplyCreatorName(userEntity.getUserName());
            replies.add(reply);
        }
        return replies;
    }
    //回复
    @PostMapping("/add")
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
        byte t = 1;
        byte f = 0;
        Byte pt = (replyMsg.getReplyParentType() == 1) ? t : f;
        replyEntity.setReplyParentType(pt);
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
    //为帖子点赞(操作规则 type=true代表like，false代表dislike，add=true代表添加，false代表取消)
    @GetMapping("likeAndDislike/modify")
    public boolean Like(@Param("replyId")Integer replyId,@Param("type")boolean type,@Param("add")boolean add){
        ReplyEntity replyEntity = repository.findByReplyId(replyId);
        if(replyEntity!=null){
            if(type&&add){
                replyEntity.setReplyLikes(replyEntity.getReplyLikes()+1);
            }else if(type){
                replyEntity.setReplyLikes(replyEntity.getReplyLikes()-1);
            }else if(add){
                replyEntity.setReplyDislikes(replyEntity.getReplyDislikes()+1);
            }else {
                replyEntity.setReplyDislikes(replyEntity.getReplyDislikes()-1);
            }
            repository.saveAndFlush(replyEntity);
            return true;
        }
        return false;
    }

    private void updatePostsUpdateTime(Integer id,Integer type,Timestamp time){
        if(type == 1){
            //回复
            ReplyEntity replyEntity = repository.findByReplyId(id);
            updatePostsUpdateTime(replyEntity.getReplyParent(),(int) replyEntity.getReplyParentType(),time);
        } else{
            //帖子
            PostsEntity postsEntity = postsRepository.findByPostsId(id);
            postsEntity.setPostsUpdateTime(new Timestamp(System.currentTimeMillis()));
            postsRepository.saveAndFlush(postsEntity);
        }
    }
}
