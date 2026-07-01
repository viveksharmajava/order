package com.playpro.playpro.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Value("${orders.cors.allowed-origins:http://localhost:5173,http://localhost:3000}")
    private String allowedOrigins;

    @Bean
    public StubAuthFilter stubAuthFilter() {
        return new StubAuthFilter();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable()
                .httpBasic().disable()
                .formLogin().disable()
                .logout().disable()
                .exceptionHandling()
                .authenticationEntryPoint(new JsonUnauthorizedEntryPoint())
                .and()
                .addFilterBefore(stubAuthFilter(), UsernamePasswordAuthenticationFilter.class)
                .authorizeRequests()
                .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                .antMatchers(HttpMethod.GET, "/orders/**").hasAnyAuthority("ADMIN", "CATALOG_MANAGER", "MERCHANDISER", "VIEWER")
                .antMatchers(HttpMethod.POST, "/orders/find").hasAnyAuthority("ADMIN", "CATALOG_MANAGER", "MERCHANDISER", "VIEWER")
                .antMatchers(HttpMethod.POST, "/orders/quotes/find").hasAnyAuthority("ADMIN", "CATALOG_MANAGER", "MERCHANDISER", "VIEWER")
                .antMatchers(HttpMethod.GET, "/orders/reference/**").hasAnyAuthority("ADMIN", "CATALOG_MANAGER", "MERCHANDISER", "VIEWER")
                .antMatchers("/orders/**").hasAnyAuthority("ADMIN", "CATALOG_MANAGER", "MERCHANDISER")
                .anyRequest().denyAll();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(Arrays.asList(allowedOrigins.split(",")));
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(Arrays.asList("*"));
        config.setExposedHeaders(Arrays.asList("X-User"));
        config.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }
}
