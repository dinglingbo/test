/*
Navicat MySQL Data Transfer

Source Server         : dms
Source Server Version : 50717
Source Host           : 192.168.111.60:3306
Source Database       : wb_repair

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-03-11 09:47:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rps_gearbox_fault
-- ----------------------------
DROP TABLE IF EXISTS `rps_gearbox_fault`;
CREATE TABLE `rps_gearbox_fault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL DEFAULT '0' COMMENT '维修工单ID',
  `lock_gear_status` int(11) DEFAULT NULL COMMENT '锁挡状态（1只有一个挡在工作；2亮故障灯；3跑不起来）',
  `abnormal_sound_status` int(11) DEFAULT NULL COMMENT '波箱异响状态（1行车异响；2挂挡异响；3停车异响）',
  `skidding_status` int(11) DEFAULT NULL COMMENT '波箱打滑（1 1换2；2 2换3； 3 3换4； 4 4换5； 5 5换6； 6 6换7）',
  `attack_status` int(11) DEFAULT NULL COMMENT '波箱冲击（1 换挡冲击； 2挂挡冲击； 3降挡冲击）',
  `hole_oil_desc` varchar(500) DEFAULT NULL COMMENT '漏油位置',
  `gear_move_status` int(11) DEFAULT '0' COMMENT '挂挡不能行走（0可以行走；1不能行政）',
  `fault_desc` varchar(500) DEFAULT '' COMMENT '故障描述',
  `remark` varchar(800) DEFAULT '' COMMENT '备注',
  `recorder` varchar(20) DEFAULT '' COMMENT '建档人',
  `record_date` datetime DEFAULT NULL COMMENT '建档日期',
  `modifier` varchar(20) DEFAULT '' COMMENT '修改人',
  `modify_date` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) TYPE=InnoDB AUTO_INCREMENT=102;
