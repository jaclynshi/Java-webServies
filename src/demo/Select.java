package demo;

import java.util.List;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.io.UnsupportedEncodingException;

import cn.com.webxml.ArrayOfString;
import cn.com.webxml.WeatherWS;
import cn.com.webxml.WeatherWSSoap;

import cn.com.webxml.MobileCodeWS;
import cn.com.webxml.MobileCodeWSSoap;

import cn.com.webxml.ChinaZipSearchWebService;
import cn.com.webxml.ChinaZipSearchWebServiceSoap;

import cn.com.webxml.TrainTimeWebService;
import cn.com.webxml.TrainTimeWebServiceSoap;

import cn.com.webxml.ValidateCodeWebService;
import cn.com.webxml.ValidateCodeWebServiceSoap;

@WebServlet(name = "ToolServlet", urlPatterns = "/Tool.do")
public class Select extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
    	String func = request.getParameter("func");
    	String str = request.getParameter("str");
    	switch(func){
	        case "weather" :
	        	response.getWriter().write(weather(str));
	        	break;
	        case "moblie" :
	        	response.getWriter().write(moblie(str));
	        	break;
	        case "postal" :
	        	response.getWriter().write(postal(str));
	        	break;
	        case "train" :
	        	response.getWriter().write(train(str));
	        	break;
	        case "codeimg" :
	        	response.getWriter().write(codeimg(str));
	        	break;
    	}
    }

	public String weather(String str) {
        WeatherWS factory = new WeatherWS();
        WeatherWSSoap weatherWSSoap = factory.getWeatherWSSoap();
        ArrayOfString weatherInfo = weatherWSSoap.getWeather(str, null);
        List<String> lstWeatherInfo = weatherInfo.getString();
        String weather_str = lstWeatherInfo.get(4);
        return weather_str;
	}
	
	public String moblie(String str) {
         MobileCodeWS factory = new MobileCodeWS();
         MobileCodeWSSoap mobileCodeWSSoap = factory.getMobileCodeWSSoap();
         String searchResult = mobileCodeWSSoap.getMobileCodeInfo(str, null);
         return searchResult;
	}
	
	public String train(String str) {
		TrainTimeWebService factory = new TrainTimeWebService();
		TrainTimeWebServiceSoap trainTimeWebServiceSoap = factory.getTrainTimeWebServiceSoap();
        ArrayOfString trainInfo = trainTimeWebServiceSoap.getStationAndTimeByTrainCode(str, "");
        List<String> lsttrainInfo = trainInfo.getString();
        String res = "出发站：" + lsttrainInfo.get(1) + "； 终点站：" + lsttrainInfo.get(2) + "； 出发时间：" + lsttrainInfo.get(4) + "； 到达时间：" + lsttrainInfo.get(6);
        return res;
	}
	
	public String postal(String str) {
		ChinaZipSearchWebService factory = new ChinaZipSearchWebService();
		ChinaZipSearchWebServiceSoap chinaZipSearchWebServiceSoap = factory.getChinaZipSearchWebServiceSoap();
		String Info = chinaZipSearchWebServiceSoap.getAddressByZipCode("225300", "").toString();
		System.out.println(chinaZipSearchWebServiceSoap.getZipCodeByAddress("江苏", "南京", "雨花台", ""));
        return Info;
	}
	
	public String codeimg(String str) {
		ValidateCodeWebService factory = new ValidateCodeWebService();
		ValidateCodeWebServiceSoap validateCodeWebServiceSoap = factory.getValidateCodeWebServiceSoap();
		byte[] bytes = validateCodeWebServiceSoap.cnValidateByte(str);
		String base64Str = Base64.getEncoder().encodeToString(bytes);
        return base64Str;
	}
	
	public static String getEncodedBase64(String plainText){
        String encoded = null;
        try {
            byte[] bytes =plainText.getBytes("UTF-8");
            encoded = Base64.getEncoder().encodeToString(bytes);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return encoded;
    }
	
	public static byte[] getDecodedBase64(String plainText){
        byte[] decoded = null;
        try {
            byte[] bytes =plainText.getBytes("UTF-8");
            decoded = Base64.getDecoder().decode(bytes);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return decoded;
    }

}
