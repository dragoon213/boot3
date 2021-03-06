package com.iu.boot3.confing;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

import com.iu.boot3.interceptor.AdminInterceptor;
import com.iu.boot3.interceptor.BoardInterceptor;
import com.iu.boot3.interceptor.SellerInterceptor;
import com.iu.boot3.interceptor.WriterCheckInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
	
	@Autowired
	private SellerInterceptor sellerInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private BoardInterceptor boardInterceptor;
	@Autowired
	private WriterCheckInterceptor writerCheckInterceptor;
	
	// LocaleChangeInterceptor 주입
	@Autowired
	private LocaleChangeInterceptor localeChangeInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 적용할 Interceptor를 등록
		registry.addInterceptor(sellerInterceptor)
			// interceptor를 사용할 URL
			.addPathPatterns("/product/manage");
//			.addPathPatterns("//");
		
		// 제외할 URL
//		 .excludePathPatterns("")
		// 추가로 다른 Interceptor를 등록
//		registry.addInterceptor()
//				.addPathPatterns("")
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns("/admin/manage");
				
		registry.addInterceptor(boardInterceptor)
				.addPathPatterns("/board/*")
				.excludePathPatterns("/board/list");
		
		registry.addInterceptor(writerCheckInterceptor)
		.addPathPatterns("/board/update")
		.addPathPatterns("/board/delete");
		
		// localechangeInterceptor를 등록
		registry.addInterceptor(localeChangeInterceptor)
				.addPathPatterns("/**");
		
	}
}
