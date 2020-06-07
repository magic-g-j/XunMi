package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.User;
import com.tutulei.xunmi.bean.UserForList;
import com.tutulei.xunmi.entity.FollowEntity;
import com.tutulei.xunmi.entity.UserEntity;
import com.tutulei.xunmi.repository.FollowRepository;
import com.tutulei.xunmi.repository.UserRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/follow")
public class FollowController {
    private final FollowRepository repository;
    private final UserRepository userRepository;
    FollowController(FollowRepository repository,UserRepository userRepository){this.repository = repository;this.userRepository=userRepository;}
    //master 被关注者 slave 关注者


    //添加一个关注关系（如果已经有该关系了，返回false）
    @PostMapping("/addOne")
    public boolean addOne(@Param("master")int master,@Param("slave")int slave){
        Integer state = this.getState(master, slave);
        if(state==0||state==2){
            FollowEntity followEntity= new FollowEntity();
            followEntity.setFollowMaster(master);
            followEntity.setFollowSlave(slave);
            repository.save(followEntity);
            return true;
        }
        return false;
    }
    //删除一个关注关系（如果本来没有关系，返回false）
    @PostMapping("/deleteOne")
    public boolean deleteOne(@Param("master")int master,@Param("slave")int slave){
        Integer state = this.getState(master, slave);
        if(state==1||state==3){
            FollowEntity followEntity = repository.findByFollowMasterAndAndFollowSlave(master,slave);
            repository.delete(followEntity);
            return true;
        }
        return false;
    }

    //获取两人之间的关系（0，无关系 1，我关注他 2他关注我 3，互关）
    @GetMapping("/getState")
    public Integer getState(@Param("me")int me,@Param("he")int he){
        FollowEntity f1 = repository.findByFollowMasterAndAndFollowSlave(he,me);
        FollowEntity f2 = repository.findByFollowMasterAndAndFollowSlave(me,he);
        if(f1!=null&&f2!=null){
            return 3;
        }else if(f1!=null){
            return 1;
        }else  if(f2!=null){
            return 2;
        }
        return 0;
    }
    //获取用户关注列表
    @GetMapping("/getMasters")
    public List<UserForList> getMasters(@Param("userId")int userId){
        List<Integer> masterList = repository.findFollowMasterByFollowSlave(userId);
        return getUserForLists(masterList);
    }
    //获取用粉丝注列表
    @GetMapping("/getSlaves")
    public List<UserForList> getSlaves(@Param("userId")int userId){
        List<Integer> slaveList = repository.findFollowSlaveByFollowMaster(userId);
        return getUserForLists(slaveList);
    }

    private List<UserForList> getUserForLists(List<Integer> slaveList) {
        List<UserEntity> userEntities = userRepository.findByUserIdIn(slaveList);
        List<UserForList> users = new ArrayList<>();
        for(UserEntity userEntity:userEntities){
            UserForList user = new UserForList();
            BeanUtils.copyProperties(userEntity, user);
            users.add(user);
        }
        return users;
    }

    //获取用户关注总数
    @GetMapping("/getCount")
    public Integer getCount(@Param("userId")int userId){
        return repository.countByFollowSlave(userId);
    }

    //获取用户粉丝总数
    @GetMapping("/getSlaveCount")
    public Integer getSalveCount(@Param("userId")int userId){
        return repository.countByFollowMaster(userId);
    }
}
