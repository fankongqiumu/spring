package com.hsun.service;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.hsun.pojo.Student;

/**
 * 定义服务接口
 * @author hsun
 *
 */
public interface StudentService {
	
	@GET
    @Path("/student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	Student retireveStudentById(@PathParam("id")long id);

}
