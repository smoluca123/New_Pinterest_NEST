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

 Date: 17/07/2024 14:06:45
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
  INDEX `replyto_comment_id`(`reply_to` ASC) USING BTREE,
  CONSTRAINT `media_id_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `replyto_comment_id` FOREIGN KEY (`reply_to`) REFERENCES `comment` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `user_id_users_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'Đẹp quá <3', 1, '2024-07-05 00:14:35', '2024-07-05 00:14:38', 0, NULL, 19);
INSERT INTO `comment` VALUES (6, 'Đẹp dữ chờiiiii', 4, '2024-07-05 08:01:52', '2024-07-05 08:01:52', 0, NULL, 18);
INSERT INTO `comment` VALUES (11, 'ừ, công nhận!', 4, '2024-07-05 08:05:16', '2024-07-05 08:05:16', 1, 1, 19);
INSERT INTO `comment` VALUES (13, 'đóm cute phô mai que nạp 5 tỷ rolll đóm', 12, '2024-07-11 04:25:17', '2024-07-11 04:25:17', 0, NULL, 27);
INSERT INTO `comment` VALUES (14, 'vân tư   mãi đỉnh :)) qua tàu lấy vân tư', 12, '2024-07-11 04:27:12', '2024-07-11 04:27:12', 0, NULL, 20);
INSERT INTO `comment` VALUES (15, 'thấy cx đẹp :)) yêu luôn', 8, '2024-07-11 04:29:09', '2024-07-11 04:29:09', 0, NULL, 20);
INSERT INTO `comment` VALUES (16, 'ảnh thầy Luca99 đẹp sml :33', 8, '2024-07-11 04:31:56', '2024-07-11 04:31:56', 0, NULL, 21);
INSERT INTO `comment` VALUES (17, 'cx đẹp :((', 8, '2024-07-11 04:40:38', '2024-07-11 04:40:38', 0, NULL, 24);
INSERT INTO `comment` VALUES (18, 'lỗi j', 8, '2024-07-11 04:41:43', '2024-07-11 04:41:43', 0, NULL, 24);
INSERT INTO `comment` VALUES (19, 'trông lơi lỏ tý mà thôi kẹ ', 8, '2024-07-11 04:44:11', '2024-07-11 04:44:11', 0, NULL, 23);
INSERT INTO `comment` VALUES (23, 'luca tesst 11111', 8, '2024-07-11 05:56:46', '2024-07-11 05:56:46', 0, NULL, 27);
INSERT INTO `comment` VALUES (24, 'test comment by yukicute', 8, '2024-07-11 06:00:29', '2024-07-11 06:00:29', 0, NULL, 20);
INSERT INTO `comment` VALUES (25, 'test comment with enter key', 8, '2024-07-11 06:00:39', '2024-07-11 06:00:39', 0, NULL, 20);
INSERT INTO `comment` VALUES (26, 'tesst comment 2', 8, '2024-07-11 06:03:14', '2024-07-11 06:03:14', 0, NULL, 20);
INSERT INTO `comment` VALUES (27, 'tesst ceoomt', 8, '2024-07-11 06:03:20', '2024-07-11 06:03:20', 0, NULL, 20);
INSERT INTO `comment` VALUES (28, 'test comment df', 8, '2024-07-11 06:03:26', '2024-07-11 06:03:26', 0, NULL, 20);
INSERT INTO `comment` VALUES (29, 'batman no family', 8, '2024-07-11 06:03:34', '2024-07-11 06:03:34', 0, NULL, 20);
INSERT INTO `comment` VALUES (30, 'spidermannn', 8, '2024-07-11 06:03:41', '2024-07-11 06:03:41', 0, NULL, 20);
INSERT INTO `comment` VALUES (32, 'tacs giair beenhj hoanj vcl', 8, '2024-07-11 10:17:03', '2024-07-11 10:17:03', 0, NULL, 25);
INSERT INTO `comment` VALUES (33, 'tacs giar beenhj hoanj vcl', 8, '2024-07-11 10:17:51', '2024-07-11 10:17:51', 0, NULL, 25);
INSERT INTO `comment` VALUES (34, 'tác giải bệnh hoạn vcl  sao có thể viết ra truyện ma nhỉ', 8, '2024-07-11 10:18:24', '2024-07-11 10:18:24', 0, NULL, 25);
INSERT INTO `comment` VALUES (35, 'f5 qq cook', 8, '2024-07-11 10:38:05', '2024-07-11 10:38:05', 0, NULL, 21);
INSERT INTO `comment` VALUES (36, 'sếp thắng cute', 8, '2024-07-11 10:43:15', '2024-07-11 10:43:15', 0, NULL, 25);
INSERT INTO `comment` VALUES (37, 'sếp thắng cute 001', 8, '2024-07-11 10:47:05', '2024-07-11 10:47:05', 0, NULL, 25);
INSERT INTO `comment` VALUES (39, '111', 8, '2024-07-11 11:15:07', '2024-07-11 11:15:07', 0, NULL, 27);
INSERT INTO `comment` VALUES (42, 'tha', 8, '2024-07-12 02:41:25', '2024-07-12 02:41:25', 0, NULL, 20);
INSERT INTO `comment` VALUES (43, 'dsaf', 8, '2024-07-12 02:41:33', '2024-07-12 02:41:33', 0, NULL, 20);
INSERT INTO `comment` VALUES (44, 'ảo thạt', 8, '2024-07-12 02:48:28', '2024-07-12 02:48:28', 0, NULL, 19);
INSERT INTO `comment` VALUES (45, 'chịu :))', 8, '2024-07-12 02:56:22', '2024-07-12 02:56:22', 0, NULL, 23);
INSERT INTO `comment` VALUES (46, 'thua', 8, '2024-07-12 02:57:03', '2024-07-12 02:57:03', 0, NULL, 23);
INSERT INTO `comment` VALUES (47, 'dfadsf', 8, '2024-07-12 03:00:28', '2024-07-12 03:00:28', 0, NULL, 27);
INSERT INTO `comment` VALUES (48, 'fsadsda', 8, '2024-07-12 03:00:30', '2024-07-12 03:00:30', 0, NULL, 27);
INSERT INTO `comment` VALUES (49, 'ấd', 8, '2024-07-12 03:00:32', '2024-07-12 03:00:32', 0, NULL, 27);
INSERT INTO `comment` VALUES (50, 'dsfasdf', 8, '2024-07-12 03:00:34', '2024-07-12 03:00:34', 0, NULL, 27);
INSERT INTO `comment` VALUES (53, 'sao trong nó lại như thế này :))', 8, '2024-07-12 06:40:53', '2024-07-12 06:40:53', 0, NULL, 19);
INSERT INTO `comment` VALUES (54, 'm hỏi t t hỏi ai tr', 8, '2024-07-12 06:41:08', '2024-07-12 06:41:08', 1, 53, 19);
INSERT INTO `comment` VALUES (55, 'trông cute', 8, '2024-07-12 06:45:26', '2024-07-12 06:45:26', 0, NULL, 26);
INSERT INTO `comment` VALUES (56, 'um cx dep', 8, '2024-07-12 06:47:24', '2024-07-12 06:47:24', 1, 55, 26);
INSERT INTO `comment` VALUES (57, 'hinh sau vai', 8, '2024-07-12 07:08:22', '2024-07-12 07:08:22', 0, NULL, 21);
INSERT INTO `comment` VALUES (58, 'vis duj cmtttttt', 8, '2024-07-12 07:13:32', '2024-07-12 07:13:32', 1, 14, 20);
INSERT INTO `comment` VALUES (59, ' khẻ thôi bạn :(( fulltack đấy', 8, '2024-07-12 07:14:11', '2024-07-12 07:14:11', 1, NULL, 22);
INSERT INTO `comment` VALUES (60, 'dev 10  năm kinh nghiệm làm fullsstack 3 hôm', 8, '2024-07-12 07:15:37', '2024-07-12 07:15:37', 1, NULL, 22);
INSERT INTO `comment` VALUES (62, 'anh furrina có dạy react không nhỉ', 8, '2024-07-12 08:38:19', '2024-07-12 08:38:19', 0, NULL, 22);
INSERT INTO `comment` VALUES (63, 'ai mà biết đc nghe ns ổng đấy đi làm 5 năm gì đấy code ác lắm', 8, '2024-07-12 08:39:42', '2024-07-12 08:39:42', 1, 62, 22);
INSERT INTO `comment` VALUES (64, 'dẹt sơ', 8, '2024-07-12 09:35:42', '2024-07-12 09:35:42', 0, NULL, 19);
INSERT INTO `comment` VALUES (67, 'dep ma', 8, '2024-07-12 14:46:36', '2024-07-12 14:46:36', 1, 57, 21);
INSERT INTO `comment` VALUES (68, 'biết ông Lu không ?', 8, '2024-07-12 15:06:40', '2024-07-12 15:06:40', 0, NULL, 22);
INSERT INTO `comment` VALUES (69, 'detj sow', 8, '2024-07-12 15:21:46', '2024-07-12 15:21:46', 1, 15, 20);
INSERT INTO `comment` VALUES (70, 'đăng xàm vcl xoá mẹ đi', 8, '2024-07-13 05:42:34', '2024-07-13 05:42:34', 0, NULL, 30);
INSERT INTO `comment` VALUES (71, 'đúng vậy', 8, '2024-07-13 07:37:47', '2024-07-13 07:37:47', 1, 16, 21);
INSERT INTO `comment` VALUES (72, 'hình hơi bị đẹp?, lói cái giề bậy bạ thế nhò', 1, '2024-07-13 14:26:31', '2024-07-13 14:26:31', 1, 57, 21);
INSERT INTO `comment` VALUES (73, 'đẹp z sếp :))', 12, '2024-07-14 12:48:53', '2024-07-14 12:48:53', 0, NULL, 31);
INSERT INTO `comment` VALUES (74, 'bơ Hà Nội 60k 1 kg ', 8, '2024-07-15 05:49:48', '2024-07-15 05:49:48', 0, NULL, 32);
INSERT INTO `comment` VALUES (75, 'có ship không bạn', 13, '2024-07-15 05:51:37', '2024-07-15 05:51:37', 1, 74, 32);
INSERT INTO `comment` VALUES (76, 'lên playduo tạo đơn giúp mình nah', 8, '2024-07-15 05:52:47', '2024-07-15 05:52:47', 1, 74, 32);
INSERT INTO `comment` VALUES (77, 'bơ này có ship không bạn mình tận miền trong á  :33', 13, '2024-07-15 06:00:01', '2024-07-15 06:00:01', 0, NULL, 33);
INSERT INTO `comment` VALUES (78, 'bạn lên play duo  oder giúp mình nha ship 3-5 ngày là có hàng ạ , cảm ơn bạn', 8, '2024-07-15 06:00:51', '2024-07-15 06:00:51', 1, 77, 33);
INSERT INTO `comment` VALUES (79, ' bơ này mắc sml luôn bạn ơi :(( đùng mua', 12, '2024-07-15 06:04:15', '2024-07-15 06:04:15', 1, 77, 33);
INSERT INTO `comment` VALUES (83, 'thấy cx không mắc lắm á kiểu bơ này cx ngon  vs cute', 13, '2024-07-15 07:13:36', '2024-07-15 07:13:36', 1, 77, 33);
INSERT INTO `comment` VALUES (84, ' đúng rùi á ', 8, '2024-07-15 07:18:39', '2024-07-15 07:18:39', 1, 77, 33);
INSERT INTO `comment` VALUES (85, ' tin jaun', 8, '2024-07-15 07:35:00', '2024-07-15 07:35:00', 1, 6, 18);
INSERT INTO `comment` VALUES (86, 'tin juan chua  admin', 8, '2024-07-15 13:16:36', '2024-07-15 13:16:36', 0, NULL, 34);
INSERT INTO `comment` VALUES (87, 'vcl', 16, '2024-07-16 00:49:10', '2024-07-16 00:49:10', 0, NULL, 22);
INSERT INTO `comment` VALUES (89, 'test 2', 16, '2024-07-16 01:11:33', '2024-07-16 01:11:33', 0, NULL, 42);
INSERT INTO `comment` VALUES (90, 'cmar ơn bạn   ạ ', 13, '2024-07-16 01:20:19', '2024-07-16 01:20:19', 1, 89, 42);
INSERT INTO `comment` VALUES (91, 'dẹt sơ', 13, '2024-07-16 01:20:57', '2024-07-16 01:20:57', 0, NULL, 41);
INSERT INTO `comment` VALUES (92, 'lỏ ơi là lỏ', 13, '2024-07-16 12:17:27', '2024-07-16 12:17:27', 0, NULL, 43);
INSERT INTO `comment` VALUES (93, 'ok', 13, '2024-07-16 14:31:01', '2024-07-16 14:31:01', 1, 92, 43);
INSERT INTO `comment` VALUES (94, '/ với chúng tôi :)))', 13, '2024-07-17 06:34:10', '2024-07-17 06:34:10', 0, NULL, 44);

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
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `image` VALUES (58, '1721080389438_code-icon-design-vector-png_125856.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721080389438_code-icon-design-vector-png_125856.jpg', 41, '2024-07-15 21:53:10');
INSERT INTO `image` VALUES (59, '1721080389438_smo-letter-logo-design-on-black-background-vector-41106740.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721080389438_smo-letter-logo-design-on-black-background-vector-41106740.jpg', 41, '2024-07-15 21:53:10');
INSERT INTO `image` VALUES (60, '1721092248571_quest-mountain-hero.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721092248571_quest-mountain-hero.png', 42, '2024-07-16 01:10:50');
INSERT INTO `image` VALUES (61, '1721092910916_357346897_6449069211837594_529973375358662294_n.jpg', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721092910916_357346897_6449069211837594_529973375358662294_n.jpg', 43, '2024-07-16 01:21:52');
INSERT INTO `image` VALUES (62, '1721095293252_Wikipe-tan_cropped.png', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/1721095293252_Wikipe-tan_cropped.png', 44, '2024-07-16 02:01:35');

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
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `media` VALUES (33, 'Liggg ❤️❤️❤️❤️❤️', 'Liggg-1721023006821', 8, ' bà bán bơ :))   bơ Hà Nội chất lượng cao 60k 1 kg ', 'Ungroup', '2024-07-15 05:56:47', '2024-07-15 05:56:47', 0);
INSERT INTO `media` VALUES (34, 'Chill Background', 'Chill-Background-1721048883085', 4, 'Coffe chill, 4k background', 'Ungroup', '2024-07-15 13:08:03', '2024-07-15 13:08:03', 0);
INSERT INTO `media` VALUES (35, 'Lenovo GeekPro G5000 20231721054105995', 'fshsfh1721054105995', 8, 'xfbffh', 'Ungroup', '2024-07-15 13:45:40', '2024-07-15 14:35:06', 1);
INSERT INTO `media` VALUES (36, 'Arry moethod for js dev', 'Arry-moethod-for-js-dev-1721054033756', 8, 'some arry method i think  you need', 'Ungroup', '2024-07-15 14:33:54', '2024-07-15 14:33:54', 0);
INSERT INTO `media` VALUES (37, 'Liggg ❤️❤️❤️❤️❤️1721055607223', 'Liggg-17210543934981721055607223', 8, ' bà bán bơ :))   bơ Hà Nội chất lượng cao 60k 1 kg ', 'Ungroup', '2024-07-15 14:39:53', '2024-07-15 15:00:07', 1);
INSERT INTO `media` VALUES (38, 'rose blackpink cute vip pro', 'rose-blackpink-cute-vip-pro-1721054736497', 8, 'ảnh thường nhật của idooo;l', 'Ungroup', '2024-07-15 14:45:36', '2024-07-15 14:45:36', 0);
INSERT INTO `media` VALUES (39, 'nude seleee', 'nude-seleee-1721055460452', 8, 'anime cute HI3 cahrr', 'Ungroup', '2024-07-15 14:57:40', '2024-07-15 14:57:40', 0);
INSERT INTO `media` VALUES (40, 'himeko cosplay', 'himeko-cosplay-1721056133756', 8, 'E6S5 mai dỉnh', 'Ungroup', '2024-07-15 15:08:54', '2024-07-15 15:08:54', 0);
INSERT INTO `media` VALUES (41, 'SMO Logo', 'SMO-Logo-1721080390397', 1, 'Logo of SMOTeam', 'Group', '2024-07-15 21:53:10', '2024-07-15 21:53:10', 0);
INSERT INTO `media` VALUES (42, 'Wumpus Quest', 'Wumpus Quest', 16, 'discord quest beta leak image', 'Ungroup', '2024-07-16 01:10:50', '2024-07-16 01:10:50', 0);
INSERT INTO `media` VALUES (43, 'tháng 7 ấy chúng ta mất nhau', 'thang-7-ay-chung-ta-mat-nhau-1721092912057', 13, 'final image of tT09TK204', 'Ungroup', '2024-07-16 01:21:52', '2024-07-16 01:21:52', 0);
INSERT INTO `media` VALUES (44, '\\n\\n wikitan', '\\n\\n wikitan', 16, 'wikitan\\n\\ntesst\\r\\n', 'Ungroup', '2024-07-16 02:01:34', '2024-07-16 02:01:34', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of save_media
-- ----------------------------
INSERT INTO `save_media` VALUES (3, 18, 1, '2024-07-06 09:27:32');
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
INSERT INTO `save_media` VALUES (78, 33, 13, '2024-07-15 06:06:22');
INSERT INTO `save_media` VALUES (83, 33, 8, '2024-07-15 11:32:52');

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'usertest1', 'usertest1@gmail.com', 2, 'User Test', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 55, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 00:13:32', '2024-07-01 04:20:45', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MjExMjE1MzE5NzAsImlhdCI6MTcyMTEyMTUzMSwiZXhwIjoxNzIzNzEzNTMxfQ.FryEGWwIWlJj4aTEmfT98TbtS_rDqMkZ9Jm5Wq_Rseg', 0);
INSERT INTO `user` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-06-21 18:34:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MjEwNDg4MTgyNTYsImlhdCI6MTcyMTA0ODgxOCwiZXhwIjoxNzIzNjQwODE4fQ.PVp8KnrsTpzpDZ6kGM_xJITXTIUX7jN_19FFyiaWSkA', 0);
INSERT INTO `user` VALUES (5, 'kieulinh123', 'ogyminecraft497@gmail.com', 1, 'dang haong thien an', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$ZRo1v7zFs95tEHvLLAj8..yQ6O1T2hUhra8004Im01Z0AcENGT3X.', '2024-06-22 13:56:19', '2024-06-22 13:56:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJraWV1bGluaDEyMyIsImtleSI6MTcxOTA2NDU3ODg1MywiaWF0IjoxNzE5MDY0NTc4LCJleHAiOjE3MjE2NTY1Nzh9.I-188-iXhqjtwimO2JcbuFOYEQPsms7J4BhEAPEjHk4', 0);
INSERT INTO `user` VALUES (6, 'lucadev222', 'lucan1@gmail.com', 1, 'nguyen phi phu ', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 9999, '$2b$10$7OMJSX2f252jc5ctJR000Ov9pJS2vX1nVFK.G52SKwTkbQwzUn7Hq', '2024-06-22 14:00:28', '2024-06-22 14:00:28', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwidXNlcm5hbWUiOiJsdWNhZGV2MjIyIiwia2V5IjoxNzE5MDY0ODI4NDQyLCJpYXQiOjE3MTkwNjQ4MjgsImV4cCI6MTcyMTY1NjgyOH0.4UaGAoE8qepwDo4K5WAL8af1Za964RPsFvjb-1W9TMI', 0);
INSERT INTO `user` VALUES (7, 'tieulig', 'asunayuki402@gmail.com', 1, 'dev yuki', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$iAZ7cSZ5wIwYC4W/xJQEVerPRXEfJEwZ8VDeAVdiRDwihi6wZ95Q.', '2024-06-22 14:04:24', '2024-06-22 14:04:24', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywidXNlcm5hbWUiOiJ0aWV1bGlnIiwia2V5IjoxNzE5MDY1MDY0MDAzLCJpYXQiOjE3MTkwNjUwNjQsImV4cCI6MTcyMTY1NzA2NH0.LQhmPS4vrvrxGizeFmYAsFnAEHxL5WzZ1V2vFfSsYFM', 0);
INSERT INTO `user` VALUES (8, 'devyuki123', 'kieukinhbo23@gmail.com', 1, 'Kiều Linh', '', 22, '$2b$10$QHMzWF6hMSHqM9Z24D1zpuZHOrZ6jkJycM9Wtmom2br7O0zId0I.O', '2024-06-22 14:06:55', '2024-07-15 08:08:15', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzIxMDU1NDA1NzYyLCJpYXQiOjE3MjEwNTU0MDUsImV4cCI6MTcyMzY0NzQwNX0.FDEIai-Cwda2JozxaGf0orwzjFi9IngSezLgmTtieS0', 0);
INSERT INTO `user` VALUES (9, '1719656488817_devyuki1234', '1719656488817_adangthienphuc110312@gmail.com', 1, 'tieu lig', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5NDc2NzA1MDI5LCJpYXQiOjE3MTk0NzY3MDUsImV4cCI6MTcyMjA2ODcwNX0.sl1FCUplMUGovgtP2QMLqcx9ZquinauK6vuJLrTm3zk', 1);
INSERT INTO `user` VALUES (10, 'smoleo', 'smoleo@gmail.com', 1, 'Am Leo', NULL, 0, '$2b$10$TY3mKpGPrB5bbV.EotUoI.jXPEL08lO3q321szfjXzhJXsWWV5I8u', '2024-07-10 06:39:10', '2024-07-10 06:39:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsInVzZXJuYW1lIjoic21vbGVvIiwia2V5IjoxNzIwNTkzNTUwNTMxLCJpYXQiOjE3MjA1OTM1NTAsImV4cCI6MTcyMzE4NTU1MH0.ixKRBEENJcJ1p2gBSi6fFd7zx4TBqmE9r0WPE-kMIT0', 0);
INSERT INTO `user` VALUES (11, 'hantieulinh123', 'tieuligcute@gmail.com', 1, 'Kieu Linh', NULL, 22, '$2b$10$l7Os5ZROcB3EuIXlDRFjI.ejSquqh3teFadHe12pLjxh/Af97.212', '2024-07-10 07:09:00', '2024-07-10 07:09:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiaGFudGlldWxpbmgxMjMiLCJrZXkiOjE3MjA1OTUzMzk4NTEsImlhdCI6MTcyMDU5NTMzOSwiZXhwIjoxNzIzMTg3MzM5fQ.pCT20LEYXB1XZCOUtNFUR9zIbObeT73Uf1I0Qxc0-zs', 0);
INSERT INTO `user` VALUES (12, 'gialinh0212', 'truongialinh@gamil.com', 1, 'Trương Gia Linh', NULL, 55, '$2b$10$nkysaAnoq/B.hAtO.2KyMOSopwYLWY7518wIX1j1zO4ySH2bcntq2', '2024-07-10 08:08:10', '2024-07-10 08:08:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsInVzZXJuYW1lIjoiZ2lhbGluaDAyMTIiLCJrZXkiOjE3MjEwMjM0Mzc1NjksImlhdCI6MTcyMTAyMzQzNywiZXhwIjoxNzIzNjE1NDM3fQ.ByxvdPLy3Q1al2Ta-VZj3FP_dd28QTbe3QM39J6KQCY', 0);
INSERT INTO `user` VALUES (13, 'AsunaYuki1009', 'navigraphteam2806@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 18, '$2b$10$MCiUXjU5m17LMls2dAeC6eGc7eS7d.vb5nYdIwFq9Sh0eYf56JwH6', '2024-07-15 05:51:02', '2024-07-15 05:51:02', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsInVzZXJuYW1lIjoiQXN1bmFZdWtpMTAwOSIsImtleSI6MTcyMTE5OTQ5OTA0NiwiaWF0IjoxNzIxMTk5NDk5LCJleHAiOjE3MjM3OTE0OTl9.JufYT1qRCiWM00cLmQeUrkZFu7B6bZH48NuXHg92swQ', 0);
INSERT INTO `user` VALUES (14, 'Hoàng', 'huyhoang74205@gmail.com', 1, 'Ta Tuan Huy Hoang', NULL, 19, '$2b$10$MRNoxVs8Iihib3TTlb4jLeF6thN7nen4DwStSyzn4cDv8lpDGGO6i', '2024-07-15 15:00:44', '2024-07-15 15:00:44', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInVzZXJuYW1lIjoiSG_DoG5nIiwia2V5IjoxNzIxMDU1NzU4MzQ4LCJpYXQiOjE3MjEwNTU3NTgsImV4cCI6MTcyMzY0Nzc1OH0.w_pdDS_PSeLSbFFpQaCq0GC0hAW_4JtLxTZORCfKY3E', 0);
INSERT INTO `user` VALUES (15, 'Hoàng', 'huyhoang74205@gmail.com', 1, 'Ta Tuan Huy Hoang', NULL, 19, '$2b$10$J9AcphnCqp4KmJz81pOof.VT1Me6HO0wqQmRXf3EKLBZJbJSC9UNm', '2024-07-15 15:00:44', '2024-07-15 15:00:44', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiSG_DoG5nIiwia2V5IjoxNzIxMDU1NjQzNzgzLCJpYXQiOjE3MjEwNTU2NDMsImV4cCI6MTcyMzY0NzY0M30.G_hyTX9qnuGoH46JuvLrdGiKbRGLN-B_fLiJfbQIDwo', 0);
INSERT INTO `user` VALUES (16, 'ako', 'mizuto.discord@gmail.com', 1, 'doan bao', NULL, 18, '$2b$10$hH3s9PXB1zesP11ZqAInQO2gFNEN8dh9pUeW4WFjdPWDIcE3sLL/m', '2024-07-16 00:48:36', '2024-07-16 00:48:36', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsInVzZXJuYW1lIjoiYWtvIiwia2V5IjoxNzIxMTA2Njk2MTYxLCJpYXQiOjE3MjExMDY2OTYsImV4cCI6MTcyMzY5ODY5Nn0.DVNSS4OC03uf0JcrJ1jiSkAhSzu-yFNeQtEsYhgNorc', 0);
INSERT INTO `user` VALUES (17, 'ako12', 'mizuto.discord2@gmail.com', 1, 'doan bao 2', NULL, 18, '$2b$10$GJVs/4B7yaL61/HF99KT8uSe8oqzxO0Ba6ydAzH0nVuxSTI9DkEMO', '2024-07-16 00:59:49', '2024-07-16 00:59:49', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsInVzZXJuYW1lIjoiYWtvMTIiLCJrZXkiOjE3MjEwOTE1ODg5NjksImlhdCI6MTcyMTA5MTU4OCwiZXhwIjoxNzIzNjgzNTg4fQ.AsjSSByxExBsQG8ykqKRDTnKFMvr7OmeyAC6aYZ_JBY', 0);
INSERT INTO `user` VALUES (18, 'FurinaDev', 'sadako@gmail.com', 1, 'dinh thi mai chi', NULL, 55, '$2b$10$3wnTHi0pGwfAVp4W.O1uYuK2ayazCOne35vURs2hwbQA3ResGOZSG', '2024-07-16 01:58:41', '2024-07-16 01:58:41', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTgsInVzZXJuYW1lIjoiRnVyaW5hRGV2Iiwia2V5IjoxNzIxMDk1MTIxMjQ3LCJpYXQiOjE3MjEwOTUxMjEsImV4cCI6MTcyMzY4NzEyMX0.d0opReTUovs4eceM4pc8_IS_2ijYIlEMzG5VBmyksCs', 0);
INSERT INTO `user` VALUES (19, 'usertest3', 'usertest3@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$z2tSlWHe27hLvy4Lvvv1DOvsMOc36Gb38muFtkc9.5oOwWpixblvS', '2024-07-16 02:20:17', '2024-07-16 02:20:17', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksInVzZXJuYW1lIjoidXNlcnRlc3QzIiwia2V5IjoxNzIxMDk2NDE2ODk1LCJpYXQiOjE3MjEwOTY0MTYsImV4cCI6MTcyMzY4ODQxNn0.nwqJ1MVPvfOAMThIt0L3J81tC-r2K7NAk8HgUMf__Fg', 0);
INSERT INTO `user` VALUES (20, 'usertest355', 'usetest4@gmai.com', 1, 'yuki', NULL, 55, '$2b$10$FLH54iydROXWzd6XyCCOYOVw0StsVErPZihUqvjU6ByBf.blbDg/y', '2024-07-16 02:25:50', '2024-07-16 02:25:50', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjAsInVzZXJuYW1lIjoidXNlcnRlc3QzNTUiLCJrZXkiOjE3MjEwOTY3NTA4OTgsImlhdCI6MTcyMTA5Njc1MCwiZXhwIjoxNzIzNjg4NzUwfQ.XUIqSxUipkWafPAc_Vy60SxXLga18caoO7i_dF6m9IY', 0);
INSERT INTO `user` VALUES (21, 'ủetest6', 'ủetest6@gmail.com', 1, 'yuki', NULL, 55, '$2b$10$VgLk61xGRLQx0.rs.AYiqu3Dt0NV3AssbAIFVAfhabXfZOvZXQSRe', '2024-07-16 11:10:27', '2024-07-16 11:10:27', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsInVzZXJuYW1lIjoi4bunZXRlc3Q2Iiwia2V5IjoxNzIxMTI4MjI3MTg1LCJpYXQiOjE3MjExMjgyMjcsImV4cCI6MTcyMzcyMDIyN30.Rk1Fj5bmx9qzgQqVzdmrjHBcG4r-SGn1syoy4ujPZPE', 0);
INSERT INTO `user` VALUES (22, 'usertest7', 'ủetest7@gmail.com', 1, 'yuki', NULL, 55, '$2b$10$irrh5dW.AxA/UVRSnwKSE.qLIj/7j78Zadz4pXF/pqCWTaDsvO8J2', '2024-07-16 11:14:31', '2024-07-16 11:14:31', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsInVzZXJuYW1lIjoidXNlcnRlc3Q3Iiwia2V5IjoxNzIxMTI4NDcxMzg5LCJpYXQiOjE3MjExMjg0NzEsImV4cCI6MTcyMzcyMDQ3MX0.T-rce15t09vNBXbzm-3SvBt-q7ILiUfTiqpUeMMD0TE', 0);
INSERT INTO `user` VALUES (23, 'usertest8', 'usertest8@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$DpzWeYF321HEvdgnm5zwGub/aTRn4H6EwP/YnlivY0WHZHzbpnpie', '2024-07-16 11:17:30', '2024-07-16 11:17:30', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsInVzZXJuYW1lIjoidXNlcnRlc3Q4Iiwia2V5IjoxNzIxMTI4NjUwNDY4LCJpYXQiOjE3MjExMjg2NTAsImV4cCI6MTcyMzcyMDY1MH0.tDrweI00k5oPW82fK7BeQl_CDcCRH49ymVg3QzYQSCE', 0);
INSERT INTO `user` VALUES (24, 'usertest9', 'usertest9@gmail.com', 1, 'Đặng Hoàng Thiên Ân', NULL, 55, '$2b$10$7gq3ycHWWfxU7RUIcjZw3uFc9EmNyWkcBFlHEvzhj2jmx6lm79Qsm', '2024-07-16 11:20:25', '2024-07-16 11:20:25', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsInVzZXJuYW1lIjoidXNlcnRlc3Q5Iiwia2V5IjoxNzIxMTI4ODI0ODY3LCJpYXQiOjE3MjExMjg4MjQsImV4cCI6MTcyMzcyMDgyNH0.LkbNFhLdqDcj6OrEDXODrom39PbeMGVllAgc1S9VEAQ', 0);
INSERT INTO `user` VALUES (25, 'sanhao1', 'sanhao1@gmail.com', 1, 'San Hao', NULL, 0, '$2b$10$H8vEXDQLUKXRIBQqUmxWYusMaiPbrWx2EIQrfr/lRCV3/fWikKHQ6', '2024-07-16 14:42:34', '2024-07-16 14:42:34', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjUsInVzZXJuYW1lIjoic2FuaGFvMSIsImtleSI6MTcyMTE0MDk1NDI4MSwiaWF0IjoxNzIxMTQwOTU0LCJleHAiOjE3MjM3MzI5NTR9.ULX1mal3TrzchfACtKjCuLnJks6o4QucpGXWJAjr-Xs', 0);
INSERT INTO `user` VALUES (26, 'usertest11', 'usertest11@gmail.com', 1, 'Dang Kieu Van trang', NULL, 55, '$2b$10$lQMecKc6Yb4C0D78taazo.78I3Zvze4iDCkJF/3pSQluWai5Dtlka', '2024-07-17 06:15:38', '2024-07-17 06:15:38', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsInVzZXJuYW1lIjoidXNlcnRlc3QxMSIsImtleSI6MTcyMTE5NjkzNzg5NSwiaWF0IjoxNzIxMTk2OTM3LCJleHAiOjE3MjM3ODg5Mzd9.XVE7uKL--RFIidGsKNQhSUTPi6IEVoPWjOky7gD1Hjs', 0);
INSERT INTO `user` VALUES (27, 'sanhao2', 'sanhao2@gmail.com', 1, 'San Hao', NULL, 0, '$2b$10$1OTMNef8/sDAdNEn0UrgqO04pKfAPyewgAxm.PPVoreuuXEybdwJa', '2024-07-17 07:03:03', '2024-07-17 07:03:03', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsInVzZXJuYW1lIjoic2FuaGFvMiIsImtleSI6MTcyMTE5OTc4Mjc1NSwiaWF0IjoxNzIxMTk5NzgzLCJleHAiOjE3MjM3OTE3ODN9.F3_0RwZjjeC8WW9N4AcWnc_pRvaH4lhiHR-2f3576yo', 0);

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
