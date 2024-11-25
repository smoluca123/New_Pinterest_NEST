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

 Date: 25/11/2024 16:51:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for active_code
-- ----------------------------
DROP TABLE IF EXISTS `active_code`;
CREATE TABLE `active_code`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'User ID',
  `code` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of active_code
-- ----------------------------
INSERT INTO `active_code` VALUES (19, 68, '434A95', '2024-09-11 13:54:25', '2024-09-11 13:44:25');
INSERT INTO `active_code` VALUES (20, 69, 'EBE415', '2024-09-12 04:10:12', '2024-09-12 04:00:12');
INSERT INTO `active_code` VALUES (21, 70, 'C18E0B', '2024-09-12 07:24:03', '2024-09-12 07:14:03');
INSERT INTO `active_code` VALUES (22, 71, 'F16381', '2024-09-12 08:11:01', '2024-09-12 08:01:01');
INSERT INTO `active_code` VALUES (23, 4, 'D66583', '2024-09-12 15:31:06', '2024-09-12 15:21:06');
INSERT INTO `active_code` VALUES (27, 72, 'D3D1B5', '2024-09-14 07:07:45', '2024-09-14 06:57:45');
INSERT INTO `active_code` VALUES (28, 73, 'F8AE30', '2024-09-17 17:27:13', '2024-09-17 17:17:13');
INSERT INTO `active_code` VALUES (29, 74, 'A2E05E', '2024-09-18 15:28:20', '2024-09-18 15:18:20');
INSERT INTO `active_code` VALUES (38, 77, '44020E', '2024-09-20 09:03:43', '2024-09-20 08:53:43');
INSERT INTO `active_code` VALUES (40, 8, '2ADC57', '2024-09-25 13:44:31', '2024-09-25 13:34:31');
INSERT INTO `active_code` VALUES (41, 79, 'EB72D6', '2024-09-26 14:26:01', '2024-09-26 14:16:01');
INSERT INTO `active_code` VALUES (45, 80, '586D02', '2024-11-20 06:59:14', '2024-11-20 06:49:14');
INSERT INTO `active_code` VALUES (46, 81, 'A971DA', '2024-11-20 07:09:16', '2024-11-20 06:59:16');
INSERT INTO `active_code` VALUES (47, 82, '9B2577', '2024-11-20 07:37:20', '2024-11-20 07:27:20');
INSERT INTO `active_code` VALUES (49, 6, '63974C', '2024-11-20 08:42:29', '2024-11-20 08:32:29');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_code
-- ----------------------------
INSERT INTO `auth_code` VALUES (2, 'Paindev', 3);
INSERT INTO `auth_code` VALUES (3, 'SMOTeam', 3);

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
  `replies` int NOT NULL DEFAULT 0 COMMENT 'replies count',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_users_id`(`user_id` ASC) USING BTREE,
  INDEX `media_id_media_id`(`media_id` ASC) USING BTREE,
  INDEX `replyto_comment_id`(`reply_to` ASC) USING BTREE,
  CONSTRAINT `media_id_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `replyto_comment_id` FOREIGN KEY (`reply_to`) REFERENCES `comment` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `user_id_users_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 456 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'Đẹp quá <3', 1, '2024-07-05 00:14:35', '2024-07-05 00:14:38', 0, NULL, 19, 1);
INSERT INTO `comment` VALUES (6, 'Đẹp dữ chờiiiii', 4, '2024-07-05 08:01:52', '2024-07-05 08:01:52', 0, NULL, 18, 24);
INSERT INTO `comment` VALUES (11, 'ừ, công nhận!', 4, '2024-07-05 08:05:16', '2024-07-05 08:05:16', 1, 1, 19, 0);
INSERT INTO `comment` VALUES (13, 'đóm cute phô mai que nạp 5 tỷ rolll đóm', 12, '2024-07-11 04:25:17', '2024-07-11 04:25:17', 0, NULL, 27, 0);
INSERT INTO `comment` VALUES (14, 'vân tư   mãi đỉnh :)) qua tàu lấy vân tư', 12, '2024-07-11 04:27:12', '2024-07-11 04:27:12', 0, NULL, 20, 1);
INSERT INTO `comment` VALUES (15, 'thấy cx đẹp :)) yêu luôn', 8, '2024-07-11 04:29:09', '2024-07-11 04:29:09', 0, NULL, 20, 1);
INSERT INTO `comment` VALUES (17, 'cx đẹp :((', 8, '2024-07-11 04:40:38', '2024-07-11 04:40:38', 0, NULL, 24, 0);
INSERT INTO `comment` VALUES (18, 'lỗi j', 8, '2024-07-11 04:41:43', '2024-07-11 04:41:43', 0, NULL, 24, 0);
INSERT INTO `comment` VALUES (19, 'trông lơi lỏ tý mà thôi kẹ ', 8, '2024-07-11 04:44:11', '2024-07-11 04:44:11', 0, NULL, 23, 0);
INSERT INTO `comment` VALUES (23, 'luca tesst 11111', 8, '2024-07-11 05:56:46', '2024-07-11 05:56:46', 0, NULL, 27, 0);
INSERT INTO `comment` VALUES (30, 'spidermannn', 8, '2024-07-11 06:03:41', '2024-07-11 06:03:41', 0, NULL, 20, 0);
INSERT INTO `comment` VALUES (32, 'tacs giair beenhj hoanj vcl', 8, '2024-07-11 10:17:03', '2024-07-11 10:17:03', 0, NULL, 25, 0);
INSERT INTO `comment` VALUES (33, 'tacs giar beenhj hoanj vcl', 8, '2024-07-11 10:17:51', '2024-07-11 10:17:51', 0, NULL, 25, 0);
INSERT INTO `comment` VALUES (34, 'tác giải bệnh hoạn vcl  sao có thể viết ra truyện ma nhỉ', 8, '2024-07-11 10:18:24', '2024-07-11 10:18:24', 0, NULL, 25, 0);
INSERT INTO `comment` VALUES (36, 'sếp thắng cute', 8, '2024-07-11 10:43:15', '2024-07-11 10:43:15', 0, NULL, 25, 0);
INSERT INTO `comment` VALUES (37, 'sếp thắng cute 001', 8, '2024-07-11 10:47:05', '2024-07-11 10:47:05', 0, NULL, 25, 0);
INSERT INTO `comment` VALUES (39, '111', 8, '2024-07-11 11:15:07', '2024-07-11 11:15:07', 0, NULL, 27, 0);
INSERT INTO `comment` VALUES (42, 'tha', 8, '2024-07-12 02:41:25', '2024-07-12 02:41:25', 0, NULL, 20, 0);
INSERT INTO `comment` VALUES (44, 'ảo thạt', 8, '2024-07-12 02:48:28', '2024-07-12 02:48:28', 0, NULL, 19, 0);
INSERT INTO `comment` VALUES (45, 'chịu :))', 8, '2024-07-12 02:56:22', '2024-07-12 02:56:22', 0, NULL, 23, 0);
INSERT INTO `comment` VALUES (46, 'thua', 8, '2024-07-12 02:57:03', '2024-07-12 02:57:03', 0, NULL, 23, 0);
INSERT INTO `comment` VALUES (53, 'sao trong nó lại như thế này :))', 8, '2024-07-12 06:40:53', '2024-07-12 06:40:53', 0, NULL, 19, 1);
INSERT INTO `comment` VALUES (54, 'm hỏi t t hỏi ai tr', 8, '2024-07-12 06:41:08', '2024-07-12 06:41:08', 1, 53, 19, 0);
INSERT INTO `comment` VALUES (55, 'trông cute', 8, '2024-07-12 06:45:26', '2024-07-12 06:45:26', 0, NULL, 26, 2);
INSERT INTO `comment` VALUES (56, 'um cx dep', 8, '2024-07-12 06:47:24', '2024-07-12 06:47:24', 1, 55, 26, 0);
INSERT INTO `comment` VALUES (58, 'vis duj cmtttttt', 8, '2024-07-12 07:13:32', '2024-07-12 07:13:32', 1, 14, 20, 0);
INSERT INTO `comment` VALUES (59, ' khẻ thôi bạn :(( fulltack đấy', 8, '2024-07-12 07:14:11', '2024-07-12 07:14:11', 1, NULL, 22, 0);
INSERT INTO `comment` VALUES (60, 'dev 10  năm kinh nghiệm làm fullsstack 3 hôm', 8, '2024-07-12 07:15:37', '2024-07-12 07:15:37', 1, NULL, 22, 0);
INSERT INTO `comment` VALUES (62, 'anh furrina có dạy react không nhỉ', 8, '2024-07-12 08:38:19', '2024-07-12 08:38:19', 0, NULL, 22, 1);
INSERT INTO `comment` VALUES (63, 'ai mà biết đc nghe ns ổng đấy đi làm 5 năm gì đấy code ác lắm', 8, '2024-07-12 08:39:42', '2024-07-12 08:39:42', 1, 62, 22, 0);
INSERT INTO `comment` VALUES (64, 'dẹt sơ', 8, '2024-07-12 09:35:42', '2024-07-12 09:35:42', 0, NULL, 19, 0);
INSERT INTO `comment` VALUES (68, 'biết ông Lu không ?', 8, '2024-07-12 15:06:40', '2024-07-12 15:06:40', 0, NULL, 22, 0);
INSERT INTO `comment` VALUES (69, 'detj sow', 8, '2024-07-12 15:21:46', '2024-07-12 15:21:46', 1, 15, 20, 0);
INSERT INTO `comment` VALUES (70, 'đăng xàm vcl xoá mẹ đi', 8, '2024-07-13 05:42:34', '2024-07-13 05:42:34', 0, NULL, 30, 0);
INSERT INTO `comment` VALUES (73, 'đẹp z sếp :))', 12, '2024-07-14 12:48:53', '2024-07-14 12:48:53', 0, NULL, 31, 0);
INSERT INTO `comment` VALUES (74, 'bơ Hà Nội 60k 1 kg ', 8, '2024-07-15 05:49:48', '2024-07-15 05:49:48', 0, NULL, 32, 2);
INSERT INTO `comment` VALUES (75, 'có ship không bạn', 13, '2024-07-15 05:51:37', '2024-07-15 05:51:37', 1, 74, 32, 0);
INSERT INTO `comment` VALUES (76, 'lên playduo tạo đơn giúp mình nah', 8, '2024-07-15 05:52:47', '2024-07-15 05:52:47', 1, 74, 32, 0);
INSERT INTO `comment` VALUES (85, ' tin jaun', 8, '2024-07-15 07:35:00', '2024-07-15 07:35:00', 1, 6, 18, 2);
INSERT INTO `comment` VALUES (86, 'tin juan chua  admin', 8, '2024-07-15 13:16:36', '2024-07-15 13:16:36', 0, NULL, 34, 0);
INSERT INTO `comment` VALUES (87, 'vcl', 16, '2024-07-16 00:49:10', '2024-07-16 00:49:10', 0, NULL, 22, 0);
INSERT INTO `comment` VALUES (89, 'test 2', 16, '2024-07-16 01:11:33', '2024-07-16 01:11:33', 0, NULL, 42, 1);
INSERT INTO `comment` VALUES (90, 'cmar ơn bạn   ạ ', 13, '2024-07-16 01:20:19', '2024-07-16 01:20:19', 1, 89, 42, 0);
INSERT INTO `comment` VALUES (91, 'dẹt sơ', 13, '2024-07-16 01:20:57', '2024-07-16 01:20:57', 0, NULL, 41, 0);
INSERT INTO `comment` VALUES (92, 'lỏ ơi là lỏ', 13, '2024-07-16 12:17:27', '2024-07-16 12:17:27', 0, NULL, 43, 1);
INSERT INTO `comment` VALUES (93, 'ok', 13, '2024-07-16 14:31:01', '2024-07-16 14:31:01', 1, 92, 43, 0);
INSERT INTO `comment` VALUES (94, '/ với chúng tôi :)))', 13, '2024-07-17 06:34:10', '2024-07-17 06:34:10', 0, NULL, 44, 0);
INSERT INTO `comment` VALUES (95, 'bỏ mẹ r sai chính tả r', 13, '2024-07-17 15:03:15', '2024-07-17 15:03:15', 0, NULL, 45, 0);
INSERT INTO `comment` VALUES (98, 'hmm...', 1, '2024-08-04 11:42:44', '2024-08-04 11:42:44', 1, 55, 26, 0);
INSERT INTO `comment` VALUES (99, 'bé yuki đang simp cái lap hơn cả lig', 13, '2024-08-05 06:09:37', '2024-08-05 06:09:37', 0, NULL, 47, 0);
INSERT INTO `comment` VALUES (265, 'tesst htu cxem khong replay ', 13, '2024-08-22 06:30:36', '2024-08-22 06:30:36', 0, NULL, 42, 0);
INSERT INTO `comment` VALUES (288, 'yuki1', 13, '2024-08-24 05:23:34', '2024-08-24 05:23:34', 0, NULL, 34, 0);
INSERT INTO `comment` VALUES (289, 'yuki2', 13, '2024-08-24 05:24:37', '2024-08-24 05:24:37', 0, NULL, 34, 1);
INSERT INTO `comment` VALUES (296, 'wow', 13, '2024-08-24 06:22:07', '2024-08-24 06:22:07', 0, NULL, 28, 0);
INSERT INTO `comment` VALUES (297, 'ua alo', 13, '2024-08-24 06:22:21', '2024-08-24 06:22:21', 0, NULL, 28, 0);
INSERT INTO `comment` VALUES (299, 'i love sếp thắng', 8, '2024-08-24 06:26:07', '2024-08-24 06:26:07', 0, NULL, 41, 1);
INSERT INTO `comment` VALUES (300, 'trông cứ sao sao ấy', 13, '2024-08-24 06:28:23', '2024-08-24 06:28:23', 0, NULL, 21, 1);
INSERT INTO `comment` VALUES (301, 'cx đúng', 13, '2024-08-24 06:28:30', '2024-08-24 06:28:30', 1, 300, 21, 0);
INSERT INTO `comment` VALUES (326, ' cute', 13, '2024-08-31 09:08:01', '2024-08-31 09:08:01', 0, NULL, 40, 0);
INSERT INTO `comment` VALUES (327, 'hay quá bạn', 13, '2024-09-03 03:12:45', '2024-09-03 03:12:45', 0, NULL, 36, 1);
INSERT INTO `comment` VALUES (328, 'ok mình cảm ơn bạn nhều nha', 13, '2024-09-03 03:17:53', '2024-09-03 03:17:53', 1, 327, 36, 0);
INSERT INTO `comment` VALUES (329, 'hàm map thần kỳ ghê á', 13, '2024-09-03 03:22:14', '2024-09-03 03:22:14', 0, NULL, 36, 1);
INSERT INTO `comment` VALUES (330, 'dạ đong', 13, '2024-09-03 03:30:19', '2024-09-03 03:30:19', 1, 329, 36, 0);
INSERT INTO `comment` VALUES (331, 'cảm ơn cacs bnaj', 13, '2024-09-03 03:30:33', '2024-09-03 03:30:33', 0, NULL, 36, 0);
INSERT INTO `comment` VALUES (333, 'bạn còn onl không ạ', 13, '2024-09-03 03:36:23', '2024-09-03 03:36:23', 1, NULL, 51, 0);
INSERT INTO `comment` VALUES (334, 'banj nayf raats laf cute as moij ng', 13, '2024-09-03 03:39:03', '2024-09-03 03:39:03', 0, NULL, 51, 0);
INSERT INTO `comment` VALUES (335, 'học code   tỷ lệ 96.69% có việc tại : https://www.facebook.com/LucaNN.Info', 13, '2024-09-03 03:43:34', '2024-09-03 03:43:34', 0, NULL, 52, 2);
INSERT INTO `comment` VALUES (336, 'tin chuẩn  không bạn', 13, '2024-09-03 03:44:03', '2024-09-03 03:44:03', 1, 335, 52, 0);
INSERT INTO `comment` VALUES (337, 'hình đẹp á', 13, '2024-09-03 04:02:11', '2024-09-03 04:02:11', 0, NULL, 21, 0);
INSERT INTO `comment` VALUES (338, 'đẹp ghê', 13, '2024-09-03 04:03:03', '2024-09-03 04:03:03', 0, NULL, 21, 0);
INSERT INTO `comment` VALUES (339, 'hình này xinh á', 13, '2024-09-03 04:05:31', '2024-09-03 04:05:31', 0, NULL, 21, 0);
INSERT INTO `comment` VALUES (340, ' z hong yêu bé zuki nữa à :(( ', 13, '2024-09-03 04:09:17', '2024-09-03 04:09:17', 1, 299, 41, 0);
INSERT INTO `comment` VALUES (341, 'chuẩn chưa', 8, '2024-09-03 04:15:29', '2024-09-03 04:15:29', 0, NULL, 52, 1);
INSERT INTO `comment` VALUES (342, 'chuaanr as banja', 13, '2024-09-03 04:36:22', '2024-09-03 04:36:22', 1, 335, 52, 0);
INSERT INTO `comment` VALUES (343, ' chwa chuaanr hocj furina moiws chuarn', 13, '2024-09-03 04:39:11', '2024-09-03 04:39:11', 1, 341, 52, 1);
INSERT INTO `comment` VALUES (344, '  cx đúng', 13, '2024-09-03 04:39:27', '2024-09-03 04:39:27', 2, 343, 52, 0);
INSERT INTO `comment` VALUES (349, 'mọi người like cho mình nha', 40, '2024-09-03 07:04:09', '2024-09-03 07:04:09', 0, NULL, 53, 1);
INSERT INTO `comment` VALUES (350, ' ok bạn', 40, '2024-09-03 07:04:20', '2024-09-03 07:04:20', 1, 349, 53, 0);
INSERT INTO `comment` VALUES (351, ' bạn này xinh quá', 13, '2024-09-03 07:06:15', '2024-09-03 07:06:15', 0, NULL, 51, 0);
INSERT INTO `comment` VALUES (354, '60 rolll vẫn lệch', 8, '2024-09-04 05:48:05', '2024-09-04 05:48:05', 0, NULL, 27, 0);
INSERT INTO `comment` VALUES (360, 'lâu r không chơi lại game ? hsr giờ có gì mới không tác giả', 13, '2024-09-20 09:20:18', '2024-09-20 09:20:18', 0, NULL, 27, 0);
INSERT INTO `comment` VALUES (377, 'dep phet', 66, '2024-10-09 15:40:51', '2024-10-09 15:40:51', 0, NULL, 20, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (28, '1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9-1024x1024.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9-1024x1024.png', 18, '2024-07-04 11:43:22');
INSERT INTO `image` VALUES (29, '1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093383729_SMO_Luca_earth_moon_realism_3D_CGI_volumetric_light_render_unr_33c7c6de-6b42-44fd-8848-63822d7003a9.png', 18, '2024-07-04 11:43:22');
INSERT INTO `image` VALUES (30, '1720093665678_tmp9ccg8cxu.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720093665678_tmp9ccg8cxu.png', 19, '2024-07-04 11:47:51');
INSERT INTO `image` VALUES (31, '1720102350208_20231027172049-2595420240118160828.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720102350208_20231027172049-2595420240118160828.jpg', 20, '2024-07-04 14:12:31');
INSERT INTO `image` VALUES (32, '1720250492520_DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720250492520_DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 21, '2024-07-06 07:21:42');
INSERT INTO `image` VALUES (33, '1720250492520_DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_3.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720250492520_DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_3.jpg', 21, '2024-07-06 07:21:42');
INSERT INTO `image` VALUES (34, '1720346945259_218abc1cae3da896bda388ba1abc50f1.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720346945259_218abc1cae3da896bda388ba1abc50f1.jpg', 22, '2024-07-07 10:09:07');
INSERT INTO `image` VALUES (35, '1720347060655_aaf84319a0bc2c76dc8a50593f5a2288.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720347060655_aaf84319a0bc2c76dc8a50593f5a2288.jpg', 23, '2024-07-07 10:11:02');
INSERT INTO `image` VALUES (36, '1720347250836_e919fc5933496556e8ba21e29cefe2ae.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720347250836_e919fc5933496556e8ba21e29cefe2ae.jpg', 24, '2024-07-07 10:14:12');
INSERT INTO `image` VALUES (37, '1720347250836_03fcfc2ea0449428feff2d07d822f4b6.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720347250836_03fcfc2ea0449428feff2d07d822f4b6.jpg', 24, '2024-07-07 10:14:12');
INSERT INTO `image` VALUES (38, '1720347250836_2b79af21c557a7100c7453d0a4ac35b3.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720347250836_2b79af21c557a7100c7453d0a4ac35b3.jpg', 24, '2024-07-07 10:14:12');
INSERT INTO `image` VALUES (39, '1720347444884_450063425_1149363602990767_6686580160152733454_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720347444884_450063425_1149363602990767_6686580160152733454_n.jpg', 25, '2024-07-07 10:17:27');
INSERT INTO `image` VALUES (40, '1720350317357_5babcad842cc5c2f087c42d5fdca5836.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720350317357_5babcad842cc5c2f087c42d5fdca5836.jpg', 26, '2024-07-07 11:05:19');
INSERT INTO `image` VALUES (41, '1720432238616_4993efdcdee782df7e24ff7ac0b6cf41.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720432238616_4993efdcdee782df7e24ff7ac0b6cf41.jpg', 27, '2024-07-08 09:50:40');
INSERT INTO `image` VALUES (42, '1720695841746_450424311_1151113109482483_5269449298290679435_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720695841746_450424311_1151113109482483_5269449298290679435_n.jpg', 28, '2024-07-11 11:04:03');
INSERT INTO `image` VALUES (43, '1720695841747_450094875_1151078319485962_1598635678090921194_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720695841747_450094875_1151078319485962_1598635678090921194_n.jpg', 28, '2024-07-11 11:04:03');
INSERT INTO `image` VALUES (44, '1720695841747_449459709_1145036493423478_478577091240090309_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720695841747_449459709_1145036493423478_478577091240090309_n.jpg', 28, '2024-07-11 11:04:03');
INSERT INTO `image` VALUES (45, '1720695841748_448901036_1141457330448061_6620835617020543838_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720695841748_448901036_1141457330448061_6620835617020543838_n.jpg', 28, '2024-07-11 11:04:03');
INSERT INTO `image` VALUES (46, '1720695841748_448304666_1136944160899378_8203226100984494783_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720695841748_448304666_1136944160899378_8203226100984494783_n.jpg', 28, '2024-07-11 11:04:03');
INSERT INTO `image` VALUES (47, '1720849315740_vn-11134207-7r98o-lsi1r7af46h02c.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720849315740_vn-11134207-7r98o-lsi1r7af46h02c.jpg', 30, '2024-07-13 05:41:57');
INSERT INTO `image` VALUES (48, '1720960236107_f48fda044639e9bdb071dc90a991baeb.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1720960236107_f48fda044639e9bdb071dc90a991baeb.jpg', 31, '2024-07-14 12:30:37');
INSERT INTO `image` VALUES (49, '1721022527066_linhggg.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721022527066_linhggg.png', 32, '2024-07-15 05:48:48');
INSERT INTO `image` VALUES (50, '1721023005885_433439081_1132268427959569_6984999506338997221_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721023005885_433439081_1132268427959569_6984999506338997221_n.jpg', 33, '2024-07-15 05:56:47');
INSERT INTO `image` VALUES (51, '1721048881882_0848f9fa5490f6c5d99ab3b360f3ecc1.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721048881882_0848f9fa5490f6c5d99ab3b360f3ecc1.jpg', 34, '2024-07-15 13:08:03');
INSERT INTO `image` VALUES (52, '1721051138611_433439081_1132268427959569_6984999506338997221_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721051138611_433439081_1132268427959569_6984999506338997221_n.jpg', 35, '2024-07-15 13:45:40');
INSERT INTO `image` VALUES (53, '1721054032671_GIOE71XWcAAu46J.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721054032671_GIOE71XWcAAu46J.jpg', 36, '2024-07-15 14:33:54');
INSERT INTO `image` VALUES (54, '1721054392257_linhggg.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721054392257_linhggg.png', 37, '2024-07-15 14:39:54');
INSERT INTO `image` VALUES (55, '1721054735330_364151933_821830585990876_3990029536718715454_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721054735330_364151933_821830585990876_3990029536718715454_n.jpg', 38, '2024-07-15 14:45:37');
INSERT INTO `image` VALUES (56, '1721055459500_image_background_screenshot_for_stack.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721055459500_image_background_screenshot_for_stack.jpg', 39, '2024-07-15 14:57:40');
INSERT INTO `image` VALUES (57, '1721056132708_367391857_1535284143948302_6142094902777987956_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721056132708_367391857_1535284143948302_6142094902777987956_n.jpg', 40, '2024-07-15 15:08:54');
INSERT INTO `image` VALUES (58, '1721080389438_code-icon-design-vector-png_125856.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/mamun25g220712535.png', 41, '2024-07-15 21:53:10');
INSERT INTO `image` VALUES (59, '1721080389438_smo-letter-logo-design-on-black-background-vector-41106740.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/mamun25g220712535.png', 41, '2024-07-15 21:53:10');
INSERT INTO `image` VALUES (60, '1721092248571_quest-mountain-hero.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721092248571_quest-mountain-hero.png', 42, '2024-07-16 01:10:50');
INSERT INTO `image` VALUES (61, '1721092910916_357346897_6449069211837594_529973375358662294_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721092910916_357346897_6449069211837594_529973375358662294_n.jpg', 43, '2024-07-16 01:21:52');
INSERT INTO `image` VALUES (62, '1721095293252_Wikipe-tan_cropped.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721095293252_Wikipe-tan_cropped.png', 44, '2024-07-16 02:01:35');
INSERT INTO `image` VALUES (63, '1721228560979_linhggg.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721228560979_linhggg.png', 45, '2024-07-17 15:02:43');
INSERT INTO `image` VALUES (64, '1721315469173_wallpaperflare.com_wallpaper.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721315469173_wallpaperflare.com_wallpaper.jpg', 46, '2024-07-18 15:11:11');
INSERT INTO `image` VALUES (65, '1722751403704_img6863-1189.jpeg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1722751403704_img6863-1189.jpeg', 47, '2024-08-04 06:03:25');
INSERT INTO `image` VALUES (66, '1722838287572_481838ec7cb63aeba25447d7f67ac8ef.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1722838287572_481838ec7cb63aeba25447d7f67ac8ef.jpg', 48, '2024-08-05 06:11:29');
INSERT INTO `image` VALUES (67, '1723191787736_450094875_1151078319485962_1598635678090921194_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1723191787736_450094875_1151078319485962_1598635678090921194_n.jpg', 49, '2024-08-09 08:23:09');
INSERT INTO `image` VALUES (68, '1724313015862_Screenshot2023-07-06100957.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1724313015862_Screenshot2023-07-06100957.png', 50, '2024-08-22 07:50:17');
INSERT INTO `image` VALUES (69, '1725334390666_456785134_929908069283378_4492031625861560943_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1725334390666_456785134_929908069283378_4492031625861560943_n.jpg', 51, '2024-09-03 03:33:12');
INSERT INTO `image` VALUES (70, '1725334921537_455969405_307429985793566_568729500223265332_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1725334921537_455969405_307429985793566_568729500223265332_n.jpg', 52, '2024-09-03 03:42:03');
INSERT INTO `image` VALUES (71, '1725347006400_438196156_1002248498129871_1016470206629337226_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1725347006400_438196156_1002248498129871_1016470206629337226_n.jpg', 53, '2024-09-03 07:03:28');
INSERT INTO `image` VALUES (72, '1725428600047_photo_2024-03-11_12-05-44.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1725428600047_photo_2024-03-11_12-05-44.jpg', 54, '2024-09-04 05:43:22');
INSERT INTO `image` VALUES (73, '1726824180032_406106550_721448053212763_8958059431194846067_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1726824180032_406106550_721448053212763_8958059431194846067_n.jpg', 55, '2024-09-20 09:23:01');

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
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media
-- ----------------------------
INSERT INTO `media` VALUES (18, 'Beautiful Moon <3', 'Beautiful-Moon-1720093401292', 1, 'Beautiful Moon, style 3D Render', 'Group', '2024-07-04 11:43:21', '2024-07-09 06:53:43', 0);
INSERT INTO `media` VALUES (19, 'Korean Girl', 'Korean-Girl-1720093671009', 1, 'Beautiful Girl, Korean, Asian', 'Ungroup', '2024-07-04 11:47:51', '2024-07-04 11:47:51', 0);
INSERT INTO `media` VALUES (20, 'Ly Van Tu Love', 'ly-van-tu-love', 1, 'My Love Of Yuki Dev <3 <3 <3', 'Ungroup', '2024-07-04 14:12:31', '2024-07-04 14:12:31', 0);
INSERT INTO `media` VALUES (21, 'Ice Queen', 'Ice-Queen-1720250501576', 4, 'Ice Queen, by Luca using Model DreamShaper v6', 'Group', '2024-07-06 07:21:42', '2024-07-06 07:21:42', 0);
INSERT INTO `media` VALUES (22, 'Furina Wallpaper', 'Furina-Wallpaper-1720346946752', 8, 'furina de forntenddd', 'Ungroup', '2024-07-07 10:09:07', '2024-07-07 10:09:07', 0);
INSERT INTO `media` VALUES (23, 'Dương Mịch | Giang Mi1720847373817', 'Duong-Mich-or-Giang-Mi-17203470617291720847373817', 8, 'LIÊN HOAN PHIM CANNES NĂM 2024', 'Ungroup', '2024-07-07 10:11:02', '2024-07-13 05:09:34', 1);
INSERT INTO `media` VALUES (24, 'Dương Mịch | Giang Mi', 'Duong-Mich-or-Giang-Mi-1720347251974', 8, 'bộ sưu tập 2024', 'Group', '2024-07-07 10:14:12', '2024-07-07 10:14:12', 0);
INSERT INTO `media` VALUES (25, 'Trương Gia Linh  | rối và nghệ thuạt 1720855348807', 'Truong-Gia-Linh-or-roi-va-nghe-thuat-17203474465151720855348807', 8, 'đây là nhân vật hư cấu trong truyện ma kinh dị rối và nghệ thuật của tác giả Hy Phạm phát sóng 22h30 trên kênh truyền đêm khuya', 'Ungroup', '2024-07-07 10:17:27', '2024-07-13 07:22:29', 1);
INSERT INTO `media` VALUES (26, 'wallpaper', 'wallpaper-1720350318500', 8, 'Adorn your iPhone with the serene beauty of a fantasy beach under a rainbow sky. This wallpaper captures a breathtaking scene where a crescent moon and stars twinkle above in soft pastel colors, offering a glimpse into a tranquil, dreamlike world. Inspired by the styles of various artists, this beautiful backdrop combines fantasy and elegance, perfect for those seeking a touch of whimsy for their device. #FantasyBeach #PastelSky #CrescentMoon #iPhoneWallpaper', 'Ungroup', '2024-07-07 11:05:19', '2024-07-07 11:05:19', 0);
INSERT INTO `media` VALUES (27, 'FireFly | loli mãi đỉnh ', 'FireFly-or-loli-mai-djinh-1720432239760', 8, 'FireFly là DPS hệ hoả vận mệnh huỷ diệt   với lối chơi break   độc đáo  hứa hẹn đem lại trãi nghiệm đỉnh cao cho các con simp', 'Ungroup', '2024-07-08 09:50:40', '2024-07-08 09:50:40', 0);
INSERT INTO `media` VALUES (28, 'Hy Phạm | tác giả truyện ma tâm lý  siêu hack não ', 'Hy-Pham-or-tac-gia-truyen-ma-tam-ly-sieu-hack-nao-1720695843225', 8, 'Hy Phạm là một tác giải tài  năng với tuyển tập truyện ma tâm lý hack não :))  cả thằng dev viết cái web  này nghe xong còn lú huống chi là dọc giải :))', 'Group', '2024-07-11 11:04:03', '2024-07-11 11:04:03', 0);
INSERT INTO `media` VALUES (29, 'Hy Phạm | tác giả truyện ma tâm lý  siêu hack não 1720781815616', 'Hy-Pham-or-tac-gia-truyen-ma-tam-ly-sieu-hack-nao-1720695843225', 1, 'Hy Phạm là một tác giải tài  năng với tuyển tập truyện ma tâm lý hack não :))  cả thằng dev viết cái web  này nghe xong còn lú huống chi là dọc giải :))', 'Group', '2024-07-11 11:04:03', '2024-07-12 10:56:56', 1);
INSERT INTO `media` VALUES (30, 'chuột gaming lỏ 1720849363034', 'chuot-gaming-lo-17208493174251720849363034', 8, 'chuột vắt vlc', 'Ungroup', '2024-07-13 05:41:57', '2024-07-13 05:42:43', 1);
INSERT INTO `media` VALUES (31, 'Pin by Jessica Goudett on F in 2022 | Iphone wallpaper earth, Dark phone wallpapers, Wallpap… in 2022 | Galaxy phone wallpaper, Dark phone wallpapers, Wallpaper iphone neon', 'galaxy_phone_wallpapers_neon', 1, 'This Pin was discovered by Apurva✨. Discover (and save!) your own Pins on Pinterest', 'Ungroup', '2024-07-14 12:30:37', '2024-07-14 12:30:37', 0);
INSERT INTO `media` VALUES (32, 'Liggg ❤️❤️❤️❤️❤️17210227972471721022803594', 'Liggg-172102252837517210227972471721022803594', 8, ' bà bán bơ :))', 'Ungroup', '2024-07-15 05:48:48', '2024-07-15 05:53:24', 1);
INSERT INTO `media` VALUES (33, 'Liggg ❤️❤️❤️❤️❤️', 'Liggg-1721023006821', 8, ' bà bán bơ :))   bơ Hà Nội chất lượng cao 60k 1 kg ', 'Ungroup', '2024-07-15 05:56:47', '2024-08-09 13:40:22', 0);
INSERT INTO `media` VALUES (34, 'Chill Background', 'Chill-Background-1721048883085', 4, 'Coffe chill, 4k background', 'Ungroup', '2024-07-15 13:08:03', '2024-07-15 13:08:03', 0);
INSERT INTO `media` VALUES (35, 'Lenovo GeekPro G5000 20231721054105995', 'fshsfh1721054105995', 8, 'xfbffh', 'Ungroup', '2024-07-15 13:45:40', '2024-07-15 14:35:06', 1);
INSERT INTO `media` VALUES (36, 'Arry moethod for js dev', 'Arry-moethod-for-js-dev-1721054033756', 8, 'some arry method i think  you need', 'Ungroup', '2024-07-15 14:33:54', '2024-07-15 14:33:54', 0);
INSERT INTO `media` VALUES (37, 'Liggg ❤️❤️❤️❤️❤️1721055607223', 'Liggg-17210543934981721055607223', 8, ' bà bán bơ :))   bơ Hà Nội chất lượng cao 60k 1 kg ', 'Ungroup', '2024-07-15 14:39:53', '2024-07-15 15:00:07', 1);
INSERT INTO `media` VALUES (38, 'rose blackpink cute vip pro', 'rose-blackpink-cute-vip-pro-1721054736497', 8, 'ảnh thường nhật của idooo;l', 'Ungroup', '2024-07-15 14:45:36', '2024-07-15 14:45:36', 0);
INSERT INTO `media` VALUES (39, 'nude seleee', 'nude-seleee-1721055460452', 8, 'anime cute HI3 cahrr', 'Ungroup', '2024-07-15 14:57:40', '2024-07-15 14:57:40', 0);
INSERT INTO `media` VALUES (40, 'himeko cosplay', 'himeko-cosplay-1721056133756', 8, 'E6S5 mai dỉnh', 'Ungroup', '2024-07-15 15:08:54', '2024-07-15 15:08:54', 0);
INSERT INTO `media` VALUES (41, 'SMO Logo', 'SMO-Logo-1721080390397', 1, 'Logo of SMOTeam', 'Group', '2024-07-15 21:53:10', '2024-07-15 21:53:10', 0);
INSERT INTO `media` VALUES (42, 'Wumpus Quest', 'Wumpus Quest', 16, 'discord quest beta leak image', 'Ungroup', '2024-07-16 01:10:50', '2024-07-16 01:10:50', 0);
INSERT INTO `media` VALUES (43, 'tháng 7 ấy chúng ta mất nhau1721290809157', 'thang-7-ay-chung-ta-mat-nhau-17210929120571721290809157', 13, 'final image of tT09TK204', 'Ungroup', '2024-07-16 01:21:52', '2024-07-18 08:20:09', 1);
INSERT INTO `media` VALUES (44, '\\n\\n wikitan', '\\n\\n wikitan', 16, 'wikitan\\n\\ntesst\\r\\n', 'Ungroup', '2024-07-16 02:01:34', '2024-07-16 02:01:34', 0);
INSERT INTO `media` VALUES (45, 'han tiue liggggg1721283083581', 'han-tiue-liggggg-17212285626731721283083581', 13, 'lig cuteeeeee', 'Ungroup', '2024-07-17 15:02:43', '2024-07-18 06:11:24', 1);
INSERT INTO `media` VALUES (46, 'best wallpaper pink mountant for pc / macbook1723606961648', 'best-wallpaper-pink-mountant-for-pc-macbook-17213154705721723606961648', 13, 'best wallpaper pink mountant for pc / macbook byy Y7ukicute ', 'Ungroup', '2024-07-18 15:11:11', '2024-08-14 03:42:42', 1);
INSERT INTO `media` VALUES (47, 'Lenovo GeekPro G5000 2023', 'Lenovo-GeekPro-G5000-2023-1722751405006', 13, 'Laptop Lenovo Legion 5 Pro 16IAH7H 82RG008SVN (Ryzen 7 6800H/ 16GB RAM/ 512GB SSD/ RTX 3060 6GB/ 16\" WQXGA IPS/ Win 11/ Trắng/ 3Yrs)', 'Ungroup', '2024-08-04 06:03:25', '2024-08-04 06:03:25', 0);
INSERT INTO `media` VALUES (48, 'radie shogun in genshin impact1725428373702', 'radie-shogun-in-genshin-impact-17228382887811725428373702', 13, 'dont hae des', 'Ungroup', '2024-08-05 06:11:29', '2024-09-04 05:39:34', 1);
INSERT INTO `media` VALUES (49, 'sdfsafasdf', 'fsadfasdfsadf', 13, 'sdfasdfsa', 'Ungroup', '2024-08-09 08:23:09', '2024-08-09 08:23:09', 0);
INSERT INTO `media` VALUES (50, 'Event1724313086049', 'tính năng1724313086049', 39, 'Alo', 'Ungroup', '2024-08-22 07:50:17', '2024-08-22 07:51:26', 1);
INSERT INTO `media` VALUES (51, 'Haàn Tiểu  Ling exe', 'iloveyuki', 8, 'plaer chơi gì Ling chơi đó :))', 'Ungroup', '2024-09-03 03:33:12', '2024-09-19 05:22:28', 0);
INSERT INTO `media` VALUES (52, 'bữa ăn tối ấm cúng cùng leaer', 'bua-an-toi-am-cung-cung-leaer-1725334922725', 13, 'bé yuki báo đi ăn cùng những ng anh / ng thầy :3\r\n   đồ ăn ngon , phim 4.5/10 :3', 'Ungroup', '2024-09-03 03:42:03', '2024-09-03 03:42:03', 0);
INSERT INTO `media` VALUES (53, 'lý van tư1725347117436', 'ly-van-tu-17253470079161725347117436', 40, '  my real love ', 'Ungroup', '2024-09-03 07:03:28', '2024-09-03 07:05:17', 1);
INSERT INTO `media` VALUES (54, 'nana haru', 'animepicturecute', 13, 'ảnh anine cute', 'Ungroup', '2024-09-04 05:43:21', '2024-09-04 05:43:21', 0);
INSERT INTO `media` VALUES (55, 'RAIDEN EI CUTE EMOJJI', 'RAIDEN-EI-CUTE-EMOJJI-1726824180858', 13, 'play genshin impact and have more :33', 'Ungroup', '2024-09-20 09:23:01', '2024-09-20 09:23:01', 0);

-- ----------------------------
-- Table structure for save_media
-- ----------------------------
DROP TABLE IF EXISTS `save_media`;
CREATE TABLE `save_media`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `media_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mediaid_media_id`(`media_id` ASC) USING BTREE,
  INDEX `userid_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `mediaid_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `userid_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of save_media
-- ----------------------------
INSERT INTO `save_media` VALUES (4, 19, 1, '2024-07-06 09:27:40');
INSERT INTO `save_media` VALUES (25, 19, 8, '2024-07-10 09:03:17');
INSERT INTO `save_media` VALUES (58, 25, 8, '2024-07-11 10:37:55');
INSERT INTO `save_media` VALUES (68, 22, 8, '2024-07-12 15:19:01');
INSERT INTO `save_media` VALUES (69, 20, 8, '2024-07-12 15:20:58');
INSERT INTO `save_media` VALUES (70, 21, 8, '2024-07-13 07:38:04');
INSERT INTO `save_media` VALUES (71, 31, 12, '2024-07-15 04:56:21');
INSERT INTO `save_media` VALUES (72, 22, 12, '2024-07-15 04:57:48');
INSERT INTO `save_media` VALUES (73, 28, 12, '2024-07-15 04:58:15');
INSERT INTO `save_media` VALUES (74, 20, 12, '2024-07-15 04:59:44');
INSERT INTO `save_media` VALUES (75, 24, 12, '2024-07-15 04:59:49');
INSERT INTO `save_media` VALUES (76, 32, 8, '2024-07-15 05:49:17');
INSERT INTO `save_media` VALUES (83, 33, 8, '2024-07-15 11:32:52');
INSERT INTO `save_media` VALUES (87, 39, 13, '2024-07-18 15:08:44');
INSERT INTO `save_media` VALUES (103, 33, 13, '2024-07-23 05:13:50');
INSERT INTO `save_media` VALUES (105, 47, 13, '2024-08-04 06:11:53');
INSERT INTO `save_media` VALUES (193, 31, 13, '2024-09-03 04:08:44');
INSERT INTO `save_media` VALUES (194, 40, 40, '2024-09-03 07:01:31');
INSERT INTO `save_media` VALUES (196, 18, 40, '2024-09-03 07:04:48');
INSERT INTO `save_media` VALUES (197, 40, 13, '2024-09-04 05:38:06');
INSERT INTO `save_media` VALUES (199, 18, 66, '2024-09-06 17:37:56');
INSERT INTO `save_media` VALUES (200, 18, 67, '2024-09-10 17:46:39');
INSERT INTO `save_media` VALUES (220, 18, 1, '2024-10-19 14:51:48');

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
  `is_active` int NOT NULL DEFAULT 0 COMMENT '0: inactive, 1: active',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_usertypes`(`type` ASC) USING BTREE,
  CONSTRAINT `type_usertypes` FOREIGN KEY (`type`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'usertest1', 'usertest1@gmail.com', 2, 'User Test1', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1731394098678_1731394100185_image', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 00:13:32', '2024-11-12 06:46:44', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MzI0NzY0NDYyNTAsImlhdCI6MTczMjQ3NjQ0NiwiZXhwIjoxNzM1MDY4NDQ2fQ.2A8iiDAjLF41cWGgP7moe0ux0fQrPlKbffdCRZ13wo0', 0, 1);
INSERT INTO `user` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-08-06 14:42:22', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MjYxNDkwMzczNTQsImlhdCI6MTcyNjE0OTAzNywiZXhwIjoxNzI4NzQxMDM3fQ.jrQ7Vqiqt2VTXtuvaBA2F_Rl_u7xg18lkDaomv-ZlXE', 0, 0);
INSERT INTO `user` VALUES (5, 'kieulinh123', 'ogyminecraft497@gmail.com', 1, 'dang haong thien an', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$ZRo1v7zFs95tEHvLLAj8..yQ6O1T2hUhra8004Im01Z0AcENGT3X.', '2024-06-22 13:56:19', '2024-06-22 13:56:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJraWV1bGluaDEyMyIsImtleSI6MTcyNjgyMTM1MzgwNiwiaWF0IjoxNzI2ODIxMzUzLCJleHAiOjE3Mjk0MTMzNTN9.4lrzHNiUam0t7vFpgCgwCPMR09C4VPwI1FXzhSdk4UM', 0, 1);
INSERT INTO `user` VALUES (6, 'lucadev222', 'lucan1@gmail.com', 1, 'nguyen phi phu ', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 9999, '$2b$10$7OMJSX2f252jc5ctJR000Ov9pJS2vX1nVFK.G52SKwTkbQwzUn7Hq', '2024-06-22 14:00:28', '2024-08-05 08:44:21', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwidXNlcm5hbWUiOiJsdWNhZGV2MjIyIiwia2V5IjoxNzIyODQ3NDYxMTA5LCJpYXQiOjE3MjI4NDc0NjEsImV4cCI6MTcyNTQzOTQ2MX0.6o_94hZJWdmjwjmuVJ78sxu-rLEJk4vvVX7WwR7k2RY', 0, 0);
INSERT INTO `user` VALUES (7, '1726821636399_tieulig', '1726821636399_asunayuki402@gmail.com', 1, 'dev yuki', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$iAZ7cSZ5wIwYC4W/xJQEVerPRXEfJEwZ8VDeAVdiRDwihi6wZ95Q.', '2024-06-22 14:04:24', '2024-08-08 05:39:36', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywidXNlcm5hbWUiOiJ0aWV1bGlnIiwia2V5IjoxNzIzMDk1NTc2MjMxLCJpYXQiOjE3MjMwOTU1NzYsImV4cCI6MTcyNTY4NzU3Nn0.MybVx5jRiXuCRBFOLiKc_BMHw7HWidTBg1p35JRbn50', 1, 0);
INSERT INTO `user` VALUES (8, 'devyuki123', 'kieukinhbo23@gmail.com', 1, 'Kiều Linh', '', 22, '$2b$10$QHMzWF6hMSHqM9Z24D1zpuZHOrZ6jkJycM9Wtmom2br7O0zId0I.O', '2024-06-22 14:06:55', '2024-07-15 08:08:15', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzI3MjcxMjU2OTQ4LCJpYXQiOjE3MjcyNzEyNTYsImV4cCI6MTcyOTg2MzI1Nn0.vIlSoGWpc1N6rgiT-iGbGdPc7cdV9UtQu6GT_e4irmg', 0, 0);
INSERT INTO `user` VALUES (9, '1719656488817_devyuki1234', '1719656488817_adangthienphuc110312@gmail.com', 1, 'tieu lig', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5NDc2NzA1MDI5LCJpYXQiOjE3MTk0NzY3MDUsImV4cCI6MTcyMjA2ODcwNX0.sl1FCUplMUGovgtP2QMLqcx9ZquinauK6vuJLrTm3zk', 1, 0);
INSERT INTO `user` VALUES (10, 'smoleo', 'smoleo@gmail.com', 1, 'Am Leo', NULL, 0, '$2b$10$TY3mKpGPrB5bbV.EotUoI.jXPEL08lO3q321szfjXzhJXsWWV5I8u', '2024-07-10 06:39:10', '2024-07-10 06:39:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsInVzZXJuYW1lIjoic21vbGVvIiwia2V5IjoxNzIwNTkzNTUwNTMxLCJpYXQiOjE3MjA1OTM1NTAsImV4cCI6MTcyMzE4NTU1MH0.ixKRBEENJcJ1p2gBSi6fFd7zx4TBqmE9r0WPE-kMIT0', 0, 0);
INSERT INTO `user` VALUES (11, 'hantieulinh123', 'tieuligcute@gmail.com', 1, 'Kieu Linh', NULL, 22, '$2b$10$l7Os5ZROcB3EuIXlDRFjI.ejSquqh3teFadHe12pLjxh/Af97.212', '2024-07-10 07:09:00', '2024-07-10 07:09:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiaGFudGlldWxpbmgxMjMiLCJrZXkiOjE3MjA1OTUzMzk4NTEsImlhdCI6MTcyMDU5NTMzOSwiZXhwIjoxNzIzMTg3MzM5fQ.pCT20LEYXB1XZCOUtNFUR9zIbObeT73Uf1I0Qxc0-zs', 0, 0);
INSERT INTO `user` VALUES (12, 'gialinh0212', 'truongialinh@gamil.com', 1, 'Trương Gia Linh', NULL, 55, '$2b$10$E3V4PepCARrsCvcEOQs36uaHc0qywi.LIQJPt.zHnPU8uzpEa7w92', '2024-07-10 08:08:10', '2024-08-08 05:39:50', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsInVzZXJuYW1lIjoiZ2lhbGluaDAyMTIiLCJrZXkiOjE3MjUwOTE2NzkwNzEsImlhdCI6MTcyNTA5MTY3OSwiZXhwIjoxNzI3NjgzNjc5fQ.K5IxkeNPZwAc9smIQHg8M6X2SZWjJLLvM-W1PRXtqwA', 0, 0);
INSERT INTO `user` VALUES (13, 'AsunaYuki1009', 'navigraphteam2806@gmail.com', 2, 'dev yuki', NULL, 87, '$2b$10$Kpht5TqP6HuAUotsXxxDJO.PxC1VN1vqI1GwezTl/td3g1v/CceZm', '2024-07-15 05:51:02', '2024-08-22 09:17:37', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsInVzZXJuYW1lIjoiQXN1bmFZdWtpMTAwOSIsImtleSI6MTczMjUyNDg1NjczMSwiaWF0IjoxNzMyNTI0ODU2LCJleHAiOjE3MzUxMTY4NTZ9.z-qgXWICXfUbqbnlKAk7Yq2PPEQYQRjc5oy5wXb6mXg', 0, 1);
INSERT INTO `user` VALUES (14, 'Hoàng', 'huyhoang74205@gmail.com', 1, 'Ta Tuan Huy Hoang', NULL, 19, '$2b$10$MRNoxVs8Iihib3TTlb4jLeF6thN7nen4DwStSyzn4cDv8lpDGGO6i', '2024-07-15 15:00:44', '2024-07-15 15:00:44', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInVzZXJuYW1lIjoiSG_DoG5nIiwia2V5IjoxNzIxMDU1NzU4MzQ4LCJpYXQiOjE3MjEwNTU3NTgsImV4cCI6MTcyMzY0Nzc1OH0.w_pdDS_PSeLSbFFpQaCq0GC0hAW_4JtLxTZORCfKY3E', 0, 0);
INSERT INTO `user` VALUES (15, 'Hoàng', 'huyhoang74205@gmail.com', 1, 'Ta Tuan Huy Hoang', NULL, 19, '$2b$10$J9AcphnCqp4KmJz81pOof.VT1Me6HO0wqQmRXf3EKLBZJbJSC9UNm', '2024-07-15 15:00:44', '2024-07-15 15:00:44', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiSG_DoG5nIiwia2V5IjoxNzIxMDU1NjQzNzgzLCJpYXQiOjE3MjEwNTU2NDMsImV4cCI6MTcyMzY0NzY0M30.G_hyTX9qnuGoH46JuvLrdGiKbRGLN-B_fLiJfbQIDwo', 0, 0);
INSERT INTO `user` VALUES (16, 'ako', 'mizuto.discord@gmail.com', 1, 'doan bao', NULL, 18, '$2b$10$hH3s9PXB1zesP11ZqAInQO2gFNEN8dh9pUeW4WFjdPWDIcE3sLL/m', '2024-07-16 00:48:36', '2024-07-16 00:48:36', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsInVzZXJuYW1lIjoiYWtvIiwia2V5IjoxNzIxMTA2Njk2MTYxLCJpYXQiOjE3MjExMDY2OTYsImV4cCI6MTcyMzY5ODY5Nn0.DVNSS4OC03uf0JcrJ1jiSkAhSzu-yFNeQtEsYhgNorc', 0, 0);
INSERT INTO `user` VALUES (17, 'ako12', 'mizuto.discord2@gmail.com', 1, 'doan bao 2', NULL, 18, '$2b$10$GJVs/4B7yaL61/HF99KT8uSe8oqzxO0Ba6ydAzH0nVuxSTI9DkEMO', '2024-07-16 00:59:49', '2024-07-16 00:59:49', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsInVzZXJuYW1lIjoiYWtvMTIiLCJrZXkiOjE3MjEwOTE1ODg5NjksImlhdCI6MTcyMTA5MTU4OCwiZXhwIjoxNzIzNjgzNTg4fQ.AsjSSByxExBsQG8ykqKRDTnKFMvr7OmeyAC6aYZ_JBY', 0, 0);
INSERT INTO `user` VALUES (18, 'FurinaDev', 'sadako@gmail.com', 1, 'dinh thi mai chi', NULL, 55, '$2b$10$3wnTHi0pGwfAVp4W.O1uYuK2ayazCOne35vURs2hwbQA3ResGOZSG', '2024-07-16 01:58:41', '2024-07-16 01:58:41', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTgsInVzZXJuYW1lIjoiRnVyaW5hRGV2Iiwia2V5IjoxNzIxMDk1MTIxMjQ3LCJpYXQiOjE3MjEwOTUxMjEsImV4cCI6MTcyMzY4NzEyMX0.d0opReTUovs4eceM4pc8_IS_2ijYIlEMzG5VBmyksCs', 0, 0);
INSERT INTO `user` VALUES (19, 'usertest3', 'usertest3@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$z2tSlWHe27hLvy4Lvvv1DOvsMOc36Gb38muFtkc9.5oOwWpixblvS', '2024-07-16 02:20:17', '2024-07-16 02:20:17', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksInVzZXJuYW1lIjoidXNlcnRlc3QzIiwia2V5IjoxNzIxMDk2NDE2ODk1LCJpYXQiOjE3MjEwOTY0MTYsImV4cCI6MTcyMzY4ODQxNn0.nwqJ1MVPvfOAMThIt0L3J81tC-r2K7NAk8HgUMf__Fg', 0, 0);
INSERT INTO `user` VALUES (20, 'usertest355', 'usetest4@gmai.com', 1, 'yuki', NULL, 55, '$2b$10$FLH54iydROXWzd6XyCCOYOVw0StsVErPZihUqvjU6ByBf.blbDg/y', '2024-07-16 02:25:50', '2024-07-16 02:25:50', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjAsInVzZXJuYW1lIjoidXNlcnRlc3QzNTUiLCJrZXkiOjE3MjEwOTY3NTA4OTgsImlhdCI6MTcyMTA5Njc1MCwiZXhwIjoxNzIzNjg4NzUwfQ.XUIqSxUipkWafPAc_Vy60SxXLga18caoO7i_dF6m9IY', 0, 0);
INSERT INTO `user` VALUES (22, 'usertest7', 'ủetest7@gmail.com', 1, 'yuki', '1728375709304_tmponhtgobp.png', 55, '$2b$10$irrh5dW.AxA/UVRSnwKSE.qLIj/7j78Zadz4pXF/pqCWTaDsvO8J2', '2024-07-16 11:14:31', '2024-07-16 11:14:31', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsInVzZXJuYW1lIjoidXNlcnRlc3Q3Iiwia2V5IjoxNzIxMTI4NDcxMzg5LCJpYXQiOjE3MjExMjg0NzEsImV4cCI6MTcyMzcyMDQ3MX0.T-rce15t09vNBXbzm-3SvBt-q7ILiUfTiqpUeMMD0TE', 0, 0);
INSERT INTO `user` VALUES (23, 'usertest8', 'usertest8@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$DpzWeYF321HEvdgnm5zwGub/aTRn4H6EwP/YnlivY0WHZHzbpnpie', '2024-07-16 11:17:30', '2024-07-16 11:17:30', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsInVzZXJuYW1lIjoidXNlcnRlc3Q4Iiwia2V5IjoxNzIxMTI4NjUwNDY4LCJpYXQiOjE3MjExMjg2NTAsImV4cCI6MTcyMzcyMDY1MH0.tDrweI00k5oPW82fK7BeQl_CDcCRH49ymVg3QzYQSCE', 0, 0);
INSERT INTO `user` VALUES (24, 'usertest9', 'usertest9@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$7gq3ycHWWfxU7RUIcjZw3uFc9EmNyWkcBFlHEvzhj2jmx6lm79Qsm', '2024-07-16 11:20:25', '2024-07-16 11:20:25', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsInVzZXJuYW1lIjoidXNlcnRlc3Q5Iiwia2V5IjoxNzIxMTI4ODI0ODY3LCJpYXQiOjE3MjExMjg4MjQsImV4cCI6MTcyMzcyMDgyNH0.LkbNFhLdqDcj6OrEDXODrom39PbeMGVllAgc1S9VEAQ', 0, 0);
INSERT INTO `user` VALUES (25, 'sanhao1', 'sanhao1@gmail.com', 1, 'San Hao', NULL, 0, '$2b$10$H8vEXDQLUKXRIBQqUmxWYusMaiPbrWx2EIQrfr/lRCV3/fWikKHQ6', '2024-07-16 14:42:34', '2024-07-16 14:42:34', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjUsInVzZXJuYW1lIjoic2FuaGFvMSIsImtleSI6MTcyMTE0MDk1NDI4MSwiaWF0IjoxNzIxMTQwOTU0LCJleHAiOjE3MjM3MzI5NTR9.ULX1mal3TrzchfACtKjCuLnJks6o4QucpGXWJAjr-Xs', 0, 0);
INSERT INTO `user` VALUES (26, 'usertest11', 'usertest11@gmail.com', 1, 'Dang Kieu Van trang', NULL, 55, '$2b$10$lQMecKc6Yb4C0D78taazo.78I3Zvze4iDCkJF/3pSQluWai5Dtlka', '2024-07-17 06:15:38', '2024-07-17 06:15:38', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsInVzZXJuYW1lIjoidXNlcnRlc3QxMSIsImtleSI6MTcyMTE5NjkzNzg5NSwiaWF0IjoxNzIxMTk2OTM3LCJleHAiOjE3MjM3ODg5Mzd9.XVE7uKL--RFIidGsKNQhSUTPi6IEVoPWjOky7gD1Hjs', 0, 0);
INSERT INTO `user` VALUES (27, 'sanhao2', 'sanhao2@gmail.com', 1, 'San Hao', NULL, 0, '$2b$10$1OTMNef8/sDAdNEn0UrgqO04pKfAPyewgAxm.PPVoreuuXEybdwJa', '2024-07-17 07:03:03', '2024-07-17 07:03:03', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsInVzZXJuYW1lIjoic2FuaGFvMiIsImtleSI6MTcyMTE5OTc4Mjc1NSwiaWF0IjoxNzIxMTk5NzgzLCJleHAiOjE3MjM3OTE3ODN9.F3_0RwZjjeC8WW9N4AcWnc_pRvaH4lhiHR-2f3576yo', 0, 0);
INSERT INTO `user` VALUES (28, 'KitoMC', 'me@kitomc.site', 1, 'KitoMC', NULL, 15, '$2b$10$Hh7CuDjTc20U0HaCfgQ2FOyt4uCsKprNlQ6WbxRPbEdiN6EfUAvma', '2024-07-18 01:41:21', '2024-08-06 14:43:16', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsInVzZXJuYW1lIjoiS2l0b01DIiwia2V5IjoxNzIyOTU1Mzk1NTI3LCJpYXQiOjE3MjI5NTUzOTUsImV4cCI6MTcyNTU0NzM5NX0.Tfq6W4lft-vJ46UwJiy2l3CN4Q_6TokyXzYoD3ARlOA', 0, 0);
INSERT INTO `user` VALUES (36, 'usertest6', 'usertest6@gmail.com', 1, 'User Test6', NULL, 22, '$2b$10$NFO5uak84IyKyZEH15xaaebXoHc/CUzPJXj1LtRgEzayqD9bijAMe', '2024-08-04 09:39:15', '2024-08-09 07:39:30', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzYsInVzZXJuYW1lIjoidXNlcnRlc3Q2Iiwia2V5IjoxNzIzMTg5MTY5Njg1LCJpYXQiOjE3MjMxODkxNjksImV4cCI6MTcyNTc4MTE2OX0.VsH-wtBFObxuThTW7-sDryv-TmR8IzkzA1G2MWbO-Ys', 0, 0);
INSERT INTO `user` VALUES (37, 'yenvy01', 'nanaharu2806@gmail.com', 1, 'pham thi yen vy', NULL, 19, '$2b$10$AGsJ4ncKA6gGF5hheKl6DeR8c24p.oRhU0UK6NAgjSmHx.DjCes/C', '2024-08-17 03:06:42', '2024-08-17 03:06:42', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsInVzZXJuYW1lIjoieWVudnkwMSIsImtleSI6MTcyMzg2NDAwMTk3MiwiaWF0IjoxNzIzODY0MDAxLCJleHAiOjE3MjY0NTYwMDF9.BcPTsAMK2Go3kjYWx713pJarSl_Veo9Upu5VE7c1x_0', 0, 0);
INSERT INTO `user` VALUES (38, 'nguyentruc01', 'truccute@gmail.com', 1, 'Nguyễn Đỗ Hoàng Trúc', NULL, 22, '$2b$10$nOvy4cxmw6661Bc86J0hL.i0.RzooRext4GYLQBbuBTWlrEdKWGgC', '2024-08-17 03:12:03', '2024-09-04 05:45:54', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzgsInVzZXJuYW1lIjoibmd1eWVudHJ1YzAxIiwia2V5IjoxNzI1NDI4NzU0MjQyLCJpYXQiOjE3MjU0Mjg3NTQsImV4cCI6MTcyODAyMDc1NH0.SKmF3CKfSM-3QDXKYSUdu6y-DnLoPQuVW5R_ypRwSy8', 0, 0);
INSERT INTO `user` VALUES (39, 'Micheal Dung', 'dung@gmail.com', 1, 'Micheal Dung', NULL, 23, '$2b$10$31RBhvQsheI9C4jQkjgny.hXIBTyg4D92LQdFEqfPTvmbJyWirckW', '2024-08-22 07:48:45', '2024-08-22 07:48:45', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzksInVzZXJuYW1lIjoiTWljaGVhbCBEdW5nIiwia2V5IjoxNzI0MzEyOTI0Nzc0LCJpYXQiOjE3MjQzMTI5MjUsImV4cCI6MTcyNjkwNDkyNX0.D7Cobsm1hsy5xGTwT04bwavUPH_zNZ7Sx4s31a5eEl8', 0, 0);
INSERT INTO `user` VALUES (40, 'hantieulig', 'tieulinh123@gmail.com', 2, 'Kiều Linh', NULL, 22, '$2b$10$1Nazsuy/8gF7d0jeYpDvy.7RgLy/TBjkXqZDvXZTCBM2bHLgvU0CS', '2024-09-03 07:01:05', '2024-09-03 07:42:05', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDAsInVzZXJuYW1lIjoiaGFudGlldWxpZyIsImtleSI6MTcyNTM0OTMyNTE4NiwiaWF0IjoxNzI1MzQ5MzI1LCJleHAiOjE3Mjc5NDEzMjV9.2s345zXJ_3OTjiki4zAw_b8aA-JZx93dOTooSc_J6lU', 0, 0);
INSERT INTO `user` VALUES (41, 'buatoimongadelam', 'telegramweb@gmail.com', 1, 'Nguyễn Văn An', NULL, 50, '$2b$10$tl4uvGUwujNdnTNC75T82.bfnxtcPmTHwZdJJfjsOMsH6AORTiDsi', '2024-09-03 14:41:06', '2024-09-03 14:41:06', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDEsInVzZXJuYW1lIjoiYnVhdG9pbW9uZ2FkZWxhbSIsImtleSI6MTcyNTM3NDQ2NTc3NSwiaWF0IjoxNzI1Mzc0NDY1LCJleHAiOjE3Mjc5NjY0NjV9.f-4mMsNZAnyBc2MFdai9g0WBLwHyYT182wJMRGarJCo', 0, 0);
INSERT INTO `user` VALUES (65, 'icaluca12', 'icaluca12@gmail.com', 1, 'Luca 12', NULL, 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-09-06 10:39:16', '2024-09-06 10:39:16', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjUsInVzZXJuYW1lIjoiaWNhbHVjYTEyIiwia2V5IjoxNzI2MTU1NTM3Mzc2LCJpYXQiOjE3MjYxNTU1MzcsImV4cCI6MTcyODc0NzUzN30.ddk58_T8ahv1RRjoQh4KNCB9Al0Gh8_ke23bKQKuhWs', 0, 1);
INSERT INTO `user` VALUES (66, 'Nguyenvanb', 'icaluca14@gmail.com', 1, 'Nguyen van B', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1728716244357_1728716245428_image', 22, '$2b$10$so81hwdFn7cOT7hmE7rZnuhVu/DTAv9RcBfIUgwxW0nbsjAsRZ7U6', '2024-09-06 17:36:22', '2024-10-18 15:13:18', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjYsInVzZXJuYW1lIjoiTmd1eWVudmFuYiIsImtleSI6MTcyOTI2NDg1MzI2MywiaWF0IjoxNzI5MjY0ODUzLCJleHAiOjE3MzE4NTY4NTN9.__YGFqSwxwDV9F_jMnLuHlSUQh30HZ_yAzHIiNZpcXE', 0, 1);
INSERT INTO `user` VALUES (67, 'Quocthang', 'quocthang5731@gmail.com', 1, 'Nguyễn Leo', NULL, 22, '$2b$10$JSbTHIHopGM/vdUd0igbhe1a1T2yNarS7cY8VuG4cPi5GsPAqwgqW', '2024-09-10 16:52:01', '2024-09-10 16:52:01', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjcsInVzZXJuYW1lIjoiUXVvY3RoYW5nIiwia2V5IjoxNzI1OTg5Nzc5MTI0LCJpYXQiOjE3MjU5ODk3NzksImV4cCI6MTcyODU4MTc3OX0.j3MWdYAwD-0m7y_dZ0XXcOJ84VTwUTzJDj4DkgDhbPU', 0, 1);
INSERT INTO `user` VALUES (68, 'd', 'duongtai110510@gmail.com', 1, 'ddat', NULL, 90, '$2b$10$5IJ.sOXrJ.Gx.OAXftB3kurYLwKW5GSPMWhffp//4qkueaK9poo6q', '2024-09-11 13:44:24', '2024-09-11 13:44:24', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjgsInVzZXJuYW1lIjoiZCIsImtleSI6MTcyNjA2MjI2NDI1MCwiaWF0IjoxNzI2MDYyMjY0LCJleHAiOjE3Mjg2NTQyNjR9.UrH2uMTHRPCrSmdkFyKuX5IhAksK7yqQHgeQXSrEgqk', 0, 0);
INSERT INTO `user` VALUES (69, 'VuongLam', '22t1020721@husc.edu.vn', 1, 'Le Vuong Lam', NULL, 23, '$2b$10$MdzIUc140uUAhaVoPICx9OEn1saaUtNcVotiX3JunnN/Q2wy.00Yu', '2024-09-12 04:00:12', '2024-09-12 04:00:12', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjksInVzZXJuYW1lIjoiVnVvbmdMYW0iLCJrZXkiOjE3MjYxMTM2MTIwMjgsImlhdCI6MTcyNjExMzYxMiwiZXhwIjoxNzI4NzA1NjEyfQ.bUPl5c6ZCDNHwAYmuqXxyzMTHFN-RVGlJ5W0suk0m0c', 0, 0);
INSERT INTO `user` VALUES (70, 'dakngok', 'dakngokkt@gmail.com', 1, 'dak ngok', NULL, 23, '$2b$10$7DlrMeCBm2BbOV3P2GuQJ.kFP.ThPcwh9DUj6NWvSEhsAB1n/re2q', '2024-09-12 07:14:03', '2024-09-12 07:14:03', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzAsInVzZXJuYW1lIjoiZGFrbmdvayIsImtleSI6MTcyNjEyNTI0MzAxNSwiaWF0IjoxNzI2MTI1MjQzLCJleHAiOjE3Mjg3MTcyNDN9.vVqn1IYkh264Xx-eC6ED1jL5g_1KOCI6ETlBBdEDiJg', 0, 0);
INSERT INTO `user` VALUES (71, 'quyen', 'quyenqh19378@gmail.com', 1, 'hoang quyen', NULL, 22, '$2b$10$17QjrHvZzU8aVGQ1cEAUPuhKgC7oDlrzp3M2/4DTD/B9hAb1ynUaa', '2024-09-12 08:01:01', '2024-09-12 08:01:01', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzEsInVzZXJuYW1lIjoicXV5ZW4iLCJrZXkiOjE3MjYxMjgwNjA3MjgsImlhdCI6MTcyNjEyODA2MCwiZXhwIjoxNzI4NzIwMDYwfQ.SenYOE88WT7lv_WtBlFT8E_j4sribUVfdMN-816C9zQ', 0, 0);
INSERT INTO `user` VALUES (72, 'hhh', 'h@gmail.com', 1, 'nguyank ', NULL, 124, '$2b$10$mw3kUSOYdjrKh8ub9QeBAeAlAZO0SA7Vwdti.I798ZJFwRphVTlya', '2024-09-14 06:57:45', '2024-09-14 06:57:45', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzIsInVzZXJuYW1lIjoiaGhoIiwia2V5IjoxNzI2Mjk3MDY0NzQ4LCJpYXQiOjE3MjYyOTcwNjQsImV4cCI6MTcyODg4OTA2NH0.SAVMZVlzFfoaxhW6nCaMSdS-D0qlV3VOV9AVDzLemAs', 0, 0);
INSERT INTO `user` VALUES (73, 'dddd', 'dddd@gmial.com', 1, 'đâsdasdasdas', NULL, 12, '$2b$10$rLHay8BCEYNZ444QpBqlEuUs4zUmAdhuhWm2av7PUfWmRvqhY3Bea', '2024-09-17 17:17:11', '2024-09-17 17:17:11', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzMsInVzZXJuYW1lIjoiZGRkZCIsImtleSI6MTcyNjU5MzQzMTQyMywiaWF0IjoxNzI2NTkzNDMyLCJleHAiOjE3MjkxODU0MzJ9.dx9oS2fjHEUhpEBekC1gCpyPOHjbQ28OOX2FN4b7HYk', 0, 0);
INSERT INTO `user` VALUES (74, 'Anh Le', 'anh1234@gmail.com', 1, 'adds', NULL, 12, '$2b$10$.7z8gSItyRqOuwtsj/bs7OT7mKijss.aGgiFcCRzM3zo6Huw24Agi', '2024-09-18 15:18:20', '2024-09-18 15:18:20', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzQsInVzZXJuYW1lIjoiQW5oIExlIiwia2V5IjoxNzI2NjcyNzAwMDM3LCJpYXQiOjE3MjY2NzI3MDAsImV4cCI6MTcyOTI2NDcwMH0.Z8gOJe4i1oV2oPznBMvGSromQ0Nfvh-gwZ4Af0kBeWo', 0, 0);
INSERT INTO `user` VALUES (75, 'icaluca14plus', 'icaluca14+test1@gmail.com', 1, 'Luca 14', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1728979956129_1728979954167_image', 22, '$2b$10$YqOkSZIjXW.8tgRAjj569.3.bS9PdSrTM1hUXqiVVz9iL9QQf5JO6', '2024-09-19 07:44:54', '2024-10-15 10:35:42', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzUsInVzZXJuYW1lIjoiaWNhbHVjYTE0cGx1cyIsImtleSI6MTczMjA5MTc1ODAzOSwiaWF0IjoxNzMyMDkxNzU4LCJleHAiOjE3MzQ2ODM3NTh9.X_-VzBKErvk_pkHTIQ_mdjSLFLvCoigCGVtDzb5GLvo', 0, 1);
INSERT INTO `user` VALUES (76, '1726822382449_YukiAsuna2007', '1726822382449_asunayuki402@gmail.com', 1, 'Asuna Yuki', NULL, 17, '$2b$10$aaBom8TVNjtEgHbs6QMbsuVzsQNSd2YPRm5z80/k.v6Eg6jb/CZpO', '2024-09-20 08:41:38', '2024-09-20 08:41:38', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzYsInVzZXJuYW1lIjoiWXVraUFzdW5hMjAwNyIsImtleSI6MTcyNjgyMTczNzEzNywiaWF0IjoxNzI2ODIxNzM3LCJleHAiOjE3Mjk0MTM3Mzd9.xO7vl-nzz1RjwwQwichGHsxyA0z4BxzlBgHHMWIb6aQ', 1, 1);
INSERT INTO `user` VALUES (77, '1726823089841_YukiAsuna2007', '1726823089841_asunayuki402@gmail.com', 1, 'Asuna Yuki', NULL, 17, '$2b$10$deWoSFarzpi5qOJg8RlipOtSW0xD9qNfHqZj6TgtubqtIV7eNRvKK', '2024-09-20 08:53:42', '2024-09-20 08:53:42', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzcsInVzZXJuYW1lIjoiWXVraUFzdW5hMjAwNyIsImtleSI6MTcyNjgyMjQyMjM2OSwiaWF0IjoxNzI2ODIyNDIyLCJleHAiOjE3Mjk0MTQ0MjJ9.XRTOGATbCSZxC6YsOhQm4ukMDnYXwPf2PP-9OOW-iAw', 1, 0);
INSERT INTO `user` VALUES (78, '1726823791308_YukiAsuna2007', '1726823791308_asunayuki402@gmail.com', 1, 'yuki asunay', NULL, 17, '$2b$10$xiR5CLYDyB.US3SxTqGKk.1VY6FLomRAKAMDKaOos53Wztd7Er2nK', '2024-09-20 09:05:39', '2024-09-20 09:05:39', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzgsInVzZXJuYW1lIjoiWXVraUFzdW5hMjAwNyIsImtleSI6MTcyNjgyMzE2NjUxNCwiaWF0IjoxNzI2ODIzMTY2LCJleHAiOjE3Mjk0MTUxNjZ9.hR-EtghfUj07RQQJPJeUMn-xV2qitjk8iJciPdtAQ24', 1, 1);
INSERT INTO `user` VALUES (79, 'LENGUYENNAMPHUONG', 'phuonglenguyen2811@gmail.com', 1, 'Phuong', NULL, 23, '$2b$10$2bK3Ge1qzUesd0KnKMHq3uQ6Z/SgXYeNbE156r25ng3BFADx7bKB6', '2024-09-26 14:16:01', '2024-09-26 14:16:01', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzksInVzZXJuYW1lIjoiTEVOR1VZRU5OQU1QSFVPTkciLCJrZXkiOjE3MjczNjAxNjE0NTAsImlhdCI6MTcyNzM2MDE2MSwiZXhwIjoxNzI5OTUyMTYxfQ.npbM3IeTFAUCJ-GhfSmFFz7So_DVTBAMRM0VIAa-RyQ', 0, 0);
INSERT INTO `user` VALUES (80, 'fpt1', 'fpt1@gmail.com', 1, 'fpt1', NULL, 22, '$2b$10$fX6yKcDhl3vCuSRY7q4RoeYeoVLGVsKo3HndMagj5Y.trLoG4USUW', '2024-11-20 06:49:14', '2024-11-20 06:49:14', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODAsInVzZXJuYW1lIjoiZnB0MSIsImtleSI6MTczMjA4NTM1NDE5MCwiaWF0IjoxNzMyMDg1MzU0LCJleHAiOjE3MzQ2NzczNTR9.n9gj58hFqAhM41f-8NyL8QvysJWyM61pl14HXRjG2uw', 0, 0);
INSERT INTO `user` VALUES (81, 'fpt2', 'fpt2@gmail.com', 1, 'fpt2', NULL, 22, '$2b$10$Lu/QiqD1IM2ShZ3QqwX3UudX5gngAjhLyJZbt3O.BCEtoJp0jcqSm', '2024-11-20 06:59:16', '2024-11-20 06:59:16', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODEsInVzZXJuYW1lIjoiZnB0MiIsImtleSI6MTczMjA4NTk1ODA5NSwiaWF0IjoxNzMyMDg1OTU4LCJleHAiOjE3MzQ2Nzc5NTh9.VFhlHkdC6CIxh6D_VX9wEwo8OTcKTxvHRG0jbeAtay8', 0, 0);
INSERT INTO `user` VALUES (82, 'furina1', 'furina1@gmail.com', 1, 'furina 3 year', NULL, 11, '$2b$10$qkpKj4MEw5CV4aTHBNr0eu.mo02T5ySwrSOerT/cu.YSA1nsby4oW', '2024-11-20 07:27:20', '2024-11-20 07:27:20', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODIsInVzZXJuYW1lIjoiZnVyaW5hMSIsImtleSI6MTczMjA4NzY0MTcyOSwiaWF0IjoxNzMyMDg3NjQxLCJleHAiOjE3MzQ2Nzk2NDF9.whOfAnOQDLP1YrayYttNrVXhnuPung4LceRnaGA1lkE', 0, 0);
INSERT INTO `user` VALUES (83, 'fpt3', 'fpt3@gmail.com', 1, 'fpt3', NULL, 22, '$2b$10$P6N/4MnzMbscQjVHT6ouZuOJHF83W2vd8.8lhKFVP8oAIxmG6/i8u', '2024-11-20 08:17:10', '2024-11-20 08:17:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODMsInVzZXJuYW1lIjoiZnB0MyIsImtleSI6MTczMjA5MDYzMTg5MCwiaWF0IjoxNzMyMDkwNjMxLCJleHAiOjE3MzQ2ODI2MzF9.bvaZLDfPoa7q0ftM5f8PT2IeytAzbSjydET3KuXXnug', 0, 0);
INSERT INTO `user` VALUES (92, 'testactive1', 'icaluca14+testactive1@gmail.com', 1, 'testactive1', NULL, 0, '$2b$10$atFNn82/EZluvqoaJTO47eCj3fRYDbUnNKA6I5VNWpjKoRdkGV/ny', '2024-11-21 09:14:19', '2024-11-21 09:14:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTIsInVzZXJuYW1lIjoidGVzdGFjdGl2ZTEiLCJrZXkiOjE3MzIxODIwNzQxMDgsImlhdCI6MTczMjE4MjA3NCwiZXhwIjoxNzM0Nzc0MDc0fQ.Fn3WWEE_KkixA7q9AqYKBkgglRs6ifkpraW1VIilNFo', 0, 1);
INSERT INTO `user` VALUES (94, 'testactive2', 'icaluca14+testactive2@gmail.com', 1, 'testactive2', NULL, 22, '$2b$10$1ZjO2lpum/OwA0mWH6GhSOslWD11S89dsjRFBHCqZ8Xxcf8eUChUO', '2024-11-24 19:28:35', '2024-11-24 19:28:35', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTQsInVzZXJuYW1lIjoidGVzdGFjdGl2ZTIiLCJrZXkiOjE3MzI0Nzc0NjQ5NzIsImlhdCI6MTczMjQ3NzQ2NCwiZXhwIjoxNzM1MDY5NDY0fQ.GW0itlulEgPKTvKSzsYh9crxnUKBB5-HO_i8ElZNb2E', 0, 1);

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
