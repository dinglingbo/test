/*
Navicat MySQL Data Transfer

Source Server         : DMS
Source Server Version : 50717
Source Host           : 192.168.111.60:3306
Source Database       : wb_frm

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-07-27 14:14:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for fis_pre_bill
-- ----------------------------
DROP TABLE IF EXISTS `fis_pre_bill`;
CREATE TABLE `fis_pre_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bill_code` varchar(20) NOT NULL COMMENT '单据编码',
  `orgid` int(11) NOT NULL COMMENT '机构ID',
  `rp_bill_ids` varchar(255) NOT NULL COMMENT '应收应付单号',
  `rp_bill_names` varchar(255) DEFAULT NULL COMMENT '应收类型',
  `guest_id` int(11) DEFAULT NULL COMMENT '往来单位id',
  `guest_name` varchar(100) DEFAULT NULL COMMENT '往来单位名称',
  `contactor_id` int(11) DEFAULT '0' COMMENT '联系人ID',
  `wechat_open_id` varchar(50) DEFAULT '' COMMENT '微信openId',
  `car_id` int(11) DEFAULT '0' COMMENT '车辆ID',
  `car_no` varchar(15) DEFAULT '' COMMENT '车牌号',
  `car_vin` varchar(20) DEFAULT '' COMMENT 'vin',
  `total_amt` decimal(18,4) DEFAULT '0.0000' COMMENT '应收总金额',
  `sett_account_name` varchar(100) DEFAULT NULL,
  `sett_account_id` int(11) DEFAULT NULL COMMENT '结算账户ID',
  `sett_account_code` varchar(20) DEFAULT NULL COMMENT '结算账户编码',
  `enable_settle_date` datetime NOT NULL COMMENT '可结算日期',
  `settle_date` datetime DEFAULT NULL COMMENT '结算日期',
  `settle_status` int(11) DEFAULT '0' COMMENT '结算状态（0未结算；1全部结算，2作废）',
  `remark` varchar(200) DEFAULT NULL COMMENT '??',
  `creator_id` varchar(20) DEFAULT NULL COMMENT '创建人ID',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `operator_id` varchar(20) DEFAULT NULL COMMENT '???ID',
  `operator` varchar(20) DEFAULT NULL COMMENT '???',
  `operate_date` datetime DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`)
) TYPE=InnoDB AUTO_INCREMENT=38 COMMENT='线上支付表';
