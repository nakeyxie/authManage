package com.oct.controller.main;

import com.oct.common.JsonResult;
import com.oct.common.SysConstant;
import com.oct.dto.response.accessManage.MenuTreeDTO;
import com.oct.entity.accessManage.SysUser;
import com.oct.exception.LogInEnum;
import com.oct.exception.LoginException;
import com.oct.dto.request.main.LoginParam;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysUserService;
import com.oct.service.main.MainService;
import com.oct.util.BeanValidator;
import com.oct.util.ImageCodeUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
public class MainController {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private MainService mainService;

	/**
	 * 跳转到登录页
	 */
	@GetMapping("/preLogin")
	@Auth(verifyLogin=false,verifyUrl=false)
	public String preLogin(){
		return "login";
	}


	@PostMapping("/login")
	@ResponseBody
	@Auth(verifyLogin=false,verifyUrl=false)
	public JsonResult login(LoginParam loginParam, HttpSession session){
		BeanValidator.check(loginParam);
		String sessionCode = (String) session.getAttribute(SysConstant.SESSION_IMAGE_CODE);
		String imageCode = loginParam.getImageCode();
		if(!imageCode.equalsIgnoreCase(sessionCode)){
			throw new LoginException(LogInEnum.CODE_ERROE);
		}
		SysUser user = sysUserService.login(loginParam.getAccount(),loginParam.getPassword());
		session.setAttribute(SysConstant.SESSION_USER,user);
		return JsonResult.success(user);
	}

	@GetMapping("/logout")
	@Auth(verifyLogin=false,verifyUrl=false)
	public String logout(HttpSession session){
		session.removeAttribute(SysConstant.SESSION_USER);
		return "login";
	}
	@GetMapping("/index")
	@Auth(verifyUrl=false)
	public String index(){
		return "index";
	}

	@GetMapping("/getCode")
    @Auth(verifyLogin=false,verifyUrl=false)
	public void  getCode (HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try {
			String code = new ImageCodeUtil().processRequest(request,response);
			session.setAttribute(SysConstant.SESSION_IMAGE_CODE,code);
		}catch (Exception e) {
			log.error("生成验证码错误：",e);
		}
	}

	@GetMapping("/getMenu")
    @ResponseBody
    @Auth(verifyUrl=false)
	public List<MenuTreeDTO> getMenu(HttpSession session){
		SysUser user = (SysUser) session.getAttribute(SysConstant.SESSION_USER);
		return mainService.getMenu(user.getId());
	}

}
