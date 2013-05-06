package com.evalimine.uus.tests;

import org.junit.Test;

import junit.framework.TestCase;
import junit.framework.TestSuite;
import junit.textui.TestRunner;

public class TestSuite1 extends TestCase{
	
	public static TestSuite suite() { 
		TestSuite suite = new TestSuite(); 
		suite.addTestSuite(SeleniumTest.class); 
		suite.addTestSuite(SeleniumTest2.class); 
		suite.addTestSuite(SeleniumTest3.class);
		return suite;
		
	}
	
	public static void main(String arg[]){
		TestRunner.run(suite()); 
	}
}
