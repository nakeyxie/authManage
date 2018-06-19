package com.oct.filter;

import com.oct.common.ApplicationContextHelper;
import com.oct.common.JsonResult;
import com.oct.common.RequestHolder;
import com.oct.common.SysConstant;
import com.oct.entity.accessManage.SysUser;
import com.oct.filter.annotation.Auth;
import com.oct.service.main.MainService;
import com.oct.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * 
 * <p>
 * Title: AuthInterceptor.java
 * </p>
 * Description: 权限拦截器
 * <p>
 * Modify histoty:
 * 
 * @author lxc
 * @version 1.0
 * @created Jul 10, 2017 4:12:04 PM
 */
@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

	private final static String noAuthUrl = "/menu/preNoAuth";
	/**
	 * 验证权限
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HandlerMethod method = (HandlerMethod) handler;
		Auth auth = method.getMethod().getAnnotation(Auth.class);

		HttpSession session = request.getSession();



		String requestedWith = request.getHeader("x-requested-with");

		// 对登录超时与默认验证进行验证
		if (auth == null || auth.verifyLogin()) {
			SysUser user = (SysUser) session.getAttribute(SysConstant.SESSION_USER);
			if (null == user || user.getId() == 0) {
				
				// ajax请求处理方式
				if (requestedWith != null && "XMLHttpRequest".equals(requestedWith)) {
					log.info("用户未登录或登录超时——>ajax请求处理方式");
					JsonResult jsonResult = new JsonResult();
					response.setHeader("sessionstatus", "timeout");
					response.getWriter().print(JsonResult.fail(-1,"由于您长时间没有操作, 请重新登录。"));
					return false;
					
				// 普通请求处理方式
				} else {
					log.info("用户未登录或登录超时——>普通请求处理方式");
					
					/*StringBuffer redirctHtmlBuffer = new StringBuffer();
					redirctHtmlBuffer.append("<!DOCTYPE HTML><html><head>");
					redirctHtmlBuffer.append("<script type=\"text/javascript\">");
					redirctHtmlBuffer.append("window.top.location.href=\"");
					redirctHtmlBuffer.append(request.getContextPath() + SysConstant.PRE_NOT_LOGIN_PAGE);
					redirctHtmlBuffer.append("\";");
					redirctHtmlBuffer.append("</script>");
					redirctHtmlBuffer.append("</head><body></body></html>");
					response.getWriter().print(redirctHtmlBuffer);*/
					response.sendRedirect(request.getContextPath()+"/preLogin");
					return false;
				}

			}

            RequestHolder.add(user);
            RequestHolder.add(request);
			//权限验证
            if(auth == null || auth.verifyUrl()){

                String servletPath = request.getServletPath();
                Map requestMap = request.getParameterMap();

                if (user == null) {
                    log.info("someone visit {}, but no login, parameter:{}", servletPath, JsonMapper.obj2String(requestMap));
                    noAuth(request, response);
                    return false;
                }

                MainService mainService = ApplicationContextHelper.popBean(MainService.class);
                if (!mainService.hasUrlAcl(servletPath)) {
                    log.info("{} visit {}, but no auth, parameter:{}", JsonMapper.obj2String(user), servletPath, JsonMapper.obj2String(requestMap));
                    noAuth(request, response);
                    return false;
                }
            }

		}

		return super.preHandle(request, response, handler);

	}

	private void noAuth(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requestedWith = request.getHeader("x-requested-with");
		if (requestedWith != null && "XMLHttpRequest".equals(requestedWith)) {
			response.setHeader("Content-Type", "application/json;charset=UTF-8");

			response.getWriter().print(JsonMapper.obj2String(JsonResult.fail(-2,"没有访问权限，如需要访问，请联系管理员")));
			return;
		} else {
            response.sendRedirect(request.getContextPath()+noAuthUrl);
			/*clientRedirect(noAuthUrl, response);*/
			return;
		}
	}

	private void clientRedirect(String url, HttpServletResponse response) throws IOException{
		response.setHeader("Content-Type", "text/html");
		response.getWriter().print("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
				+ "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" + "<head>\n" + "<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>\n"
				+ "<title>跳转中...</title>\n" + "</head>\n" + "<body>\n" + "跳转中，请稍候...\n" + "<script type=\"text/javascript\">//<![CDATA[\n"
				+ "window.location.href='" + url + "?ret='+encodeURIComponent(window.location.href);\n" + "//]]></script>\n" + "</body>\n" + "</html>\n");
	}

}
