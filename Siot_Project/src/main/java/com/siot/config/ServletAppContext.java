package com.siot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
@EnableWebMvc
@ComponentScan("com.siot.controller")
@ComponentScan("com.siot.model")
//com.jjang051.model 에 있는 annotation 스캔해서 Spring Container에 담아둬라....
public class ServletAppContext implements WebMvcConfigurer {
	//viewResolver
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/",".jsp");
	}
	//정적 파일 세팅
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		WebMvcConfigurer.super.addResourceHandlers(registry);
		registry.addResourceHandler("/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/userProject/**").addResourceLocations("file:///C:/user_image/");
		registry.addResourceHandler("/qnaImg/**").addResourceLocations("file:///C:/qna_image/");
		registry.addResourceHandler("/productImage/**").addResourceLocations("file:///C:/pdt_image/");
		registry.addResourceHandler("/summernoteImg/**").addResourceLocations("file:///C:/summernote/");
		registry.addResourceHandler("/summernoteImg2/**").addResourceLocations("file:///C:/summernote2/");
		
	}
	
	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}
}





