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

 Date: 12/07/2024 15:36:13
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
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media
-- ----------------------------
INSERT INTO `media` VALUES (18, 'Beautiful Moon <3', 'Beautiful-Moon-1720093401292', 1, 'Beautiful Moon, style 3D Render', 'Group', '2024-07-04 11:43:21', '2024-07-09 06:53:43', 0);
INSERT INTO `media` VALUES (19, 'Korean Girl', 'Korean-Girl-1720093671009', 1, 'Beautiful Girl, Korean, Asian', 'Ungroup', '2024-07-04 11:47:51', '2024-07-04 11:47:51', 0);
INSERT INTO `media` VALUES (20, 'Ly Van Tu Love', 'ly-van-tu-love', 1, 'My Love Of Yuki Dev <3 <3 <3', 'Ungroup', '2024-07-04 14:12:31', '2024-07-04 14:12:31', 0);
INSERT INTO `media` VALUES (21, 'Ice Queen', 'Ice-Queen-1720250501576', 4, 'Ice Queen, by Luca using Model DreamShaper v6', 'Group', '2024-07-06 07:21:42', '2024-07-06 07:21:42', 0);
INSERT INTO `media` VALUES (22, 'Furina Wallpaper', 'Furina-Wallpaper-1720346946752', 8, 'furina de forntenddd', 'Ungroup', '2024-07-07 10:09:07', '2024-07-07 10:09:07', 0);
INSERT INTO `media` VALUES (23, 'Dương Mịch | Giang Mi', 'Duong-Mich-or-Giang-Mi-1720347061729', 8, 'LIÊN HOAN PHIM CANNES NĂM 2024', 'Ungroup', '2024-07-07 10:11:02', '2024-07-07 10:11:02', 0);
INSERT INTO `media` VALUES (24, 'Dương Mịch | Giang Mi', 'Duong-Mich-or-Giang-Mi-1720347251974', 8, 'bộ sưu tập 2024', 'Group', '2024-07-07 10:14:12', '2024-07-07 10:14:12', 0);
INSERT INTO `media` VALUES (25, 'Trương Gia Linh  | rối và nghệ thuạt ', 'Truong-Gia-Linh-or-roi-va-nghe-thuat-1720347446515', 8, 'đây là nhân vật hư cấu trong truyện ma kinh dị rối và nghệ thuật của tác giả Hy Phạm phát sóng 22h30 trên kênh truyền đêm khuya', 'Ungroup', '2024-07-07 10:17:27', '2024-07-07 10:17:27', 0);
INSERT INTO `media` VALUES (26, 'wallpaper', 'wallpaper-1720350318500', 8, 'Adorn your iPhone with the serene beauty of a fantasy beach under a rainbow sky. This wallpaper captures a breathtaking scene where a crescent moon and stars twinkle above in soft pastel colors, offering a glimpse into a tranquil, dreamlike world. Inspired by the styles of various artists, this beautiful backdrop combines fantasy and elegance, perfect for those seeking a touch of whimsy for their device. #FantasyBeach #PastelSky #CrescentMoon #iPhoneWallpaper', 'Ungroup', '2024-07-07 11:05:19', '2024-07-07 11:05:19', 0);
INSERT INTO `media` VALUES (27, 'FireFly | loli mãi đỉnh ', 'FireFly-or-loli-mai-djinh-1720432239760', 8, 'FireFly là DPS hệ hoả vận mệnh huỷ diệt   với lối chơi break   độc đáo  hứa hẹn đem lại trãi nghiệm đỉnh cao cho các con simp', 'Ungroup', '2024-07-08 09:50:40', '2024-07-08 09:50:40', 0);
INSERT INTO `media` VALUES (28, 'Hy Phạm | tác giả truyện ma tâm lý  siêu hack não ', 'Hy-Pham-or-tac-gia-truyen-ma-tam-ly-sieu-hack-nao-1720695843225', 8, 'Hy Phạm là một tác giải tài  năng với tuyển tập truyện ma tâm lý hack não :))  cả thằng dev viết cái web  này nghe xong còn lú huống chi là dọc giải :))', 'Group', '2024-07-11 11:04:03', '2024-07-11 11:04:03', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of save_media
-- ----------------------------
INSERT INTO `save_media` VALUES (3, 18, 1, '2024-07-06 09:27:32');
INSERT INTO `save_media` VALUES (4, 19, 1, '2024-07-06 09:27:40');
INSERT INTO `save_media` VALUES (25, 19, 8, '2024-07-10 09:03:17');
INSERT INTO `save_media` VALUES (52, 27, 8, '2024-07-10 13:29:48');
INSERT INTO `save_media` VALUES (55, 20, 8, '2024-07-10 13:55:23');
INSERT INTO `save_media` VALUES (58, 25, 8, '2024-07-11 10:37:55');

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'usertest1', 'usertest1@gmail.com', 2, 'User Test', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 55, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 00:13:32', '2024-07-01 04:20:45', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJ1c2VydGVzdDEiLCJrZXkiOjE3MjA2MTcyOTE5NTgsImlhdCI6MTcyMDYxNzI5MSwiZXhwIjoxNzIzMjA5MjkxfQ.APXZefhKRLEtGDavAJJ5eBbJGNhhp4nS36T2tqkA_r4', 0);
INSERT INTO `user` VALUES (4, 'usertest2', 'usertest2@gmail.com', 1, 'User Test 2', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-21 18:34:00', '2024-06-21 18:34:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwidXNlcm5hbWUiOiJ1c2VydGVzdDIiLCJrZXkiOjE3MjAyNTAzNDY0MTMsImlhdCI6MTcyMDI1MDM0NiwiZXhwIjoxNzIyODQyMzQ2fQ.5ZApF1aFs7nMRINTeInI3vSfTsoDn2bTu-BadJ3cK5g', 0);
INSERT INTO `user` VALUES (5, 'kieulinh123', 'ogyminecraft497@gmail.com', 1, 'dang haong thien an', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 22, '$2b$10$ZRo1v7zFs95tEHvLLAj8..yQ6O1T2hUhra8004Im01Z0AcENGT3X.', '2024-06-22 13:56:19', '2024-06-22 13:56:19', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJraWV1bGluaDEyMyIsImtleSI6MTcxOTA2NDU3ODg1MywiaWF0IjoxNzE5MDY0NTc4LCJleHAiOjE3MjE2NTY1Nzh9.I-188-iXhqjtwimO2JcbuFOYEQPsms7J4BhEAPEjHk4', 0);
INSERT INTO `user` VALUES (6, 'lucadev222', 'lucan1@gmail.com', 1, 'nguyen phi phu ', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 9999, '$2b$10$7OMJSX2f252jc5ctJR000Ov9pJS2vX1nVFK.G52SKwTkbQwzUn7Hq', '2024-06-22 14:00:28', '2024-06-22 14:00:28', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwidXNlcm5hbWUiOiJsdWNhZGV2MjIyIiwia2V5IjoxNzE5MDY0ODI4NDQyLCJpYXQiOjE3MTkwNjQ4MjgsImV4cCI6MTcyMTY1NjgyOH0.4UaGAoE8qepwDo4K5WAL8af1Za964RPsFvjb-1W9TMI', 0);
INSERT INTO `user` VALUES (7, 'tieulig', 'asunayuki402@gmail.com', 1, 'dev yuki', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$iAZ7cSZ5wIwYC4W/xJQEVerPRXEfJEwZ8VDeAVdiRDwihi6wZ95Q.', '2024-06-22 14:04:24', '2024-06-22 14:04:24', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywidXNlcm5hbWUiOiJ0aWV1bGlnIiwia2V5IjoxNzE5MDY1MDY0MDAzLCJpYXQiOjE3MTkwNjUwNjQsImV4cCI6MTcyMTY1NzA2NH0.LQhmPS4vrvrxGizeFmYAsFnAEHxL5WzZ1V2vFfSsYFM', 0);
INSERT INTO `user` VALUES (8, 'devyuki123', 'dangthienphuc110312@gmail.com', 1, 'tieu lig', '', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzIwNzczMzIyNzU1LCJpYXQiOjE3MjA3NzMzMjIsImV4cCI6MTcyMzM2NTMyMn0.4DFaLQn0DvhYEVK6ZDW9wPCtg4bLEp_h_NyZsG8eWw8', 0);
INSERT INTO `user` VALUES (9, '1719656488817_devyuki1234', '1719656488817_adangthienphuc110312@gmail.com', 1, 'tieu lig', 'https://bmboosjxeycdzkofgsmx.supabase.co/storage/v1/object/public/Pinterrest_upload/DreamShaper_v6_Woman_with_platinum_hair_in_a_dress_of_ice_flow_1.jpg', 5, '$2b$10$zFCQ2Dd09UsmXOTBJjZ.E.8pEK5J241/CaT5qPu1hh6AfDZBzPjFi', '2024-06-22 14:06:55', '2024-06-22 14:06:55', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJkZXZ5dWtpMTIzIiwia2V5IjoxNzE5NDc2NzA1MDI5LCJpYXQiOjE3MTk0NzY3MDUsImV4cCI6MTcyMjA2ODcwNX0.sl1FCUplMUGovgtP2QMLqcx9ZquinauK6vuJLrTm3zk', 1);
INSERT INTO `user` VALUES (10, 'smoleo', 'smoleo@gmail.com', 1, 'Am Leo', NULL, 0, '$2b$10$TY3mKpGPrB5bbV.EotUoI.jXPEL08lO3q321szfjXzhJXsWWV5I8u', '2024-07-10 06:39:10', '2024-07-10 06:39:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsInVzZXJuYW1lIjoic21vbGVvIiwia2V5IjoxNzIwNTkzNTUwNTMxLCJpYXQiOjE3MjA1OTM1NTAsImV4cCI6MTcyMzE4NTU1MH0.ixKRBEENJcJ1p2gBSi6fFd7zx4TBqmE9r0WPE-kMIT0', 0);
INSERT INTO `user` VALUES (11, 'hantieulinh123', 'tieuligcute@gmail.com', 1, 'Kieu Linh', NULL, 22, '$2b$10$l7Os5ZROcB3EuIXlDRFjI.ejSquqh3teFadHe12pLjxh/Af97.212', '2024-07-10 07:09:00', '2024-07-10 07:09:00', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiaGFudGlldWxpbmgxMjMiLCJrZXkiOjE3MjA1OTUzMzk4NTEsImlhdCI6MTcyMDU5NTMzOSwiZXhwIjoxNzIzMTg3MzM5fQ.pCT20LEYXB1XZCOUtNFUR9zIbObeT73Uf1I0Qxc0-zs', 0);
INSERT INTO `user` VALUES (12, 'gialinh0212', 'truongialinh@gamil.com', 1, 'Trương Gia Linh', NULL, 55, '$2b$10$nkysaAnoq/B.hAtO.2KyMOSopwYLWY7518wIX1j1zO4ySH2bcntq2', '2024-07-10 08:08:10', '2024-07-10 08:08:10', 0, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsInVzZXJuYW1lIjoiZ2lhbGluaDAyMTIiLCJrZXkiOjE3MjA3NzMzMDEwNTUsImlhdCI6MTcyMDc3MzMwMSwiZXhwIjoxNzIzMzY1MzAxfQ.VBqFgF63x4c4y5zqpBiQ-wIuSolW_MpcIhtJ5hxQYE0', 0);

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
