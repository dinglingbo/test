/*
Navicat MySQL Data Transfer

Source Server         : dms
Source Server Version : 50717
Source Host           : 192.168.111.60:3306
Source Database       : wb_repair

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-03-12 20:14:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rps_gearbox_fault
-- ----------------------------
DROP TABLE IF EXISTS `rps_gearbox_fault`;
CREATE TABLE `rps_gearbox_fault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL DEFAULT '0' COMMENT '维修工单ID',
  `lock_gear_status` tinyint(4) DEFAULT NULL COMMENT '锁挡状态（0否1是）',
  `abnormal_sound_status` int(11) DEFAULT NULL COMMENT '波箱异响状态（1行车异响；2挂挡异响；3停车异响）',
  `skidding_status` int(11) DEFAULT NULL COMMENT '波箱打滑（1 1换2；2 2换3； 3 3换4； 4 4换5； 5 5换6； 6 6换7）',
  `attack_status` int(11) DEFAULT NULL COMMENT '波箱冲击（1 换挡冲击； 2挂挡冲击； 3降挡冲击）',
  `hole_oil_status` int(11) DEFAULT NULL COMMENT '漏油位置前油封漏油	1后油封漏油2油底壳漏油3前壳与中壳之间漏4尾盖漏油',
  `gear_move_status` int(11) DEFAULT '0' COMMENT '挂挡不能行走（0不能行走；1可以行走）',
  `shift_up_status` int(11) DEFAULT NULL COMMENT '变速箱升档冲击(1一档升二档、2二档升三档、3三档升四档、4四档升五档、5五档升六档、6六档升七档、7七档升八档)',
  `transfer_case_jitter_status` tinyint(4) DEFAULT '0' COMMENT '分动箱抖动(摩擦片打滑0否1是)',
  `transfer_case_sound_status` int(11) DEFAULT NULL COMMENT '分动箱异响（1轴承摩损、2链条拉长变形）',
  `start_shaking_status` tinyint(4) DEFAULT '0' COMMENT '变速箱起步或40-60码时抖动（0否1是）',
  `fault_desc` varchar(500) DEFAULT '' COMMENT '故障描述',
  `remark` varchar(800) DEFAULT '' COMMENT '备注',
  `recorder` varchar(20) DEFAULT '' COMMENT '建档人',
  `record_date` datetime DEFAULT NULL COMMENT '建档日期',
  `modifier` varchar(20) DEFAULT '' COMMENT '修改人',
  `modify_date` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) TYPE=InnoDB AUTO_INCREMENT=129;
