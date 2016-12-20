package com.framework.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;

public class PerformanceTraceAdvice {
	public Object trace(ProceedingJoinPoint joinPoint){
		System.out.println("PerformanceTraceAdvice : "+joinPoint.getSignature());
		
		long start = System.currentTimeMillis();
		
		try{
			Object obj = joinPoint.proceed();
			return obj;
		}catch(Throwable e){
			e.printStackTrace();
			return null;
		}finally{
			System.out.println("PerformanceTraceAdvice : "+joinPoint.getSignature()+ " / PerformanceTime : "+(System.currentTimeMillis() - start)+"ms");
		}		
	}
}
