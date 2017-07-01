package kr.co.turnup_fridger.security.handler;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
@Component
public class LoginFailHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException ex)
			throws IOException, ServletException {
		String errorMessage = URLEncoder.encode(ex.getMessage(), "UTF-8");
		response.sendRedirect(request.getContextPath()+"/login_form.do?errorMessage="+errorMessage);
		
	}
	
}
