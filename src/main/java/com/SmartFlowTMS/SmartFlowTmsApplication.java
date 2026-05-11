package com.SmartFlowTMS;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SmartFlowTmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(SmartFlowTmsApplication.class, args);
		System.out.println("========================================");
        System.out.println("🚦 SmartFlow TMS is RUNNING!");
        System.out.println("📍 Access at: http://localhost:8080/smartflow");
        System.out.println("========================================");
	}

}
