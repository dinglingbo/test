/*
Navicat MySQL Data Transfer

Source Server         : DMS
Source Server Version : 50717
Source Host           : 192.168.111.60:3306
Source Database       : wb_frm

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-07-27 15:12:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for fis_pre_bill_detail
-- ----------------------------
DROP TABLE IF EXISTS `fis_pre_bill_detail`;
CREATE TABLE `fis_pre_bill_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `main_id` int(11) NOT NULL COMMENT '应收表 id',
  `bill_main_id` int(11) NOT NULL,
  `pre_bill_id` int(11) NOT NULL COMMENT '主表id  线上支付表（fis_pre_bill）',
  `guest_id` int(11) DEFAULT NULL COMMENT '往来单位id',
  `guest_name` varchar(100) DEFAULT NULL COMMENT '往来单位名称',
  `car_id` int(11) DEFAULT '0' COMMENT '车辆ID',
  `car_no` varchar(15) DEFAULT '' COMMENT '车牌号',
  `bill_service_id` varchar(20) DEFAULT NULL,
  `bill_type_id` int(11) DEFAULT NULL,
  `rp_amt` decimal(18,4) DEFAULT '0.0000' COMMENT '应收金额',
  `now_amt` decimal(18,4) DEFAULT '0.0000' COMMENT '结算金额',
  `creator_id` varchar(20) DEFAULT NULL COMMENT '创建人ID',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `operator_id` varchar(20) DEFAULT NULL COMMENT '???ID',
  `operator` varchar(20) DEFAULT NULL COMMENT '???',
  `operate_date` datetime DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`)
) TYPE=InnoDB AUTO_INCREMENT=38;
