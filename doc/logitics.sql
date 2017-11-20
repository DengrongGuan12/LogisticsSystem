CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(45) NOT NULL COMMENT '账号',
  `password` varchar(45) NOT NULL COMMENT '密码',
  `login` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已登录，防止重复登录，0表示未登录，1表示已登录',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_UNIQUE` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理员表';
CREATE TABLE `delivery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_node` int(10) unsigned NOT NULL,
  `to_node` int(10) unsigned NOT NULL,
  `courier_name` varchar(15) NOT NULL COMMENT '派送员姓名',
  `courier_phone` varchar(15) NOT NULL COMMENT '派送员联系方式',
  `set_out_time` datetime NOT NULL COMMENT '出发时间',
  `expected_arrive_time` datetime NOT NULL COMMENT '预计到达时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='派送表，从一个节点到另一个节点，包含派送（负责）人姓名和联系方式以及派送开始时间，预计到达时间';
CREATE TABLE `node` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL COMMENT '节点名称',
  `index` int(11) NOT NULL COMMENT '记录节点顺序',
  `waybill_id` int(11) NOT NULL,
  `arrive_time` datetime DEFAULT NULL COMMENT '到达时间（为空表示尚未到达）',
  `leave_time` datetime DEFAULT NULL COMMENT '离开时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='运单履行节点表，跟随运单产生而产生，因为运单生成之后需要经过的路线自然确定了。';
CREATE TABLE `waybill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(45) NOT NULL,
  `sender_nm` varchar(15) NOT NULL COMMENT '寄件人姓名',
  `sender_phone` varchar(15) NOT NULL,
  `sender_location` varchar(45) NOT NULL COMMENT '寄件人地址',
  `receiver_nm` varchar(15) NOT NULL COMMENT '收件人姓名',
  `receiver_phone` varchar(15) NOT NULL,
  `receiver_location` varchar(45) NOT NULL,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间，为空表示正在进行中',
  `comment` varchar(200) DEFAULT NULL COMMENT '评价',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `pay_way` enum('cash','electronic') DEFAULT NULL COMMENT '付款方式',
  `state` enum('start','ing','end') DEFAULT 'start' COMMENT '运单状态：\nstart：收单\ning：在途\nend：签收',
  `delivery_type` enum('household','appliance','food') DEFAULT NULL COMMENT '快递类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_UNIQUE` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='运单表';
