package com.siot.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class SpringConfigClass extends AbstractAnnotationConfigDispatcherServletInitializer {

	//Bean정의 하는 거 세팅
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] {RootAppContext.class};
	}

	//SpringMvc프로젝트 설정을 위한 class 지정
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] {ServletAppContext.class};
	}

	//DispatcherServlet에서 매핑할 요청주소 세팅
	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"};
	}
	
	//한글 꺠짐방지 필터세팅
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		return new Filter[] {encodingFilter};
	}
	
	@Override
	protected void customizeRegistration(Dynamic registration) {
		super.customizeRegistration(registration);
		//업로드 되는 파일 용량 체크 하기...
		MultipartConfigElement config1 = new MultipartConfigElement(null, 1024*1024*100, 1024*1024*1000, 0);
		registration.setMultipartConfig(config1);
	}
}









