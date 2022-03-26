/*
 Navicat Premium Data Transfer

 Source Server         : hex
 Source Server Type    : MySQL
 Source Server Version : 100515
 Source Host           : localhost:3306
 Source Schema         : dcoffee

 Target Server Type    : MySQL
 Target Server Version : 100515
 File Encoding         : 65001

 Date: 26/03/2022 16:19:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mst_employee
-- ----------------------------
DROP TABLE IF EXISTS `mst_employee`;
CREATE TABLE `mst_employee`  (
  `id_employee` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `surname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `salary` double(20, 2) NULL DEFAULT NULL,
  `total_sale` double(20, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_employee`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mst_employee
-- ----------------------------
INSERT INTO `mst_employee` VALUES (1, 'สุขใจ', 'ไทยเดิม', 'พนักงาน', 5000.00, 30000.00);
INSERT INTO `mst_employee` VALUES (2, 'มานี', 'รักถิ่นไทย', 'เจ้าของร้าน', 6000.00, 50000.00);
INSERT INTO `mst_employee` VALUES (3, 'hexademical', 'chaopron', 'เจ้าของร้าน', 8000.00, 1000000.00);
INSERT INTO `mst_employee` VALUES (5, 'Jakkrit', 'Chaopron', 'เจ้าของร้าน', 10000.00, 1000000.00);
INSERT INTO `mst_employee` VALUES (6, 'Jakkrit', 'Chaopron', 'เจ้าของร้าน', 10000.00, 1000000.00);

-- ----------------------------
-- Table structure for mst_security
-- ----------------------------
DROP TABLE IF EXISTS `mst_security`;
CREATE TABLE `mst_security`  (
  `id_security` int NOT NULL AUTO_INCREMENT,
  `user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_employee` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_security`) USING BTREE,
  INDEX `id_employee`(`id_employee` ASC) USING BTREE,
  CONSTRAINT `mst_security_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mst_security
-- ----------------------------
INSERT INTO `mst_security` VALUES (1, 'sutgai.t@gmail.com', 'qw123', 1);
INSERT INTO `mst_security` VALUES (2, 'manee.r@gmail.com', 'as123', 2);
INSERT INTO `mst_security` VALUES (3, 'hex@gmail.com', '123', 3);
INSERT INTO `mst_security` VALUES (5, 'hss@gmail.com', '525', 5);
INSERT INTO `mst_security` VALUES (6, 'grimjakkrit@gmail.com', 'asd', 6);

-- ----------------------------
-- Table structure for trn_login
-- ----------------------------
DROP TABLE IF EXISTS `trn_login`;
CREATE TABLE `trn_login`  (
  `id_login` int NOT NULL AUTO_INCREMENT,
  `datetime_login` datetime NULL DEFAULT NULL,
  `id_employee` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_login`) USING BTREE,
  INDEX `id_employee`(`id_employee` ASC) USING BTREE,
  CONSTRAINT `trn_login_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of trn_login
-- ----------------------------
INSERT INTO `trn_login` VALUES (1, '2021-02-03 08:08:11', 1);
INSERT INTO `trn_login` VALUES (2, '2021-02-03 12:08:11', 2);
INSERT INTO `trn_login` VALUES (3, '2021-02-04 08:08:11', 1);
INSERT INTO `trn_login` VALUES (4, '2021-02-04 08:08:11', 2);
INSERT INTO `trn_login` VALUES (5, '2021-02-05 08:08:11', 2);
INSERT INTO `trn_login` VALUES (6, '2021-02-06 08:08:11', 2);
INSERT INTO `trn_login` VALUES (7, '2022-03-11 15:26:45', 3);
INSERT INTO `trn_login` VALUES (8, '2022-03-11 16:02:58', 3);
INSERT INTO `trn_login` VALUES (9, '2022-03-11 16:12:24', 3);
INSERT INTO `trn_login` VALUES (10, '2022-03-11 16:12:27', 3);
INSERT INTO `trn_login` VALUES (11, '2022-03-11 16:12:30', 3);
INSERT INTO `trn_login` VALUES (12, '2022-03-11 16:24:53', 3);
INSERT INTO `trn_login` VALUES (13, '2022-03-11 16:24:57', 3);
INSERT INTO `trn_login` VALUES (14, '2022-03-11 16:27:32', 3);
INSERT INTO `trn_login` VALUES (15, '2022-03-11 16:28:29', 3);
INSERT INTO `trn_login` VALUES (16, '2022-03-11 16:28:44', 3);
INSERT INTO `trn_login` VALUES (17, '2022-03-11 16:31:32', 3);
INSERT INTO `trn_login` VALUES (18, '2022-03-11 16:34:55', 3);
INSERT INTO `trn_login` VALUES (19, '2022-03-11 16:36:57', 3);
INSERT INTO `trn_login` VALUES (20, '2022-03-11 16:36:58', 3);
INSERT INTO `trn_login` VALUES (21, '2022-03-11 16:37:07', 3);
INSERT INTO `trn_login` VALUES (22, '2022-03-11 16:37:07', 3);
INSERT INTO `trn_login` VALUES (23, '2022-03-11 16:37:36', 3);
INSERT INTO `trn_login` VALUES (24, '2022-03-11 16:37:36', 3);
INSERT INTO `trn_login` VALUES (25, '2022-03-11 16:37:54', 3);
INSERT INTO `trn_login` VALUES (26, '2022-03-11 16:37:54', 3);
INSERT INTO `trn_login` VALUES (27, '2022-03-11 16:38:07', 3);
INSERT INTO `trn_login` VALUES (28, '2022-03-11 16:38:07', 3);
INSERT INTO `trn_login` VALUES (29, '2022-03-11 16:38:43', 3);
INSERT INTO `trn_login` VALUES (30, '2022-03-11 16:38:43', 3);
INSERT INTO `trn_login` VALUES (31, '2022-03-11 16:41:00', 3);
INSERT INTO `trn_login` VALUES (32, '2022-03-11 16:43:26', 3);
INSERT INTO `trn_login` VALUES (33, '2022-03-14 22:57:44', 3);
INSERT INTO `trn_login` VALUES (34, '2022-03-14 23:08:01', 3);
INSERT INTO `trn_login` VALUES (35, '2022-03-14 23:08:25', 3);
INSERT INTO `trn_login` VALUES (36, '2022-03-14 23:09:27', 3);
INSERT INTO `trn_login` VALUES (37, '2022-03-14 23:10:05', 3);
INSERT INTO `trn_login` VALUES (38, '2022-03-14 23:10:09', 3);
INSERT INTO `trn_login` VALUES (39, '2022-03-14 23:10:12', 3);
INSERT INTO `trn_login` VALUES (40, '2022-03-14 23:16:08', 3);
INSERT INTO `trn_login` VALUES (41, '2022-03-14 23:16:10', 3);
INSERT INTO `trn_login` VALUES (42, '2022-03-14 23:16:12', 3);
INSERT INTO `trn_login` VALUES (43, '2022-03-14 23:17:46', 3);
INSERT INTO `trn_login` VALUES (44, '2022-03-14 23:17:48', 3);
INSERT INTO `trn_login` VALUES (45, '2022-03-14 23:17:53', 3);
INSERT INTO `trn_login` VALUES (46, '2022-03-14 23:17:58', 3);
INSERT INTO `trn_login` VALUES (47, '2022-03-14 23:25:02', 3);
INSERT INTO `trn_login` VALUES (48, '2022-03-14 23:25:03', 3);
INSERT INTO `trn_login` VALUES (49, '2022-03-14 23:25:11', 3);
INSERT INTO `trn_login` VALUES (50, '2022-03-14 23:25:11', 3);
INSERT INTO `trn_login` VALUES (51, '2022-03-14 23:25:12', 3);
INSERT INTO `trn_login` VALUES (52, '2022-03-14 23:25:12', 3);
INSERT INTO `trn_login` VALUES (53, '2022-03-14 23:25:26', 3);
INSERT INTO `trn_login` VALUES (54, '2022-03-14 23:25:43', 3);
INSERT INTO `trn_login` VALUES (55, '2022-03-14 23:26:27', 3);
INSERT INTO `trn_login` VALUES (56, '2022-03-14 23:27:39', 3);
INSERT INTO `trn_login` VALUES (57, '2022-03-14 23:28:23', 3);
INSERT INTO `trn_login` VALUES (58, '2022-03-14 23:29:04', 3);
INSERT INTO `trn_login` VALUES (59, '2022-03-14 23:29:57', 3);
INSERT INTO `trn_login` VALUES (60, '2022-03-14 23:30:54', 3);
INSERT INTO `trn_login` VALUES (61, '2022-03-14 23:30:56', 3);
INSERT INTO `trn_login` VALUES (62, '2022-03-14 23:31:06', 3);
INSERT INTO `trn_login` VALUES (63, '2022-03-14 23:36:36', 3);
INSERT INTO `trn_login` VALUES (64, '2022-03-14 23:49:23', 3);
INSERT INTO `trn_login` VALUES (65, '2022-03-14 23:51:25', 3);
INSERT INTO `trn_login` VALUES (66, '2022-03-14 23:52:48', 3);
INSERT INTO `trn_login` VALUES (67, '2022-03-14 23:53:49', 3);
INSERT INTO `trn_login` VALUES (68, '2022-03-14 23:54:41', 3);
INSERT INTO `trn_login` VALUES (69, '2022-03-15 00:04:42', 3);
INSERT INTO `trn_login` VALUES (70, '2022-03-15 00:05:36', 3);
INSERT INTO `trn_login` VALUES (71, '2022-03-15 00:06:16', 3);
INSERT INTO `trn_login` VALUES (72, '2022-03-15 00:07:22', 3);
INSERT INTO `trn_login` VALUES (73, '2022-03-15 00:08:20', 3);
INSERT INTO `trn_login` VALUES (74, '2022-03-15 00:11:23', 3);
INSERT INTO `trn_login` VALUES (75, '2022-03-15 00:12:22', 3);
INSERT INTO `trn_login` VALUES (76, '2022-03-15 00:12:53', 3);
INSERT INTO `trn_login` VALUES (77, '2022-03-15 00:13:23', 3);
INSERT INTO `trn_login` VALUES (78, '2022-03-15 00:14:07', 3);
INSERT INTO `trn_login` VALUES (79, '2022-03-15 00:14:14', 3);
INSERT INTO `trn_login` VALUES (80, '2022-03-15 00:16:01', 3);
INSERT INTO `trn_login` VALUES (81, '2022-03-15 00:16:52', 3);
INSERT INTO `trn_login` VALUES (82, '2022-03-15 00:17:21', 3);
INSERT INTO `trn_login` VALUES (83, '2022-03-15 00:18:53', 3);
INSERT INTO `trn_login` VALUES (84, '2022-03-15 00:19:39', 3);
INSERT INTO `trn_login` VALUES (85, '2022-03-15 00:23:36', 3);
INSERT INTO `trn_login` VALUES (86, '2022-03-15 00:24:25', 3);
INSERT INTO `trn_login` VALUES (87, '2022-03-15 00:24:30', 3);
INSERT INTO `trn_login` VALUES (88, '2022-03-15 00:25:33', 3);
INSERT INTO `trn_login` VALUES (89, '2022-03-15 00:26:06', 3);
INSERT INTO `trn_login` VALUES (90, '2022-03-15 00:27:25', 3);
INSERT INTO `trn_login` VALUES (91, '2022-03-15 00:28:47', 3);
INSERT INTO `trn_login` VALUES (92, '2022-03-15 00:30:16', 3);
INSERT INTO `trn_login` VALUES (93, '2022-03-15 00:31:45', 3);
INSERT INTO `trn_login` VALUES (94, '2022-03-15 00:33:07', 3);

-- ----------------------------
-- Table structure for trn_logout
-- ----------------------------
DROP TABLE IF EXISTS `trn_logout`;
CREATE TABLE `trn_logout`  (
  `id_logout` int NOT NULL AUTO_INCREMENT,
  `datetime_logout` datetime NULL DEFAULT NULL,
  `id_employee` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_logout`) USING BTREE,
  INDEX `id_employee`(`id_employee` ASC) USING BTREE,
  CONSTRAINT `trn_logout_ibfk_1` FOREIGN KEY (`id_employee`) REFERENCES `mst_employee` (`id_employee`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of trn_logout
-- ----------------------------
INSERT INTO `trn_logout` VALUES (1, '2021-02-03 16:08:11', 1);
INSERT INTO `trn_logout` VALUES (2, '2021-02-03 18:08:11', 2);
INSERT INTO `trn_logout` VALUES (3, '2021-02-04 16:08:11', 1);
INSERT INTO `trn_logout` VALUES (4, '2021-02-04 12:08:11', 2);
INSERT INTO `trn_logout` VALUES (5, '2021-02-05 16:08:11', 2);
INSERT INTO `trn_logout` VALUES (6, '2021-02-06 12:08:11', 2);
INSERT INTO `trn_logout` VALUES (7, '2022-03-11 15:26:54', 3);
INSERT INTO `trn_logout` VALUES (8, '2022-03-11 16:12:25', 3);
INSERT INTO `trn_logout` VALUES (9, '2022-03-11 16:12:28', 3);
INSERT INTO `trn_logout` VALUES (10, '2022-03-11 16:12:32', 3);
INSERT INTO `trn_logout` VALUES (11, '2022-03-11 16:24:55', 3);
INSERT INTO `trn_logout` VALUES (12, '2022-03-11 16:27:33', 3);
INSERT INTO `trn_logout` VALUES (13, '2022-03-11 16:28:47', 3);
INSERT INTO `trn_logout` VALUES (14, '2022-03-11 16:31:34', 3);
INSERT INTO `trn_logout` VALUES (15, '2022-03-11 16:37:01', 3);
INSERT INTO `trn_logout` VALUES (16, '2022-03-11 16:38:12', 3);
INSERT INTO `trn_logout` VALUES (17, '2022-03-11 16:38:45', 3);
INSERT INTO `trn_logout` VALUES (18, '2022-03-11 16:41:04', 3);
INSERT INTO `trn_logout` VALUES (19, '2022-03-11 16:43:28', 3);
INSERT INTO `trn_logout` VALUES (20, '2022-03-14 23:08:26', 3);
INSERT INTO `trn_logout` VALUES (21, '2022-03-14 23:09:28', 3);
INSERT INTO `trn_logout` VALUES (22, '2022-03-14 23:10:07', 3);
INSERT INTO `trn_logout` VALUES (23, '2022-03-14 23:16:12', 3);
INSERT INTO `trn_logout` VALUES (24, '2022-03-14 23:17:49', 3);
INSERT INTO `trn_logout` VALUES (25, '2022-03-14 23:17:54', 3);
INSERT INTO `trn_logout` VALUES (26, '2022-03-15 00:30:13', 3);
INSERT INTO `trn_logout` VALUES (27, '2022-03-15 00:33:40', 3);

SET FOREIGN_KEY_CHECKS = 1;
