package com.dhchain.system.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/SendMessage")
public class SendMessageController {
    private static Logger logger = LoggerFactory.getLogger(SendMessageController.class);

    @ResponseBody
    @RequestMapping(value = "/sendMessage")
    public void sendMessage() throws IOException, IllegalAccessException, InstantiationException, ClassNotFoundException {
        JSONObject json;
        String result;
        String corpId = "ww7a318b2eab00003e";
        String corpSecret = "lcuGZSr3ka7Xcxy2aA5ZTB086JOUgMAGX9paR-y5C5w";
        String getAccess_tokenUrl = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid="+corpId+"&corpsecret="+corpSecret;
        HttpGet httpGet = new HttpGet(getAccess_tokenUrl);
        CloseableHttpClient httpClient = HttpClients.createDefault();
        //HttpClient httpClient = new DefaultHttpClient();
        HttpResponse response = httpClient.execute(httpGet);
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            result=EntityUtils.toString(response.getEntity(),"utf-8");
            json = JSONObject.parseObject(result);
            if(json.get("errcode").equals("0")||(Integer)json.get("errcode") == 0) {
                String access_token = (String) json.get("access_token");
                String sendMessageUrl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token="+access_token;
                HttpPost httpPost = new HttpPost(sendMessageUrl);

                ////数据测试
                //List<OutputValue> list = new ArrayList<OutputValue>();
                //list = outputValueService.getOutputValue("2018", "4", "1");
                //GetListTemp getListTemp = new GetListTemp<OutputValue>();
                //String descriptionText = getListTemp.printObjectValue(list,OutputValue.class.getName());
                ////数据测试end

                JSONObject parameter = new JSONObject();
                JSONObject data = new JSONObject();
                //parameter.put("touser","@all");
                parameter.put("toparty","1");
                //parameter.put("totag","t");
                parameter.put("msgtype","textcard");
                parameter.put("agentid","1000002");
                data.put("title","今日发货报表");
                data.put("description","<div class=\"gray\">"+new Date().toString() +"</div> <div class=\"normal\">点击查看今日的发货信息</div><div class=\"highlight\">this is a test message!</div>");
                //data.put("description",descriptionText);
                data.put("url","app.dhchain.cn:8080/subpages/tab-subpage-OutputValue.html");
                //data.put("btntxt","最多四个字");
                parameter.put("textcard",data);

                String jsonStr = JSON.toJSONString(parameter);
                StringEntity se = new StringEntity(jsonStr,Charset.forName("utf-8"));
                se.setContentType("charset=utf-8");
                httpPost.setEntity(se);
                response=httpClient.execute(httpPost);
                if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                    logger.info("请求成功");
                }
            }
        }
    }
}
