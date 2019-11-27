package rscdemo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;


@Configuration
public class WebMvcConfigurer extends WebMvcConfigurerAdapter {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new MailCustomerInterceptor()).addPathPatterns("/user/**");
        registry.addInterceptor(new PostInterceptor()).addPathPatterns("/post/**");
        registry.addInterceptor(new AdminInterceptor()).addPathPatterns("/admin/**");
        super.addInterceptors(registry);
    }
}
