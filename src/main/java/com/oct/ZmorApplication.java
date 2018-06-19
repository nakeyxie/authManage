package com.oct;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;


@SpringBootApplication
/*@ComponentScan(excludeFilters = {@ComponentScan.Filter(
		type = FilterType.ANNOTATION,
		classes = {org.springframework.stereotype.Service.class}
)})*/
@MapperScan("com.oct.repository")
public class ZmorApplication {

	public static void main(String[] args) {
		SpringApplication.run(ZmorApplication.class, args);
	}
}
