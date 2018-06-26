/*
Navicat MySQL Data Transfer

Source Server         : mysql_localhost
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : cxf-rest

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2018-06-26 12:22:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '学号',
  `name` varchar(20) DEFAULT NULL,
  `gender` varchar(4) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '张三', '男', '湖北省武汉市');
INSERT INTO `student` VALUES ('2', '李四', '男', '上海市');
INSERT INTO `student` VALUES ('3', '小花', '女', '南京市');
