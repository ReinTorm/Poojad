package com.evalimine.uus.tests;

import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.server.SeleniumServer;
import org.testng.annotations.AfterTest;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.SeleneseTestCase;

public class SeleniumTest3 extends SeleneseTestCase{
	
	private static SeleniumServer seleniumServer;
	@Before
	public void setUp() throws Exception {
		selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://www.google.co.in/");
        seleniumServer = new SeleniumServer();
        seleniumServer.start();
		selenium.start();
	}
	
	@Test
	public void testApplyForCandidacy() throws Exception {
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
		selenium.click("applynav");
		selenium.waitForPageToLoad("30000");
		selenium.click("//a[@id='candidateFormLink' and @class='open']/b");
		Thread.sleep(1500); 
		selenium.type("//form[@id='candidateForm']/ul/li[1]/input", "Meelis");
		selenium.type("//form[@id='candidateForm']/ul/li[2]/input", "Metsis");
		selenium.type("//form[@id='candidateForm']/ul/li[3]/input", "39321458691");
		selenium.type("//form[@id='candidateForm']/ul/li[2]/input", "Mell");
		selenium.select("//form[@id='candidateForm']/ul/li[4]/select", "Üksikkandidaat");
		selenium.click("//*[@id='10']");
		//selenium.select("//form[@id='candidateForm']/ul/li[5]/select", "//*[@id='10']"); 
		selenium.type("//form[@id='candidateForm']/ul/li[6]/input", "Lamp 1");
	
		selenium.click("//a[@id='marginFixer' and @class='button']");
		Thread.sleep(1000); 
		selenium.click("//a[@id='candidatebutton' and @class='button']"); 
		Thread.sleep(1000); 
		String value = selenium.getText("//div[@id='easyNotification']"); 
		assertEquals(value, "Ankeet edukalt ülevaatusele saadetud!Sulge"); 
	
	}
	
	@AfterTest
	public void tearDown() throws InterruptedException{
		selenium.stop(); 
		seleniumServer.stop();

	}
	
}
