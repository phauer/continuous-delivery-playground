package de.philipphauer.helloworld;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.junit.Assert;
import org.junit.Test;

public class DummyAcceptanceTest {
	
	//TODO do real acceptance testing (GUI test with selenium or behavior test with jbehave)

	@Test
	public void testConnection() throws IOException {
		String urlString = System.getProperty("service.url");
		System.out.println("testing url:" + urlString);

		URL serviceUrl = new URL(urlString + "hello-world");
		HttpURLConnection connection = (HttpURLConnection) serviceUrl.openConnection();
		int responseCode = connection.getResponseCode();
		Assert.assertEquals(200, responseCode);
	}
}
