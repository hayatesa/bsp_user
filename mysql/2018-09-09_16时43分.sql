/*
 Navicat Premium Data Transfer

 Source Server         : dev
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : book_sharing_platform

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 09/09/2018 16:41:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator`  (
  `a_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员唯一标识',
  `a_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员登录账号',
  `a_password` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `a_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `a_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `a_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运营方地址',
  `a_comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运营者描述',
  `a_level` int(20) NOT NULL DEFAULT 2 COMMENT '管理员权限等级，1为系统管理员，2为普通管理员',
  `is_delete` tinyint(4) NOT NULL COMMENT '是否可用，登录时需要判断，0没有禁用，1被禁用',
  PRIMARY KEY (`a_uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES ('0f999af0a4ed4b88a65d4c4f371016c7', 'hayate', 'c62617e62dcc9e30a7ddbcc2b7434559', '溅飞', '13800138001', '中国广东', '你好', 1, 0);
INSERT INTO `administrator` VALUES ('a972961ccf6e4e8291818f94088c4bc3', 'ltg', 'cee1ccbf7cb9b24ecaf6ce2e4b19cebb', '小伙伴', '13800138002', '中国广东', NULL, 2, 0);
INSERT INTO `administrator` VALUES ('e55b4494e04146aca17c3c59ca760bcc', 'admin', 'a66abb5684c45962d887564f08346e8d', '溶酶菌', '13800138000', '中国广东', '菌です、よろしくお願いします。', 0, 0);
INSERT INTO `administrator` VALUES ('ea222a070e7e45f0af45ddb6f7058433', 'xnbaji', '316b47aae56f20c53237199e87dd0fd6', '新吧唧', '13800138003', NULL, NULL, 2, 1);

-- ----------------------------
-- Table structure for check_demand_book
-- ----------------------------
DROP TABLE IF EXISTS `check_demand_book`;
CREATE TABLE `check_demand_book`  (
  `cdb_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '需求图书标识，数字自增长',
  `cdb_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书名称',
  `cdb_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书作者',
  `cdb_publishing` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求图书出版社',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求图书的ISBN',
  `cdb_duration` int(11) NOT NULL COMMENT '需求图书需求时长',
  `cdb_number` int(11) NOT NULL COMMENT '需要图书数量',
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求图书照片路径',
  `cdb_comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求者联系电话',
  `cdb_status` tinyint(4) NOT NULL COMMENT '图书审核状态:0提交申请未审核转态，1申请失败返回原因',
  `failure_cause` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人员填写，审核失败的原因',
  `sc_id` int(11) NOT NULL COMMENT '需求图书所属的二级分类',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书申请人',
  PRIMARY KEY (`cdb_id`) USING BTREE,
  INDEX `FKc6if89oh86n3vxut5uuave8a8`(`sc_id`) USING BTREE,
  INDEX `FKhid2mb9kb9d8a2p0yovaapvfb`(`uuid`) USING BTREE,
  CONSTRAINT `FKc6if89oh86n3vxut5uuave8a8` FOREIGN KEY (`sc_id`) REFERENCES `secondary_classification` (`sc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKhid2mb9kb9d8a2p0yovaapvfb` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for check_loanable_book
-- ----------------------------
DROP TABLE IF EXISTS `check_loanable_book`;
CREATE TABLE `check_loanable_book`  (
  `clb_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '共享的图书标识，数字自增长',
  `clb_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书作者',
  `clb_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书名称',
  `clb_publishing` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书出版社',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书的ISBN',
  `clb_duration` int(11) NOT NULL COMMENT '图书可共享时长',
  `clb_number` int(11) NOT NULL COMMENT '可共享图书数量',
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书照片路径',
  `clb_comment` varchar(1200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享者的联系电话',
  `clb_status` tinyint(4) NOT NULL COMMENT '图书审核状态:0提交申请未审核转态，1申请失败返回原因，2审核通过',
  `failure_cause` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人员填写，审核失败的原因',
  `sc_id` int(11) NOT NULL COMMENT '共享图书所属的二级分类',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书申请人',
  PRIMARY KEY (`clb_id`) USING BTREE,
  INDEX `FKkld0wnb45l7fsg94ulvg97jgm`(`sc_id`) USING BTREE,
  INDEX `FKqckqc9s430podyftxap7a8skx`(`uuid`) USING BTREE,
  CONSTRAINT `FKkld0wnb45l7fsg94ulvg97jgm` FOREIGN KEY (`sc_id`) REFERENCES `secondary_classification` (`sc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKqckqc9s430podyftxap7a8skx` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of check_loanable_book
-- ----------------------------
INSERT INTO `check_loanable_book` VALUES (1, '海明威', '老人与海', '浙江文艺出版社', '9787533947354', 50, 2, '/e/b/eb0191f667bc4c78b09d19210f0a2a30.png', '◆ 海明威等了64年的中文译本终于来了！一字未删，完整典藏！\r\n\r\n◆ 传奇作家鲁羊首次翻译外国经典，译自海明威1952年亲自授权的美国Scribner原版定本！译稿出版前在各界名人中广泛流传，好评如潮，口碑爆棚！\r\n\r\n◆ “所有的原则自天而降：那就是你必须相信魔法，相信美，相信那些在百万个钻石中总结我们的人，相信此刻你手捧的鲁羊先生的译本，就是‘不朽’这个璀璨的词语给出的极好佐证。”——丁玲文学大奖、徐志摩诗歌金奖双奖得主何三坡\r\n\r\n◆“鲁羊的译文，其语言的简洁、节奏、语感、画面感和情感浓与淡的交错堪称完美，我感觉是海明威用中文写了《老人与海》，真棒！”——美籍华人知名学者、博士后导师邢若曦\r\n\r\n◆ 国际当红女插画师SlavaShults，首次为中文版《老人与海》专门创作12副海报级手绘插图，带给你绝美的阅读体验；随书附赠英文版本定版。\r\n\r\n◆ 自1954年荣获诺贝尔文学奖至今，《老人与海》风靡全球，横扫每个必读经典书单，征服了亿万读者；据作家榜官方统计：截至2017年1月，113位诺贝尔文学奖得主作品中文版销量排行榜，海明威高居榜首，总销量突破550万册。\r\n\r\n◆ “人可以被毁灭，但不能被打败。”——本书作者海明威（诺贝尔文学奖、普利策奖双奖得主）', '13821865025', 0, NULL, 1, 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `check_loanable_book` VALUES (2, '莫言', '丰乳肥臀', '浙江文艺出版社', '9787533946630', 60, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '莫言认可的“定稿版”。\r\n\r\n莫言早期创作的一座高峰，篇幅*长、内容*丰富的一部经典力作。\r\n\r\n不同于主流叙事，从一个家族的兴衰，重看百年中国的疯癫岁月。\r\n\r\n一份“献给天下母亲”，也献给所有怀念母亲的人的礼物。\r\n\r\n一本写给中国人，只有中国人读得懂的社会历史小说。\r\n\r\n你知道婴儿可以通过母乳的味道观察世界吗？\r\n\r\n你知道人为了救活快饿死的子女，可以像牛一样学会反刍吗？\r\n\r\n你知道如果假装成精神病人，活在世界上多么快乐吗？\r\n\r\n“一茬茬地死,一茬茬地发,有生就有死，死容易,活难,越难越要活。”\r\n\r\n莫言坦言：我再写不出像《丰乳肥臀》那样的作品了。', '13800138000', 1, '类目不正确', 2, 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `check_loanable_book` VALUES (3, '井上雄彦', '灌篮高手（套装1-31 册）', '长春出版社', '9787544534888', 100, 10, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '《灌篮高手》这部漫画以湘北高中篮球队向着全国联赛的目标前进为导线，刻绘了几名湘北篮球队领军人物生活、训练、比赛等等一系列事情，再将他们闪耀的光点一一联合，升华出整个篮球队的精神，感动了看着他们的所有人。当然，轻松与幽默也时时调节着气氛，调动读者欢悦的欣喜之情。', '13824865025', 2, NULL, 5, 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `check_loanable_book` VALUES (4, 'Designing编辑部 (作者), 周燕华 (译者), 郝微 (译者)', '版式设计:日本平面设计师参考手册', '人民邮电出版社; 第1版 (2016年12月1日)', '7115256519, 9787115256515', 35, 3, '/3/8/38bcf0c24244416ba26fe0a99f9d438d.png', '　　《版式设计：日本平面设计师参考手册》主要介绍了版式设计的基本原则、设计技巧以及软件相关技术，通过将具体的版式案例进行Before与After的对比，并举一反三地进一步分析讲解，鲜明而直观地呈现了学习价值的版式设计经验。\n　　《版式设计：日本平面设计师参考手册》共分为6部分，第 1～2部分讲解版式设计软件InDesign和Illustrator的基本操作；第3部分讲解版面构图的要点，包括构图的原则、分割线的设置和视觉化设计等；第4部分讲解如何编排文字，包括字体的运用、标题的运用等内容；第5部分讲解如何设置照片；第6部分讲解配色，包括颜色的基础知识与配色在版式设计中的运用。\n　　《版式设计：日本平面设计师参考手册》包括87组Before与After对比案例，与之相关的267个拓展案例解析，以及40个InDesign和Illustrator必须掌握的软件技术，真正解决版式设计中从设计、制作到印刷的常见问题。\n　　《版式设计：日本平面设计师参考手册》适合从事版式设计相关工作的设计师阅读。', '13824865025', 0, NULL, 97, 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `check_loanable_book` VALUES (5, 'Yuval Noah Harari (作者), 林俊宏 (译者)', '人类简史：从动物到上帝（完整图文版） (开放历史系列)', '中信出版社; 第1版 (2014年11月26日)', 'B00T95D35G', 60, 4, '/8/8/889a5b7031ba4c7f9c47a64d6e9f2dd7.png', '十万年前，地球上至少有六种不同的人\n\n但今日，世界舞台为什么只剩下了我们自己？\n\n从只能啃食虎狼吃剩的残骨的猿人，到跃居食物链顶端的智人，\n\n从雪维洞穴壁上的原始人手印，到阿姆斯壮踩上月球的脚印，\n\n从认知革命、农业革命，到科学革命、生物科技革命，\n\n我们如何登上世界舞台成为万物之灵的？\n\n从公元前1776年的《汉摩拉比法典》，到1776年的美国独立宣言，\n\n从帝国主义、资本主义，到自由主义、消费主义，\n\n从兽欲，到物欲，从兽性、人性，到神性，\n\n我们了解自己吗？我们过得更快乐吗？\n\n我们究竟希望自己得到什么、变成什么？\n《人类简史：从动物到上帝》是以色列新锐历史学家的一部重磅作品。从十万年前有生命迹象开始到21世纪资本、科技交织的人类发展史。十万年前，地球上至少有六个人种，为何今天却只剩下了我们自己？我们曾经只是非洲角落一个毫不起眼的族群，对地球上生态的影响力和萤火虫、猩猩或者水母相差无几。为何我们能登上生物链的顶端，最终成为地球的主宰？\n\n从认知革命、农业革命到科学革命，我们真的了解自己吗？我们过得更加快乐吗？我们知道金钱和宗教从何而来，为何产生吗？人类创建的帝国为何一个个衰亡又兴起？为什么地球上几乎每一个社会都有男尊女卑的观念？为何一神教成为最为广泛接受的宗教？科学和资本主义如何成为现代社会最重要的信条？理清影响人类发展的重大脉络，挖掘人类文化、宗教、法律、国家、信贷等产生的根源。这是一部宏大的人类简史，更见微知著、以小写大，让人类重新审视自己（电子书不含思维导图及有声书）。', '13800138000', 0, NULL, 130, 'f01c3b8acd114a689e237564d925789b');

-- ----------------------------
-- Table structure for demand_book
-- ----------------------------
DROP TABLE IF EXISTS `demand_book`;
CREATE TABLE `demand_book`  (
  `db_id` int(11) NOT NULL COMMENT '需求图书标识，来源于check_demand_book表主键',
  `db_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书名称',
  `db_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书作者',
  `db_publishing` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 需求图书的出版社',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求图书的ISBN',
  `db_duratuin` int(11) NOT NULL COMMENT '需求图书时长',
  `db_number` int(11) NOT NULL COMMENT '需求图书的数量',
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求图书照片路径',
  `db_comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT ' 需求者的联系电话',
  `open_demand_time` datetime NULL DEFAULT NULL COMMENT ' 开启图书需求的时间',
  `db_status` tinyint(4) NOT NULL COMMENT '开启需求状态：0停止需求，1开始需求',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除图书：0没有删除，1表示删除，默认为0',
  `sc_id` int(11) NOT NULL COMMENT ' 需求图书所属的二级分类',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '需求图书所属的用户',
  PRIMARY KEY (`db_id`) USING BTREE,
  INDEX `FKm8v0asyr2m1gj705j3au5d6e6`(`sc_id`) USING BTREE,
  INDEX `FKpsm7rge07898jwqf63o33t7fg`(`uuid`) USING BTREE,
  CONSTRAINT `FKm8v0asyr2m1gj705j3au5d6e6` FOREIGN KEY (`sc_id`) REFERENCES `secondary_classification` (`sc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKpsm7rge07898jwqf63o33t7fg` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for donated_book
-- ----------------------------
DROP TABLE IF EXISTS `donated_book`;
CREATE TABLE `donated_book`  (
  `dob_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '捐赠的图书标识，自增',
  `dob_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '捐赠的图书名称',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '捐赠的图书ISBN号',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '捐赠的图书数量',
  `sc_id` int(11) NULL DEFAULT NULL COMMENT '捐赠图书所属的二级分类',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '捐赠人账户',
  `source` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '捐赠来源',
  `donor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '捐赠人',
  `time` datetime NULL DEFAULT NULL COMMENT '捐赠时间',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`dob_id`) USING BTREE,
  INDEX `FKh45bmrwc34etref3un2f51pj0`(`sc_id`) USING BTREE,
  INDEX `FKqk83s5hu3qrgnydw0dboku20e`(`uuid`) USING BTREE,
  CONSTRAINT `FKh45bmrwc34etref3un2f51pj0` FOREIGN KEY (`sc_id`) REFERENCES `secondary_classification` (`sc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKqk83s5hu3qrgnydw0dboku20e` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of donated_book
-- ----------------------------
INSERT INTO `donated_book` VALUES (1, '超级漫画扫描技法（套装四本）', '9787500683179', 1, 99, 'd500618bd4e4473a8abbcd53b6f29ece', '个人捐赠', '溶酶菌', '2018-06-06 17:34:53', '13800138000');
INSERT INTO `donated_book` VALUES (2, '老人与海', '9787533947354', 1, 1, 'd500618bd4e4473a8abbcd53b6f29ece', '共享记录6', 'hayatesa@live.cn', '2018-06-06 17:37:15', '13821865025');
INSERT INTO `donated_book` VALUES (3, 'JavaScript权威指南', '9787111376613', 3, 6, NULL, '6月11日爱心捐赠活动', '溶酶菌', '2018-06-11 16:50:48', '13800138000');
INSERT INTO `donated_book` VALUES (4, '数据结构与算法（第三版）', '9787111457954', 1, 215, NULL, '个人捐赠', '溶酶菌', '2018-06-12 00:09:17', '13800138000');
INSERT INTO `donated_book` VALUES (5, '极简主义', '9787123456789', 2, 215, NULL, '个人捐赠', '溶酶菌', '2018-06-12 00:11:27', '13800138000');

-- ----------------------------
-- Table structure for lending_history
-- ----------------------------
DROP TABLE IF EXISTS `lending_history`;
CREATE TABLE `lending_history`  (
  `lh_id` int(11) NOT NULL COMMENT '借出记录历史标识，来源于LendingRecord表的主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '借阅人申请时间，创建订单',
  `agree_time` datetime NULL DEFAULT NULL COMMENT '借出人同意申请时间',
  `send_to_time` datetime NULL DEFAULT NULL COMMENT '借出人送达运营商服务点时间',
  `take_away_time` datetime NULL DEFAULT NULL COMMENT '借阅人取走图书时间',
  `expected_return_time` datetime NULL DEFAULT NULL COMMENT '借阅人预期还书时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '借阅人实际还书时间',
  `take_back_time` datetime NULL DEFAULT NULL COMMENT '借出人取回图书时间',
  `lh_struts` tinyint(4) NOT NULL COMMENT '1借阅人取消，2借出人拒绝申请，3申请超时借出人未同意，5借出人逾期未送达运营方，12借出人取回归还的图书，13借出人捐赠图书',
  `loan_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借阅人电话号码',
  `lb_id` int(11) NOT NULL COMMENT '借阅的图书',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '借阅人',
  `receive_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借出人送达图书的管理员',
  `back_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借阅人还图书的管理员',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  PRIMARY KEY (`lh_id`) USING BTREE,
  INDEX `FKh4lfbyr8nb9px111xy30sq53a`(`back_uuid`) USING BTREE,
  INDEX `FKr8bar09oqoy4qtbhmuajgggfw`(`lb_id`) USING BTREE,
  INDEX `FK4mb3dn1kfkapetlj4v9x37krn`(`receive_uuid`) USING BTREE,
  INDEX `FKmwnhbcswmtuspk8hyyrakxna4`(`uuid`) USING BTREE,
  CONSTRAINT `FK4mb3dn1kfkapetlj4v9x37krn` FOREIGN KEY (`receive_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKh4lfbyr8nb9px111xy30sq53a` FOREIGN KEY (`back_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKmwnhbcswmtuspk8hyyrakxna4` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for lending_record
-- ----------------------------
DROP TABLE IF EXISTS `lending_record`;
CREATE TABLE `lending_record`  (
  `lr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '借出记录标识，数字自增长',
  `create_time` datetime NULL DEFAULT NULL COMMENT '借阅人申请时间，创建订单',
  `agree_time` datetime NULL DEFAULT NULL COMMENT '借出人同意申请时间',
  `send_to_time` datetime NULL DEFAULT NULL COMMENT '借出人送达运营商服务点时间',
  `take_away_time` datetime NULL DEFAULT NULL COMMENT '借阅人取走图书时间',
  `expected_return_time` datetime NULL DEFAULT NULL COMMENT '借阅人预期还书时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '借阅人实际还书时间',
  `take_back_time` datetime NULL DEFAULT NULL COMMENT '借出人取回图书时间',
  `lr_struts` tinyint(4) NOT NULL COMMENT '借出记录状态 0发布申请，4借出人同意借书申请，6借出人送达运营商，7借阅人逾期未取书，8借阅人拿到图书，9借阅人逾期未还，10借出方已经还书，11借出方逾期没有取回图书',
  `loan_phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借阅人电话号码',
  `lb_id` int(11) NOT NULL COMMENT '借阅的图书',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '借阅人',
  `receive_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借出人送达图书的管理员',
  `back_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借阅人还图书的管理员',
  `amount` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  PRIMARY KEY (`lr_id`) USING BTREE,
  INDEX `FK3ihcdi8oemx69a00pcb9fkrpg`(`back_uuid`) USING BTREE,
  INDEX `FK25q7i39xrtwj48c2wq6kb4dr6`(`lb_id`) USING BTREE,
  INDEX `FKawpqnxsx4w797jlmoykoos37k`(`receive_uuid`) USING BTREE,
  INDEX `FK9d77hacy0ngffex45q08qx8j5`(`uuid`) USING BTREE,
  CONSTRAINT `FK3ihcdi8oemx69a00pcb9fkrpg` FOREIGN KEY (`back_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK9d77hacy0ngffex45q08qx8j5` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKawpqnxsx4w797jlmoykoos37k` FOREIGN KEY (`receive_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKlb_id` FOREIGN KEY (`lb_id`) REFERENCES `loanable_book` (`lb_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of lending_record
-- ----------------------------
INSERT INTO `lending_record` VALUES (1, '2018-06-01 17:49:11', '2018-06-02 17:49:17', '2018-06-05 17:49:24', '2018-06-06 17:49:38', '2018-07-06 17:49:44', '2018-07-04 17:49:55', '2018-07-07 17:50:10', 12, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', 'e55b4494e04146aca17c3c59ca760bcc', 'e55b4494e04146aca17c3c59ca760bcc', 1);
INSERT INTO `lending_record` VALUES (2, '2018-06-01 18:04:19', '2018-07-28 17:28:32', NULL, NULL, NULL, NULL, NULL, 0, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (3, '2018-05-01 18:05:49', '2018-06-02 18:06:07', '2018-06-05 18:06:13', NULL, NULL, NULL, NULL, 6, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (4, '2018-05-02 18:08:14', '2018-05-02 18:08:21', '2018-05-03 18:08:33', '2018-05-04 18:08:44', '2018-06-30 18:09:08', NULL, NULL, 8, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (5, '2018-05-01 18:12:22', '2018-06-02 18:12:31', NULL, NULL, NULL, NULL, NULL, 4, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (6, '2018-06-01 18:13:14', '2018-06-02 18:13:20', '2018-06-05 18:13:25', '2018-06-05 18:14:08', '2018-07-26 18:14:14', '2018-07-25 18:14:38', NULL, 10, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (7, '2018-06-01 18:20:41', NULL, NULL, NULL, NULL, NULL, NULL, 1, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (8, '2018-06-01 18:22:12', NULL, NULL, NULL, NULL, NULL, NULL, 2, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (9, '2018-05-01 18:23:43', '2018-06-02 18:24:35', NULL, NULL, NULL, NULL, NULL, 5, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (10, '2018-06-01 18:24:50', NULL, NULL, NULL, NULL, NULL, NULL, 3, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (11, '2018-05-05 18:28:44', '2018-05-06 18:28:51', '2018-05-07 18:29:08', NULL, NULL, NULL, NULL, 11, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (12, '2018-05-05 18:38:40', '2018-05-06 18:38:45', '2018-05-07 18:38:51', NULL, NULL, NULL, NULL, 7, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (13, '2018-05-05 18:39:31', '2018-05-06 18:39:35', '2018-05-07 18:39:41', '2018-05-07 18:39:52', '2018-05-31 18:39:58', NULL, NULL, 9, '13800138000', 10, 'd500618bd4e4473a8abbcd53b6f29ece', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (20, '2018-06-18 17:14:33', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1380010086', 13, 'f01c3b8acd114a689e237564d925789b', NULL, NULL, 1);
INSERT INTO `lending_record` VALUES (21, '2018-06-18 17:42:56', NULL, NULL, NULL, NULL, NULL, NULL, 0, '1380010086', 13, 'f01c3b8acd114a689e237564d925789b', NULL, NULL, 1);

-- ----------------------------
-- Table structure for loanable_book
-- ----------------------------
DROP TABLE IF EXISTS `loanable_book`;
CREATE TABLE `loanable_book`  (
  `lb_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '共享的图书标识，自增长',
  `lb_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书名称',
  `lb_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书作者',
  `lb_publishing` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '共享图书出版社',
  `isbn` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书的ISBN',
  `lb_duratuin` int(11) NOT NULL COMMENT '共享图书可共享时长',
  `lb_number` int(11) NOT NULL COMMENT '可共享图书数量',
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '共享图书照片路径',
  `lb_comment` varchar(1200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享者的联系电话',
  `open_loan_time` datetime NULL DEFAULT NULL COMMENT '开启图书共享的时间',
  `total_lending` int(11) NULL DEFAULT 0 COMMENT '共享累计借出总数,初始为0',
  `lb_status` tinyint(4) NOT NULL COMMENT '0用户停止共享，1开始共享，2管理员下架，默认为1',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除图书：0没有删除，1表示删除，默认为0',
  `sc_id` int(11) NOT NULL COMMENT '共享图书所属的二级分类',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '共享图书所属的用户',
  `left` int(11) NOT NULL COMMENT '剩余数量',
  PRIMARY KEY (`lb_id`) USING BTREE,
  INDEX `FKtdh9wvruiyi1w3t03m4ollqpd`(`sc_id`) USING BTREE,
  INDEX `FK1xj6yghopeuuwsp2i6wlilpfg`(`uuid`) USING BTREE,
  CONSTRAINT `FK1xj6yghopeuuwsp2i6wlilpfg` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKtdh9wvruiyi1w3t03m4ollqpd` FOREIGN KEY (`sc_id`) REFERENCES `secondary_classification` (`sc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of loanable_book
-- ----------------------------
INSERT INTO `loanable_book` VALUES (1, '马克思思想', 'tom', '清华大学出版社', '12345678', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '介绍马克思思想', '17876253475', '2018-05-12 22:58:55', 7, 0, 0, 8, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (2, '毛泽东自传', '毛泽东', '清华大学出版社', '4546545', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '毛泽东生平事迹', '17876253475', '2018-05-12 22:58:55', 6, 1, 0, 7, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (3, '哲学先驱', 'tom', '清华大学出版社', '45415742', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '哲学思想指导', '17876253475', '2018-05-12 22:58:55', 5, 2, 0, 9, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (4, '世界哲学理论', 'Alce', '清华大学出版社', '45415742', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '世界哲学著作', '17876253475', '2018-05-12 22:58:55', 4, 1, 1, 11, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (6, '中国哲学理论1', 'Alice', '清华大学出版社', '45415742', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '中国哲学著作', '17876253475', '2018-05-12 22:58:55', 3, 1, 0, 12, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (7, '亚洲哲学理论', 'Alice', '清华大学出版社', '45415742', 168, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '亚洲哲学著作', '17876253475', '2018-05-12 22:58:55', 2, 1, 0, 13, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (8, '非洲哲学理论', 'Alice', '清华大学出版社', '5646545', 188, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '非洲哲学著作', '17876253475', '2018-05-12 22:58:55', 1, 1, 0, 14, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (9, '丰乳肥臀', '莫言', '浙江文艺出版社', '9787533946630', 60, 2, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '莫言认可的“定稿版”。\r\n\r\n莫言早期创作的一座高峰，篇幅*长、内容*丰富的一部经典力作。\r\n\r\n不同于主流叙事，从一个家族的兴衰，重看百年中国的疯癫岁月。\r\n\r\n一份“献给天下母亲”，也献给所有怀念母亲的人的礼物。\r\n\r\n一本写给中国人，只有中国人读得懂的社会历史小说。\r\n\r\n你知道婴儿可以通过母乳的味道观察世界吗？\r\n\r\n你知道人为了救活快饿死的子女，可以像牛一样学会反刍吗？\r\n\r\n你知道如果假装成精神病人，活在世界上多么快乐吗？\r\n\r\n“一茬茬地死,一茬茬地发,有生就有死，死容易,活难,越难越要活。”\r\n\r\n莫言坦言：我再写不出像《丰乳肥臀》那样的作品了。', '13800138000', '2018-06-02 10:54:51', 0, 1, 0, 2, 'f01c3b8acd114a689e237564d925789b', 2);
INSERT INTO `loanable_book` VALUES (10, '老人与海', '海明威', '浙江文艺出版社', '9787533947354', 50, 1, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '◆ 海明威等了64年的中文译本终于来了！一字未删，完整典藏！\r\n\r\n◆ 传奇作家鲁羊首次翻译外国经典，译自海明威1952年亲自授权的美国Scribner原版定本！译稿出版前在各界名人中广泛流传，好评如潮，口碑爆棚！\r\n\r\n◆ “所有的原则自天而降：那就是你必须相信魔法，相信美，相信那些在百万个钻石中总结我们的人，相信此刻你手捧的鲁羊先生的译本，就是‘不朽’这个璀璨的词语给出的极好佐证。”——丁玲文学大奖、徐志摩诗歌金奖双奖得主何三坡\r\n\r\n◆“鲁羊的译文，其语言的简洁、节奏、语感、画面感和情感浓与淡的交错堪称完美，我感觉是海明威用中文写了《老人与海》，真棒！”——美籍华人知名学者、博士后导师邢若曦\r\n\r\n◆ 国际当红女插画师SlavaShults，首次为中文版《老人与海》专门创作12副海报级手绘插图，带给你绝美的阅读体验；随书附赠英文版本定版。\r\n\r\n◆ 自1954年荣获诺贝尔文学奖至今，《老人与海》风靡全球，横扫每个必读经典书单，征服了亿万读者；据作家榜官方统计：截至2017年1月，113位诺贝尔文学奖得主作品中文版销量排行榜，海明威高居榜首，总销量突破550万册。\r\n\r\n◆ “人可以被毁灭，但不能被打败。”——本书作者海明威（诺贝尔文学奖、普利策奖双奖得主）', '13821865025', '2018-06-02 10:57:27', 0, 1, 0, 1, 'f01c3b8acd114a689e237564d925789b', 1);
INSERT INTO `loanable_book` VALUES (11, '灌篮高手（套装1-31 册）', '井上雄彦', '长春出版社', '9787544534888', 100, 10, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '《灌篮高手》这部漫画以湘北高中篮球队向着全国联赛的目标前进为导线，刻绘了几名湘北篮球队领军人物生活、训练、比赛等等一系列事情，再将他们闪耀的光点一一联合，升华出整个篮球队的精神，感动了看着他们的所有人。当然，轻松与幽默也时时调节着气氛，调动读者欢悦的欣喜之情。', '13824865025', '2018-06-02 11:02:55', 0, 1, 0, 5, 'd500618bd4e4473a8abbcd53b6f29ece', 9);
INSERT INTO `loanable_book` VALUES (12, '老人与海', '海明威', '浙江文艺出版社', '9787533947354', 50, 2, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '◆ 海明威等了64年的中文译本终于来了！一字未删，完整典藏！\r\n\r\n◆ 传奇作家鲁羊首次翻译外国经典，译自海明威1952年亲自授权的美国Scribner原版定本！译稿出版前在各界名人中广泛流传，好评如潮，口碑爆棚！\r\n\r\n◆ “所有的原则自天而降：那就是你必须相信魔法，相信美，相信那些在百万个钻石中总结我们的人，相信此刻你手捧的鲁羊先生的译本，就是‘不朽’这个璀璨的词语给出的极好佐证。”——丁玲文学大奖、徐志摩诗歌金奖双奖得主何三坡\r\n\r\n◆“鲁羊的译文，其语言的简洁、节奏、语感、画面感和情感浓与淡的交错堪称完美，我感觉是海明威用中文写了《老人与海》，真棒！”——美籍华人知名学者、博士后导师邢若曦\r\n\r\n◆ 国际当红女插画师SlavaShults，首次为中文版《老人与海》专门创作12副海报级手绘插图，带给你绝美的阅读体验；随书附赠英文版本定版。\r\n\r\n◆ 自1954年荣获诺贝尔文学奖至今，《老人与海》风靡全球，横扫每个必读经典书单，征服了亿万读者；据作家榜官方统计：截至2017年1月，113位诺贝尔文学奖得主作品中文版销量排行榜，海明威高居榜首，总销量突破550万册。\r\n\r\n◆ “人可以被毁灭，但不能被打败。”——本书作者海明威（诺贝尔文学奖、普利策奖双奖得主）', '13821865025', '2018-06-02 12:39:28', 0, 1, 0, 1, 'd500618bd4e4473a8abbcd53b6f29ece', 2);
INSERT INTO `loanable_book` VALUES (13, '老人与海', '海明威', '浙江文艺出版社', '9787533947354', 50, 10, '/f/1/f1c0ae03344549858c92c805ada6cf62.png', '◆ 海明威等了64年的中文译本终于来了！一字未删，完整典藏！\r\n\r\n◆ 传奇作家鲁羊首次翻译外国经典，译自海明威1952年亲自授权的美国Scribner原版定本！译稿出版前在各界名人中广泛流传，好评如潮，口碑爆棚！\r\n\r\n◆ “所有的原则自天而降：那就是你必须相信魔法，相信美，相信那些在百万个钻石中总结我们的人，相信此刻你手捧的鲁羊先生的译本，就是‘不朽’这个璀璨的词语给出的极好佐证。”——丁玲文学大奖、徐志摩诗歌金奖双奖得主何三坡\r\n\r\n◆“鲁羊的译文，其语言的简洁、节奏、语感、画面感和情感浓与淡的交错堪称完美，我感觉是海明威用中文写了《老人与海》，真棒！”——美籍华人知名学者、博士后导师邢若曦\r\n\r\n◆ 国际当红女插画师SlavaShults，首次为中文版《老人与海》专门创作12副海报级手绘插图，带给你绝美的阅读体验；随书附赠英文版本定版。\r\n\r\n◆ 自1954年荣获诺贝尔文学奖至今，《老人与海》风靡全球，横扫每个必读经典书单，征服了亿万读者；据作家榜官方统计：截至2017年1月，113位诺贝尔文学奖得主作品中文版销量排行榜，海明威高居榜首，总销量突破550万册。\r\n\r\n◆ “人可以被毁灭，但不能被打败。”——本书作者海明威（诺贝尔文学奖、普利策奖双奖得主）', '13821865025', '2018-06-02 12:46:18', 0, 1, 0, 1, 'd500618bd4e4473a8abbcd53b6f29ece', 14);

-- ----------------------------
-- Table structure for mapping
-- ----------------------------
DROP TABLE IF EXISTS `mapping`;
CREATE TABLE `mapping`  (
  `mapkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键，键',
  `m_value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT ' 值',
  PRIMARY KEY (`mapkey`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mapping
-- ----------------------------
INSERT INTO `mapping` VALUES ('contact_emails', 'bsp@163.com</>bsp@126.com');
INSERT INTO `mapping` VALUES ('contact_phones', '[{\"name\":\"邬同学\",\"phone\":\"13800138000\"},{\"name\":\"陈同学\",\"phone\":\"13800138001\"},{\"name\":\"赖同学\",\"phone\":\"13800138002\"},{\"name\":\"梁同学\",\"phone\":\"13800138003\"}]');
INSERT INTO `mapping` VALUES ('msg_create_order_success', '<p>尊敬的用户，您已成功提交<a href=\"%url_user/p/details?lbId=%lb_id\" target=\"_blank\">《%bookname》</a>的借阅申请，正在等待借出方审核，我们将在%overtime_agree_apply天内向你反馈审核结果。<a href=\"%url_user/p/record\" target=\"_blank\">点击查看</a></p>');
INSERT INTO `mapping` VALUES ('msg_email_from', 'books_sharing@126.com');
INSERT INTO `mapping` VALUES ('msg_email_host', 'smtp.126.com');
INSERT INTO `mapping` VALUES ('msg_email_password', '123456bsp');
INSERT INTO `mapping` VALUES ('msg_email_username', 'books_sharing');
INSERT INTO `mapping` VALUES ('msg_reveive_borrow_apply', '<p>尊敬的用户，您收到您所共享的图书<a href=\"%url_user/p/details?lbId=%lb_id\" target=\"_blank\">《%bookname》</a>的借阅申请，请在%overtime_agree_apply天内处理申请，逾期将自动取消订单。点击查看<a href=\"%url_user/p/lended\" target=\"_blank\">点击查看</a></p>');
INSERT INTO `mapping` VALUES ('msg_share_failure', '<p>尊敬的用户，您分享的《%bookname》审核不通过。原因：%failureMsg<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>');
INSERT INTO `mapping` VALUES ('msg_share_success', '<p>尊敬的用户，您分享的《%bookname》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>');
INSERT INTO `mapping` VALUES ('msg_template', '待定s%');
INSERT INTO `mapping` VALUES ('overtime_agree_apply', '7');
INSERT INTO `mapping` VALUES ('overtime_book_apply_check', '7');
INSERT INTO `mapping` VALUES ('overtime_bring_to_transfer_station', '3');
INSERT INTO `mapping` VALUES ('overtime_take_from_transfer_station', '7');
INSERT INTO `mapping` VALUES ('path_image_linux', '/opt/bsp/imgs');
INSERT INTO `mapping` VALUES ('path_image_win', 'd:/bsp/imgs');
INSERT INTO `mapping` VALUES ('qq_group', '7895426416</>1891578894');
INSERT INTO `mapping` VALUES ('transfer_station', '肇庆学院图书馆102室');
INSERT INTO `mapping` VALUES ('url_admin', 'http://127.0.0.1:8080');
INSERT INTO `mapping` VALUES ('url_user', 'http://127.0.0.1:8081');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `n_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '通知消息记录ID，数字自增长	',
  `n_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知消息标题',
  `n_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知消息内容',
  `news_time` datetime NOT NULL COMMENT '产生消息的时间',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知消息所属的用户 ',
  PRIMARY KEY (`n_id`) USING BTREE,
  INDEX `FKf96u6pu7bsv28mi8kwql3ubb7`(`uuid`) USING BTREE,
  CONSTRAINT `FKf96u6pu7bsv28mi8kwql3ubb7` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (8, '审核失败', '<p>尊敬的用户，您分享的《老人与海》审核不通过。原因：<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:23:40', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (10, '审核失败', '<p>尊敬的用户，您分享的《丰乳肥臀》审核不通过。原因：类目不正确<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:28:05', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (11, '审核失败', '<p>尊敬的用户，您分享的《丰乳肥臀》审核不通过。原因：类目不正确<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:32:01', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (13, '审核通过', '<p>尊敬的用户，您分享的《老人与海》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:57:27', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (14, '审核通过', '<p>尊敬的用户，您分享的《灌篮高手（套装1-31 册）》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 11:02:55', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (15, '审核通过', '<p>尊敬的用户，您分享的《老人与海》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 12:39:28', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (16, '审核通过', '<p>尊敬的用户，您分享的《老人与海》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 12:46:18', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (17, '还书通知', '您借的图书已过期，请及时规划', '2018-06-06 20:07:00', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (18, '测试', '测试', '2018-06-06 20:08:58', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (19, '你好', '订单过期，请尽快规还', '2018-06-06 20:18:17', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (20, '测试消息', '<p>测试消息</p>', '2018-06-06 20:20:33', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (21, '收到申请', '请尽快确认', '2018-06-06 20:30:19', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (22, '你好', '三扽广泛', '2018-06-06 21:43:23', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (23, '成功提交借阅申请', '<p>尊敬的用户，您已成功提交<a href=\"/p/details?lbId=11\">《灌篮高手（套装1-31 册）》</a>的借阅申请，正在等待借出方审核，我们将在7天内向你反馈审核结果。<a href=\"/p/record\" target=\"_blank\">点击查看</a></p>', '2018-06-18 16:52:41', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (24, '成功提交借阅申请', '收到借阅申请，请尽快处理', '2018-06-18 16:52:46', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (25, '成功提交借阅申请', '<p>尊敬的用户，您已成功提交<a href=\"localhost:8081/p/details?lbId=13\" target=\"_blank\">《老人与海》</a>的借阅申请，正在等待借出方审核，我们将在7天内向你反馈审核结果。<a href=\"localhost:8081/p/record\" target=\"_blank\">点击查看</a></p>', '2018-06-18 17:05:59', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (26, '成功提交借阅申请', '收到借阅申请，请尽快处理', '2018-06-18 17:06:10', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (27, '成功提交借阅申请', '<p>尊敬的用户，您已成功提交<a href=\"127.0.0.2:8081/p/details?lbId=13\" target=\"_blank\">《老人与海》</a>的借阅申请，正在等待借出方审核，我们将在7天内向你反馈审核结果。<a href=\"127.0.0.2:8081/p/record\" target=\"_blank\">点击查看</a></p>', '2018-06-18 17:14:33', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (28, '成功提交借阅申请', '收到借阅申请，请尽快处理', '2018-06-18 17:14:38', 'd500618bd4e4473a8abbcd53b6f29ece');
INSERT INTO `news` VALUES (29, '成功提交借阅申请', '<p>尊敬的用户，您已成功提交<a href=\"http://127.0.0.1:8081/p/details?lbId=13\" target=\"_blank\">《老人与海》</a>的借阅申请，正在等待借出方审核，我们将在7天内向你反馈审核结果。<a href=\"http://127.0.0.1:8081/p/record\" target=\"_blank\">点击查看</a></p>', '2018-06-18 17:42:56', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `news` VALUES (30, '成功提交借阅申请', '收到借阅申请，请尽快处理', '2018-06-18 17:43:13', 'd500618bd4e4473a8abbcd53b6f29ece');

-- ----------------------------
-- Table structure for outdated_news
-- ----------------------------
DROP TABLE IF EXISTS `outdated_news`;
CREATE TABLE `outdated_news`  (
  `n_id` int(11) NOT NULL COMMENT '通知消息记录ID，来源news表主键	',
  `n_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知消息标题',
  `n_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知消息内容',
  `news_time` datetime NOT NULL COMMENT '产生消息的时间',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知消息所属的用户 ',
  PRIMARY KEY (`n_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of outdated_news
-- ----------------------------
INSERT INTO `outdated_news` VALUES (1, '测试消息2', '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本', '2018-05-02 00:00:51', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (2, '测试消息3', '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本', '2018-05-03 23:43:03', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (3, '测试消息5', '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本', '2018-05-05 23:43:51', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (4, '测试消息6', '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本', '2018-05-06 23:44:16', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (5, '测试消息7', '文本文本文本文本文本文本文本文本文本文本文本文本文本文文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本本文本', '2018-05-07 23:44:33', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (6, '测试消息1', '文本文本文本文本文本文本文本文本文本', '2018-05-01 22:49:07', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (9, '审核失败', '<p>尊敬的用户，您分享的《丰乳肥臀》审核不通过。原因：<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:23:53', 'f01c3b8acd114a689e237564d925789b');
INSERT INTO `outdated_news` VALUES (12, '审核通过', '<p>尊敬的用户，您分享的《丰乳肥臀》已通过审核。<a href=\'/p/my_share\' target=\'_blank\'> 点击查看</a></p>', '2018-06-02 10:54:51', 'f01c3b8acd114a689e237564d925789b');

-- ----------------------------
-- Table structure for primary_classification
-- ----------------------------
DROP TABLE IF EXISTS `primary_classification`;
CREATE TABLE `primary_classification`  (
  `pc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书一级分类唯一标识，数字自增长',
  `pc_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级分类名称',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除分类 0表示没有删除，1表示删除，默认为0',
  PRIMARY KEY (`pc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of primary_classification
-- ----------------------------
INSERT INTO `primary_classification` VALUES (1, 'A马克思主义、列宁主义、毛泽东思想、邓小平理论', 0);
INSERT INTO `primary_classification` VALUES (2, 'B哲学、宗教', 0);
INSERT INTO `primary_classification` VALUES (3, 'C社会科学总论', 0);
INSERT INTO `primary_classification` VALUES (4, 'D政治、法律', 0);
INSERT INTO `primary_classification` VALUES (5, 'E军事', 0);
INSERT INTO `primary_classification` VALUES (6, 'F经济', 0);
INSERT INTO `primary_classification` VALUES (7, 'G文化、科学、教育、体育', 0);
INSERT INTO `primary_classification` VALUES (8, 'H语言、文字', 0);
INSERT INTO `primary_classification` VALUES (9, 'I文学', 0);
INSERT INTO `primary_classification` VALUES (10, 'J艺术', 0);
INSERT INTO `primary_classification` VALUES (11, 'K历史、地理', 0);
INSERT INTO `primary_classification` VALUES (12, 'N自然科学总论', 0);
INSERT INTO `primary_classification` VALUES (13, 'O数理科学和化学', 0);
INSERT INTO `primary_classification` VALUES (14, 'P天文学、地球科学', 0);
INSERT INTO `primary_classification` VALUES (15, 'Q生物科学', 0);
INSERT INTO `primary_classification` VALUES (16, 'R医药、卫生', 0);
INSERT INTO `primary_classification` VALUES (17, 'S农业科学', 0);
INSERT INTO `primary_classification` VALUES (18, 'T工业技术', 0);
INSERT INTO `primary_classification` VALUES (19, 'U交通运输', 0);
INSERT INTO `primary_classification` VALUES (20, 'V航空、航天', 0);
INSERT INTO `primary_classification` VALUES (21, 'X环境科学、安全科学', 0);
INSERT INTO `primary_classification` VALUES (22, 'Z综合性图书', 0);
INSERT INTO `primary_classification` VALUES (23, '测试', 1);

-- ----------------------------
-- Table structure for respond_history
-- ----------------------------
DROP TABLE IF EXISTS `respond_history`;
CREATE TABLE `respond_history`  (
  `rh_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '响应记录标识，来源RespondRecord表主键',
  `respond_time` datetime NULL DEFAULT NULL COMMENT '需求者响应时间',
  `send_to_time` datetime NULL DEFAULT NULL COMMENT '响应者送达运营商服务点时间',
  `take_away_time` datetime NULL DEFAULT NULL COMMENT '需求者取走图书时间',
  `expected_return_time` datetime NULL DEFAULT NULL COMMENT '需求者预期还书时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '需求者实际还书时间',
  `take_back_time` datetime NULL DEFAULT NULL COMMENT '响应者取回图书时间',
  `rh_struts` tinyint(4) NOT NULL COMMENT '1需求者取消需求，2响应者取消响应，3响应者逾期未送达运营方，10响应者取回图书，11响应者捐赠图书',
  `respond_phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '响应者电话号码',
  `db_id` int(11) NOT NULL COMMENT '需求的图书',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '响应者',
  `receive_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借出人送到图书的管理员',
  `back_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借阅人还图书的管理员',
  PRIMARY KEY (`rh_id`) USING BTREE,
  INDEX `FKc4n2o3pnt7v1ro1llit26bdh9`(`back_uuid`) USING BTREE,
  INDEX `FKpitdtd9j0unkorryr5v9o6peo`(`db_id`) USING BTREE,
  INDEX `FKm3dc3iuwl80ca9gg0nixapqpa`(`receive_uuid`) USING BTREE,
  INDEX `FKen5iu87u8vxcd5fiigbd7m2fy`(`uuid`) USING BTREE,
  CONSTRAINT `FKc4n2o3pnt7v1ro1llit26bdh9` FOREIGN KEY (`back_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKen5iu87u8vxcd5fiigbd7m2fy` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKm3dc3iuwl80ca9gg0nixapqpa` FOREIGN KEY (`receive_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKpitdtd9j0unkorryr5v9o6peo` FOREIGN KEY (`db_id`) REFERENCES `demand_book` (`db_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for respond_record
-- ----------------------------
DROP TABLE IF EXISTS `respond_record`;
CREATE TABLE `respond_record`  (
  `rr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '响应记录标识，数字自增长',
  `respond_time` datetime NULL DEFAULT NULL COMMENT '需求者响应时间',
  `send_to_time` datetime NULL DEFAULT NULL COMMENT '响应者送达运营商服务点时间',
  `take_away_time` datetime NULL DEFAULT NULL COMMENT '需求者取走图书时间',
  `expected_return_time` datetime NULL DEFAULT NULL COMMENT '需求者预期还书时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '需求者实际还书时间',
  `take_back_time` datetime NULL DEFAULT NULL COMMENT '响应者取回图书时间',
  `rr_struts` tinyint(4) NOT NULL COMMENT '0需求被响应，4响应者送达图书到运营方，5需求者逾期未取书，6需求者取走图书，7需求者逾期未还，8需求者还书，9响应者逾期未取回',
  `respond_phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '响应者电话号码',
  `db_id` int(11) NOT NULL COMMENT '需求的图书',
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '响应者',
  `receive_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借出人送到图书的管理员',
  `back_uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收到借阅人还图书的管理员',
  PRIMARY KEY (`rr_id`) USING BTREE,
  INDEX `FK89a26aixakyy0k9o7ikpukkre`(`back_uuid`) USING BTREE,
  INDEX `FK1cmp26fjwow0e0srh5q4xkaor`(`db_id`) USING BTREE,
  INDEX `FK8qaplwhx6f0yc7qjwtby8d2dr`(`receive_uuid`) USING BTREE,
  INDEX `FK5k9cn0i74f6tkxvypn0x6p33a`(`uuid`) USING BTREE,
  CONSTRAINT `FK1cmp26fjwow0e0srh5q4xkaor` FOREIGN KEY (`db_id`) REFERENCES `demand_book` (`db_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK5k9cn0i74f6tkxvypn0x6p33a` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK89a26aixakyy0k9o7ikpukkre` FOREIGN KEY (`back_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK8qaplwhx6f0yc7qjwtby8d2dr` FOREIGN KEY (`receive_uuid`) REFERENCES `administrator` (`a_uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for secondary_classification
-- ----------------------------
DROP TABLE IF EXISTS `secondary_classification`;
CREATE TABLE `secondary_classification`  (
  `sc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书二级分类唯一标识，数字增长值',
  `sc_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '二级分类名称',
  `pc_id` int(11) NOT NULL COMMENT '所属一级分类',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除分类 0表示没有删除，1表示删除，默认为0',
  PRIMARY KEY (`sc_id`) USING BTREE,
  INDEX `FKfnox8i80pxh4rxj3ubjk7b0kd`(`pc_id`) USING BTREE,
  CONSTRAINT `FKfnox8i80pxh4rxj3ubjk7b0kd` FOREIGN KEY (`pc_id`) REFERENCES `primary_classification` (`pc_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 250 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of secondary_classification
-- ----------------------------
INSERT INTO `secondary_classification` VALUES (1, 'A1马克思、恩格斯著作', 1, 0);
INSERT INTO `secondary_classification` VALUES (2, 'A2列宁著作', 1, 0);
INSERT INTO `secondary_classification` VALUES (3, 'A3斯大林著作', 1, 0);
INSERT INTO `secondary_classification` VALUES (4, 'A4毛泽东著作', 1, 0);
INSERT INTO `secondary_classification` VALUES (5, 'A49邓小平著作', 1, 0);
INSERT INTO `secondary_classification` VALUES (6, 'A5马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编', 1, 0);
INSERT INTO `secondary_classification` VALUES (7, 'A7马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记', 1, 0);
INSERT INTO `secondary_classification` VALUES (8, 'A8马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究', 1, 0);
INSERT INTO `secondary_classification` VALUES (9, 'B-4哲学教育与普及', 2, 0);
INSERT INTO `secondary_classification` VALUES (10, 'B0哲学理论', 2, 0);
INSERT INTO `secondary_classification` VALUES (11, 'B1世界哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (12, 'B2中国哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (13, 'B3亚洲哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (14, 'B4非洲哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (15, 'B5欧洲哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (16, 'B6大洋洲哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (17, 'B7美洲哲学', 2, 0);
INSERT INTO `secondary_classification` VALUES (18, 'B80思维科学', 2, 0);
INSERT INTO `secondary_classification` VALUES (19, 'B81逻辑学（论理学）', 2, 0);
INSERT INTO `secondary_classification` VALUES (20, 'B82伦理学（道德哲学）', 2, 0);
INSERT INTO `secondary_classification` VALUES (21, 'B83美学', 2, 0);
INSERT INTO `secondary_classification` VALUES (22, 'B84心理学', 2, 0);
INSERT INTO `secondary_classification` VALUES (23, 'B9宗教', 2, 0);
INSERT INTO `secondary_classification` VALUES (24, 'C0社会科学理论与方法论', 3, 0);
INSERT INTO `secondary_classification` VALUES (25, 'C1社会科学现状及发展', 3, 0);
INSERT INTO `secondary_classification` VALUES (26, 'C2社会科学机构、团体、会议', 3, 0);
INSERT INTO `secondary_classification` VALUES (27, 'C3社会科学研究方法', 3, 0);
INSERT INTO `secondary_classification` VALUES (28, 'C4社会科学教育与普及', 3, 0);
INSERT INTO `secondary_classification` VALUES (29, 'C5社会科学丛书、文集、连续性出版物', 3, 0);
INSERT INTO `secondary_classification` VALUES (30, 'C6社会科学参考工具书', 3, 0);
INSERT INTO `secondary_classification` VALUES (31, '[C7]社会科学文献检索工具书', 3, 0);
INSERT INTO `secondary_classification` VALUES (32, 'C8统计学', 3, 0);
INSERT INTO `secondary_classification` VALUES (33, 'C91社会学', 3, 0);
INSERT INTO `secondary_classification` VALUES (34, 'C92人口学', 3, 0);
INSERT INTO `secondary_classification` VALUES (35, 'C93管理学', 3, 0);
INSERT INTO `secondary_classification` VALUES (36, '[C94]系统科学', 3, 0);
INSERT INTO `secondary_classification` VALUES (37, 'C95民族学', 3, 0);
INSERT INTO `secondary_classification` VALUES (38, 'C96人才学', 3, 0);
INSERT INTO `secondary_classification` VALUES (39, 'C97劳动科学', 3, 0);
INSERT INTO `secondary_classification` VALUES (40, 'D0政治理论', 4, 0);
INSERT INTO `secondary_classification` VALUES (41, 'D1国际共产主义运动', 4, 0);
INSERT INTO `secondary_classification` VALUES (42, 'D2中国共产党', 4, 0);
INSERT INTO `secondary_classification` VALUES (43, 'D33/37各国共产党', 4, 0);
INSERT INTO `secondary_classification` VALUES (44, 'D4工人、农民、青年、妇女运动与组织', 4, 0);
INSERT INTO `secondary_classification` VALUES (45, 'D5世界政治', 4, 0);
INSERT INTO `secondary_classification` VALUES (46, 'D6中国政治', 4, 0);
INSERT INTO `secondary_classification` VALUES (47, 'D73/77各国政治', 4, 0);
INSERT INTO `secondary_classification` VALUES (48, 'D8外交、国际关系', 4, 0);
INSERT INTO `secondary_classification` VALUES (49, 'D9法律', 4, 0);
INSERT INTO `secondary_classification` VALUES (50, 'DF法律', 4, 0);
INSERT INTO `secondary_classification` VALUES (51, 'E0军事理论', 5, 0);
INSERT INTO `secondary_classification` VALUES (52, 'E1世界军事', 5, 0);
INSERT INTO `secondary_classification` VALUES (53, 'E2中国军事', 5, 0);
INSERT INTO `secondary_classification` VALUES (54, 'E3/7各国军事', 5, 0);
INSERT INTO `secondary_classification` VALUES (55, 'E8战略学、战役学、战术学', 5, 0);
INSERT INTO `secondary_classification` VALUES (56, 'E9军事技术', 5, 0);
INSERT INTO `secondary_classification` VALUES (57, 'E99军事地形学、军事地理学', 5, 0);
INSERT INTO `secondary_classification` VALUES (58, 'F0经济学', 6, 0);
INSERT INTO `secondary_classification` VALUES (59, 'F1世界各国经济概况、经济史、经济地理', 6, 0);
INSERT INTO `secondary_classification` VALUES (60, 'F2经济计划与管理', 6, 0);
INSERT INTO `secondary_classification` VALUES (61, 'F3农业经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (62, 'F4工业经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (63, 'F49信息产业经济（总论）', 6, 0);
INSERT INTO `secondary_classification` VALUES (64, 'F5交通运输经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (65, 'F59旅游经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (66, 'F6邮电经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (67, 'F7贸易经济', 6, 0);
INSERT INTO `secondary_classification` VALUES (68, 'F8财政、金融', 6, 0);
INSERT INTO `secondary_classification` VALUES (69, 'G0文化理论', 7, 0);
INSERT INTO `secondary_classification` VALUES (70, 'G1世界各国文化与文化事业', 7, 0);
INSERT INTO `secondary_classification` VALUES (71, 'G2信息与知识传播', 7, 0);
INSERT INTO `secondary_classification` VALUES (72, 'G3科学、科学研究', 7, 0);
INSERT INTO `secondary_classification` VALUES (73, 'G4教育', 7, 0);
INSERT INTO `secondary_classification` VALUES (74, 'G8体育', 7, 0);
INSERT INTO `secondary_classification` VALUES (75, 'H0语言学', 8, 0);
INSERT INTO `secondary_classification` VALUES (76, 'H1汉语', 8, 0);
INSERT INTO `secondary_classification` VALUES (77, 'H2中国少数民族语言', 8, 0);
INSERT INTO `secondary_classification` VALUES (78, 'H3常用外国语', 8, 0);
INSERT INTO `secondary_classification` VALUES (79, 'H4汉藏语系', 8, 0);
INSERT INTO `secondary_classification` VALUES (80, 'H5阿尔泰语系（突厥-蒙古-通古斯语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (81, 'H61南亚语系（澳斯特罗-亚细亚语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (82, 'H62南印语系（达罗毗荼语系、德拉维达语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (83, 'H63南岛语系（马来亚-玻里尼西亚语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (84, 'H64东北亚诸语言', 8, 0);
INSERT INTO `secondary_classification` VALUES (85, 'H65高加索语系（伊比利亚-高加索语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (86, 'H66乌拉尔语系（芬兰-乌戈尔语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (87, 'H67闪-含语系（阿非罗-亚细亚语系）', 8, 0);
INSERT INTO `secondary_classification` VALUES (88, 'H7印欧语系', 8, 0);
INSERT INTO `secondary_classification` VALUES (89, 'H81非洲诸语言', 8, 0);
INSERT INTO `secondary_classification` VALUES (90, 'H83美洲诸语言', 8, 0);
INSERT INTO `secondary_classification` VALUES (91, 'H84大洋洲诸语言', 8, 0);
INSERT INTO `secondary_classification` VALUES (92, 'H9国际辅助语', 8, 0);
INSERT INTO `secondary_classification` VALUES (93, 'I0文学理论', 9, 0);
INSERT INTO `secondary_classification` VALUES (94, 'I1世界文学', 9, 0);
INSERT INTO `secondary_classification` VALUES (95, 'I2中国文学', 9, 0);
INSERT INTO `secondary_classification` VALUES (96, 'I3/7各国文学', 9, 0);
INSERT INTO `secondary_classification` VALUES (97, 'J0艺术理论', 10, 0);
INSERT INTO `secondary_classification` VALUES (98, 'J1世界各国艺术概况', 10, 0);
INSERT INTO `secondary_classification` VALUES (99, 'J2绘画', 10, 0);
INSERT INTO `secondary_classification` VALUES (100, 'J29书法、篆刻', 10, 0);
INSERT INTO `secondary_classification` VALUES (101, 'J3雕塑', 10, 0);
INSERT INTO `secondary_classification` VALUES (102, 'J4摄影艺术', 10, 0);
INSERT INTO `secondary_classification` VALUES (103, 'J5工艺美术', 10, 0);
INSERT INTO `secondary_classification` VALUES (104, '[J59]建筑艺术', 10, 0);
INSERT INTO `secondary_classification` VALUES (105, 'J6音乐', 10, 0);
INSERT INTO `secondary_classification` VALUES (106, 'J7舞蹈', 10, 0);
INSERT INTO `secondary_classification` VALUES (107, 'J8戏剧艺术', 10, 0);
INSERT INTO `secondary_classification` VALUES (108, 'J9电影、电视艺术', 10, 0);
INSERT INTO `secondary_classification` VALUES (109, 'K0史学理论', 11, 0);
INSERT INTO `secondary_classification` VALUES (110, 'K1世界史', 11, 0);
INSERT INTO `secondary_classification` VALUES (111, 'K2中国史', 11, 0);
INSERT INTO `secondary_classification` VALUES (112, 'K3亚洲史', 11, 0);
INSERT INTO `secondary_classification` VALUES (113, 'K4非洲史', 11, 0);
INSERT INTO `secondary_classification` VALUES (114, 'K5欧洲史', 11, 0);
INSERT INTO `secondary_classification` VALUES (115, 'K6大洋洲史', 11, 0);
INSERT INTO `secondary_classification` VALUES (116, 'K7美洲史', 11, 0);
INSERT INTO `secondary_classification` VALUES (117, 'K81传记', 11, 0);
INSERT INTO `secondary_classification` VALUES (118, 'K85文物考古', 11, 0);
INSERT INTO `secondary_classification` VALUES (119, 'K89风俗习惯', 11, 0);
INSERT INTO `secondary_classification` VALUES (120, 'K9地理', 11, 0);
INSERT INTO `secondary_classification` VALUES (121, 'N0自然科学理论与方法论', 12, 0);
INSERT INTO `secondary_classification` VALUES (122, 'N1自然科学现状及发展', 12, 0);
INSERT INTO `secondary_classification` VALUES (123, 'N2自然科学机构、团体、会议', 12, 0);
INSERT INTO `secondary_classification` VALUES (124, 'N3自然科学研究方法', 12, 0);
INSERT INTO `secondary_classification` VALUES (125, 'N4自然科学教育与普及', 12, 0);
INSERT INTO `secondary_classification` VALUES (126, 'N5自然科学丛书、文集、连续性出版物', 12, 0);
INSERT INTO `secondary_classification` VALUES (127, 'N6自然科学参考工具书', 12, 0);
INSERT INTO `secondary_classification` VALUES (128, '[N7]自然科学文献检索工具', 12, 0);
INSERT INTO `secondary_classification` VALUES (129, 'N8自然科学调查、考察', 12, 0);
INSERT INTO `secondary_classification` VALUES (130, 'N91自然研究、自然历史', 12, 0);
INSERT INTO `secondary_classification` VALUES (131, 'N93非线性科学', 12, 0);
INSERT INTO `secondary_classification` VALUES (132, 'N94系统科学', 12, 0);
INSERT INTO `secondary_classification` VALUES (133, '[N99]情报学、情报工作', 12, 0);
INSERT INTO `secondary_classification` VALUES (134, 'O1数学', 13, 0);
INSERT INTO `secondary_classification` VALUES (135, 'O3力学', 13, 0);
INSERT INTO `secondary_classification` VALUES (136, 'O4物理学', 13, 0);
INSERT INTO `secondary_classification` VALUES (137, 'O6化学', 13, 0);
INSERT INTO `secondary_classification` VALUES (138, 'O7晶体学', 13, 0);
INSERT INTO `secondary_classification` VALUES (139, 'P1天文学', 14, 0);
INSERT INTO `secondary_classification` VALUES (140, 'P2测绘学', 14, 0);
INSERT INTO `secondary_classification` VALUES (141, 'P3地球物理学', 14, 0);
INSERT INTO `secondary_classification` VALUES (142, 'P4大气科学（气象学）', 14, 0);
INSERT INTO `secondary_classification` VALUES (143, 'P5地质学', 14, 0);
INSERT INTO `secondary_classification` VALUES (144, 'P7海洋学', 14, 0);
INSERT INTO `secondary_classification` VALUES (145, 'P9自然地理学', 14, 0);
INSERT INTO `secondary_classification` VALUES (146, 'Q-0生物科学的理论与方法', 15, 0);
INSERT INTO `secondary_classification` VALUES (147, 'Q-1生物科学现状与发展', 15, 0);
INSERT INTO `secondary_classification` VALUES (148, 'Q-3生物科学的研究方法与技术', 15, 0);
INSERT INTO `secondary_classification` VALUES (149, 'Q-4生物科学教育与普及', 15, 0);
INSERT INTO `secondary_classification` VALUES (150, 'Q-9生物资源调查', 15, 0);
INSERT INTO `secondary_classification` VALUES (151, 'Q1普通生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (152, 'Q2细胞生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (153, 'Q3遗传学', 15, 0);
INSERT INTO `secondary_classification` VALUES (154, 'Q4生理学', 15, 0);
INSERT INTO `secondary_classification` VALUES (155, 'Q5生物化学', 15, 0);
INSERT INTO `secondary_classification` VALUES (156, 'Q6生物物理学', 15, 0);
INSERT INTO `secondary_classification` VALUES (157, 'Q7分子生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (158, 'Q81生物工程学（生物技术）', 15, 0);
INSERT INTO `secondary_classification` VALUES (159, '[Q89]环境生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (160, 'Q91古生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (161, 'Q93微生物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (162, 'Q94植物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (163, 'Q95动物学', 15, 0);
INSERT INTO `secondary_classification` VALUES (164, 'Q96昆虫学', 15, 0);
INSERT INTO `secondary_classification` VALUES (165, 'Q98人类学', 15, 0);
INSERT INTO `secondary_classification` VALUES (166, 'R-0一般理论', 16, 0);
INSERT INTO `secondary_classification` VALUES (167, 'R-1现状与发展', 16, 0);
INSERT INTO `secondary_classification` VALUES (168, 'R-3医学研究方法', 16, 0);
INSERT INTO `secondary_classification` VALUES (169, 'R1预防医学、卫生学', 16, 0);
INSERT INTO `secondary_classification` VALUES (170, 'R2中国医学', 16, 0);
INSERT INTO `secondary_classification` VALUES (171, 'R3基础医学', 16, 0);
INSERT INTO `secondary_classification` VALUES (172, 'R4临床医学', 16, 0);
INSERT INTO `secondary_classification` VALUES (173, 'R5内科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (174, 'R6外科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (175, 'R71妇产科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (176, 'R72儿科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (177, 'R73肿瘤学', 16, 0);
INSERT INTO `secondary_classification` VALUES (178, 'R74神经病学与精神病学', 16, 0);
INSERT INTO `secondary_classification` VALUES (179, 'R75皮肤病学与性病学', 16, 0);
INSERT INTO `secondary_classification` VALUES (180, 'R76耳鼻咽喉科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (181, 'R77眼科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (182, 'R78口腔科学', 16, 0);
INSERT INTO `secondary_classification` VALUES (183, 'R79外国民族医学', 16, 0);
INSERT INTO `secondary_classification` VALUES (184, 'R8特种医学', 16, 0);
INSERT INTO `secondary_classification` VALUES (185, 'R9药学', 16, 0);
INSERT INTO `secondary_classification` VALUES (186, 'S-0一般性理论', 17, 0);
INSERT INTO `secondary_classification` VALUES (187, 'S-1农业科学技术现状与发展', 17, 0);
INSERT INTO `secondary_classification` VALUES (188, 'S-3农业科学研究、试验', 17, 0);
INSERT INTO `secondary_classification` VALUES (189, '[S-9]农业经济', 17, 0);
INSERT INTO `secondary_classification` VALUES (190, 'S1农业基础科学', 17, 0);
INSERT INTO `secondary_classification` VALUES (191, 'S2农业工程', 17, 0);
INSERT INTO `secondary_classification` VALUES (192, 'S3农学（农艺学）', 17, 0);
INSERT INTO `secondary_classification` VALUES (193, 'S4植物保护', 17, 0);
INSERT INTO `secondary_classification` VALUES (194, 'S5农作物', 17, 0);
INSERT INTO `secondary_classification` VALUES (195, 'S6园艺', 17, 0);
INSERT INTO `secondary_classification` VALUES (196, 'S7林业', 17, 0);
INSERT INTO `secondary_classification` VALUES (197, 'S8畜牧、动物医学、狩猎、蚕、蜂', 17, 0);
INSERT INTO `secondary_classification` VALUES (198, 'S9水产、渔业', 17, 0);
INSERT INTO `secondary_classification` VALUES (199, 'T-0工业技术理论', 18, 0);
INSERT INTO `secondary_classification` VALUES (200, 'T-1工业技术现状与发展', 18, 0);
INSERT INTO `secondary_classification` VALUES (201, 'T-2机构、团体、会议', 18, 0);
INSERT INTO `secondary_classification` VALUES (202, 'T-6参考工具书', 18, 0);
INSERT INTO `secondary_classification` VALUES (203, '[T-9]工业经济', 18, 0);
INSERT INTO `secondary_classification` VALUES (204, 'TB一般工业技术', 18, 0);
INSERT INTO `secondary_classification` VALUES (205, 'TD矿业工程', 18, 0);
INSERT INTO `secondary_classification` VALUES (206, 'TE石油、天然气工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (207, 'TF冶金工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (208, 'TG金属学与金属工艺', 18, 0);
INSERT INTO `secondary_classification` VALUES (209, 'TH机械、仪表工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (210, 'TJ武器工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (211, 'TK能源与动力工程', 18, 0);
INSERT INTO `secondary_classification` VALUES (212, 'TL原子能技术', 18, 0);
INSERT INTO `secondary_classification` VALUES (213, 'TM电工技术', 18, 0);
INSERT INTO `secondary_classification` VALUES (214, 'TN无线电电子学、电信技术', 18, 0);
INSERT INTO `secondary_classification` VALUES (215, 'TP自动化技术、计算机技术', 18, 0);
INSERT INTO `secondary_classification` VALUES (216, 'TQ化学工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (217, 'TS轻工业、手工业', 18, 0);
INSERT INTO `secondary_classification` VALUES (218, 'TU建筑科学', 18, 0);
INSERT INTO `secondary_classification` VALUES (219, 'TV水利工程', 18, 0);
INSERT INTO `secondary_classification` VALUES (220, '[U-9]交通运输经济', 19, 0);
INSERT INTO `secondary_classification` VALUES (221, 'U1综合运输', 19, 0);
INSERT INTO `secondary_classification` VALUES (222, 'U2铁路运输', 19, 0);
INSERT INTO `secondary_classification` VALUES (223, 'U4公路运输', 19, 0);
INSERT INTO `secondary_classification` VALUES (224, 'U6水路运输', 19, 0);
INSERT INTO `secondary_classification` VALUES (225, '[U8]航空运输', 19, 0);
INSERT INTO `secondary_classification` VALUES (226, 'V1航空、航天技术的研究与探索', 20, 0);
INSERT INTO `secondary_classification` VALUES (227, 'V2航空', 20, 0);
INSERT INTO `secondary_classification` VALUES (228, 'V4航天（宇宙航行）', 20, 0);
INSERT INTO `secondary_classification` VALUES (229, '[V7]航空、航天医学', 20, 0);
INSERT INTO `secondary_classification` VALUES (230, 'X-0环境科学理论', 21, 0);
INSERT INTO `secondary_classification` VALUES (231, 'X-1环境科学技术现状与发展', 21, 0);
INSERT INTO `secondary_classification` VALUES (232, 'X-4环境保护宣传教育及普及', 21, 0);
INSERT INTO `secondary_classification` VALUES (233, 'X-6环境保护参考工具书', 21, 0);
INSERT INTO `secondary_classification` VALUES (234, 'X1环境科学基础理论', 21, 0);
INSERT INTO `secondary_classification` VALUES (235, 'X2社会与环境', 21, 0);
INSERT INTO `secondary_classification` VALUES (236, 'X3环境保护管理', 21, 0);
INSERT INTO `secondary_classification` VALUES (237, 'X4灾害及其防治', 21, 0);
INSERT INTO `secondary_classification` VALUES (238, 'X5环境污染及其防治', 21, 0);
INSERT INTO `secondary_classification` VALUES (239, 'X7废物处理与综合利用', 21, 0);
INSERT INTO `secondary_classification` VALUES (240, 'X8环境质量评价与环境监测', 21, 0);
INSERT INTO `secondary_classification` VALUES (241, 'X9安全科学', 21, 0);
INSERT INTO `secondary_classification` VALUES (242, 'Z1丛书', 22, 0);
INSERT INTO `secondary_classification` VALUES (243, 'Z2百科全书、类书', 22, 0);
INSERT INTO `secondary_classification` VALUES (244, 'Z3辞典', 22, 0);
INSERT INTO `secondary_classification` VALUES (245, 'Z4论文集、全集、选集、杂著', 22, 0);
INSERT INTO `secondary_classification` VALUES (246, 'Z5年鉴、年刊', 22, 0);
INSERT INTO `secondary_classification` VALUES (247, 'Z6期刊、连续性出版物', 22, 0);
INSERT INTO `secondary_classification` VALUES (248, 'Z8图书目录、文摘、索引', 22, 0);
INSERT INTO `secondary_classification` VALUES (249, '测试', 1, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户唯一标识符号',
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户邮箱，作为用户登录账号',
  `password` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录账号密码',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0没有禁用，1被禁用，默认为0',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('d500618bd4e4473a8abbcd53b6f29ece', 'hayatesa@live.cn', '8d90bad3ed38d67ea1fe74e526b98ffc', 0);
INSERT INTO `user` VALUES ('f01c3b8acd114a689e237564d925789b', '358739303@qq.com', 'b8cd35019d332fc19bb4a06e3e2e1998', 0);

-- ----------------------------
-- Table structure for user_infor
-- ----------------------------
DROP TABLE IF EXISTS `user_infor`;
CREATE TABLE `user_infor`  (
  `uuid` varchar(33) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户唯一标识来源于user表主键',
  `u_nickname` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的昵称',
  `u_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户性别',
  `u_phone` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户联系手机号码',
  `u_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户联系地址',
  `u_qq` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户QQ号',
  `u_wechat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户微信号',
  `u_headpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像路径',
  `u_signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户个性签名 ',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_infor
-- ----------------------------
INSERT INTO `user_infor` VALUES ('d500618bd4e4473a8abbcd53b6f29ece', '溶酶菌', '男', '13800138000', '广东广州', '358739303', 'rsmzjp', NULL, 'Hello World!');
INSERT INTO `user_infor` VALUES ('f01c3b8acd114a689e237564d925789b', '李同学', '女', '1380010086', '广东深圳', '365826073', 'zzimsu', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
