package com.where2park.view.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice("com.where2park.view")
public class CommonExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public String handlerException(Exception e){
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", e);
		mav.setViewName("/common/error.jsp");
		return "/common/error.jsp";
	}
}
