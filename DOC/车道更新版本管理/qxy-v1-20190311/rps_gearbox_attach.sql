/*
Navicat MySQL Data Transfer

Source Server         : dms
Source Server Version : 50717
Source Host           : 192.168.111.60:3306
Source Database       : wb_repair

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-03-11 09:46:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rps_gearbox_attach
-- ----------------------------
DROP TABLE IF EXISTS `rps_gearbox_attach`;
CREATE TABLE `rps_gearbox_attach` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL DEFAULT '0' COMMENT '维修工单ID',
  `attach_code` varchar(50) DEFAULT NULL COMMENT '附加项编码',
  `attach_name` varchar(100) DEFAULT NULL COMMENT '附加项名称',
  `qty` int(11) DEFAULT NULL COMMENT '数量',
  `recorder` varchar(20) DEFAULT '' COMMENT '建档人',
  `record_date` datetime DEFAULT NULL COMMENT '建档日期',
  `modifier` varchar(20) DEFAULT '' COMMENT '修改人',
  `modify_date` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) TYPE=InnoDB COMMENT='工单附加项';
