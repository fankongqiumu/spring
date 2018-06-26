package com.hsun.test;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;
import com.hsun.pojo.Student;

import org.apache.cxf.jaxrs.client.WebClient;

import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;

/**
 * cxf test客户端
 * @author hsun
 *
 */

public class CXFWebClient {
    public static void main(String[] args) {
        String baseAddress="http://localhost:8080/ws/rest";
        List<Object> providerList=new ArrayList<Object>();
        providerList.add(new JacksonJsonProvider());
        Student student = WebClient.create(baseAddress,providerList)
                .path("/student/2")
                .accept(MediaType.APPLICATION_JSON)
                .get(Student.class);
            System.out.println(student);
        }
}