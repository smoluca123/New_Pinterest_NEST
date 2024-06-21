/*
 Navicat Premium Data Transfer

 Source Server         : new_pinterest
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33-25)
 Source Host           : bl2va3nmsrbafisthiaa-mysql.services.clever-cloud.com:21694
 Source Schema         : bl2va3nmsrbafisthiaa

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33-25)
 File Encoding         : 65001

 Date: 22/06/2024 01:35:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_code
-- ----------------------------
DROP TABLE IF EXISTS `auth_code`;
CREATE TABLE `auth_code`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `auth_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_code
-- ----------------------------
INSERT INTO `auth_code` VALUES (1, 'SMOTeam');

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_type
-- ----------------------------
INSERT INTO `user_type` VALUES (1, 'User');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` int NOT NULL DEFAULT 1,
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_ban` int NOT NULL DEFAULT 0 COMMENT '0: false, 1 : true',
  `refresh_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_usertypes`(`type` ASC) USING BTREE,
  CONSTRAINT `type_usertypes` FOREIGN KEY (`type`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'usertest1', 'usertest1@gmail.com', 1, 'User Test', 22, '$2b$10$945c9wxwmx3okkaCfGbKGO4g6c656C1j55vaQXxMEm0oUTwdjlJ7e', '2024-06-22 00:13:32', '2024-06-22 00:13:35', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MTg5OTQ1MTgzMDgsImlhdCI6MTcxODk5NDUxOCwiZXhwIjoxNzIxNTg2NTE4fQ.Zrsc--xOLReEd41F7RtGzVb1Ba1kcA6o1dqeHoYkirU');
INSERT INTO `users` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-06-21 18:34:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MTg5OTQ4NDAzMDcsImlhdCI6MTcxODk5NDg0MCwiZXhwIjoxNzIxNTg2ODQwfQ.otF3G3g0ZizZhu03JfBX0fs_TUFilRyGhHZOqXzPopk');

SET FOREIGN_KEY_CHECKS = 1;
