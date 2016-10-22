package com.pujar.sudheer.automation.selenium;

import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

//import org.openqa.selenium.firefox.FirefoxDriver;

/**
 *  This test is help to test login page.
 */
public class VanillaSeleniumTest
{

    private WebDriver driver;



    @Test
    public void VanillaSeleniumTest() {

        WebDriverWait webDriverWait = new WebDriverWait(driver,10);
        webDriverWait.until(ExpectedConditions.elementToBeClickable(By.id("login")));
        String title = driver.getTitle();
       //Take Screenshot
        captureScreenShot();

        Assert.assertTrue(title.contains(Title of the page"));


    }

    @Before
    public void beforeTest(){

        //To do test case with two parameters

        try {
            DesiredCapabilities capabilities = DesiredCapabilities.internetExplorer();
            capabilities.setCapability(CapabilityType.BROWSER_NAME, "internet explorer");
            capabilities.setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS,true);
            capabilities.setCapability(CapabilityType.VERSION,"11");

            driver = new RemoteWebDriver(new URL("http://<gridhost>:4444/wd/hub"), capabilities);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        driver.get("http://www.google.com");
    }
    @After
    public void afterTest() {
        driver.quit();
    }

    /**
     *  This method help to take screenshot
     */
    public void captureScreenShot(){


        File scrFile = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
        // Now you can do whatever you need to do with it, for example copy somewhere
        try{

            String userHome = System.getProperty("user.home");

           //Make directory
            File seleniumDir = new File(userHome+"\\SeleniumScreenShot");

            if(!seleniumDir.exists()){
                seleniumDir.mkdir();

            }

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
            //get current date time with Date()
            Date date = new Date();
            //Save file copy to user home directory
            FileUtils.copyFile(scrFile, new File(seleniumDir.getPath()+"\\screenshot_"+dateFormat.format(date)+".png"));


    }catch (IOException ex){
        ex.printStackTrace();
        }
    }
}
