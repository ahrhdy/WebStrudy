package com.framework.spring.common.scheduled;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {
	
	@Autowired
	public ScheduleService scheduleService;
	
	@Scheduled(cron="0 28 17 * * ?")
	public void process() throws Exception{
		System.out.println("스캐쥴러 START");
		Map map = new HashMap();
		scheduleService.scheduleFileProcess(map);			
	}
}
