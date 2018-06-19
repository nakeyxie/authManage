package com.oct.service.accessManage;

import com.oct.entity.accessManage.SysUser;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.junit.Assert.*;

@SpringBootTest
@RunWith(SpringRunner.class)
@Slf4j
public class SysUserServiceTest {

    @Autowired
    private SysUserService sysUserService;
    @Test
    public void saveUser() {
    }

    @Test
    public void login() {
    }

    @Test
    public void selectAll() {
        List<SysUser> users = sysUserService.selectAll();
        users.forEach(user-> System.out.println(user));
    }
}