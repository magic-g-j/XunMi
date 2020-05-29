package com.tutulei.xunmi.controller;

import com.tutulei.xunmi.MyMethod;
import com.tutulei.xunmi.bean.User;
import com.tutulei.xunmi.entity.UserEntity;
import com.tutulei.xunmi.repository.UserRepository;
import com.tutulei.xunmi.validatecode.IVerifyCodeGen;
import com.tutulei.xunmi.validatecode.SimpleCharVerifyCodeGenImpl;
import com.tutulei.xunmi.validatecode.VerifyCode;
import com.tutulei.xunmi.view.LoginMsg;
import com.tutulei.xunmi.view.RegisterMsg;
import org.springframework.beans.BeanUtils;
import org.springframework.data.repository.query.Param;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Timestamp;


@RestController
@RequestMapping("/user")
public class UserController {
    private final UserRepository repository;
    private static final String salt_part = "jh";
    UserController(UserRepository repository){this.repository = repository;}

    @GetMapping("/getOne")
    User GetOne(@Param("userId") int userId){
        UserEntity userEntity = repository.findByUserId(userId);
        if(userEntity != null){
            User user = new User();
            BeanUtils.copyProperties(userEntity, user);
            return user;
        }
        return null;
    }

    //登录
    @PostMapping("/login")
    User Login(@RequestBody LoginMsg loginMsg){
        String md5Password = addSaltPWD(loginMsg.getUserPwd(),loginMsg.getUserPhone());
//        System.out.println(md5Password);
        UserEntity userEntity = repository.findByUserPasswordAndUserPhone(md5Password,loginMsg.getUserPhone());
        if(userEntity != null){
            User user = new User();
            BeanUtils.copyProperties(userEntity, user);
            return user;
        }
        return null;
    }
    //用户注册post
    @PostMapping("/register")
    User Register(@RequestBody RegisterMsg registerMsg,HttpServletRequest request){
//        System.out.println(registerMsg.getUserPassword());
        UserEntity u1 = repository.findByUserPhone(registerMsg.getUserPhone());
        UserEntity u2 = repository.findByUserName(registerMsg.getUserName());
        User u = new User();
        String code = registerMsg.getVerifyCode();
        if(!MyMethod.verifyCodeMap.get(GETIP(request)).equals(code) || code.equals("")){
            u.setUserId(-9);
//            u.setUserName(code);
//            u.setUserWords(SimpleCharVerifyCodeGenImpl.verifyCodeMap.get(GETIP(request)));
            return u;
        }
        if(u1 == null && u2 == null) {
            UserEntity entity = new UserEntity();
            BeanUtils.copyProperties(registerMsg, entity);
            String str = addSaltPWD(entity.getUserPassword(),entity.getUserPhone());
//            System.out.println(str);
            entity.setUserPassword(str);
            entity.setUserIdentity(0);
            entity.setUserCtime(new Timestamp(System.currentTimeMillis()));
            System.out.println(entity.getUserId());
            UserEntity userEntity = repository.saveAndFlush(entity);
            System.out.println(userEntity.getUserId());
            User user = new User();
            BeanUtils.copyProperties(userEntity, user);
            System.out.println(user.getUserId());
            return user;
        }
        u.setUserId(-8);
        u.setUserName("用户名或手机号已经被注册！");
        return u;
    }


//    @ApiOperation(value = "验证码")
    @GetMapping("/verifyCode")
    public byte[] verifyCode(HttpServletRequest request) {
        IVerifyCodeGen iVerifyCodeGen = new SimpleCharVerifyCodeGenImpl();
        try {
            //设置长宽
            VerifyCode verifyCode = iVerifyCodeGen.generate(80, 28);
            String code = verifyCode.getCode();
            String ip = GETIP(request);
            System.out.println(code);
            System.out.println(ip);
            MyMethod.verifyCodeMap.put(ip,code);
            System.out.println(MyMethod.verifyCodeMap.toString());
            return verifyCode.getImgBytes();
//            LOGGER.info(code);
//            //将VerifyCode绑定session
//            request.getSession().setAttribute("VerifyCode", code);
//            //设置响应头
//            response.setHeader("Pragma", "no-cache");
//            //设置响应头
//            response.setHeader("Cache-Control", "no-cache");
//            //在代理服务器端防止缓冲
//            response.setDateHeader("Expires", 0);
//            //设置响应内容类型
//            response.setContentType("image/jpeg");
//            response.getOutputStream().write(verifyCode.getImgBytes());
//            response.getOutputStream().flush();
        } catch (IOException e) {
        }

        return null;
    }

    private String GETIP(HttpServletRequest request){
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.trim() == "" || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }

        // 多个路由时，取第一个非unknown的ip
        final String[] arr = ip.split(",");
        for (final String str : arr) {
            if (!"unknown".equalsIgnoreCase(str)) {
                ip = str;
                break;
            }
        }
        return ip;
    }

    private String addSaltPWD(String code1,String code2){
        //md5二次加密，salt = MD5密码 + "jh" +用户手机号
        String temp = code1 + salt_part + code2;
        String md5Password = DigestUtils.md5DigestAsHex(temp.getBytes());//MD5加密
        return md5Password;
    }

}
