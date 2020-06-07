package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.bean.Attention;
import com.tutulei.xunmi.entity.AttentionEntity;
import com.tutulei.xunmi.repository.AttentionRepository;
import com.tutulei.xunmi.repository.UserRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/subject")
public class AttentionController {
    private final AttentionRepository repository;
    AttentionController( AttentionRepository repository){this.repository = repository;}

    //获取用户关注圈子列表
    @GetMapping("getList")
    public List<Attention> getList(@Param("userId")int userId){
        List<AttentionEntity> attentionEntities = repository.findByAttentionUser(userId);
        List<Attention> list = new ArrayList<>();
        for(AttentionEntity attentionEntity:attentionEntities){
            Attention attention = new Attention();
            BeanUtils.copyProperties(attentionEntity, attention);
            list.add(attention);
        }
        return list;
    }
    //获取用户关注圈子总数
    @GetMapping("getCount")
    public int getCount(@Param("userId")int userId){
        return repository.countByAttentionUser(userId);
    }
}
