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

 Date: 05/07/2024 14:50:14
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
INSERT INTO `auth_code` VALUES (1, 'SMOTeam', 3);
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
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `categorie_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `categorie_desc` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is_hidden` int NULL DEFAULT NULL COMMENT '0:Active, 1:Hidden',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL COMMENT 'level reply comment',
  `reply_to` int NULL DEFAULT NULL COMMENT 'id comment',
  `media_id` int NULL DEFAULT NULL COMMENT 'id media',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_users_id`(`user_id` ASC) USING BTREE,
  INDEX `media_id_media_id`(`media_id` ASC) USING BTREE,
  CONSTRAINT `media_id_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_id_users_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'Đẹp quá <3', 1, '2024-07-05 00:14:35', '2024-07-05 00:14:38', 0, NULL, 19);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `url` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `media_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_media_id`(`media_id` ASC) USING BTREE,
  CONSTRAINT `id_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (28, '1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9-1024x1024.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9-1024x1024.png', 18, '2024-07-04 11:43:22');
INSERT INTO `image` VALUES (29, '1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9.png', 18, '2024-07-04 11:43:22');
INSERT INTO `image` VALUES (30, '1720093665678_tmp9ccg8cxu.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093665678_tmp9ccg8cxu.png', 19, '2024-07-04 11:47:51');
INSERT INTO `image` VALUES (31, '1720102350208_20231027172049-2595420240118160828.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720102350208_20231027172049-2595420240118160828.jpg', 20, '2024-07-04 14:12:31');

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `creator_id` int NULL DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` enum('Group','Ungroup') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Ungroup',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_hidden` int NOT NULL DEFAULT 0 COMMENT '0: Show, 1:Hidden',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  INDEX `creatorId_user_id`(`creator_id` ASC) USING BTREE,
  CONSTRAINT `creatorId_user_id` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media
-- ----------------------------
INSERT INTO `media` VALUES (18, 'Beautiful Moon', 'Beautiful-Moon-1720093401292', 1, 'Beautiful Moon, style 3D Render', 'Group', '2024-07-04 11:43:21', '2024-07-04 11:43:21', 0);
INSERT INTO `media` VALUES (19, 'Korean Girl', 'Korean-Girl-1720093671009', 1, 'Beautiful Girl, Korean, Asian', 'Ungroup', '2024-07-04 11:47:51', '2024-07-04 11:47:51', 0);
INSERT INTO `media` VALUES (20, 'Ly Van Tu Love', 'ly-van-tu-love', 1, 'My Love Of Yuki Dev <3 <3 <3', 'Ungroup', '2024-07-04 14:12:31', '2024-07-04 14:12:31', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` int NOT NULL DEFAULT 1,
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'avatar url',
  `age` int NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_ban` int NOT NULL DEFAULT 0 COMMENT '0: false, 1 : true',
  `refresh_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is_hidden` int NOT NULL DEFAULT 0 COMMENT '0: false, 1 : true',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_usertypes`(`type` ASC) USING BTREE,
  CONSTRAINT `type_usertypes` FOREIGN KEY (`type`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'usertest1', 'usertest1@gmail.com', 2, 'User Test', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 55, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 00:13:32', '2024-07-01 04:20:45', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MjAxNjU3NDI0NjYsImlhdCI6MTcyMDE2NTc0MiwiZXhwIjoxNzIyNzU3NzQyfQ.peA15okyHDxbZvIqJe_AJAQFgDCR0zk1HPDXc8W6FgU', 0);
INSERT INTO `user` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-06-21 18:34:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MTg5OTQ4NDAzMDcsImlhdCI6MTcxODk5NDg0MCwiZXhwIjoxNzIxNTg2ODQwfQ.otF3G3g0ZizZhu03JfBX0fs_TUFilRyGhHZOqXzPopk', 0);
INSERT INTO `user` VALUES (5, 'kieulinh123', 'ogyminecraft497@gmail.com', 1, 'dang haong thien an', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$ZRo1v7zFs95tEHvLLAj8..yQ6O1T2hUhra8004Im01Z0AcENGT3X.', '2024-06-22 13:56:19', '2024-06-22 13:56:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJraWV1bGluaDEyMyIsImtleSI6MTcxOTA2NDU3ODg1MywiaWF0IjoxNzE5MDY0NTc4LCJleHAiOjE3MjE2NTY1Nzh9.I-188-iXhqjtwimO2JcbuFOYEQPsms7J4BhEAPEjHk4', 0);
INSERT INTO `user` VALUES (6, 'lucadev222', 'lucan1@gmail.com', 1, 'nguyen phi phu ', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 9999, '$2b$10$7OMJSX2f252jc5ctJR000Ov9pJS2vX1nVFK.G52SKwTkbQwzUn7Hq', '2024-06-22 14:00:28', '2024-06-22 14:00:28', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwidXNlcm5hbWUiOiJsdWNhZGV2MjIyIiwia2V5IjoxNzE5MDY0ODI4NDQyLCJpYXQiOjE3MTkwNjQ4MjgsImV4cCI6MTcyMTY1NjgyOH0.4UaGAoE8qepwDo4K5WAL8af1Za964RPsFvjb-1W9TMI', 0);
INSERT INTO `user` VALUES (7, 'tieulig', 'asunayuki402@gmail.com', 1, 'dev yuki', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$iAZ7cSZ5wIwYC4W/xJQEVerPRXEfJEwZ8VDeAVdiRDwihi6wZ95Q.', '2024-06-22 14:04:24', '2024-06-22 14:04:24', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywidXNlcm5hbWUiOiJ0aWV1bGlnIiwia2V5IjoxNzE5MDY1MDY0MDAzLCJpYXQiOjE3MTkwNjUwNjQsImV4cCI6MTcyMTY1NzA2NH0.LQhmPS4vrvrxGizeFmYAsFnAEHxL5WzZ1V2vFfSsYFM', 0);
INSERT INTO `user` VALUES (8, 'devyuki123', 'dangthienphuc110312@gmail.com', 1, 'tieu lig', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5NDc2NzA1MDI5LCJpYXQiOjE3MTk0NzY3MDUsImV4cCI6MTcyMjA2ODcwNX0.sl1FCUplMUGovgtP2QMLqcx9ZquinauK6vuJLrTm3zk', 0);
INSERT INTO `user` VALUES (9, '1719656488817_devyuki1234', '1719656488817_adangthienphuc110312@gmail.com', 1, 'tieu lig', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5NDc2NzA1MDI5LCJpYXQiOjE3MTk0NzY3MDUsImV4cCI6MTcyMjA2ODcwNX0.sl1FCUplMUGovgtP2QMLqcx9ZquinauK6vuJLrTm3zk', 1);

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_type
-- ----------------------------
INSERT INTO `user_type` VALUES (1, 'User');
INSERT INTO `user_type` VALUES (2, 'Admin');

SET FOREIGN_KEY_CHECKS = 1;
