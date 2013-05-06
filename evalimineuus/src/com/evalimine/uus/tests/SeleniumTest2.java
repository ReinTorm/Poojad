package com.evalimine.uus.tests;

import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.server.SeleniumServer;
import org.testng.annotations.AfterTest;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.SeleneseTestCase;

public class SeleniumTest2 extends SeleneseTestCase {
	private static SeleniumServer seleniumServer;
	@Before
	public void setUp() throws Exception {
		selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://www.google.co.in/");
        seleniumServer = new SeleniumServer();
        seleniumServer.start();
		selenium.start();
	}
	
	@Test
	public void testSearchForArtur() throws Exception {
		selenium.open("http://3valimine.appspot.com");
		selenium.waitForPageToLoad("30000"); 
		selenium.click("loginnav");
		selenium.waitForPageToLoad("30000"); 
		selenium.click("googlelogin");  
		selenium.waitForPageToLoad("30000"); 
		selenium.type("Email", "SISESTA EMAIL");
		selenium.type("Passwd", "SISESTA PAROOL");
		selenium.click("signIn");
		selenium.waitForPageToLoad("30000");
		selenium.type("resultSearch", "Artur Käpp"); 
		String name = selenium.getText("//ul[@id='results']/li[1]/a"); 
		assertEquals(name, "Artur Käpp");  
	}
	
	@AfterTest
	public void tearDown() throws InterruptedException{
	selenium.stop(); 
	seleniumServer.stop();

	}
	
}