/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50720
Source Host           : localhost:3308
Source Database       : rscdemo

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-12-07 09:43:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES ('91');
INSERT INTO `hibernate_sequence` VALUES ('91');
INSERT INTO `hibernate_sequence` VALUES ('91');
INSERT INTO `hibernate_sequence` VALUES ('91');
INSERT INTO `hibernate_sequence` VALUES ('91');
INSERT INTO `hibernate_sequence` VALUES ('91');

-- ----------------------------
-- Table structure for rsc_mail_customer
-- ----------------------------
DROP TABLE IF EXISTS `rsc_mail_customer`;
CREATE TABLE `rsc_mail_customer` (
  `ma_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ma_adress` varchar(100) DEFAULT NULL,
  `ma_loginname` varchar(50) DEFAULT NULL,
  `ma_name` varchar(50) DEFAULT NULL,
  `ma_password` varchar(50) DEFAULT NULL,
  `ma_phone` varchar(50) DEFAULT NULL,
  `ma_role` smallint(6) DEFAULT NULL,
  `ma_workingarea` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ma_id`),
  KEY `FK3gxa1jh5quoc90m98bsipvxjq` (`ma_role`),
  KEY `FKeo1sjnwh8b85fa8tq0vr32w7x` (`ma_workingarea`),
  CONSTRAINT `FK3gxa1jh5quoc90m98bsipvxjq` FOREIGN KEY (`ma_role`) REFERENCES `rsc_role` (`ro_id`),
  CONSTRAINT `FKeo1sjnwh8b85fa8tq0vr32w7x` FOREIGN KEY (`ma_workingarea`) REFERENCES `rsc_worlkingarea` (`wo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_mail_customer
-- ----------------------------
INSERT INTO `rsc_mail_customer` VALUES ('1', null, 'hello', null, '123456', null, '1', null);
INSERT INTO `rsc_mail_customer` VALUES ('2', null, '亮亮', null, '123456', null, '1', null);
INSERT INTO `rsc_mail_customer` VALUES ('3', '华软', '毛毛', '陈小树', '123456', '15219584649', '2', '1');
INSERT INTO `rsc_mail_customer` VALUES ('5', '华软学院584号', '薇薇', '李薇薇', '123456', '14789652365', '2', '1');
INSERT INTO `rsc_mail_customer` VALUES ('6', '温泉路198号', '明明', '叶明明', '123456', '1', '3', '2');
INSERT INTO `rsc_mail_customer` VALUES ('7', '良口56号', '维维', '谭维维', '123456', '15978643542', '3', '3');
INSERT INTO `rsc_mail_customer` VALUES ('8', '江高65号', '凉凉', '黎凉凉', '123456', '15978643542', '2', '5');
INSERT INTO `rsc_mail_customer` VALUES ('9', null, '冷冷', null, '123456', null, '1', null);

-- ----------------------------
-- Table structure for rsc_management
-- ----------------------------
DROP TABLE IF EXISTS `rsc_management`;
CREATE TABLE `rsc_management` (
  `ma_id` bigint(20) NOT NULL,
  `ma_loginname` varchar(50) DEFAULT NULL,
  `ma_password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ma_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_management
-- ----------------------------
INSERT INTO `rsc_management` VALUES ('1', '大王', '123456');

-- ----------------------------
-- Table structure for rsc_post
-- ----------------------------
DROP TABLE IF EXISTS `rsc_post`;
CREATE TABLE `rsc_post` (
  `po_id` bigint(20) NOT NULL,
  `po_name` varchar(50) DEFAULT NULL,
  `po_password` varchar(50) DEFAULT NULL,
  `po_phone` varchar(50) DEFAULT NULL,
  `po_work` bit(1) DEFAULT NULL,
  `po_workload` int(11) DEFAULT NULL,
  `po_workarea` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`po_id`),
  KEY `FK_WORD_AREA` (`po_workarea`),
  CONSTRAINT `FK_WORD_AREA` FOREIGN KEY (`po_workarea`) REFERENCES `rsc_worlkingarea` (`wo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_post
-- ----------------------------
INSERT INTO `rsc_post` VALUES ('42', '小差', '123456', '15920360693', '', '2', '4');
INSERT INTO `rsc_post` VALUES ('43', '小火', '123456', '13202203138', '', '3', '2');
INSERT INTO `rsc_post` VALUES ('44', '小时', '123456', '13902203138', '', '3', '3');
INSERT INTO `rsc_post` VALUES ('45', '小智', '123456', '15920360693', '', '3', '1');
INSERT INTO `rsc_post` VALUES ('48', '小明', '123456', '18366957489', '', '2', '5');
INSERT INTO `rsc_post` VALUES ('49', '小丽', '123456', '17456893245', '', '0', '6');
INSERT INTO `rsc_post` VALUES ('55', '小华', '123456', '18697453654', '', '2', '7');
INSERT INTO `rsc_post` VALUES ('57', '小亮', '123456', '13075896432', '', '1', '4');
INSERT INTO `rsc_post` VALUES ('58', '小强', '123456', '18965784351', '\0', '2', '2');
INSERT INTO `rsc_post` VALUES ('59', '小天', '123456', '13678956431', '', '3', '3');
INSERT INTO `rsc_post` VALUES ('60', '小尹', '123456', '18679436842', '', '2', '1');
INSERT INTO `rsc_post` VALUES ('65', '小豪', '123456', '18679541684', '', '1', '5');
INSERT INTO `rsc_post` VALUES ('66', '小树', '123456', '18796347862', '', '3', '6');
INSERT INTO `rsc_post` VALUES ('67', '小三', '123456', '17596348051', '', '2', '7');

-- ----------------------------
-- Table structure for rsc_recipient
-- ----------------------------
DROP TABLE IF EXISTS `rsc_recipient`;
CREATE TABLE `rsc_recipient` (
  `re_id` bigint(20) NOT NULL,
  `re_count` float DEFAULT NULL,
  `re_creeaterdate` datetime DEFAULT NULL,
  `re_edndate` datetime DEFAULT NULL,
  `re_name` varchar(50) DEFAULT NULL,
  `re_phone` varchar(15) DEFAULT NULL,
  `re_stateadress` varchar(255) DEFAULT NULL,
  `re_endadress` bigint(20) DEFAULT NULL,
  `re_mailcustomer_id` bigint(20) DEFAULT NULL,
  `re_post_id` bigint(20) DEFAULT NULL,
  `re_state` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`re_id`),
  KEY `FKpe8oe47ytklvxb5h6pipat3m6` (`re_endadress`),
  KEY `RE_MAIL_RECIPIENT` (`re_mailcustomer_id`),
  KEY `RE_POST_RECIPIENT` (`re_post_id`),
  KEY `FKcaq6aeyosljkkpjnnf9khi7ha` (`re_state`),
  CONSTRAINT `FKcaq6aeyosljkkpjnnf9khi7ha` FOREIGN KEY (`re_state`) REFERENCES `rsc_state` (`st_id`),
  CONSTRAINT `FKpe8oe47ytklvxb5h6pipat3m6` FOREIGN KEY (`re_endadress`) REFERENCES `rsc_worlkingarea` (`wo_id`),
  CONSTRAINT `RE_MAIL_RECIPIENT` FOREIGN KEY (`re_mailcustomer_id`) REFERENCES `rsc_mail_customer` (`ma_id`),
  CONSTRAINT `RE_POST_RECIPIENT` FOREIGN KEY (`re_post_id`) REFERENCES `rsc_post` (`po_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_recipient
-- ----------------------------
INSERT INTO `rsc_recipient` VALUES ('50', '45', '2018-12-01 22:13:02', '2018-12-01 22:14:29', '衣服', '14789652365', '华软学院584号', '1', '5', '45', '3');
INSERT INTO `rsc_recipient` VALUES ('51', '18', '2018-12-01 22:15:31', '2018-12-01 22:30:13', '红帽子', '14789652365', '碧水新村', '2', '5', '43', '3');
INSERT INTO `rsc_recipient` VALUES ('52', '18', '2018-12-01 22:24:09', '2018-12-01 22:30:03', '鞋子', '14789652365', '温泉镇58号\n', '2', '5', '43', '3');
INSERT INTO `rsc_recipient` VALUES ('53', '45', '2018-12-01 22:43:59', '2018-12-01 22:44:59', '手机', '15978643542', '良口56号', '4', '7', '42', '3');
INSERT INTO `rsc_recipient` VALUES ('54', '40.5', '2018-12-01 22:55:01', '2018-12-01 22:55:42', '书本', '15978643542', '钟落潭70号', '7', '8', '44', '3');
INSERT INTO `rsc_recipient` VALUES ('56', null, '2018-12-01 23:04:26', null, '手表', '15978643542', '吕田34号', '3', '8', '44', '4');
INSERT INTO `rsc_recipient` VALUES ('68', null, '2018-12-01 23:24:30', null, '电脑', '15219584649', '华软', '1', '3', '60', '1');
INSERT INTO `rsc_recipient` VALUES ('69', '35', '2018-12-01 23:26:13', '2018-12-01 23:28:25', '运动裤', '15978643542', '温泉街88号', '2', '7', '58', '3');
INSERT INTO `rsc_recipient` VALUES ('76', '48', '2018-12-01 23:48:32', '2018-12-01 23:49:05', '秋裤', '15978643542', '江高街56号', '5', '7', '65', '3');
INSERT INTO `rsc_recipient` VALUES ('77', null, '2018-12-02 00:02:33', null, '短袖', '18930466678', '太平小学', '1', '6', '60', '5');

-- ----------------------------
-- Table structure for rsc_role
-- ----------------------------
DROP TABLE IF EXISTS `rsc_role`;
CREATE TABLE `rsc_role` (
  `ro_id` smallint(6) NOT NULL,
  `ro_discount` double DEFAULT NULL,
  `ro_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_role
-- ----------------------------
INSERT INTO `rsc_role` VALUES ('1', '0', '新用户');
INSERT INTO `rsc_role` VALUES ('2', '0.9', '普通用户');
INSERT INTO `rsc_role` VALUES ('3', '0.8', 'VIP用户');
INSERT INTO `rsc_role` VALUES ('4', '0.7', '集团用户');

-- ----------------------------
-- Table structure for rsc_sentpieces
-- ----------------------------
DROP TABLE IF EXISTS `rsc_sentpieces`;
CREATE TABLE `rsc_sentpieces` (
  `se_id` bigint(20) NOT NULL,
  `se_createdate` datetime DEFAULT NULL,
  `se_endadress` varchar(255) DEFAULT NULL,
  `se_enddate` datetime DEFAULT NULL,
  `se_mailcustomername` varchar(10) DEFAULT NULL,
  `se_name` varchar(50) DEFAULT NULL,
  `se_phone` varchar(50) DEFAULT NULL,
  `se_post_id` bigint(20) DEFAULT NULL,
  `se_state` smallint(6) DEFAULT NULL,
  `se_stateadress` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`se_id`),
  KEY `FK_POST_SERT` (`se_post_id`),
  KEY `FKcpdl61c7d0j83vp756n3wih6y` (`se_state`),
  KEY `FK31irq3h16m8fabcwn66joq150` (`se_stateadress`),
  CONSTRAINT `FK31irq3h16m8fabcwn66joq150` FOREIGN KEY (`se_stateadress`) REFERENCES `rsc_worlkingarea` (`wo_id`),
  CONSTRAINT `FK_POST_SERT` FOREIGN KEY (`se_post_id`) REFERENCES `rsc_post` (`po_id`),
  CONSTRAINT `FKcpdl61c7d0j83vp756n3wih6y` FOREIGN KEY (`se_state`) REFERENCES `rsc_state` (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_sentpieces
-- ----------------------------
INSERT INTO `rsc_sentpieces` VALUES ('46', '2018-12-01 21:09:48', '华软', null, '陈运筹', '手机', '15920360693', '45', '1', '1');
INSERT INTO `rsc_sentpieces` VALUES ('47', '2018-12-01 21:36:17', '软件', null, '陈运筹', '帽子', '15920360693', '45', '1', '1');
INSERT INTO `rsc_sentpieces` VALUES ('61', '2018-12-01 23:17:08', '中山大学南方学院', null, '陈小树', '电脑', '15219584641', '58', '1', '2');
INSERT INTO `rsc_sentpieces` VALUES ('62', '2018-12-01 23:18:51', '钟落潭小学', null, '陈小树', '书籍', '15219584641', '55', '1', '7');
INSERT INTO `rsc_sentpieces` VALUES ('63', '2018-12-01 23:20:32', '第二中学', '2018-12-01 23:46:54', '陈运筹', '运动鞋', '15687942652', '48', '3', '5');
INSERT INTO `rsc_sentpieces` VALUES ('64', '2018-12-01 23:22:20', '镇政府', null, '陈小树', '充电宝', '15219584641', '49', '0', '6');
INSERT INTO `rsc_sentpieces` VALUES ('70', '2018-12-01 23:30:17', '华软', '2018-12-02 00:33:45', '陈小树', '机密文件', '15219584641', '66', '3', '6');
INSERT INTO `rsc_sentpieces` VALUES ('71', '2018-12-01 23:35:21', '吕田', null, '陈运筹', '茶叶', '15361346226', '57', '1', '4');
INSERT INTO `rsc_sentpieces` VALUES ('72', '2018-12-01 23:38:23', '文化站', null, '黄振亮', '音响', '13213223658', '59', '1', '3');
INSERT INTO `rsc_sentpieces` VALUES ('73', '2018-12-01 23:40:18', '医院', null, '陈运筹', '手机膜', '15326652332', '44', '1', '3');
INSERT INTO `rsc_sentpieces` VALUES ('74', '2018-12-01 23:43:07', '三村村民委员会', null, '黄振亮', '衣服', '13234366522', '42', '1', '4');
INSERT INTO `rsc_sentpieces` VALUES ('75', '2018-12-01 23:46:31', '钟落潭公园', null, '陈小树', '健身器械', '15219584648', '67', '1', '7');
INSERT INTO `rsc_sentpieces` VALUES ('78', '2018-12-02 00:02:37', '医院', null, '陈小树', '医疗药品', '15219584941', '55', '1', '7');
INSERT INTO `rsc_sentpieces` VALUES ('79', '2018-12-02 00:10:33', '第三中学', null, '陈运筹', '电风扇', '152323463341', '59', '1', '3');
INSERT INTO `rsc_sentpieces` VALUES ('80', '2018-12-02 00:13:05', '镇政府', null, '黄振亮', '信封', '13215284646', '49', '0', '6');
INSERT INTO `rsc_sentpieces` VALUES ('81', '2018-12-02 00:14:41', '文化站', null, '陈运筹', '无线键盘', '15216584695', '44', '1', '3');
INSERT INTO `rsc_sentpieces` VALUES ('82', '2018-12-02 00:17:03', '中山大学南方学院', null, '黄振亮', '笔记本散热器', '13267864862', '67', '1', '7');
INSERT INTO `rsc_sentpieces` VALUES ('83', '2018-12-02 00:21:29', '第二小学', '2018-12-02 00:33:44', '黄振亮', '冼衣液', '13215684694', '66', '3', '6');
INSERT INTO `rsc_sentpieces` VALUES ('84', '2018-12-02 00:22:48', '华软', null, '陈小树', '台灯', '15219584941', '60', '1', '1');
INSERT INTO `rsc_sentpieces` VALUES ('85', '2018-12-02 00:23:45', '第三小学\n', null, '陈小树', '鞋架', '15219584941', '59', '1', '3');
INSERT INTO `rsc_sentpieces` VALUES ('86', '2018-12-02 00:25:27', '中田小学', null, '陈小树', '无线鼠标', '15219584941', '43', '1', '2');
INSERT INTO `rsc_sentpieces` VALUES ('87', '2018-12-02 00:26:17', '第二中学', null, '陈小树', '高钙牛奶', '15219584941', '48', '1', '5');
INSERT INTO `rsc_sentpieces` VALUES ('88', '2018-12-02 00:28:31', '第三小学', null, '陈运筹', '书包', '15223842941', '49', '0', '6');
INSERT INTO `rsc_sentpieces` VALUES ('89', '2018-12-02 00:30:27', '文化广场', '2018-12-02 00:33:41', '陈小树', '腰带', '15219584941', '66', '3', '6');
INSERT INTO `rsc_sentpieces` VALUES ('90', '2018-12-02 00:32:28', '医院', null, '黄振亮', '笔记本', '15219521441', '49', '0', '6');

-- ----------------------------
-- Table structure for rsc_state
-- ----------------------------
DROP TABLE IF EXISTS `rsc_state`;
CREATE TABLE `rsc_state` (
  `st_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `st_describe` varchar(50) DEFAULT NULL,
  `st_name` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_state
-- ----------------------------
INSERT INTO `rsc_state` VALUES ('0', '失败', '时间超时');
INSERT INTO `rsc_state` VALUES ('1', '成功', '正在准备');
INSERT INTO `rsc_state` VALUES ('2', '成功', '进行中');
INSERT INTO `rsc_state` VALUES ('3', '成功', '已经完成');
INSERT INTO `rsc_state` VALUES ('4', '失败', '邮客号码出错');
INSERT INTO `rsc_state` VALUES ('5', '失败', '邮客地址出错');
INSERT INTO `rsc_state` VALUES ('6', '失败', '其他');

-- ----------------------------
-- Table structure for rsc_worlkingarea
-- ----------------------------
DROP TABLE IF EXISTS `rsc_worlkingarea`;
CREATE TABLE `rsc_worlkingarea` (
  `wo_id` bigint(20) NOT NULL,
  `wo_area` varchar(50) DEFAULT NULL,
  `wo_town` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`wo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rsc_worlkingarea
-- ----------------------------
INSERT INTO `rsc_worlkingarea` VALUES ('1', '从化区', '太平镇');
INSERT INTO `rsc_worlkingarea` VALUES ('2', '从化区', '温泉镇');
INSERT INTO `rsc_worlkingarea` VALUES ('3', '从化区', '良口镇');
INSERT INTO `rsc_worlkingarea` VALUES ('4', '从化区', '吕田镇');
INSERT INTO `rsc_worlkingarea` VALUES ('5', '白云区', '江高镇');
INSERT INTO `rsc_worlkingarea` VALUES ('6', '白云区', '人和镇');
INSERT INTO `rsc_worlkingarea` VALUES ('7', '白云区', '钟落潭镇');
