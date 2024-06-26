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

 Date: 27/06/2024 01:03:34
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
  `role` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_role_id`(`role` ASC) USING BTREE,
  CONSTRAINT `id_role_id` FOREIGN KEY (`role`) REFERENCES `auth_roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_code
-- ----------------------------
INSERT INTO `auth_code` VALUES (1, 'SMOTeam', 1);
INSERT INTO `auth_code` VALUES (2, 'PainDev', 3);

-- ----------------------------
-- Table structure for auth_roles
-- ----------------------------
DROP TABLE IF EXISTS `auth_roles`;
CREATE TABLE `auth_roles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `role_level` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_roles
-- ----------------------------
INSERT INTO `auth_roles` VALUES (1, 'User', 0);
INSERT INTO `auth_roles` VALUES (2, 'Manager', 1);
INSERT INTO `auth_roles` VALUES (3, 'Admin', 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'usertest1', 'usertest1@gmail.com', 1, 'User Test', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 00:13:32', '2024-06-23 07:19:13', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MTk0MTI1OTQ0NDksImlhdCI6MTcxOTQxMjU5NCwiZXhwIjoxNzIyMDA0NTk0fQ.JUVUoYHB-cixpajwIBnp5u-NCgepZlC5gosoQt4-FHE');
INSERT INTO `users` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-06-21 18:34:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MTg5OTQ4NDAzMDcsImlhdCI6MTcxODk5NDg0MCwiZXhwIjoxNzIxNTg2ODQwfQ.otF3G3g0ZizZhu03JfBX0fs_TUFilRyGhHZOqXzPopk');
INSERT INTO `users` VALUES (5, 'kieulinh123', 'ogyminecraft497@gmail.com', 1, 'dang haong thien an', 22, '$2b$10$ZRo1v7zFs95tEHvLLAj8..yQ6O1T2hUhra8004Im01Z0AcENGT3X.', '2024-06-22 13:56:19', '2024-06-22 13:56:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJraWV1bGluaDEyMyIsImtleSI6MTcxOTA2NDU3ODg1MywiaWF0IjoxNzE5MDY0NTc4LCJleHAiOjE3MjE2NTY1Nzh9.I-188-iXhqjtwimO2JcbuFOYEQPsms7J4BhEAPEjHk4');
INSERT INTO `users` VALUES (6, 'lucadev222', 'lucan1@gmail.com', 1, 'nguyen phi phu ', 9999, '$2b$10$7OMJSX2f252jc5ctJR000Ov9pJS2vX1nVFK.G52SKwTkbQwzUn7Hq', '2024-06-22 14:00:28', '2024-06-22 14:00:28', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwidXNlcm5hbWUiOiJsdWNhZGV2MjIyIiwia2V5IjoxNzE5MDY0ODI4NDQyLCJpYXQiOjE3MTkwNjQ4MjgsImV4cCI6MTcyMTY1NjgyOH0.4UaGAoE8qepwDo4K5WAL8af1Za964RPsFvjb-1W9TMI');
INSERT INTO `users` VALUES (7, 'tieulig', 'asunayuki402@gmail.com', 1, 'dev yuki', 5, '$2b$10$iAZ7cSZ5wIwYC4W/xJQEVerPRXEfJEwZ8VDeAVdiRDwihi6wZ95Q.', '2024-06-22 14:04:24', '2024-06-22 14:04:24', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywidXNlcm5hbWUiOiJ0aWV1bGlnIiwia2V5IjoxNzE5MDY1MDY0MDAzLCJpYXQiOjE3MTkwNjUwNjQsImV4cCI6MTcyMTY1NzA2NH0.LQhmPS4vrvrxGizeFmYAsFnAEHxL5WzZ1V2vFfSsYFM');
INSERT INTO `users` VALUES (8, 'devyuki123', 'dangthienphuc110312@gmail.com', 1, 'tieu lig', 5, '$2b$10$3TF.cUJDw3WHYjBrUQRQ.eMcp/dLdoQOUFsuJUNPNu2ZsUHIN0GfS', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5MDY1MjE0OTQyLCJpYXQiOjE3MTkwNjUyMTQsImV4cCI6MTcyMTY1NzIxNH0.B8Ds7WEW_cuFle_3Z0ZQPOdALZU-u-pHXmTVTjCw6kY');

SET FOREIGN_KEY_CHECKS = 1;
