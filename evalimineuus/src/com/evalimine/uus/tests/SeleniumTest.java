package com.evalimine.uus.tests;

import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.server.SeleniumServer;

import com.thoughtworks.selenium.*; 


public class SeleniumTest extends SeleneseTestCase {
	private static SeleniumServer seleniumServer;
	@Before
	public void setUp() throws Exception {
		selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://www.google.co.in/");
        seleniumServer = new SeleniumServer();
        seleniumServer.start();
		selenium.start();
	}
	
	@Test
	public void testVoteForArtur() throws Exception {
		selenium.open("http://3valimine.appspot.com");
		selenium.waitForPageToLoad("30000"); 
		selenium.click("loginnav");
		selenium.waitForPageToLoad("30000"); 
		selenium.click("googlelogin");  
		selenium.waitForPageToLoad("30000"); 
		selenium.type("Email", "rntorm@gmail.com");
		selenium.type("Passwd", "Kalakeneelukas321");
		selenium.click("signIn");
		selenium.waitForPageToLoad("30000");
		selenium.click("statnav");
		Thread.sleep(500); 
		selenium.click("//div[@id='statpage' and @class='tab']/aside/a[1][@class='statbutton']");
		Thread.sleep(1000); 
		String vote1  = selenium.getText("//tbody[@id='candidateTable']/tr[4]/td[6]"); 	
        selenium.click("votenav"); 
        Thread.sleep(500); 
		selenium.click("//ul[@id='results']/li[1]/a");   
		Thread.sleep(500); 
		selenium.click("votebutton"); 
		selenium.click("statnav");
		selenium.waitForPageToLoad("30000"); 
		selenium.click("//div[@id='statpage' and @class='tab']/aside/a[1][@class='statbutton']");
		Thread.sleep(1500);
		String vote2  = selenium.getText("//tbody[@id='candidateTable']/tr[1]/td[6]"); 
		
		//selenium.click("//input[@value='Advanced Search']");
		//selenium.waitForPageToLoad("30000");
	}
	


	





}
