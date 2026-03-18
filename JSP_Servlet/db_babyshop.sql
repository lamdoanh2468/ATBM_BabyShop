/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : db_babyshop

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 07/01/2026 23:00:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `profile_id` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` enum('Active','UnActive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active',
  `role` int NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`account_id`) USING BTREE,
  INDEX `fk_accounts_profiles`(`profile_id` ASC) USING BTREE,
  CONSTRAINT `fk_accounts_profiles` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (3, 3, 'lamdoanh2468@gmail.com', 'lamdoanh', '$2a$10$vAS.vm5VUY/XntZR21GxbO8yh9bpdNWg4IRDY8HbCfEhnbaGgW4k2', 'Active', 0, '2026-01-07 11:12:14');

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `brand_id` int NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `brand_logo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`brand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (2, 'RemKhanhDuong', NULL, 'Thế giới rèm trẻ em đa sắc màu từ Rèm Khánh Đường. Từ những mẫu rèm bé gái điệu đà đến rèm bé trai năng động, chúng tôi cam kết chất lượng từng đường kim mũi chỉ, mang lại vẻ đẹp sang trọng và an toàn tuyệt đối cho phòng của bé');
INSERT INTO `brands` VALUES (3, 'RoyalArt Kids', NULL, 'RoyalArt Kids là thương hiệu tranh dành cho trẻ em theo phong cách dễ thương – sáng tạo – giáo dục nhẹ nhàng. Màu sắc tươi sáng, hình họa đơn giản mà thông minh, giúp kích thích trí tưởng tượng và khả năng quan sát của bé. Bộ sưu tập phù hợp để treo phòng ngủ, phòng học hoặc khu vui chơi, tạo không gian vui tươi và an toàn cho trẻ nhỏ.');
INSERT INTO `brands` VALUES (4, 'LuxCanvas Premium', NULL, 'LuxCanvas Premium tập trung vào dòng tranh trẻ em cao cấp, đề cao sự tinh tế trong từng nét vẽ. Màu sắc hài hòa, chủ đề hiện đại, hướng tới không gian sống sang trọng nhưng vẫn thân thiện với trẻ. Đây là lựa chọn hoàn hảo cho các gia đình muốn tạo điểm nhấn nghệ thuật nhẹ nhàng, tinh tế mà không đánh mất sự đáng yêu của thế giới trẻ thơ.');
INSERT INTO `brands` VALUES (5, 'Elite Gallery', NULL, 'Elite Gallery mang đến phong cách tranh trẻ em nghệ thuật – độc đáo – mang dấu ấn sáng tạo riêng biệt. Các tác phẩm được thiết kế theo hướng mỹ thuật hơn, giúp trẻ tiếp cận thế giới nghệ thuật từ sớm. Từng bức tranh đều có câu chuyện nhỏ bên trong, tạo cảm giác gần gũi, truyền cảm hứng và khơi mở trí tò mò của trẻ.');
INSERT INTO `brands` VALUES (6, 'LUXURY TopKids', NULL, 'Thương hiệu bàn ghế học sinh cao cấp');
INSERT INTO `brands` VALUES (7, 'Fancy TopKids', NULL, 'Thương hiệu bàn ghế học sinh thông minh, chống gù chống cận');
INSERT INTO `brands` VALUES (8, 'DELUX TopKids', NULL, 'Dòng sản phẩm cao cấp từ TopKids');
INSERT INTO `brands` VALUES (9, 'Comus TopKids', NULL, 'Bàn ghế học sinh Comus');
INSERT INTO `brands` VALUES (10, 'WOODEN TopKids', NULL, 'Chuyên các dòng bàn gỗ tự nhiên');
INSERT INTO `brands` VALUES (11, 'Thương hiệu TopKids', NULL, NULL);
INSERT INTO `brands` VALUES (12, 'BBT Global', NULL, 'Thương hiệu đồ chơi trẻ em, thiết bị vận động chất lượng cao');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `category_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Đồ Nội Thất', 'https://gotrangtri.vn/wp-content/uploads/2024/04/avar-giuong-go-2-tang-tre-em.jpg', 'Các sản phẩm nội thất dành cho bé như giường, tủ, bàn ghế');
INSERT INTO `categories` VALUES (2, 'Đồ Trang Trí', 'https://lumitex.vn/upload/product/22-8-2024/rem-tre-em-60.png', 'Các sản phẩm trang trí phòng cho bé');
INSERT INTO `categories` VALUES (3, 'Đồ Chơi', 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-11.jpg', 'Các loại đồ chơi an toàn và phát triển trí tuệ cho bé');

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `full_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`contact_id`) USING BTREE,
  INDEX `fk_contacts_accounts`(`account_id` ASC) USING BTREE,
  CONSTRAINT `fk_contacts_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contacts
-- ----------------------------

-- ----------------------------
-- Table structure for favorite_products
-- ----------------------------
DROP TABLE IF EXISTS `favorite_products`;
CREATE TABLE `favorite_products`  (
  `favorite_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`favorite_id`) USING BTREE,
  INDEX `fk_favorites_accounts`(`account_id` ASC) USING BTREE,
  INDEX `fk_favorites_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_favorites_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_favorites_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorite_products
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_price` int NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`) USING BTREE,
  INDEX `fk_orderdetails_orders`(`order_id` ASC) USING BTREE,
  INDEX `fk_orderdetails_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_orderdetails_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetails_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  `status` enum('Pending','Done','Cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Pending',
  `total_amount` int NULL DEFAULT NULL,
  `delivery_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `payment_method` enum('COD','Card') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'COD',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_orders_accounts`(`account_id` ASC) USING BTREE,
  INDEX `fk_orders_vouchers`(`voucher_id` ASC) USING BTREE,
  CONSTRAINT `fk_orders_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_vouchers` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`voucher_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for product_details
-- ----------------------------
DROP TABLE IF EXISTS `product_details`;
CREATE TABLE `product_details`  (
  `product_detail_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `detail_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`product_detail_id`) USING BTREE,
  INDEX `fk_productdetails_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_productdetails_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 373 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_details
-- ----------------------------
INSERT INTO `product_details` VALUES (1, 25, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+Tranh Canvas: Tranh phi hành gia treo phòng bé trai cực chất\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (2, 25, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (3, 25, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (4, 26, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+ Tranh Canvas Tranh treo tường trẻ em màu nước dễ thương\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (5, 26, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', NULL);
INSERT INTO `product_details` VALUES (6, 26, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (7, 27, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+ Tranh Canvas Tranh treo tường gấu trắng ngộ nghĩnh trang trí phòng bé trai\r\n\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (8, 27, 'https://xuongtranh.net/uploads/w900/2022/12/13/vien-tranh.jpg', NULL);
INSERT INTO `product_details` VALUES (9, 27, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (10, 28, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+ Tranh Canvas Tranh treo phòng phi hành gia trang trí phòng bé trai đẹp\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (11, 28, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', NULL);
INSERT INTO `product_details` VALUES (12, 28, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (13, 29, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+ Tranh Canvas Tranh treo tường Sweet Dream cho bé trai\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (14, 29, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', NULL);
INSERT INTO `product_details` VALUES (15, 29, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (16, 30, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', '+ Tranh Canvas Tranh treo phòng bé gái đáng yêu với cá heo\r\nChất liệu tranh: Tranh được in trên vải canvas chất lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (17, 30, 'https://xuongtranh.net/uploads/w900/2022/12/13/khung-tranh-canvas.jpg', NULL);
INSERT INTO `product_details` VALUES (18, 30, 'https://xuongtranh.net/uploads/w900/2022/12/13/chat-lieu-vai.jpg', NULL);
INSERT INTO `product_details` VALUES (19, 31, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh PP treo phòng trẻ em cá heo và bé cái cầm bóng bay\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (20, 32, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh PP kỳ lân và cầu vồng đáng yêu cho bé gái\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (21, 33, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh PP khủng long ngộ nghĩnh trang trí phòng bé trai\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (22, 34, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh PP động vật ngộ nghĩnh trang trí phòng trẻ em\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (23, 35, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+  Tranh PP công chúa múa bale trang trí phòng bé gái\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (24, 36, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+Tranh PP mèo vàng và bé gái màu nước cực đẹp\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (25, 37, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh PP cá heo xanh và bé gái ngộ nghĩnh\r\nChất liệu tranh: in trên chất liệu giấy PP... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (26, 38, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica  thỏ và bóng bay ngộ nghĩnh\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (27, 39, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica  Lovely động vật màu sắc trang trí phòng bé\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (28, 40, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica  động vật ngộ nghĩnh treo phòng bé\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (29, 41, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+Tranh gỗ mica  treo phòng ngủ mèo dễ thương cho bé\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (30, 42, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica treo phòng bé gái nàng tiên cá\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (31, 43, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica cá heo treo phòng bé ngộ nghĩnh\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (32, 44, 'https://xuongtranh.net/uploads/w900/2022/12/13/chong-nuoc.jpg', '+ Tranh gỗ mica  phi hành gia ngộ nghĩnh trang trí phòng bé trai\r\nChất liệu tranh: in trên gỗ Mica... Sau khi in tranh, bề mặt tranh sẽ được phủ lên lớp bóng gương để tạo độ sáng, nhẵn bóng. Lớp gương này giúp tranh có chiều sâu và có hồn không lượng cao, in bằng mực UV sắc nét 10 năm không bị phai màu. Mặt tranh Tranh treo phòng bé được phủ lớp sơn bóng chống thấm nước');
INSERT INTO `product_details` VALUES (39, 7, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-3.jpg', 'Thiết kế rèm trẻ em với họa tiết hoạt hình sinh động như Mickey, Doraemon, Tom & Jerry giúp bé vui chơi và ngủ ngon hơn.');
INSERT INTO `product_details` VALUES (40, 7, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (41, 7, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (42, 8, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-4-1.jpg', 'Rèm trẻ em với họa tiết hoạt hình bắt mắt, tạo không gian vui nhộn và dễ chịu cho bé.');
INSERT INTO `product_details` VALUES (43, 8, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-3-1.jpg', NULL);
INSERT INTO `product_details` VALUES (44, 8, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-5.jpg', NULL);
INSERT INTO `product_details` VALUES (45, 9, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-2-1.jpg', 'Thiết kế rèm trẻ em phù hợp phòng ngủ bé với họa tiết sinh động, giúp bé ngủ ngon hơn.');
INSERT INTO `product_details` VALUES (46, 9, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (47, 9, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-4.jpg', NULL);
INSERT INTO `product_details` VALUES (48, 10, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-3-1.jpg', 'Rèm trẻ em với phong cách hiện đại, màu sắc tươi sáng phù hợp nhiều không gian phòng bé.');
INSERT INTO `product_details` VALUES (49, 10, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (50, 10, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (51, 11, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-2-1.jpg', 'Rèm trẻ em cao cấp được nhiều gia đình lựa chọn, an toàn và thẩm mỹ cho bé.');
INSERT INTO `product_details` VALUES (52, 11, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (53, 11, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-4.jpg', NULL);
INSERT INTO `product_details` VALUES (54, 12, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-3-1.jpg', 'Rèm trẻ em với họa tiết sinh động, mang lại không gian vui vẻ cho bé.');
INSERT INTO `product_details` VALUES (55, 12, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (56, 12, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-4.jpg', NULL);
INSERT INTO `product_details` VALUES (57, 13, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-3-1.jpg', 'Rèm trẻ em phong cách hoạt hình, tạo cảm giác thân thiện và đáng yêu.');
INSERT INTO `product_details` VALUES (58, 13, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (59, 13, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (60, 14, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-133.jpg', 'Thiết kế rèm phù hợp phòng ngủ trẻ em, tạo không gian ấm áp và sinh động.');
INSERT INTO `product_details` VALUES (61, 14, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-133.jpg', NULL);
INSERT INTO `product_details` VALUES (62, 14, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-135.jpg', NULL);
INSERT INTO `product_details` VALUES (63, 15, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-7-1.jpg', 'Rèm trẻ em cao cấp với nhiều mẫu mã đáng yêu cho bé.');
INSERT INTO `product_details` VALUES (64, 15, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-6-1.jpg', NULL);
INSERT INTO `product_details` VALUES (65, 15, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-5-2.jpg', NULL);
INSERT INTO `product_details` VALUES (66, 16, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-2-1.jpg', 'Các thiết kế trong nội thất đặc biệt là rèm cửa cũng được quan tâm hàng đầu. Những họa tiết hoạt hình, nhân vật cổ tích hay con vật như sư tử, hươu cao cổ tạo nên không gian vui nhộn, dễ chịu cho bé. Rèm Khánh Đường với hơn 10 năm kinh nghiệm mang đến không gian tuyệt vời cho con yêu.');
INSERT INTO `product_details` VALUES (67, 16, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (68, 16, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-3.jpg', NULL);
INSERT INTO `product_details` VALUES (69, 17, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-dep-tm-866-2-1.jpg', 'Trong cuộc sống hiện đại, mỗi gia đình đều dành không gian riêng cho bé. Rèm với họa tiết hoạt hình quen thuộc như Mickey, Doraemon, Tom & Jerry giúp bé vui chơi thoải mái và ngủ ngon hơn.');
INSERT INTO `product_details` VALUES (70, 17, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-dep-tm-866-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (71, 17, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-dep-tm-866-3.jpg', NULL);
INSERT INTO `product_details` VALUES (72, 18, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-181-sao-chep.jpg', 'Rèm Khánh Đường là đơn vị chuyên sản xuất rèm vải trẻ em với hơn 10 năm kinh nghiệm, mang đến không gian sống an toàn và đẹp mắt cho bé.');
INSERT INTO `product_details` VALUES (73, 18, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-tm885-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (74, 18, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-1711.jpg', NULL);
INSERT INTO `product_details` VALUES (75, 19, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-dep-tm-867-3-1.jpg', 'Không gian phòng bé được chăm chút với các mẫu rèm họa tiết sinh động, giúp bé phát triển trí tưởng tượng và có giấc ngủ ngon hơn. Rèm Khánh Đường là lựa chọn đáng tin cậy của nhiều gia đình.');
INSERT INTO `product_details` VALUES (76, 19, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-dep-tm-867-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (77, 19, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-dep-tm-867-4.jpg', NULL);
INSERT INTO `product_details` VALUES (78, 20, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-3-1.jpg', 'Rèm phòng bé với màu sắc tươi sáng, họa tiết quen thuộc giúp bé cảm thấy an toàn và vui vẻ trong không gian riêng của mình.');
INSERT INTO `product_details` VALUES (79, 20, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (80, 20, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (81, 21, 'https://remkhanhduong.com/wp-content/uploads/2025/09/phong-be-223.jpg', 'Rèm Khánh Đường mang đến những mẫu rèm trẻ em an toàn, thẩm mỹ và phù hợp với nhiều không gian phòng ngủ của bé.');
INSERT INTO `product_details` VALUES (82, 21, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-be-gai-tm-86899-1-2.jpg', NULL);
INSERT INTO `product_details` VALUES (83, 21, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-be-gai-tm-86899-4.jpg', NULL);
INSERT INTO `product_details` VALUES (84, 22, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-hoa-tiet-hoat-hinh-5.jpg', 'Rèm trẻ em họa tiết hoạt hình vừa cản nắng, cản sáng vừa tạo điểm nhấn trang trí cho phòng ngủ của bé.');
INSERT INTO `product_details` VALUES (85, 22, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-hoa-tiet-hoat-hinh-112.jpg', 'Rèm vải hai lớp gồm voan mỏng và lớp vải dày giúp che nắng, cách nhiệt và giảm tiếng ồn, rất tiện dụng cho phòng bé.');
INSERT INTO `product_details` VALUES (86, 22, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-hoa-tiet-hoat-hinh-4.jpg', NULL);
INSERT INTO `product_details` VALUES (87, 23, 'https://remkhanhduong.com/wp-content/uploads/2025/09/chiem-nguong-ve-dep-rem-vai-tre-em-tr-202.jpg', 'Rèm trẻ em TR 202 giúp tạo môi trường sống tốt cho bé, là người bạn thân thiết trong không gian phòng ngủ.');
INSERT INTO `product_details` VALUES (88, 23, 'https://remkhanhduong.com/wp-content/uploads/2025/09/thich-mat-voi-mau-rem-cua-cho-be-trai-tr-202-quan-tay-ho-3.jpg', 'Sản phẩm rèm vải hai lớp với lớp voan mỏng cản bụi và lớp vải dày cản nắng, giảm tiếng ồn hiệu quả.');
INSERT INTO `product_details` VALUES (89, 23, 'https://remkhanhduong.com/wp-content/uploads/2025/09/thich-mat-voi-mau-rem-cua-cho-be-trai-tr-202-quan-tay-ho-2.jpg', NULL);
INSERT INTO `product_details` VALUES (90, 24, 'https://remkhanhduong.com/wp-content/uploads/2025/09/remvaimauhongchophongbeyeumamjl5034-41.jpg', 'Rèm vải màu hồng cho phòng bé gái giúp tạo không gian mềm mại, dễ thương và giúp bé ngủ ngon hơn.');
INSERT INTO `product_details` VALUES (91, 24, 'https://remkhanhduong.com/wp-content/uploads/2025/09/remvaimauhongchophongbeyeumamjl5034-5.jpg', 'Rèm được sản xuất từ chất liệu vải thân thiện với môi trường, an toàn cho sức khỏe của bé và dễ vệ sinh.');
INSERT INTO `product_details` VALUES (92, 24, 'https://remkhanhduong.com/wp-content/uploads/2025/09/remvaimauhongchophongbeyeumamjl5034-11.jpg', 'Rèm vải trẻ em màu hồng với màu sắc tươi vui, phù hợp tâm lý trẻ nhỏ và giúp cản nắng hiệu quả.');
INSERT INTO `product_details` VALUES (93, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-70qi0p7QS57ODDc6bbiqqQS8iTs6uxjl2GYsBE5dOnM50QO0UjD.png', 'ƯU ĐIỂM: Bàn ghế điều chỉnh chiều cao bằng tay quay dễ sử dụng, độ bền cao. Mặt bàn nghiêng thủy lực thao tác nhẹ nhàng. Ghế xoay cao cấp với 2 miếng tựa lưng giúp giảm áp lực cột sống. Đèn 03 chế độ sáng với dãy màu từ 2000 – 2400 an toàn cho trẻ. Giá sách 2 tầng.');
INSERT INTO `product_details` VALUES (94, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', NULL);
INSERT INTO `product_details` VALUES (95, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-9d7qAM0UaPGJtMzbXceRKa9oPmkvzh0c423yEj4LJlyygq8ZmZi.jpg', NULL);
INSERT INTO `product_details` VALUES (96, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-16px7fSINAXIU2dES316lq7ITrGUwZTWxkWk4Laikc9T8MYfB0xF.png', NULL);
INSERT INTO `product_details` VALUES (97, 47, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/tk4-hinh-5eonAFpSGayTLvSHW1qd5ASnv33i1BjOjA53LoxYTGKIT8WuzGj.png', 'BÀN HỌC THÔNG MINH CHO BÉ MẪU CẢI TIẾN FANCY TK4 NEW VERSION (sử dụng công nghệ Đức). Bộ bàn học cho trẻ hỗ trợ chống gù chống cận cải tiến TK4 New Version đến từ nhà Topkids với thiết kế mới cải tiến về không gia kệ mang đến không gian chứa đựng dụng cục học tập khoa học.');
INSERT INTO `product_details` VALUES (98, 47, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/tk4-hinh-6SJQV31FhYrIkgpyhxdtuLDmawyCNQ7kdsSPik4XxBDwf2qqgTz.png', NULL);
INSERT INTO `product_details` VALUES (99, 47, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/tk4-hinh-72nUi66xYCPEdXPTsFufxyJDYDqYVc6o9y3bqHsmG9TGXZL9eRC.jpg', 'Bàn học chống gù cao cấp: Thiết kế thông minh cho phép điều chỉnh chiều cao mặt bàn phù hợp với từng giai đoạn phát triển của bé. Giúp bé ngồi học đúng tư thế, hạn chế mỏi lưng, đau vai gáy. Đảm bảo cột sống khỏe. Đạt chứng nhận tiêu chuẩn EU.');
INSERT INTO `product_details` VALUES (100, 48, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'Bàn học thông minh TOPKIDS MACARON CAO CẤP. Sản phẩm mới nhất của Topkids, được thiết kế phù hợp cho các em nhỏ từ 3 tuổi trở lên. Bàn được làm từ chất liệu CỐT GỖ TỰ NHIÊN, phủ lớp melamin/Matte chống lóa cao cấp.');
INSERT INTO `product_details` VALUES (101, 48, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', 'Bàn học thông minh MACARON: Khả năng chống bám bụi, mối mọt và trầy xước xuất sắc. Với chất liệu cốt gỗ tự nhiên được phủ lớp matte chống lóa, bàn này đạt độ bền gấp 20 lần so với các mẫu khác trên thị trường.');
INSERT INTO `product_details` VALUES (102, 48, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', 'Bàn học thông minh chống gù cao cấp: Thiết kế thông minh cho phép điều chỉnh chiều cao mặt Bàn phù hợp với từng giai đoạn phát triển của bé. Giúp bé ngồi học đúng tư thế. Đạt chứng nhận tiêu chuẩn EU.');
INSERT INTO `product_details` VALUES (103, 49, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-thong-minh-round-hinh-1mV5RNokE5ooKq2IcpM0a1rFg3lBnxSafUtR0JSE96pxjjCs5OO.jpg', 'Bàn Thông Minh Chống Gù Chống Cận ROUND. Bộ bàn học thông minh thế hệ mới đến từ nhà Topkids với thiết kế là sự kết hợp từ gỗ tự nhiên và khung thép không rỉ mang lại sự sang trọng.');
INSERT INTO `product_details` VALUES (104, 49, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-thong-minh-round-hinh-29oRL4AJzdVLOAt5oCjOAVyeqASpm46RDWcjqZUdl2Bbi1ZvYZY.jpg', NULL);
INSERT INTO `product_details` VALUES (105, 49, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-thong-minh-round-hinh-6ELZI3E7199q3ZvnwrVCC3ZIqX9mHagL2ovppE2XkGeF1OFXUbD.jpg', NULL);
INSERT INTO `product_details` VALUES (106, 50, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/voucher-fancy06liTXE2By1UeGpclUhNvrm8qNxEWhZvhh0UM5Gm1aBrSKIWZv.jpg', 'Bàn Học Thông Minh Cho Trẻ Thế hệ Mới Mẫu Cải Tiến Tk2');
INSERT INTO `product_details` VALUES (107, 50, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-cho-tre-tk2-hinh-3e1s8B0QdKiU0dSTmR54Ngbh8FCXYaoEpRmMaByn8vSiEIwGXbv.jpg', 'Khung bàn chắc chắn, phun sơn tĩnh điện không gỉ sét, cấu tạo từ các thanh thép dày 3mm, chịu lực tốt, không rung lắc.');
INSERT INTO `product_details` VALUES (108, 50, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-cho-tre-tk2-hinh-5sCkCF2pF8L3sQqQPUpvqLSQxOBtb1PcdsJbt9ZLvkS52nMTpy3.jpg', 'Mặt bàn nghiêng từ 0 đến 75 độ (cải tiến hơn về độ nghiêng mặt bàn so với các dòng đến 60 độ)');
INSERT INTO `product_details` VALUES (109, 51, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6671733855882_aea7d4b507b882fe2225aacb2d1f94b1A3XWc0VezbIzoeDmccvllBoOlNfcTjKyPUPzZPW4lDZ4ujP9bR.jpg', 'Bàn Học Thông Minh BULL – Đồng Hành Cùng Bé Vươn Xa Tương Lai');
INSERT INTO `product_details` VALUES (110, 51, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6694934210704_73564e50925012c4177900e257a41c06IiC2JxwlNUVMXnOVHKqHDi8uY5s6qJw9lXU9NsDGzzQ0Qgx0JM.jpg', NULL);
INSERT INTO `product_details` VALUES (111, 51, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6679243397818_2bf3e15caf2fa623fb010504e40bb31eHVqqsjvzVz6dY0glR1OBXJ9MTmGT8L5HzVVTVZP5E304Tbndd3.jpg', NULL);
INSERT INTO `product_details` VALUES (112, 52, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'Bộ Bàn Ghế Thông Minh Chống Gù Chống Cận Lux Pro 3');
INSERT INTO `product_details` VALUES (113, 52, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', 'Bàn học thông minh của TOPKIDS là giải pháp hữu hiệu ngăn chặn bệnh học đường: Chống gù, chống cận. Nhập khẩu trực tiếp 100%. Bảo hành 3 năm.');
INSERT INTO `product_details` VALUES (114, 52, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', NULL);
INSERT INTO `product_details` VALUES (115, 53, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/h120-hinh-3XrcoDtNk57WoK5J8zMQRXv7bLGXchjmpmiya9IT29ZVvVbPL61.png', 'Bàn Học Thông Minh Cho Trẻ Phiên Bảng 2025 FANCY H120. Công nghệ đến từ ĐỨC, bàn học cho trẻ FANCY H120 được nâng cấp với các học tủ và kệ rộng rãi giúp bé nhà ta có thể thỏa sức đựng các dụng cụ học tập.');
INSERT INTO `product_details` VALUES (116, 53, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/7_2SsGMe4bE7lnARS0DXojekUli9swuTLwuCm2qR9reoqLNFbAfKx.png', 'Chất liệu từ gỗ tự nhiên & Chân bàn là thép carbon. Mặt bàn và các kệ được thiết kế từ gỗ nhập khẩu nguyên mảng nên có tính chịu lực cao, mặt bàn được phủ các lớp melamin chống mài mòn chống ẩm chống cháy hiệu quả.');
INSERT INTO `product_details` VALUES (117, 53, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fancy-jz-hinh-23RykES5VHOyBwUZZDJnmq9JznLXnsilPb34AApr3rpud1vuNqZh.jpg', NULL);
INSERT INTO `product_details` VALUES (118, 54, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'MACARON - Bộ Bàn Ghế Thông Minh Cho Trẻ Với Công Nghệ Chống Gù Chống Cận. Kết hợp từ gỗ tự nhiên và khung thép không rỉ.');
INSERT INTO `product_details` VALUES (119, 54, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', NULL);
INSERT INTO `product_details` VALUES (120, 54, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', NULL);
INSERT INTO `product_details` VALUES (121, 55, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'Bộ Bàn Học Thông Minh Chống Gù Chống Cận A12 Lux Pro 2 Và Ghế G1');
INSERT INTO `product_details` VALUES (122, 55, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', 'Dòng bàn cao cấp đạt đầy đủ các chứng chỉ quốc tế trên dây chuyền công nghệ Châu Âu như: Chứng nhận an toàn và sức khỏe chuẩn CNAS, Safety Mark, SGS Thụy Sĩ.');
INSERT INTO `product_details` VALUES (123, 55, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', NULL);
INSERT INTO `product_details` VALUES (124, 56, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/hinh-2uBbKj2rIbDzqueYwlFxTf4ieQqCcRULHimrXVX0UkmDcJBrqZ7.jpg', 'Bàn Ghế học thông minh chống gù chống cận Ergonomic FANCY. Mặt bàn đa năng thông minh, linh hoạt có thể điều chỉnh góc độ nghiêng lên đến 50 độ.');
INSERT INTO `product_details` VALUES (125, 56, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/hinh-1KapcSEHZtN6KeOmr4PmYxwdJsRZbQj8zzAJNdbci93qPKUuut8.jpg', 'Mặt bàn được thiết kế từ chất liệu gỗ tự nhiên, có độ bền cao, không lo ẩm mốc. Giúp phòng ngừa các vấn đề sức khỏe do sai tư thế ngồi.');
INSERT INTO `product_details` VALUES (126, 56, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fancy-jz-hinh-23z1WaYsUeIDKAahyD0dNrJKmc1TKTjI8AbUyQd9iikRFkleDoSb.jpg', 'Bộ Bàn Học Thông Minh FANCY - là một sự lựa chọn hoàn hảo, kết hợp giữa thiết kế độc đáo và đa tính năng tiện ích. Màu bàn vân gỗ phù hợp với thị hiếu của người Việt Nam.');
INSERT INTO `product_details` VALUES (127, 57, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'Bàn học thông minh chống gù chống cận VANCOVER');
INSERT INTO `product_details` VALUES (128, 57, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', 'Mặt bàn được thiết kế với 100% gỗ sồi tự nhiên nguyên khối có khả năng chống thấm tốt. Lớp chống mài mòn, chống ẩm chống lóa.');
INSERT INTO `product_details` VALUES (129, 57, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', NULL);
INSERT INTO `product_details` VALUES (130, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6750925909185_2c728414cf2a03be87b6afe7992abbf4OWG8xVwS8JSjEVCKY464xJJorlftWrca5FISqmLo6Rn4cMcMWf.jpg', NULL);
INSERT INTO `product_details` VALUES (131, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6750925957760_94e75040cc37747748010048f57e47cfuWMtYxUWM0iSIw2PWLyydIOJ42ydO8HSnrf5gMkAFnuxmbgpC6.jpg', NULL);
INSERT INTO `product_details` VALUES (132, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/z6750926029274_733a890ad67000c6974895f9409886ecbqzC7iUotucrMuYLyqaZ2cGdodVBrT8XXj1f9BKBI4OosW9szZ.jpg', NULL);
INSERT INTO `product_details` VALUES (133, 59, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/mLMrIvZ5XR1OhTcqqVg4CDumG4y89tcYHef2ixjn6MuiFXHANCTOPKID%20VIETNAM%20l%C3%A0%20th%C6%B0%C6%A1ng%20hi%E1%BB%87u%20TI%C3%8AN%20PHONG%20-%20%C4%90%E1%BA%B2NG%20C%E1%BA%A4P%20-%20CH%E1%BA%A4T%20L%C6%', 'Bộ Bàn Ghế Thông Minh Chống Gù Chống Cận T1');
INSERT INTO `product_details` VALUES (134, 59, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-thong-minh-t1-hinh-3I11r3BpB6vapyDfIwOVrKLodX7gRE0css7kDn2HZvVKuBC8vBqI11r3BpB6vapyDfIwOVrKLodX7gRE0css7kDn2HZvVKuBC8vBq.jpg', 'Khung bàn chắc chắn, phun sơn tĩnh điện không gỉ sét kết hợp công nghệ ultra-fit kiên cố chống rung tuyệt đối. Bàn FANCY T1 thuộc dòng bàn cao cấp được TOPKIDS độc quyền nhập khẩu.');
INSERT INTO `product_details` VALUES (135, 60, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros100_hinh-4d4XynyneK4ZNMTJV7VKV4PSogVVtAypjLVKyuRQxMoBDF2h05L.png', 'Bộ Bàn Học Thông Minh Cho Trẻ Thế Hệ Mới FANCY ROS 100H. Mẫu bàn cải tiến với chất liệu từ gỗ tự nhiên nguyên khối. Bàn được cập nhật ngoài không gian học đa dụng còn bổ sung nhiều tính năng như kệ máy tính bản, bản từ tính.');
INSERT INTO `product_details` VALUES (136, 60, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros100_hinh-91Dt0DWhwdDbLs79dAOtKCpeL1NvtrSYKGZni1f4XyFQBo0o8Nc.png', 'Trang bị không gian khoang chứa thông minh tận 5 ngăn kệ và 1 học tủ kéo cho bé thỏa sức để sách vở dụng cụ học tập.');
INSERT INTO `product_details` VALUES (137, 60, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros100_hinh-13LMXrIYLnQzn4xWLjaNwHRanNBg6W2ti7rcyW98Np99fwfYERUX.png', 'Bàn được trang bị hoàn toàn từ gỗ tự nhiên từ mặt bàn đến các kệ. Mặt bàn được phủ đến 2 lớp gồm lớp chống mài mòn và chống lóa.');
INSERT INTO `product_details` VALUES (138, 61, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-gjhh105t-va-y001-hinh-5WqEgyapKA8YdGC974nWIU3qplsQICk2IgcJToS8qvlyD5cpVpD.png', 'Bộ Bàn Ghế Thông Minh Chống Gù Chống Cận GJHH105T và Y001 Pink Đến Từ Nhà TopKids');
INSERT INTO `product_details` VALUES (139, 61, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-gjhh105t-va-y001-hinh-10rDNgBPxbh5nz5r8NKB1KVzVPjivmguGqanKbqmle6VrGmClqyM.png', 'Bàn học chống gù chống cận cho bé, mẫu bàn thông minh A10 LUX G1 là mẫu bàn đạt chất lượng theo tiêu chuẩn Châu Âu. Thiết kế chuẩn Ergonomics.');
INSERT INTO `product_details` VALUES (140, 61, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ban-hoc-gjhh105t-va-y001-hinh-11PSNym6ZETlvrCTuGs2bahVc8CghxGM2LAS3c6kjbNLjupUQ6iB.png', 'Kệ sách và ngăn chứa đồ rộng rãi, kệ sách thiết kế độc đáo mới lạ và chắc chắn, bé thoải mái học online.');
INSERT INTO `product_details` VALUES (141, 62, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros1003HfZmxYq9qDPKsdZp6CjlMCm9RnkV855eANrS1O28WC3bfhuvZ.png', 'Bàn Học Thông Minh Cho Trẻ Thế Hệ Mới FANCY ROS 100 Sản Phẩm Bàn Học Thông Minh Của Năm 2025. Mẫu bàn học cải tiến với chất liệu từ gỗ tự nhiên nguyên khối. Bổ sung nhiều tính năng như kệ máy tính bản, bản từ tính, bảng note đa dụng.');
INSERT INTO `product_details` VALUES (142, 62, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros100_hinh-1s7hQAx3BUaRoWffBx33NDqFeYpUEduFoRzC4PiCvOA1XZsc0Wg.png', 'Bàn học thông minh cho bé ROS 100 có nhiều tiện ích hơn. Không gian kệ và ngăn kéo rộng rãi. Trang bị Bản từ tính phía sau. Mặt bàn trang bị lớp Matte chống lóa. Có trang bị thêm móc treo cặp tiện dụng.');
INSERT INTO `product_details` VALUES (143, 62, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ros100_hinh-13LMXrIYLnQzn4xWLjaNwHRanNBg6W2ti7rcyW98Np99fwfYERUX.png', 'Bàn được trang bị hoàn toàn từ gỗ tự nhiên từ mặt bàn đến các kệ. Mặt bàn được phủ đến 2 lớp gồm lớp chống mài mòn và chống lóa.');
INSERT INTO `product_details` VALUES (144, 63, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-9Qs01dPuEgROK0t1qQ6GLZe4ASQwHRF2NxgY9wrVmN2JxKQNx7r.png', 'Dòng ghế FAN 05 là dòng ultra luxury với tính năng chống gù ưu việt:\nBabyStore luôn luôn đồng hành với tương lai của thế hệ con em chúng ta. Hôm nay mang đến cho quý phụ huynh và các bạn một sản phẩm ghế chống gù chống cận mới. \nGhế được thiết kế cải tiến nhiều hơn so với các mẫu cũ, Chất liệu cao cấp chống gù chống cận hiệu quả luôn, mang đến sự thoải mái nhất cho bé khi ngồi học tập và giải trí trên ghế.- Ghế được thiết kế với các chất liệu cao cấp như: Thép không rỉ, cao su non, nhựa ABS giúp ghế có độ bền cao và toát lên vẻ sang trọng, thiết kế tiên tiến phù hợp với mọi không gian nội thất gia đình việt.');
INSERT INTO `product_details` VALUES (145, 63, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-11pIBhzZA04Vcz4PCy0zwUCmDUvR7Br3xGRtwoZJBOPX5CjwNWoL.png', '✅ Đệm ngồi cao su dày dặn, lưng 2 mảnh thoáng khí làm giảm áp lực cột sống.\nVới cao su non cao cấp giúp bé có thể ngồi thoải mái hơn độ đàn hồi từ cao su ôm sát lưng giúp bé ngồi thẳng lưng đúng tư thế tránh các bệnh về lưng và cột sống. Đệm tự lưng và ngồi có vải thoát khí nên khi bé ngồi sẽ không có cảm giá nóng bí bách giúp bé có thể tập chung hơn trong quá trình học tập');
INSERT INTO `product_details` VALUES (146, 63, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-12oepKqpJDE8WT6OihsqvORfcfwqijP6dHgSZi38EWrEJci95gDj.jpeg', NULL);
INSERT INTO `product_details` VALUES (147, 64, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-9Qs01dPuEgROK0t1qQ6GLZe4ASQwHRF2NxgY9wrVmN2JxKQNx7r.png', 'Ghế Điều Chỉnh Độ Cao Chống Gù G8 Ultra Luxury Thế Hệ Mới Topkids');
INSERT INTO `product_details` VALUES (148, 64, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-11pIBhzZA04Vcz4PCy0zwUCmDUvR7Br3xGRtwoZJBOPX5CjwNWoL.png', 'Đây là sản phẩm với kết cấu rắn chắn với phần chân đế to, dày và hoành tráng nhất hiện nay.\n1. Ghế bằng cao su đúc định hình nâng hạ chiều cao độc lập 3 chức năng là: đệm ngồi, lưng tựa, nới rộng lòng ghế khi bé trưởng thành.\n2. Tựa lưng ngoàiviệc di chuyển lên xuống còn có trục bập bênh ôm lưng khi ngồi giúp con ngồi thẳng lưng mà không bị mỏi.\n3. Lòng ghế có tính năng đẩy đệmra xa bằng cần gạc như ghế tài xế. Ghế cao cấp có bánh xe phanh trọng lực.\n4. Bánh xe tự động khóatrọng lực giúp con không bị trượt ngã.Khi di chuyển trọng lực tự động mở bánh xe đẩy ghế di chuyển dễ dàng.');
INSERT INTO `product_details` VALUES (149, 64, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-12oepKqpJDE8WT6OihsqvORfcfwqijP6dHgSZi38EWrEJci95gDj.jpeg', NULL);
INSERT INTO `product_details` VALUES (150, 65, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-9Qs01dPuEgROK0t1qQ6GLZe4ASQwHRF2NxgY9wrVmN2JxKQNx7r.png', 'Ghế Điều Chỉnh Độ Cao Chống Gù CO2D');
INSERT INTO `product_details` VALUES (151, 65, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-11pIBhzZA04Vcz4PCy0zwUCmDUvR7Br3xGRtwoZJBOPX5CjwNWoL.png', NULL);
INSERT INTO `product_details` VALUES (152, 65, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-12oepKqpJDE8WT6OihsqvORfcfwqijP6dHgSZi38EWrEJci95gDj.jpeg', NULL);
INSERT INTO `product_details` VALUES (153, 66, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-9Qs01dPuEgROK0t1qQ6GLZe4ASQwHRF2NxgY9wrVmN2JxKQNx7r.png', 'Ghế Điều Chỉnh Chiều Cao Chống Gù G9 Thế Hệ Mới 2025\nMẫu ghế cải tiến thế hệ mới cho bé, giúp hỗ trợ chống gù chống cận hiệu quả, chân ghế vữ chắc, cải tiếng thêm nút khóa bánh dễ dàng giúp cố định ghếĐây là sản phẩm với kết cấu rắn chắn với phần chân đế to, dày và hoành tráng nhất hiện nay.');
INSERT INTO `product_details` VALUES (154, 66, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-11pIBhzZA04Vcz4PCy0zwUCmDUvR7Br3xGRtwoZJBOPX5CjwNWoL.png', '1. Ghế bằng cao su đúc định hình nâng hạ chiều cao độc lập 3 chức năng là:Đệm ngồiLưng tựaNới rộng lòng ghế khi bé trưởng thành.\n2. Tựa lưng ngoàiviệc di chuyển lên xuống còn có trục bập bênh ôm lưng khi ngồi giúp con ngồi thẳng lưng mà không bị mỏi.\n3. Lòng ghế có tính năng đẩy đệmra xa bằng cần gạc như ghế tài xế. Ghế cao cấp có bánh xe phanh trọng lực.\n4. Bánh xe tự động khóatrọng lực giúp con không bị trượt ngã.Khi di chuyển trọng lực tự động mở bánh xe đẩy ghế di chuyển dễ dàng.\n\nBàn học thông minh của TOPKIDS là giải pháp hữu hiệu ngăn chặn bệnh học đường:\n✔Chống gù, chống cận.\n✔Nhập khẩu trực tiếp 100% từ nhà máy sản xuất, không qua trung gian.\n✔Bảo hành 1 năm, 1 đổi 1 do lỗi của nhà sản xuất 15 ngày.\n✈ Nhận vận chuyển hàng trên cả nước, miễn phí vận chuyển lắp đặt Tp.HCM.✈HÃY ĐỂ TOPKIDS CHẮP CÁNH ƯỚC MƠ CỦA CON CHA MẸ NHÉ !!!');
INSERT INTO `product_details` VALUES (155, 66, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-12oepKqpJDE8WT6OihsqvORfcfwqijP6dHgSZi38EWrEJci95gDj.jpeg', NULL);
INSERT INTO `product_details` VALUES (156, 67, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cho-gu-g6-hinh-2OB2JghZwkQM3xAth6A6CVbMmXmdW2pHPsAYbFAk082RPmuGEiK.jpg', 'GHẾ CHỐNG GÙ CHỐNG CẬN G6 \nGhế bằng cao su đúc định hình nâng hạ chiều cao độc lập 3 chức năng là: đệm ngồi, lưng tựa và nới rộng lòng ghế khi bé trưởng thành. Tựa lưng ngoài việc di chuyển lên xuống còn có trục bập bênh ôm lưng khi ngồi giúp con ngồi thẳng lưng mà không bị mỏi. Lòng ghế có tính năng đẩy đệm ra xa bằng cần gạc như ghế tài xế. Ghế cao cấp có bánh xe phanh trọng lực, khi ngồi bánh xe tự động khóa trọng lực giúp con không bị trượt ngã. Khi di chuyển trọng lực tự động mở bánh xe đẩy ghế di chuyển dễ dàng.');
INSERT INTO `product_details` VALUES (157, 67, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cho-gu-g6-hinh-4bHiITjdhwkvXzSNdfdnmfiuEUYalHm8q86v1Sg2q5sHkzBo5Kz.jpg', 'Tặng bọc đệm ghế tiện sử dụng (sản phẩm đã thêm lớp bọc bảo vệ bên ngoài)');
INSERT INTO `product_details` VALUES (158, 67, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cho-gu-g6-hinh-7W0Oh4sEs0mNXcbaEiclV393veg0mFq6Eb5vUEe5KZwNLb61ikj.jpg', 'Bàn học thông minh của TOPKIDS là giải pháp hữu hiệu ngăn chặn bệnh học đường:\n✔Chống gù, chống cận.\n✔Nhập khẩu trực tiếp 100% từ nhà máy sản xuất, không qua trung gian.\n✔Bảo hành 3 năm, 1 đổi 1 do lỗi của nhà sản xuất trong vòng 7 ngày.\n✈ Nhận vận chuyển hàng trên cả nước, miễn phí vận chuyển lắp đặt Tp.HCM.\n✈HÃY ĐỂ TOPKIDS CHẮP CÁNH ƯỚC MƠ CỦA CON CHA MẸ NHÉ !!!');
INSERT INTO `product_details` VALUES (159, 68, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-chong-can-g5-hinh-2dhFz0ob7ZbAIUG8iI6r2uqlbnBmTVLmmcUfXTk8yLuBz6pIG5k.jpg', 'Ghế Điều Chỉnh Độ Cao Chống Gù G5 - Bàn Học thông Minh Topkids\nGhế bằng cao su đúc định hình nâng hạ chiều cao độc lập 3 chức năng là: đệm ngồi, lưng tựa và nới rộng lòng ghế khi bé trưởng thành.\nTựa lưng ngoài việc di chuyển lên xuống còn có trục bập bênh ôm lưng khi ngồi giúp con ngồi thẳng lưng mà không bị mỏi.\nLòng ghế có tính năng đẩy đệm ra xa bằng cần gạc như ghế tài xế. Ghế cao cấp có bánh xe phanh trọng lực.\nKhi ngồi bánh xe tự động khóa trọng lực giúp con không bị trượt ngã. Khi di chuyển trọng lực tự động mở bánh xe đẩy ghế di chuyển dễ dàng.');
INSERT INTO `product_details` VALUES (160, 68, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-chong-can-g5-hinh-33333Rc4aTZMJnZV2fK6EqVhvoiUlfhcljXzQGdat2NN60jNZKYFNcM.png', NULL);
INSERT INTO `product_details` VALUES (161, 68, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-chong-can-g5-hinh-4BcS5eZinqcr5Priqqp6ZSO3G0xCccxtBcPeZo5KINiNL2FGNb0.jpeg', '1. Ghế bằng cao su đúc định hình nâng hạ chiều cao độc lập 3 chức năng là:Đệm ngồiLưng tựaNới rộng lòng ghế khi bé trưởng thành.\n2. Tựa lưng ngoàiviệc di chuyển lên xuống còn có trục bập bênh ôm lưng khi ngồi giúp con ngồi thẳng lưng mà không bị mỏi.\n3. Lòng ghế có tính năng đẩy đệmra xa bằng cần gạc như ghế tài xế. Ghế cao cấp có bánh xe phanh trọng lực.\n4. Bánh xe tự động khóatrọng lực giúp con không bị trượt ngã.Khi di chuyển trọng lực tự động mở bánh xe đẩy ghế di chuyển dễ dàng.\n\nBàn học thông minh của TOPKIDS là giải pháp hữu hiệu ngăn chặn bệnh học đường:\n✔Chống gù, chống cận.\n✔Nhập khẩu trực tiếp 100% từ nhà máy sản xuất, không qua trung gian.\n✔Bảo hành 1 năm, 1 đổi 1 do lỗi của nhà sản xuất 15 ngày.\n✈ Nhận vận chuyển hàng trên cả nước, miễn phí vận chuyển lắp đặt Tp.HCM.✈HÃY ĐỂ TOPKIDS CHẮP CÁNH ƯỚC MƠ CỦA CON CHA MẸ NHÉ !!!');
INSERT INTO `product_details` VALUES (162, 69, NULL, 'Ghế Điều Chỉnh Độ Cao Chống Gù CO2');
INSERT INTO `product_details` VALUES (163, 70, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-g2-hinh-12dq41gMkt44X148rX9WOskKWSfVd1lpqHIQYWPQ8holyhXOfGFT.jpg', 'GHẾ G2 CHỐNG GÙ CAO CẤP G2 Pink là sản phẩm ghế chống gù hiện đại và tiện ích dành cho các bé, được phân phối bởi TOPKIDS.\nThiết kế thực tế dựa theo hành vi, cũng như thể chất của trẻ giúp cho dáng ngồi của trẻ luôn thẳng, đúng tư thế.Từ đó, để việc học tập trở nên thoải mái, tập trung hơn. Hạn chế các vấn đề gù lưng, cận thị, bé cao lớn vóc dáng đẹp hơn.');
INSERT INTO `product_details` VALUES (164, 70, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-g2-hinh-11CEeSdCDMIKSJ3zP1ZzwIV42H0gVPDMkmgMBBXbEvnfTHMukrHl.jpg', 'NHỮNG ĐIỂM NỔI BẬT\nNâng hạ độ cao theo cơ thể trẻ\nThiết kế nâng hạ độ cao dễ dàng, để phù hợp với mọi độ tuổi và chiều cao của trẻ.\nTrẻ có thể tự điều chỉnh độ cao và lưng ghế để tạo nên sự thoải mái nhất.');
INSERT INTO `product_details` VALUES (165, 70, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-g2-hinh-10bAw0XdoHrPMCQuW2deXMwrEiDLR4FsvM96tg1DwefU6miuZ9T9.jpg', 'Bàn học thông minh của BabyStore là giải pháp hữu hiệu ngăn chặn bệnh học đường:\n✔Chống gù, chống cận.\n✔Nhập khẩu trực tiếp 100% từ nhà máy sản xuất, không qua trung gian.\n✔Bảo hành 3 năm, 1 đổi 1 do lỗi của nhà sản xuất.\n✈ Nhận vận chuyển hàng trên cả nước, miễn phí vận chuyển lắp đặt cả nước.✈');
INSERT INTO `product_details` VALUES (166, 71, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/JI69AQ3xkoOTgkPfciLLllnhLKtC5lo6VtSuWKPqkceGjYGq5d1.jpg', 'GHẾ CHỐNG GÙ FA11 THẾ HỆ MỚI (Sản phẩm Chính Hãng) \nBabyStore xin giới thiệu đến quý khách hàng dòng sản phẩm mới ghế chống gù chống cận A11 chính hãng, với các tính năng cải tiến tiên tiến năm 2024, ghế có thể hỗ trợ chống gù chống cận hiệu quả theo tiêu chuẩn công nghệ từ ĐỨC giúp hỗ trợ các bé tự thoải mái khi ngồi học tin hơn trong học tập tiếp thu các kiến thức mới. Ghế hỗ trợ chống gù chống cận hiệu quả với thiết kế cải tiến nên ghế mang đến sự chất lượng và thoải mái khi bé ngồi. Cơ chế thoáng khi không gây nóng hay bí khi ngồi lâu, giúp em có sự tập chung khi ngồi học tập');
INSERT INTO `product_details` VALUES (167, 71, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/0pddF8BuFFt6EkmZPsw21JTGCnFHFa7HmcKhfE1JD0TnnoSIODArtboard%202(1).jpg', 'CHẤT LIỆU CAO CẤP: \n+ Đệm ngồi mềm mại chống xẹp lúng  giúp bé thoải mái\n+ Lưới tự lưng có độ đàn hồi cao thoáng khí tránh hầm khi bé ngồi học hay giải trí lâu trên ghế.Ghế chống gù chống cận A1 sẽ giúp con của các bạn có một cái ghế trên cả tuyệt với giúp con có thể học tập giải trí an toàn.');
INSERT INTO `product_details` VALUES (168, 72, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan02-1pD82yFdBmlqyfVqvggdY5pKq1it19cLNK6RztCCbAt025UE7r2.jpg', 'Dòng ghế FAN 02 New version 2025 là dòng ultra luxury với tính năng chống gù ưu việt:\nBabyStore luôn luôn đồng hành với tương lai của thế hệ con em chúng ta. Hôm nay TopKids mang đến cho quý phụ huynh và các bạn một sản phẩm ghế chống gù chống cận mới. Ghế được thiết kế cải tiến nhiều hơn so với các mẫu cũ, Chất liệu cao cấp chống gù chống cận hiệu quả luôn, mang đến sự thoải mái nhất cho bé khi ngồi học tập và giải trí trên ghế.\n- Ghế được thiết kế với các chất liệu cao cấp như: Thép không rỉ, cao su non, nhựa ABS giúp ghế có độ bền cao và toát lên vẻ sang trọng, thiết kế tiên tiến phù hợp với mọi không gian nội thất gia đình việt.');
INSERT INTO `product_details` VALUES (169, 72, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan02-29ajuDTI954El9fwokJWn53x4wlJUtPDRnfsU29nC1pwjkg4ISY.jpg', NULL);
INSERT INTO `product_details` VALUES (170, 72, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan02-6mYINqoSr2Dw6QjEqz5zCcSTFPDTzUTeqvgwec9vSzaK5prgZhZ.jpg', NULL);
INSERT INTO `product_details` VALUES (171, 73, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-chong-can-cao-cap-g3-hinh-1LHufNqttekMZgYFzsaRQQ7irmLHjb5vdXQfHaibmG9JJyJctYo.png', 'GHẾ G3 CHỐNG GÙ CAO CẤP \nRiêng Ghế G3 đã nâng cấp thành phiên bản cao cấp. Lưu ý: Phần chân đế của BabyStore to và hoành tráng và tạo tư thế ngồi chắc chắn . Các mẫu trên thị trường có phần chân đế mỏng manh hơn Sản phẩm của TOPKIDS');
INSERT INTO `product_details` VALUES (172, 73, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-chong-gu-chong-can-cao-cap-g3-hinh-54ck4r4huAXxI1dpkQ74p5ee2obuToj8gxoLVWRBQ5l73gRWsij.png', 'Bàn học thông minh của TOPKIDS là giải pháp hữu hiệu ngăn chặn bệnh học đường:\n✔Chống gù, chống cận. \n✔Nhập khẩu trực tiếp 100% từ nhà máy sản xuất, không qua trung gian.\n✔Bảo hành 3 năm, 1 đổi 1 do lỗi của nhà sản xuất.\n✈ Nhận vận chuyển hàng trên cả nước, miễn phí vận chuyển lắp đặt cả nước.\n✈HÃY ĐỂ TOPKIDS CHẮP CÁNH ƯỚC MƠ CỦA CON CHA MẸ NHÉ !!!');
INSERT INTO `product_details` VALUES (173, 74, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan01_1g8JqCN7kMbMX9LYQf3DwohzNuaReLFSyTg6zH8qUoOrPPyHarL.png', NULL);
INSERT INTO `product_details` VALUES (174, 74, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan01_2OBhbz1TnYA9UKTsZc4fs1egELl44xwCeadqQMHGhEsDK0lnLnR.png', NULL);
INSERT INTO `product_details` VALUES (175, 74, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/fan01_3Z7SWNbRXlbbxkHtBM4MTMevEqNFMnvJ5zqxv69oqSV6RZIdbWJ.png', NULL);
INSERT INTO `product_details` VALUES (176, 75, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-9Qs01dPuEgROK0t1qQ6GLZe4ASQwHRF2NxgY9wrVmN2JxKQNx7r.png', 'GHẾ G1 CHỐNG GÙ CAO CẤP\n G1 Pink là sản phẩm ghế chống gù hiện đại và tiện ích dành cho các bé, được phân phối bởi BabyStore.Thiết kế thực tế dựa theo hành vi cũng như thể chất của trẻ giúp cho dáng ngồi của trẻ luôn thẳng, đúng tư thế.Từ đó, để việc học tập trở nên thoải mái, tập trung hơn. Hạn chế các vấn đề gù lưng, cận thị, bé cao lớn vóc dáng đẹp hơn.');
INSERT INTO `product_details` VALUES (177, 75, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-11pIBhzZA04Vcz4PCy0zwUCmDUvR7Br3xGRtwoZJBOPX5CjwNWoL.png', NULL);
INSERT INTO `product_details` VALUES (178, 75, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/ghe-cong-thai-hoc-g8-hinh-12oepKqpJDE8WT6OihsqvORfcfwqijP6dHgSZi38EWrEJci95gDj.jpeg', NULL);
INSERT INTO `product_details` VALUES (183, 45, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-11Ha80p3WUSkI8e5qhVew91ykjwhKHKmHWLc4SqWbEr9RhNKF676.png', 'Bàn Ghế Thông Minh Chống Gù Chống Cận D11 Pro');
INSERT INTO `product_details` VALUES (184, 45, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-14ijy4C7faSh1l7PtkNPW1I2mPqxxoMg9ltslu1ugng71W3TiaZY.jpg', '');
INSERT INTO `product_details` VALUES (185, 45, 'https://topkids.com.vn/img/upload/images/Temp_thumb/800x800/bo-ban-a12-fancy-hinh-13DkOTXFZoSdcbPSw1ZuGuckjHgTj5FmqLcryu3hJfrZq0vcjHSj.jpg', '');
INSERT INTO `product_details` VALUES (214, 76, 'https://sudospaces.com/babycuatoi/2023/07/js006-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-5-1.jpg', '✪ Thương hiệu: BBT Global\r\n✪ Độ tuổi: 3–9 tuổi');
INSERT INTO `product_details` VALUES (215, 76, 'https://sudospaces.com/babycuatoi/2023/07/js006-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-7.jpg', NULL);
INSERT INTO `product_details` VALUES (216, 76, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-1.jpg', 'Lý do khách hàng tin dùng BBT Global');
INSERT INTO `product_details` VALUES (217, 77, 'https://sudospaces.com/babycuatoi/2021/04/thiet-bi-tap-the-duc-tre-em-may-tap-cheo-thuyen-js009-1.jpg', 'Giúp bé rèn luyện cơ tay và chân');
INSERT INTO `product_details` VALUES (218, 77, 'https://sudospaces.com/babycuatoi/2021/04/thiet-bi-tap-the-duc-tre-em-may-tap-cheo-thuyen-js009-1.jpg', NULL);
INSERT INTO `product_details` VALUES (219, 77, 'https://sudospaces.com/babycuatoi/uploads/16082018/thiet-bi-tap-the-duc-tre-em.jpg', 'Công nghệ Châu Âu – bảo hành 1–2 năm');
INSERT INTO `product_details` VALUES (220, 78, 'https://sudospaces.com/babycuatoi/2023/07/js003-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-2.jpg', 'Thiết bị vận động cho bé 3–9 tuổi');
INSERT INTO `product_details` VALUES (221, 78, 'https://sudospaces.com/babycuatoi/2023/07/js003-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-4.jpg', NULL);
INSERT INTO `product_details` VALUES (222, 78, 'https://sudospaces.com/babycuatoi/2023/07/js003-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-5.jpg', NULL);
INSERT INTO `product_details` VALUES (223, 79, 'https://sudospaces.com/babycuatoi/2023/12/zk1062-1.png', 'Hầm chui con sâu KT062 – nhựa an toàn, độ tuổi 2+');
INSERT INTO `product_details` VALUES (224, 79, 'https://sudospaces.com/babycuatoi/2020/02/zk1062-ham-chui-cho-be.jpg', NULL);
INSERT INTO `product_details` VALUES (225, 79, 'https://sudospaces.com/babycuatoi/uploads/29032019/feedback-cau-truot-han-quoc-ham-chui-con-sau-va-bap-benh-1.jpg', NULL);
INSERT INTO `product_details` VALUES (226, 80, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-2.jpg', 'Hầm chui con kiến – kích thích vận động');
INSERT INTO `product_details` VALUES (227, 80, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-4.jpg', 'Phù hợp trường mầm non');
INSERT INTO `product_details` VALUES (228, 80, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-1.jpg', 'Có thể kết hợp thành nhà chơi');
INSERT INTO `product_details` VALUES (229, 81, 'https://sudospaces.com/babycuatoi/2020/08/zk1035-bap-benh-cho-be-3.jpg', 'Bập bênh ngựa đơn nhập khẩu');
INSERT INTO `product_details` VALUES (230, 81, 'https://sudospaces.com/babycuatoi/2020/08/zk1035-bap-benh-cho-be-6.jpg', NULL);
INSERT INTO `product_details` VALUES (231, 81, 'https://sudospaces.com/babycuatoi/2020/08/zk1035-bap-benh-cho-be-5.jpg', 'Giúp phát triển thăng bằng');
INSERT INTO `product_details` VALUES (232, 82, 'https://sudospaces.com/babycuatoi/2023/10/rk-701-do-choi-bap-benh-cho-be-3.jpg', 'Bập bênh hươu cao cổ');
INSERT INTO `product_details` VALUES (233, 82, 'https://sudospaces.com/babycuatoi/2024/01/rk-701-do-choi-bap-benh-cho-be-huou-cao-co-doi-5.jpg', NULL);
INSERT INTO `product_details` VALUES (234, 82, 'https://sudospaces.com/babycuatoi/uploads/16042019/rk-701-bap-benh-doi-huou-cao-co-cho-be-2.jpg', 'Điều chỉnh 2 nấc độ cao');
INSERT INTO `product_details` VALUES (235, 83, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-1-1.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\n\r\nBập bênh đôi Cỡ Lớn 2 cấp độ BBT Global RK-702');
INSERT INTO `product_details` VALUES (236, 83, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-3.jpg', NULL);
INSERT INTO `product_details` VALUES (237, 83, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-4.jpg', NULL);
INSERT INTO `product_details` VALUES (238, 84, 'https://sudospaces.com/babycuatoi/2023/08/zk1020-bap-benh-doi-con-ga-truong-mam-non-khu-vui-choi-2.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\n\r\n- Xuất xứ: Hàng nhập khẩu theo tiêu chuẩn Châu Âu, sản phẩm rất dầy dặn và chắc chắn.\r\n\r\n- Bập bênh 2 đầu cho bé - trò chơi bổ ích giúp trẻ tập vận động và rèn luyện khả năng can đảm dám chinh phục thử thách\r\n\r\n- Bập bênh bằng nhựa này là một trò chơi rèn luyện khả năng chinh phục cho bé và tạo không khí cực kỳ sôi động\r\n\r\n- Bập bênh được thiết kế có tay lái bằng nhựa dễ cầm và chỗ để chân có kích thước phù hợp giúp bé ngồi cưỡi thoải mái, vững chãi, an toàn.\r\n\r\n- Giá tiền phù hợp với đại đa số với người tiêu dùng tại Việt Nam, bập bênh được làm dựa theo các hình ngộ nghĩnh đáng yêu bảo đảm bé nhà bạn sẽ rất thích\r\n\r\n- ĐẶC BIỆT: Bập bênh được thiết kế nhựa dầy nên cực kỳ dày dặn và chắc chắn');
INSERT INTO `product_details` VALUES (239, 84, 'https://sudospaces.com/babycuatoi/uploads/20062015/bap-benh-doi-kt023-1.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (240, 85, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-5.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\n\r\nBập bênh 3 chỗ ngồi cá voi ZK1019\r\n✪ Thương hiệu: BBT GLOBAL\r\n ✪ Sản phẩm chất lượng cao, được sản xuất theo Tiêu chuẩn Châu Âu,có chứng nhận của Tổng cục TCĐL Chất lượng, NK và PP bởi BabyStore');
INSERT INTO `product_details` VALUES (241, 85, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-4.jpg', NULL);
INSERT INTO `product_details` VALUES (242, 85, 'https://sudospaces.com/babycuatoi/uploads/04042018/bap-benh-ca-voi-cho-be-zk1019.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (243, 86, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-5.jpg', 'Mô tả sản phẩm\r\n✅ Ghế xoay dành cho trẻ vận động có đế xoay 360° được các bé rất thích. Giúp rèn luyện kỹ năng giữ thăng bằng và phối hợp của trẻ, đồng thời thúc đẩy sự phát triển cân bằng não trái và não phải. Nó cũng làm giảm các triệu chứng say tàu xe và đối phó với tình trạng lăn và lắc thường xuyên.\r\n\r\n✅ Mâm xoay cân bằng BBT GLOBAL MQ01 sử dụng đế kim loại chắc chắn và ổn định, thiết kế chống trượt và có thể chịu được tải trọng 100kg. Nó còn có vòng bi giúp xoay êm ái và mép ghế dày giúp bé dễ cầm nắm, mang lại sự di chuyển dễ dàng và linh hoạt cho con bạn.\r\n\r\n✅ Mang đến những giờ phút vui chơi giải trí cho trẻ với ghế xoay, cho phép trẻ ngồi, quỳ, nằm sấp và xoay. Khuyến khích thời gian xanh thay vì thời gian sử dụng thiết bị bằng các sản phẩm giúp con bạn khỏe mạnh\r\n\r\n✅ Chiếc mâm xoay trẻ em này không chỉ mang đến niềm vui bất tận mà còn là món đồ chơi tương tác hoàn hảo cho bạn và con bạn. Một món quà bất ngờ và thú vị dành cho trẻ em ở mọi lứa tuổi. Dù ở sân chơi, trường học hay công viên, chiếc ghế xoay tự kỷ này đều tạo ra một môi trường vui nhộn và giàu cảm giác cho trẻ.');
INSERT INTO `product_details` VALUES (244, 86, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-7.jpg', NULL);
INSERT INTO `product_details` VALUES (245, 86, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-8.jpg', NULL);
INSERT INTO `product_details` VALUES (246, 87, 'https://sudospaces.com/babycuatoi/2023/08/zk1022-bap-benh-ngua-doi-cho-be-khu-vui-choi-truong-mam-non.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\nĐẶC ĐIỂM NỔI BẬT CỦA BẬP BÊNH ĐÔI NGỰA ZK1022:\r\n\r\n- Bập bênh 2 đầu cho bé - trò chơi bổ ích giúp trẻ tập vận động và rèn luyện khả năng can đảm dám chinh phục thử thách\r\n\r\n- Bập bênh bằng nhựa này là một trò chơi rèn luyện khả năng chinh phục cho bé và tạo không khí cực kỳ sôi động\r\n\r\n- Bập bênh được thiết kế có tay lái bằng nhựa dễ cầm và chỗ để chân có kích thước phù hợp giúp bé ngồi cưỡi thoải mái, vững chãi, an toàn.\r\n\r\n- Giá tiền phù hợp với đại đa số với người tiêu dùng tại Việt Nam, bập bênh được làm dựa theo các hình ngộ nghĩnh đáng yêu bảo đảm bé nhà bạn sẽ rất thích\r\n\r\n- ĐẶC BIỆT: Bập bênh được thiết kế bằng nhựa nguyên sinh nên cực kỳ dày dặn và chắc chắn');
INSERT INTO `product_details` VALUES (247, 87, 'https://sudospaces.com/babycuatoi/uploads/20062015/bap-benh-doi-ngua-kt022.jpg', NULL);
INSERT INTO `product_details` VALUES (248, 88, 'https://sudospaces.com/babycuatoi/2024/05/176a7863-f974-4c49-8b4c-bbd8b8e5043e.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\nĐặc điểm nổi bật của bập bênh Voi đơn nhập khẩu ZK1032 . \r\n✪ Sản phẩm chất lượng cao, được sản xuất theo Tiêu chuẩn Châu Âu,có chứng nhận của Tổng cục TCĐL Chất lượng, NK và PP bởi BabyStore');
INSERT INTO `product_details` VALUES (249, 88, 'https://sudospaces.com/babycuatoi/2020/08/zk1032-bap-benh-cho-be.jpg', 'Với chỗ ngồi rộng rãi, phần tựa lưng thoải mái cho bé.');
INSERT INTO `product_details` VALUES (250, 88, 'https://sudospaces.com/babycuatoi/uploads/27092018/bap-benh-zk1032.png', 'Thiết kế nhựa đúc nguyên sinh dày dặn, chắc chắn, đảm bảo an toàn cho bé');
INSERT INTO `product_details` VALUES (251, 89, 'https://sudospaces.com/babycuatoi/uploads/25082018/bap-benh-doi-cho-be-zk1017-vang-1.png', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi.\r\nĐẶC ĐIỂM NỔI BẬT CỦA BẬP BÊNH ĐƠN ĐÔI KẾT HỢP CÁ VOI KT017:\r\n\r\n- Kiểu dáng: Ngộ nghĩnh, đáng yêu\r\n\r\n- Chất liệu: Nhựa dầy an toàn chất lượng cao, an toàn cho trẻ.\r\n\r\n- Tính năng:  Tay nắm được chế tạo chất nhựa mềm giúp bé giữ chắc và thoải mái, trống trơn trượt. Chỗ ngồi có đường gân, giúp bé ngồi vững chắc.\r\n\r\n- Bập bênh bằng nhựa này là một trò chơi rèn luyện khả năng chinh phục cho bé và tạo không khí cực kỳ sôi động.\r\n\r\n- Bập bênh chất liệu nhựa cao cấp, an toàn cho bé.\r\n\r\n- Giá tiền phù hợp với đại đa số với người tiêu dùng tại Việt Nam.\r\n\r\n- Khuyến cáo: Không sử dụng đồ chơi này cho trẻ chưa biết ngồi.\r\n\r\n- Sản phẩm chất lượng cao, được sản xuất theo Tiêu chuẩn Châu Âu,có chứng nhận của Tổng cục TCĐL Chất lượng, NK và PP bởi BabyStore');
INSERT INTO `product_details` VALUES (252, 89, 'https://sudospaces.com/babycuatoi/uploads/25082018/bap-benh-doi-cho-be-zk1017-vang2.png', NULL);
INSERT INTO `product_details` VALUES (253, 89, 'https://sudospaces.com/babycuatoi/uploads/25082018/bap-benh-doi-cho-be-zk1017-tong-hop.png', NULL);
INSERT INTO `product_details` VALUES (254, 90, 'https://sudospaces.com/babycuatoi/2024/05/bap-benh-don-ca-heo-zk1031.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\nBập bênh cá heo đơn nhập khẩu ZK1033\r\n✪ Sản phẩm chất lượng cao, được sản xuất theo Tiêu chuẩn Châu Âu,có chứng nhận của Tổng cục TCĐL Chất lượng, NK và PP bởi BabyStore');
INSERT INTO `product_details` VALUES (255, 90, 'https://sudospaces.com/babycuatoi/2020/08/zk1033-bap-benh-cho-be-1.jpg', 'Với chỗ ngồi rộng rãi, phần tựa lưng thoải mái cho bé.');
INSERT INTO `product_details` VALUES (256, 90, 'https://sudospaces.com/babycuatoi/uploads/04042018/bap-benh-ca-heo-cho-be-zk1033-1.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (257, 91, 'https://sudospaces.com/babycuatoi/2025/06/rk701-bap-benh-cho-be.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi');
INSERT INTO `product_details` VALUES (258, 91, 'https://sudospaces.com/babycuatoi/2021/03/rk-701-do-choi-bap-benh-cho-be-3-1.jpg', 'Được thiết kế hình chú hươu cao cổ được các bé cực kỳ yêu thích, kích thích bé vận động mỗi ngày');
INSERT INTO `product_details` VALUES (259, 91, 'https://sudospaces.com/babycuatoi/2020/08/rk-701-do-choi-bap-benh-cho-be-1.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (260, 92, 'https://sudospaces.com/babycuatoi/2023/08/rk511b-do-choi-bap-benh-cho-be-truong-mam-non-khu-vui-choi.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\nBập bênh xe chòi chân 4 trong 1 quay đầu 90 độ RK-511B');
INSERT INTO `product_details` VALUES (261, 92, 'https://sudospaces.com/babycuatoi/2023/08/rk511b-do-choi-bap-benh-cho-be-truong-mam-non-khu-vui-choi-4.jpg', 'CỔ QUAY 90 ĐỘ GIÚP BÉ CHỦ ĐỘNG LÁI, NHIỀU MẦU SẮC CHO BÉ LỰA CHỌN');
INSERT INTO `product_details` VALUES (262, 92, 'https://sudospaces.com/babycuatoi/2023/08/rk511b-do-choi-bap-benh-cho-be-truong-mam-non-khu-vui-choi-5.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (263, 93, 'https://sudospaces.com/babycuatoi/2023/08/rk-514-bap-benh-ket-hop-xe-choi-chan-cho-be.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi');
INSERT INTO `product_details` VALUES (264, 93, 'https://sudospaces.com/babycuatoi/2023/08/rk-514-bap-benh-ket-hop-xe-choi-chan-cho-be-10.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (265, 94, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-8.jpg', 'Bập bênh là một trò chơi vận động nhẹ nhàng vừa giúp tăng cường khả năng vận động vừa rèn luyện sức khỏe và hỗ trợ phát triển các kỹ cho trẻ. Babycuatoi xin giới thiệu tới Ba Mẹ mẫu bập bênh cho bé đảm bảo an toàn cho con vui chơi\r\nĐặc điểm nổi bật của ngựa bập bênh nhập khẩu có nhạc màu hồng RK-526H\r\n\r\n✪ Thương hiệu: BBT Global\r\n✪ Bập bênh chất lượng cao, được sản xuất theo Tiêu chuẩn Châu Âu,có chứng nhận của Tổng cục TCĐL Chất lượng, NK và PP bởi BabyStore');
INSERT INTO `product_details` VALUES (266, 94, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-1.jpg', '- Thiết kế hình chú ngựa vô cùng đáng yêu, có hai màu xanh dương và hồng\r\n- Bập bênh có tay nắm mềm, ghế ngồi lót đệm êm ái, chỗ ngồi sâu an toàn cho bé\r\n\r\n- Chất liệu nhựa Nguyên Sinh nhập khẩu Hàn Quốc đảm dày dặn và không bị phải màu, đảm bảo an toàn cho trẻ nhỏ.\r\n\r\n- Được gắn chú gấu nhạc vui nhộn có phát sáng, giúp kích thích thính giác và thị giác của trẻ\r\n\r\n- Phía trước có gắn chuông kêu vui tai, hoặc bố mẹ có thể buộc thêm dây vào để kéo cho bé');
INSERT INTO `product_details` VALUES (267, 94, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-2.jpg', 'Bên cạnh đó, bập bênh còn mang lại nhiều công dụng không ngờ dành cho trẻ như:\r\n\r\nPhát triển kỹ năng thăng bằng: Bập bênh giúp trẻ phát triển kỹ năng tay và chân, từ việc cầm và đẩy bập bênh đến việc duy trì thăng bằng và di chuyển.\r\n\r\nTăng cường sức khỏe: Hoạt động vận động khi chơi bập bênh giúp tăng cường sức khỏe tim mạch và hệ thống cơ bắp của trẻ.\r\n\r\nKhuyến khích khả năng thích nghi: Việc phải điều chỉnh thăng bằng và thích ứng với môi trường khi chơi bập bênh giúp trẻ phát triển khả năng thích nghi với các tình huống mới.\r\n\r\nGiảm căng thẳng và lo lắng: Chơi bập bênh có thể làm giảm căng thẳng và lo lắng ở trẻ, tạo ra một trạng thái thư giãn và thoải mái.\r\n\r\nTạo cơ hội tương tác xã hội: Khi chơi bập bênh cùng bạn bè hoặc người thân, trẻ có cơ hội tương tác xã hội, học hỏi từ nhau và xây dựng kỹ năng giao tiếp.\r\n\r\nKhuyến khích sự sáng tạo: Trẻ có thể tạo ra các trò chơi và hoạt động mới với bập bênh, khuyến khích sự sáng tạo và tưởng tượng.');
INSERT INTO `product_details` VALUES (268, 96, 'https://sudospaces.com/babycuatoi/2024/03/xe-do-choi-container-cho-be.jpg', 'Mô tả sản phẩm ĐÂY LÀ MẪU XE MÔ HÌNH CONTAINER TO NHẤT CÓ ĐIỀU KHIỂN TỪ XA');
INSERT INTO `product_details` VALUES (269, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-1-1.jpg', 'Đồ chơi ô tô điều khiển từ xa Container cỡ đại có đèn và nhạc QH300-1D');
INSERT INTO `product_details` VALUES (270, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-7.jpg', '- Mô phỏng ô tô tải container cỡ lớn dài 57cm, có khiển từ xa 2.4GHz, thùng hàng siêu to khổng lồ tỉ lệ 1:24 - Chức năng: Đèn và nhạc, khiển từ xa tiến - lùi, rẽ trái - phải, có demo, cửa mở, tháo rời được - Thiết kế tỉ mỉ như xe đầu kéo thật tới từng chi tiết nhỏ, 10 bánh cao su siêu dày dặn');
INSERT INTO `product_details` VALUES (271, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-2.jpg', '- Thùng hàng phía sau có thể tách rời giống như xe đầu kéo thật - Chất liệu nhựa nguyên sinh an toàn cho bé - Tích hợp đèn và âm thanh vui nhộn - Thùng hàng mô phỏng như thật, có 2 cánh cửa khóa lại');
INSERT INTO `product_details` VALUES (272, 97, 'https://sudospaces.com/babycuatoi/2022/08/5501a-do-choi-duong-ham-khung-long.jpg', 'Mô tả sản phẩm Đồ chơi mô hình đường đua kỳ thú đường hầm khủng long 5501A Mô phỏng đường đua uốn lượn 3 tầng có đường hầm khủng long, kèm theo 4 ô tô con sắc màu, kích thích trí tưởng tượng, óc sáng tạo của trẻ khi điều khiển những chiếc xe trên nhiều cung đường.');
INSERT INTO `product_details` VALUES (273, 97, 'https://sudospaces.com/babycuatoi/2022/08/5501a-do-choi-duong-ham-khung-long.jpg', 'Qua mô hình bé sẽ học được nguyên lý hoạt động của nó giúp kích thích trí tưởng tượng, óc sáng tạo của trẻ khi điều khiển những chiếc xe trên nhiều cung đường.');
INSERT INTO `product_details` VALUES (274, 97, 'https://sudospaces.com/babycuatoi/2022/08/5501a-do-choi-duong-ham-khung-long.jpg', '- Để tăng thêm tính thú vị của trò chơi, chúng ta có thể có thể mua thêm ô tô nhỏ MNC để các con có thể chơi ở level cao hơn; tăng độ phản xạ, nhanh mắt, nhanh tay, cho xe vào bãi, cho xe chạy tuần hoàn liên tục.');
INSERT INTO `product_details` VALUES (275, 98, 'https://sudospaces.com/babycuatoi/2024/02/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-3.jpg', 'Mô tả sản phẩm Mô hình xe container chở 6 xe công trình bằng hợp kim cho bé 818-2B');
INSERT INTO `product_details` VALUES (276, 98, 'https://sudospaces.com/babycuatoi/2024/02/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-4.jpg', 'BÉ CHƠI MÔ HÌNH Ô TÔ MANG LẠI NHỮNG LỢI ÍCH TUYỆT VỜI: Sự phối hợp tay mắt: Trẻ phải sử dụng tay để cầm và di chuyển ô tô mô hình. Điều này giúp cải thiện kỹ năng tay mắt và tăng cường sự linh hoạt của đôi tay. Khuyến khích sự sáng tạo: Chơi với ô tô mô hình giúp trẻ phát triển sự sáng tạo và tưởng tượng. Bé có thể nghĩ ra câu chuyện, tình huống và kết hợp ý tưởng mới vào trò chơi của mình. Học về thế giới xung quanh: Ô tô mô hình container và siêu xe được thiết kế dựa trên các xe thật, giúp trẻ nhận biết và hiểu về các loại ô tô khác nhau. Điều này có thể mở rộng kiến thức của trẻ về thế giới xung quanh họ. Khuyến khích phát triển ngôn ngữ: Trong quá trình chơi, trẻ có thể mô tả ô tô, nói về màu sắc, hình dạng, và thậm chí là những câu chuyện liên quan đến ô tô. Điều này giúp tăng cường kỹ năng ngôn ngữ của trẻ. Tạo cơ hội tương tác xã hội: Trẻ thường chơi ô tô mô hình cùng nhau, tạo cơ hội cho tương tác xã hội và học hỏi từ bạn bè. Các con có thể chia sẻ ý kiến, cùng nhau xây dựng câu chuyện, và tạo ra trải nghiệm tương tác tích cực. Phát triển kỹ năng quyết định và kiểm soát: Trẻ phải quyết định làm thế nào để di chuyển ô tô, tạo ra các tình huống và quản lý các yếu tố khác nhau trong trò chơi. Điều này giúp phát triển kỹ năng quyết định và kiểm soát. Tăng cường kỹ năng tư duy không gian: Khi chơi với ô tô mô hình, trẻ phải đánh giá không gian xung quanh và tính toán cách di chuyển ô tô mô hình một cách hiệu quả. Điều này giúp phát triển kỹ năng tư duy không gian. Khuyến khích trải nghiệm thực tế: Trẻ có thể mô phỏng các tình huống thực tế thông qua trò chơi với ô tô mô hình, giúp họ hiểu về quy tắc giao thông, vai trò của các phương tiện');
INSERT INTO `product_details` VALUES (277, 98, 'https://sudospaces.com/babycuatoi/2024/01/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (278, 99, 'https://sudospaces.com/babycuatoi/2020/08/48259-nha-hoi-nha-phao-nhun-cho-be-6-1.jpg', 'Mô tả sản phẩm Đặc điểm nổi bật của nhà hơi cho bé Intex 48259 Nhà phao bơm hơi cho bé hình lâu đài có tường bao xung quanh và đáy bơm hơi giúp bé cảm thấy êm ái khi chơi.');
INSERT INTO `product_details` VALUES (279, 99, 'https://sudospaces.com/babycuatoi/2020/08/48259-nha-hoi-nha-phao-nhun-cho-be-4.jpg', 'Nhà hơi mini là một trò chơi động, các bé nhún nhảy cực vui, không sợ ngã vì tất cả đáy và thành nhà banh cho trẻ đều bơm hơi êm ái, có thể cho nhiều bé cùng chơi, kể cả các bé lớn, trờ chơi giống như chơi nhà phao ở các khu vui chơi. Khi bé không muốn chơi nữa, bố mẹ có thể xịt hơi và cất đi rất gọn gàng. Các bé có thể chơi với bóng và các đồ chơi khác trong nhà phao. Sản phẩm chính hãng, chất liệu dày và bền.');
INSERT INTO `product_details` VALUES (280, 99, 'https://sudospaces.com/babycuatoi/2021/01/48259-nha-hoi-nhun-nha-phao.jpg', 'Lưu ý khi sử dụng nhà hơi lâu đài cho bé - Tránh xa những vật phát nhiệt hoặc có góc cạnh sắc nhọn. - Tải trọng tối đa khi nhún của nhà hơi mini Intex 48259 là 54kgs, do vậy không nên cho bé quá lớn nhún nhảy trên đó để đảm bảo độ bền lâu dài cho sản phẩm.');
INSERT INTO `product_details` VALUES (281, 100, 'https://sudospaces.com/babycuatoi/2023/11/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-1.jpg', 'Mô tả sản phẩm Đồ chơi hộp dụng cụ sửa chữa lắp ráp cho bé RX-904C Các bé trai rất thích xoáy vặn các con ốc ở món đồ bất kỳ nào có trong gia đình. Hoạt động này cực kỳ tốt cho não bộ của trẻ nhưng nhiều Ba Mẹ lại bỏ qua và cho rằng bé đang nghịch ngợm vô ích. Thực chất hoạt động của đôi tay khéo léo lại giúp cho não bộ của bé phát triển tốt hơn, đặc biệt là tư duy có logic và khoa học hơn. Chính vì thế bộ đồ chơi dụng cụ sửa chữa lắp ráp ra đời, nhằm mang đến cho bé môi trường vui chơi an toàn hơn, bé được học hỏi nhiều thứ mới mẻ hơn.');
INSERT INTO `product_details` VALUES (282, 100, 'https://sudospaces.com/babycuatoi/2023/11/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-4.jpg', 'LỢI ÍCH TUYỆT VỚI TỪ BỘ ĐỒ CHƠI SỮA CHỮA TỚI SỰ PHÁT TRIỂN CỦA TRẺ: Giúp phát triển kỹ năng tư duy và giải quyết vấn đề từ việc tìm hiểu cách mà các bộ phận hoạt động cùng nhau. Vận động khéo léo đôi tay: Khi trẻ phải sử dụng tay, ngón tay và các cơ quan cảm nhận để lắp ráp, giúp cải thiện kỹ năng ngón tay linh hoạt. Thúc đẩy sự sáng tạo: Khuyến khích trẻ phát triển khả năng sáng tạo và tưởng tượng. Cải thiện khả năng tập trung: Nhiều chi tiết tách rời đòi hỏi tư duy logic để gắn kết. Xây dựng sự tự tin: Hoàn thành lắp ráp giúp con kiên nhẫn và tự tin. Tăng cường kỹ năng xã hội: Ba mẹ cùng chơi giúp làm việc nhóm, giao tiếp và chia sẻ ý tưởng. Vì vậy bộ đồ chơi lắp ráp sửa chữa không chỉ giải trí mà còn giúp trẻ phát triển nhiều kỹ năng quan trọng.');
INSERT INTO `product_details` VALUES (283, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon.jpg', 'Mô tả sản phẩm Nhiều Ba Mẹ vật lộn với con mỗi giờ đi tắm, gọi con không chịu đi tắm hoặc giờ đi tắm lại khóc lóc. Bí Quyết để bé thích tắm chính đây... Có nhiều hình xinh xắn như rùa, vịt, cua, ếch, cá heo... Các con vật này chạy bằng vặn cót nên cực kỳ bền và an toàn, không cần sử dụng tới pin tốn kém.');
INSERT INTO `product_details` VALUES (284, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-2.jpg', NULL);
INSERT INTO `product_details` VALUES (285, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-7.jpg', NULL);
INSERT INTO `product_details` VALUES (286, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-con.jpg', NULL);
INSERT INTO `product_details` VALUES (287, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-11.jpg', NULL);
INSERT INTO `product_details` VALUES (288, 102, 'https://sudospaces.com/babycuatoi/2022/12/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-1.jpg', 'Mô tả sản phẩm');
INSERT INTO `product_details` VALUES (289, 102, 'https://sudospaces.com/babycuatoi/2022/12/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-2.jpg', NULL);
INSERT INTO `product_details` VALUES (290, 102, 'https://sudospaces.com/babycuatoi/2022/12/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-5.jpg', NULL);
INSERT INTO `product_details` VALUES (291, 103, 'https://sudospaces.com/babycuatoi/2020/01/msn17074-bep-nau-an-go-cao-cap-cho-be.jpg', 'Đặc điểm nổi bật của bộ đồ chơi nấu ăn gỗ: Bộ đồ chơi nấu ăn gỗ mô phỏng căn bếp hiện đại với nhiều thiết bị như lò vi sóng, máy giặt, nồi cơm điện,... màu sắc bắt mắt, giúp bé vui chơi thích thú hơn.');
INSERT INTO `product_details` VALUES (292, 103, 'https://sudospaces.com/babycuatoi/uploads/02112019/msn17074-do-choi-nau-an-bang-go-cao-cap-cho-be-bbt-global.jpg', 'Căn bếp hiện đại và vô cùng đa năng, được các bé vô cùng yêu thích.');
INSERT INTO `product_details` VALUES (293, 103, 'https://sudospaces.com/babycuatoi/uploads/02112019/msn17074-do-choi-nau-an-bang-go-cao-cap-cho-be-bbt-global.jpg', 'Bếp được thiết kế với chủ đạo là màu hồng được bé cực kỳ yêu thích, kích thước lớn cho nhiều bé cùng chơi.');
INSERT INTO `product_details` VALUES (294, 104, 'https://sudospaces.com/babycuatoi/2024/09/20231-do-choi-gap-chuot-cho-be-1.jpg', 'Mô tả sản phẩm - Mô phỏng chiếc máy đập chuột ở khu vui chơi: với bàn đập chuột hình bánh sinh nhật xinh xắn, có đèn và nhạc vui nhộn');
INSERT INTO `product_details` VALUES (295, 104, 'https://sudospaces.com/babycuatoi/2024/09/20231-do-choi-gap-chuot-cho-be-2.jpg', NULL);
INSERT INTO `product_details` VALUES (296, 104, 'https://sudospaces.com/babycuatoi/2024/09/20231-do-choi-gap-chuot-cho-be-4.jpg', NULL);
INSERT INTO `product_details` VALUES (297, 105, 'https://sudospaces.com/babycuatoi/2024/07/158-7c-do-choi-dap-chuot-xoay-360-co-den-va-nhac-1.jpg', 'Mô tả sản phẩm Đồ chơi đập chuột xoay 360 độ, 2 búa có đèn và nhạc - Mô phỏng chiếc máy đập chuột ở khu vui chơi, thiết kế với nhiều chức năng thú vị hơn: với bàn đập chuột xoay tròn 360 độ, có đèn và nhạc vui nhộn - Máy đập chuột tại nhà là MÓN QUÀ TẶNG CON YÊU Phát triển vận động khéo léo của đôi tay, sự nhanh nhạy của mắt');
INSERT INTO `product_details` VALUES (298, 105, 'https://sudospaces.com/babycuatoi/2024/07/158-7c-do-choi-dap-chuot-xoay-360-co-den-va-nhac-2.jpg', NULL);
INSERT INTO `product_details` VALUES (299, 105, 'https://sudospaces.com/babycuatoi/2024/07/158-7c-do-choi-dap-chuot-xoay-360-co-den-va-nhac-4.jpg', 'Những bộ đồ chơi giáo dục, đồ chơi phát triển kĩ năng chắc hẳn sẽ là món quà cho bé thật đẹp, thật ý nghĩa');
INSERT INTO `product_details` VALUES (300, 106, 'https://sudospaces.com/babycuatoi/2024/01/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim-1.jpg', 'Mô tả sản phẩm Mô hình xe container chở 6 xe cảnh sát bằng hợp kim cho bé 818-2D Xe container 2 tầng thiết kế cực kỳ sáng tạo, kiêm làm hộp đựng những chiếc ô tô bằng hợp kim chắc tay, bé vừa có thể chơi xe vừa làm BST trưng bày cực đẹp');
INSERT INTO `product_details` VALUES (301, 106, 'https://sudospaces.com/babycuatoi/2024/02/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim-4.jpg', 'BÉ CHƠI MÔ HÌNH Ô TÔ MANG LẠI NHỮNG LỢI ÍCH TUYỆT VỜI: Sự phối hợp tay mắt... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (302, 107, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-2.jpg', 'Mô tả sản phẩm Đồ chơi bếp nấu ăn cỡ lớn, 73 chi tiết như thật có bàn phụ 2 tầng');
INSERT INTO `product_details` VALUES (303, 107, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-2.jpg', 'LỢI ÍCH TUYỆT VỜI TỪ ĐỒ CHƠI NẤU BẾP NẤU ĂN TỚI SỰ PHÁT TRIỂN CỦA TRẺ: Đồ chơi nhà bếp không chỉ giúp con giải trí mà bé học được những bài học bổ ích...');
INSERT INTO `product_details` VALUES (304, 107, 'https://sudospaces.com/babycuatoi/2024/08/839-012-do-choi-bap-nau-an-co-lon-cho-be-nau-an-nhu-that-1.jpg', 'Bé nhận biết các đồ dùng, vật dụng trong bếp... (nội dung dài như bạn cung cấp)');
INSERT INTO `product_details` VALUES (305, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-mu.jpg', 'Mô tả sản phẩm');
INSERT INTO `product_details` VALUES (306, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu-12.jpg', NULL);
INSERT INTO `product_details` VALUES (307, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu-6.jpg', 'ƯU ĐIỂM VÀ LỢI ÍCH CỦA ĐỒ CHƠI BÁC SĨ - Nuôi dưỡng ước mơ... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (308, 109, 'https://sudospaces.com/babycuatoi/2022/10/clb-4-do-choi-xep-hinh-nam-cham-64-chi-tiet-cho-be-3.jpg', 'Mô tả sản phẩm');
INSERT INTO `product_details` VALUES (309, 109, 'https://sudospaces.com/babycuatoi/2022/10/clb-4-do-choi-xep-hinh-nam-cham-64-chi-tiet-cho-be-11.jpg', 'Đồ chơi xếp hình nam châm cho bé tại BabyStore đã qua kiểm định chất lượng, đảm bảo an toàn cho bé nên được Ba Mẹ yên tâm lựa chọn');
INSERT INTO `product_details` VALUES (310, 109, 'https://sudospaces.com/babycuatoi/2022/10/clb-4-do-choi-xep-hinh-nam-cham-64-chi-tiet-cho-be-10.jpg', NULL);
INSERT INTO `product_details` VALUES (311, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-4.jpg', 'Mô tả sản phẩm Đồ chơi vô lăng lái xe ô tô có đèn và nhạc xoay 360 độ cho bé');
INSERT INTO `product_details` VALUES (312, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-7.jpg', NULL);
INSERT INTO `product_details` VALUES (313, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-2-1.jpg', 'LỢI ÍCH CỦA ĐỒ CHƠI ÂM NHẠC TỚI SỰ PHÁT TRIỂN CỦA TRẺ: Phát triển khả năng ngôn ngữ... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (314, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-6-1.jpg', 'Mô tả sản phẩm Bảng vẽ trẻ em CỠ LỚN 2 mặt từ tính xóa dễ dàng, không bám bụi A189');
INSERT INTO `product_details` VALUES (315, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189.jpg', NULL);
INSERT INTO `product_details` VALUES (316, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-17.jpg', NULL);
INSERT INTO `product_details` VALUES (317, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-9.jpg', '*Lợi ích của bảng vẽ giáo dục hai mặt... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (318, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-7.jpg', 'Mô tả sản phẩm Đàn Organ điện tử 61 phím kèm mic cho bé... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (319, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-6.jpg', 'Đàn Organ thiết kế mô phỏng như thật cho bé vừa học vừa chơi - Đàn còn được tích hợp thêm 1 Micro cho bé vừa đàn vừa hát vui nhộn');
INSERT INTO `product_details` VALUES (320, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-3.jpg', 'LỢI ÍCH CỦA ĐỒ CHƠI ÂM NHẠC TỚI SỰ PHÁT TRIỂN CỦA TRẺ: ... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (321, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-10.jpg', 'Mô tả sản phẩm Đồ chơi đoàn tàu 16 toa hình ô tô...');
INSERT INTO `product_details` VALUES (322, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-9.jpg', NULL);
INSERT INTO `product_details` VALUES (323, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-9.jpg', 'Những bộ đồ chơi giáo dục, đồ chơi phát triển kĩ năng chắc hẳn sẽ là món quà cho bé thật đẹp, thật ý nghĩa');
INSERT INTO `product_details` VALUES (324, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-4.jpg', 'Mô tả sản phẩm Đồ chơi cắt bánh kem sinh nhật kèm 85 chi tiết G675A ... (nội dung như bạn cung cấp)');
INSERT INTO `product_details` VALUES (325, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-4.jpg', 'LỢI ÍCH TUYỆT VỜI TỪ ĐỒ CHƠI NẤU BẾP NẤU ĂN TỚI SỰ PHÁT TRIỂN CỦA TRẺ: ...');
INSERT INTO `product_details` VALUES (326, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-7.jpg', 'Bé nhận biết các đồ dùng, vật dụng trong bếp... (nội dung dài như bạn cung cấp)');
INSERT INTO `product_details` VALUES (327, 115, 'https://sudospaces.com/babycuatoi/2024/08/839-012-do-choi-bap-nau-an-co-lon-cho-be-nau-an-nhu-that-1.jpg', 'Mô tả sản phẩm Đồ chơi nhà bếp nấu ăn cho bé cỡ lớn 95cm, 54 chi tiết như thật');
INSERT INTO `product_details` VALUES (328, 115, 'https://sudospaces.com/babycuatoi/2024/08/839-012-do-choi-bap-nau-an-co-lon-cho-be-nau-an-nhu-that-4.jpg', 'LỢI ÍCH TUYỆT VỜI TỪ ĐỒ CHƠI NẤU BẾP... (nội dung dài như bạn cung cấp)');
INSERT INTO `product_details` VALUES (329, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung-1-1.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương hiệu : BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác');
INSERT INTO `product_details` VALUES (330, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung-1.jpg', 'LÝ DO KHÁCH HÀNG TIN DÙNG CÁC SẢN PHẦM NHÚN ĐIỆN\nVÀ THIẾT BỊ SÂN CHƠI BBT GLOBAL \n1. Sản phẩm được sản xuất theo dây chuyền công nghệ Châu Âu tiên tiến nhất, với nhựa nguyên sinh nhập khẩu từ Hàn Quốc, khung thép sản xuất theo tiêu chuẩn và công nghệ Châu Âu, sơn tĩnh điện được nhập khẩu từ Hà Lan, do vậy sản phẩm rất bóng, đẹp, chắc chắn, dầy dặn và bền mầu và thời gian sử dụng lâu dài gấp nhiều lần các sản phẩm trong nước và các sản phẩm khác. \n2. Với lợi thế chi phí giảm theo quy mô sản xuất, nhà máy tập trung sản xuất với số lượng lớn và xuất khẩu đi nhiều nước trên thế giới, đặc biệt là thị trường Mỹ và EU, chúng tôi luôn đảm bảo giá bán sản phẩm luôn thấp nhất trên thị trường so với cùng chất lượng. Tặng ngay chính sản phẩm cho khách hàng nào tìm được đơn vị cung cấp sản phẩm cùng đúng chất lượng với giá rẻ hơn.');
INSERT INTO `product_details` VALUES (331, 117, 'https://sudospaces.com/babycuatoi/uploads/29122017/ndnk-rong-roc.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (332, 117, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1003-nhun-dien-nhap-khau-hello-kitty-1.jpg', 'LÝ DO KHÁCH HÀNG TIN DÙNG CÁC SẢN PHẦM NHÚN ĐIỆN\n1. Sản phẩm được sản xuất theo dây chuyền công nghệ Châu Âu tiên tiến nhất, với nhựa nguyên sinh nhập khẩu từ Hàn Quốc, khung thép sản xuất theo tiêu chuẩn và công nghệ Châu Âu, sơn tĩnh điện được nhập khẩu từ Hà Lan, do vậy sản phẩm rất bóng, đẹp, chắc chắn, dầy dặn và bền mầu và thời gian sử dụng lâu dài gấp nhiều lần các sản phẩm trong nước và các sản phẩm khác. \n2. Với lợi thế chi phí giảm theo quy mô sản xuất, nhà máy tập trung sản xuất với số lượng lớn và xuất khẩu đi nhiều nước trên thế giới, đặc biệt là thị trường Mỹ và EU, chúng tôi luôn đảm bảo giá bán sản phẩm luôn thấp nhất trên thị trường so với cùng chất lượng. Tặng ngay chính sản phẩm cho khách hàng nào tìm được đơn vị cung cấp sản phẩm cùng đúng chất lượng với giá rẻ hơn.');
INSERT INTO `product_details` VALUES (333, 118, 'https://sudospaces.com/babycuatoi/2023/02/game-6012-may-gap-thu-bong-cho-be-3.jpg', 'Mô tả sản phẩm\nThương Hiệu: BBT Global \nP được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore Việt Nam- Số 1 về đồ chơi trẻ em an toàn, đồ chơi cho bé, thiết bị giáo dục và thiết bị khu vui chơi giải trí');
INSERT INTO `product_details` VALUES (334, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-3-1.jpg', NULL);
INSERT INTO `product_details` VALUES (335, 119, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1040-nhun-dien-nhap-khau-khu-vui-choi-tre-em.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (336, 119, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1040-nhun-dien-nhap-khau-khu-vui-choi-tre-em-3.jpg', NULL);
INSERT INTO `product_details` VALUES (337, 119, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1040-nhun-dien-nhap-khau-khu-vui-choi-tre-em-4.jpg', NULL);
INSERT INTO `product_details` VALUES (338, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-1.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (339, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-1-1.jpg', NULL);
INSERT INTO `product_details` VALUES (340, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-3.jpg', NULL);
INSERT INTO `product_details` VALUES (341, 121, 'https://sudospaces.com/babycuatoi/2023/02/game-6012-may-gap-thu-bong-khu-vui-choi-1.jpg', 'Mô tả sản phẩm\nThương Hiệu: BBT Global \n- Máy đặc biệt có ưu điểm nổi bật là rất bền và chạy ổn định gấp nhiều lần dòng máy khác trên thị trường\nSP được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (342, 121, 'https://sudospaces.com/babycuatoi/2020/10/may-gap-thu-bong-khu-vui-choi-game-6012a-4-1.jpg', NULL);
INSERT INTO `product_details` VALUES (343, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014-2.jpg', 'Mô tả sản phẩm\nSản xuất tại: Trung Quốc\nNhập khẩu và phân phối chính hãng bởi công ty BabyStore');
INSERT INTO `product_details` VALUES (344, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014-1.jpg', NULL);
INSERT INTO `product_details` VALUES (345, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-3-1.jpg', 'Mô tả sản phẩm\nNhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (346, 123, 'https://sudospaces.com/babycuatoi/uploads/10122019/nhun-dien-nhap-khau-ndnk-1009-4.png', NULL);
INSERT INTO `product_details` VALUES (347, 124, 'https://sudospaces.com/babycuatoi/2020/02/ndnk-1008-nhu-dien-nhap-khau-bbt-global-1.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (348, 124, 'https://sudospaces.com/babycuatoi/2020/02/ndnk-1008-nhu-dien-nhap-khau-bbt-global-1.jpg', NULL);
INSERT INTO `product_details` VALUES (349, 124, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1008-nhu-dien-nhap-khau-bbt-global-7.jpg', 'LÝ DO KHÁCH HÀNG TIN DÙNG CÁC SẢN PHẦM NHÚN ĐIỆN\nVÀ THIẾT BỊ SÂN CHƠI BBT GLOBAL \n1. Sản phẩm được sản xuất theo dây chuyền công nghệ Châu Âu tiên tiến nhất, với nhựa nguyên sinh nhập khẩu từ Hàn Quốc, khung thép sản xuất theo tiêu chuẩn và công nghệ Châu Âu, sơn tĩnh điện được nhập khẩu từ Hà Lan, do vậy sản phẩm rất bóng, đẹp, chắc chắn, dầy dặn và bền mầu và thời gian sử dụng lâu dài gấp nhiều lần các sản phẩm trong nước và các sản phẩm khác. \n2. Với lợi thế chi phí giảm theo quy mô sản xuất, nhà máy tập trung sản xuất với số lượng lớn và xuất khẩu đi nhiều nước trên thế giới, đặc biệt là thị trường Mỹ và EU, chúng tôi luôn đảm bảo giá bán sản phẩm luôn thấp nhất trên thị trường so với cùng chất lượng. Tặng ngay chính sản phẩm cho khách hàng nào tìm được đơn vị cung cấp sản phẩm cùng đúng chất lượng với giá rẻ hơn.');
INSERT INTO `product_details` VALUES (350, 125, 'https://sudospaces.com/babycuatoi/uploads/05122019/nhun-dien-nhap-khau-ndnk-1092-2.png', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (351, 126, 'https://sudospaces.com/babycuatoi/uploads/05122019/nhun-dien-nhap-khau-ndnk-1081-5-1.png', 'Mô tả sản phẩm\nNhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nThương Hiệu: BBT Global\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (352, 126, 'https://sudospaces.com/babycuatoi/uploads/05122019/nhun-dien-nhap-khau-ndnk-1081-5-1.png', NULL);
INSERT INTO `product_details` VALUES (353, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-4.jpg', NULL);
INSERT INTO `product_details` VALUES (354, 127, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1066-nhun-dien-nhap-khau-may-bay.jpg', 'Mô tả sản phẩm\nNhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (355, 127, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1066-nhun-dien-nhap-khau-may-bay-2.jpg', NULL);
INSERT INTO `product_details` VALUES (356, 128, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020-1.jpg', 'Mô tả sản phẩm\nThương Hiệu: BBT Global\nSP được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore Việt Nam');
INSERT INTO `product_details` VALUES (357, 129, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than-1-1.jpg', 'Nhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\n\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\n\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (358, 129, 'https://sudospaces.com/babycuatoi/uploads/01082019/ndnk-1010-nhun-dien-nhap-khau-cho-be-2.jpg', NULL);
INSERT INTO `product_details` VALUES (359, 130, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-7.jpg', 'Mô tả sản phẩm\nHãng Sản xuất: BBT Global\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh');
INSERT INTO `product_details` VALUES (360, 130, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-6.jpg', NULL);
INSERT INTO `product_details` VALUES (361, 130, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-1-1.jpg', NULL);
INSERT INTO `product_details` VALUES (362, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi-1-1.jpg', 'Mô tả sản phẩm\n- Thương Hiệu: BBT Global\n- Sản phẩm được nhập khẩu linh kiện và lắp ráp tại Việt Nam');
INSERT INTO `product_details` VALUES (363, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi-5.jpg', NULL);
INSERT INTO `product_details` VALUES (364, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (365, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi-2-1.jpg', NULL);
INSERT INTO `product_details` VALUES (366, 132, 'https://sudospaces.com/babycuatoi/2021/04/game-6025-may-game-khu-vui-choi-bbt-global-5.jpg', 'Mô tả sản phẩm\n- Thương Hiệu:BBT Global\n- Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (367, 132, 'https://sudospaces.com/babycuatoi/2021/04/game-6025-may-game-khu-vui-choi-bbt-global-5.jpg', NULL);
INSERT INTO `product_details` VALUES (368, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-3.jpg', 'Mô tả sản phẩm\nNhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\n\nNhún điện nhập khẩu hình Doremon NDNK-1041\nThương Hiệu: BBT Global\n\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng truyền động ròng rọc bằng kim loại làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường sử dụng hộp số nhựa. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (369, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-2.jpg', NULL);
INSERT INTO `product_details` VALUES (370, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-1-1.jpg', 'LÝ DO KHÁCH HÀNG TIN DÙNG CÁC SẢN PHẦM NHÚN ĐIỆN VÀ THIẾT BỊ SÂN CHƠI BBT GLOBAL \n1. Sản phẩm được sản xuất theo dây chuyền công nghệ Châu Âu tiên tiến nhất, với nhựa nguyên sinh nhập khẩu từ Hàn Quốc, khung thép sản xuất theo tiêu chuẩn và công nghệ Châu Âu, sơn tĩnh điện được nhập khẩu từ Hà Lan, do vậy sản phẩm rất bóng, đẹp, chắc chắn, dầy dặn và bền mầu và thời gian sử dụng lâu dài gấp nhiều lần các sản phẩm trong nước và các sản phẩm khác. \n2. Với lợi thế chi phí giảm theo quy mô sản xuất, nhà máy tập trung sản xuất với số lượng lớn và xuất khẩu đi nhiều nước trên thế giới, đặc biệt là thị trường Mỹ và EU, chúng tôi luôn đảm bảo giá bán sản phẩm luôn thấp nhất trên thị trường so với cùng chất lượng.');
INSERT INTO `product_details` VALUES (371, 134, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-may-dap-chuot-game-3012-1-4.jpg', 'Mô tả sản phẩm\nThương Hiệu:BBT Global \nSP được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');
INSERT INTO `product_details` VALUES (372, 135, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1007-nhun-dien-nhap-khau-o-to-2.jpg', 'Mô tả sản phẩm\n\nNhún điện nhập khẩu BBT GLOBAL đều được trang bị động cơ công suất lớn 230W\n\nThương Hiệu: BBT Global\nThú nhún điện kèm 100 xu miễn phí, được lập trình sẵn mỗi xu chạy 3 phút, tích hợp máy nghe nhạc MP3 để khách hàng cắm thêm thẻ nhớ nếu muốn thêm các bài hát khác\n\nSản phẩm làm từ nhựa nguyên sinh nhập khẩu cao cấp, sản xuất theo tiêu chuẩn xuất khẩu châu Âu, với hệ thống cơ nâng và bánh răng hợp kim làm tăng tuổi thọ sản phẩm lên gấp 5 lần so với nhún thông thường. Sản phẩm cài sẵn các bài hát Tiếng Anh theo tiêu chuẩn Châu Âu, có ổ cắm thẻ nhớ để người dùng có thể cho thẻ nhớ các bài hát tiếng Việt. Sản phẩm được nhập khẩu và phân phối chính hãng bởi Công ty BabyStore');

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `product_image_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`product_image_id`) USING BTREE,
  INDEX `fk_productimages_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_productimages_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 438 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_images
-- ----------------------------
INSERT INTO `product_images` VALUES (6, 7, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (7, 7, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-2-400x400.jpg');
INSERT INTO `product_images` VALUES (8, 8, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (9, 8, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-2-400x400.jpg');
INSERT INTO `product_images` VALUES (10, 9, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (11, 9, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-2-400x400.jpg');
INSERT INTO `product_images` VALUES (12, 10, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (13, 10, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-2-400x400.jpg');
INSERT INTO `product_images` VALUES (14, 11, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (15, 11, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-2-400x400.jpg');
INSERT INTO `product_images` VALUES (16, 12, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (17, 12, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-2-400x400.jpg');
INSERT INTO `product_images` VALUES (18, 13, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (19, 13, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-2-400x400.jpg');
INSERT INTO `product_images` VALUES (20, 14, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-400x400.jpg');
INSERT INTO `product_images` VALUES (21, 14, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-2-400x400.jpg');
INSERT INTO `product_images` VALUES (22, 15, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-6-400x400.jpg');
INSERT INTO `product_images` VALUES (23, 15, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-7-400x400.jpg');
INSERT INTO `product_images` VALUES (24, 16, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (25, 16, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-2-400x400.jpg');
INSERT INTO `product_images` VALUES (26, 17, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-dep-tm-866-2-400x400.jpg');
INSERT INTO `product_images` VALUES (27, 18, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-tm885-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (28, 18, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-tm885-2-400x400.jpg');
INSERT INTO `product_images` VALUES (29, 19, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-dep-tm-867-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (30, 19, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-dep-tm-867-2-400x400.jpg');
INSERT INTO `product_images` VALUES (31, 20, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (32, 20, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (33, 21, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-be-gai-tm-86899-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (34, 21, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-be-gai-tm-86899-2-400x400.jpg');
INSERT INTO `product_images` VALUES (35, 22, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-tre-em-hoa-tiet-hoat-hinh-o-ha-noi-tr-201-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (36, 22, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-tre-em-hoa-tiet-hoat-hinh-o-ha-noi-tr-201-2-400x400.jpg');
INSERT INTO `product_images` VALUES (37, 23, 'https://remkhanhduong.com/wp-content/uploads/2025/09/thich-mat-voi-mau-rem-cua-cho-be-trai-tr-202-quan-tay-ho-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (38, 23, 'https://remkhanhduong.com/wp-content/uploads/2025/09/thich-mat-voi-mau-rem-cua-cho-be-trai-tr-202-quan-tay-ho-2-400x400.jpg');
INSERT INTO `product_images` VALUES (39, 24, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-mau-hong-cho-phong-be-yeu-ma-mjl-5034-1-1-400x400.jpg');
INSERT INTO `product_images` VALUES (40, 24, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-mau-hong-cho-phong-be-yeu-ma-mjl-5034-3-400x400.jpg');
INSERT INTO `product_images` VALUES (41, 25, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-phi-hanh-gia-treo-phong-be-trai.jpg');
INSERT INTO `product_images` VALUES (42, 26, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-tre-em-mau-nuoc-de-thuong-cho-be-gai.jpg');
INSERT INTO `product_images` VALUES (43, 27, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-gau-trang-ngo-nghinh-trang-tri-phong-be-trai.jpg');
INSERT INTO `product_images` VALUES (44, 28, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-phi-hanh-gia-trang-tri-phong-be-trai-dep.jpg');
INSERT INTO `product_images` VALUES (45, 29, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong--sweet-dream-cho-be-trai.jpg');
INSERT INTO `product_images` VALUES (46, 30, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-be-gai-dang-yeu-voi-ca-heo.jpg');
INSERT INTO `product_images` VALUES (47, 31, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-tre-em-ca-heo-va-be-gai-cam-bong-bong.jpg');
INSERT INTO `product_images` VALUES (48, 32, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-ky-lan-hong-va-cau-vong-de-thuong-cho-phong-be-gai.jpg');
INSERT INTO `product_images` VALUES (49, 33, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-khung-long-ngo-nghinh-trang-tri-phong-be-trai.jpg');
INSERT INTO `product_images` VALUES (50, 34, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-dong-vat-ngo-nghinh-trang-tri-phong-tre-em.jpg');
INSERT INTO `product_images` VALUES (51, 35, 'https://xuongtranh.net/uploads/w900/2023/06/15/set-4-trang-cong-chua-bale-trang-tri-phong-be-gai.jpg');
INSERT INTO `product_images` VALUES (52, 36, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-meo-vang-va-be-gai-dep.jpg');
INSERT INTO `product_images` VALUES (53, 37, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-ca-heo-xanh-va-be-gai-ngo-nghinh.jpg');
INSERT INTO `product_images` VALUES (54, 38, 'https://xuongtranh.net/uploads/w900/2023/06/15/set-2-tranh-tho-ngo-nghinh-va-bong-bay-ngo-nghinh.jpg');
INSERT INTO `product_images` VALUES (55, 39, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-tranh-lovely-dong-vat-mau-sac-trang-tri-phong-cho-be.jpg');
INSERT INTO `product_images` VALUES (56, 40, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-6-tranh-dong-vat-ngo-nghinh-treo-phong-be-trai.jpg');
INSERT INTO `product_images` VALUES (57, 41, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-ngu-meo-de-thuong-cho-be.jpg');
INSERT INTO `product_images` VALUES (58, 42, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-3-tranh-treo-phong-be-gai-nang-tien-ca.jpg');
INSERT INTO `product_images` VALUES (59, 43, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-3-tranh-ca-heo-treo-phong-be-ngo-nghinh.jpg');
INSERT INTO `product_images` VALUES (60, 44, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-2-tranh-phi-hanh-gia-ngo-nghinh-treo-phong-be-trai.jpg');
INSERT INTO `product_images` VALUES (67, 45, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/d11pro-xam-web_g9k2yX3RuAxH1R5zKWYmP3NbhYmgWLUPKYJEoTfjDZzM3hU1a72511686780169.webp');
INSERT INTO `product_images` VALUES (68, 45, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/d11pro-xam-web_vH0VPXBNdERVFMx4TgWwtVQdVjVaffTbHaw8zRIQXMHgRRVhNH251759387381.webp');
INSERT INTO `product_images` VALUES (69, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-a12-xanh-web_AmvqdvIOE99w7QZ2QS2xFeaZIQIjidK8HhV5e9wrvtDiiRAzU92519937312795.webp');
INSERT INTO `product_images` VALUES (70, 46, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-a12-hong-web_K2SaCVbrbNICy6zpdKDhC5L17OX1LUjQTTpVnGIOGKfIXqg0q12515067198420.webp');
INSERT INTO `product_images` VALUES (71, 47, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk4-hong-web_2ZbOIazw2qSYexklNNeP3ka1EjSg5IZITVcvQNMwAQCCpfbJl72514735995555.webp');
INSERT INTO `product_images` VALUES (72, 47, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk4-xanh-web_ukaYAmQzxv3O0bxOBX8MjZTdmwR7jCyC0u4FWvenbPTi11AjiT2513491764033.webp');
INSERT INTO `product_images` VALUES (73, 48, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-sku-xanh-web_k0XVgE8hFVTvpgooZHS46GTSkVjcQks45hhS3wxixecFIK0eMB251869949351.webp');
INSERT INTO `product_images` VALUES (74, 48, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-sku-hong-web_0PIcUHATgPTriYadsiScnldHFC9Ejf9Fs4jumKUWai9p7RA2y82519697083705.webp');
INSERT INTO `product_images` VALUES (75, 49, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/round-xanh-web_4zvh49M9JwyQXrNydFsatglSDEx4RcEk3OdFqgcHSwDNnauUVU2513131233892.webp');
INSERT INTO `product_images` VALUES (76, 49, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/round-hong-web-copy5XLikrySVbjXojLxOfkw8FnbUtUGJunf2UNoFA3FfKSzaWixlT251120347357.webp');
INSERT INTO `product_images` VALUES (77, 50, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk2-xanh-web_lAPJDFEV1siQKULuuRhQwdacuih7iCjsJb761BpUxUHqvmZsBD2511851583515.webp');
INSERT INTO `product_images` VALUES (78, 50, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk2-hong-web-copyzafTB5d6WtxLAm9Naw5NBvupathmxFDBkE6doFHZCbEU2yiQBu251387117052.webp');
INSERT INTO `product_images` VALUES (79, 51, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6696978444187_36b8b9d23976d7974ff74a0e6e5b36b8sAWmqEZhpbJeKELLeNt4KdVXndSiP4VXZKo16dOfhtbBh2udQy2567747169927.webp');
INSERT INTO `product_images` VALUES (80, 51, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6696978477818_01c7876df942bc0b2e953da41eda21acU5npJxMUXioPJjfOrvlqqVb3gY4jslOmfzXuRcFlt62go6dpVE2565129062105.webp');
INSERT INTO `product_images` VALUES (81, 52, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-3-hong-web_B5X23f3upZoWYxILNN1J5xvV9gK27vPdigLDXHPVlMt3gs7a3u2518188175221.webp');
INSERT INTO `product_images` VALUES (82, 52, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-3-xanh-web_ArZe5XrZx9sAQ2byBTKRIy7gT5nBrZI620XR0P8xw55H0GgM0k2515847278580.webp');
INSERT INTO `product_images` VALUES (83, 53, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-h120-hong-web_SLh53OuegheTK8kUm1x5vzz3Vd9WxoIYEqtZvZbaqukzOZclNX2511481748035.webp');
INSERT INTO `product_images` VALUES (84, 53, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-h120-xanh-web_yqvYdGzJSqBWbRvbI6qQGMycMAWniumCeGgd2ol7bIel5zFwMA251452747930.webp');
INSERT INTO `product_images` VALUES (85, 54, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-hong-web_Dcejh6wvZ8HgRMYuJWhV0PWUaf4K6PkBxrvHobwb0mvguxMUi12514728333872.webp');
INSERT INTO `product_images` VALUES (86, 54, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-xanh-web_DsVlme6Dop1p2qkxySzeHa40qvRVQ3pxnmFfsZCwugJ2uaX6Ms2513643342506.webp');
INSERT INTO `product_images` VALUES (87, 55, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-2-xanh-webJuEoAMxIem3R7vHBTVwPgd3NqKMlTz1FRAew2H63mty44KtxtN2519120282302.webp');
INSERT INTO `product_images` VALUES (88, 55, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-2-hong-web_6aGQUccxN44SmLa9li8kiva0Y3WEVcfkJ95zJlAgZNIiTAsM032513225566888.webp');
INSERT INTO `product_images` VALUES (89, 56, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-jz-web_uNHdT1vVDQ8fpN9fPi5XXcCuxgq7F7aHXcfLQdXKdIfEhHJL492518797068308.webp');
INSERT INTO `product_images` VALUES (90, 56, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-jz-hong-web_s4ELu98xLGJKrFGwjns5qzRVJNfWTHjajR7wKE1Phmucf9QlsB2519521490425.webp');
INSERT INTO `product_images` VALUES (91, 57, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/vancover-t3-hong-web_rm4FXdcag8Y4DrCS1KgCErJN2Zj9yLm3r0SF3Dap3FnuS79WXf2511719951654.webp');
INSERT INTO `product_images` VALUES (92, 57, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/vancover-t3-xanh-webTbV7CcuYP6pnR7GVtQ4YpE30Q3CxXXgTFQgqT4wcfTF2HxbRsw2514864891926.webp');
INSERT INTO `product_images` VALUES (93, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6774680876203_43ba0a48fea714275832b806ba92fe52loGeySl6SFm2vkwwFjGautypfNReKdEaSzJeUxxxJiS4Axg8fv2573034554393.webp');
INSERT INTO `product_images` VALUES (94, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6774680876202_d030ac784760a8d6749c6585f5568bdfXAU4JmuoesLyP958Xp8CIEgN8vF6uOCzjEzipoFyqC7QSvzOZ12574323947696.webp');
INSERT INTO `product_images` VALUES (95, 58, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6774680916189_12085f34cb62b248c34afa6b31a649eeoRzfAMnMcY7TKwC5aCgJKJ1OAPimSjveH68VtrcwQfzQubNsRA2579932570882.webp');
INSERT INTO `product_images` VALUES (96, 59, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/t1-xanh-web-copy42D7Dki3YxA0oPKyfTSDuEB8olWZaynt4kyW5gsQFUAFlhoZfG251259067222.webp');
INSERT INTO `product_images` VALUES (97, 59, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/t1-hong-web_iiY13yEX9jltCdQCPklxGFWqxnovJP8sZrQXI0prbSPfLlSY3u2519753884270.webp');
INSERT INTO `product_images` VALUES (98, 60, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/ros-hong-100h-web-copyqXOatHdpFk8jmwu8kdcEmdIXCWJ4vPljBJDAGtXOWZfYhVghaY251968704346.webp');
INSERT INTO `product_images` VALUES (99, 60, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/ros-xanhg100h-web-copyyW9ymL4F28D91LIZywcrb6605iYO4ueF43lCt24ZOciQsXaX6f2514958320202.webp');
INSERT INTO `product_images` VALUES (100, 61, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/lux-gjhh105t-xanh-web_fC2FDjSsgiglG9gGGA2OqQxx5bE5gHh1mofIJtBoKJ93BETcu22514070387718.webp');
INSERT INTO `product_images` VALUES (101, 61, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/lux-gjhh105t-hong-web_NmVcr2cSSKKJvaOFNcw9VvNo6T8oTFdsLaMHpe1BHT0GHn8GKN2516236637486.webp');
INSERT INTO `product_images` VALUES (102, 62, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/cos-hong-100-webeMFFQJASSDp358yalbM7uAAFiMOmjP2N5IzwigELY2NuDqJsHR2519749664313.webp');
INSERT INTO `product_images` VALUES (103, 62, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/cos-xanhg100-webllswoeFQwcfAmqNC5HdU7wLblloWB206BN5u5J1D8j2CG1dqaw2512448727911.webp');
INSERT INTO `product_images` VALUES (104, 63, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fan-02-hong-websSbMGQ9NCdzZOOynrPBsabtLOw0XbgHDmab5GsZNZtHkHIeBxQ255859856634.webp');
INSERT INTO `product_images` VALUES (105, 63, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/fan-02-xanh-webLI1XWoDvb7M194JPDAHRV7KxYpEoNcTaakRtdSRyHCbOZ4kAMA2554883142897.webp');
INSERT INTO `product_images` VALUES (106, 64, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g8-hong-web_CcPPgDUX6aA1twcqTExGC7879l4L0i6D0ZAbVfNzKhyAmfXDW224115777956158.webp');
INSERT INTO `product_images` VALUES (107, 64, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g8-xanh-webWOIieou6MPsJbATkwbfoVs1vFUJIax0FicU6sxe51VEEyR1XTm24116348211410.webp');
INSERT INTO `product_images` VALUES (108, 65, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2d-xanh-web_O3gxulLCFBfjR9FSTmlydAtavLGB13GyE63mAr4DnKsm10ZgRC2412379599210.webp');
INSERT INTO `product_images` VALUES (109, 65, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2d-hong-web_mIDB2cqYkQQrvQsIpXEQfgX6QZAo45Mv5nPaALa6S88MbVzagx24128787832865.webp');
INSERT INTO `product_images` VALUES (110, 66, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6223369350553_9735dd3021a14419839c7cd98cffc81eKsdcok10A9F7m2o043MsKeyPHCJZiyJ2cASqmki8b12XDBStZx2518611067055.webp');
INSERT INTO `product_images` VALUES (111, 66, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6223369350514_2576911dd5ce4ffdff12c4d844c3beb6lEuuDNu9pt2X1lf4xx1sOzlXoFOvFsvLPTMSbe41uSSmXXGSVw251656454946.webp');
INSERT INTO `product_images` VALUES (112, 67, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g6-xanh-web_6I8LX2baInaCIDde2XgSXp3cWbtqFfceyH2SeNzoNxBQa7Rr1Q24118999348849.webp');
INSERT INTO `product_images` VALUES (113, 67, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g6-hong-web_KjOVVs0Bnoo77VQ7j24Pn8NoDntVUi7xPu1zRSRtb573hJbP172411770983780.webp');
INSERT INTO `product_images` VALUES (114, 68, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g5-xanh-web_tzqtqBcflMQysF84F0JppcbjTD4TIGHf69EXVO2qczsbYkm2vu2411186942187.webp');
INSERT INTO `product_images` VALUES (115, 68, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g5-hong-web_VLLPTMHV79EOSpsoOrKldQxlXaP0ZiyDU7GrpDUNpzQFbF0Yj724116179516590.webp');
INSERT INTO `product_images` VALUES (116, 69, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2-ghi-web_GpR81MkxKhkIZrwPqeSiir30PNiRaoQf9IqSPz9JlcYvruVRA92519155084901.webp');
INSERT INTO `product_images` VALUES (117, 69, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2-hong-web_PUg2FxddUPxmaZHfs6HMnIrZIct0ZCrrvz0K42p7Yk7w94BbUg25136278342.webp');
INSERT INTO `product_images` VALUES (118, 70, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g2-hong-web_ioFZBAkbsU5MtCbs7smrqZZThhd6hOjbf1FGwe4s2AGSzEftXR24112873846301.webp');
INSERT INTO `product_images` VALUES (119, 70, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/thiet-ke-chua-co-ten-34-212jLhrt6MDQoDI7jn8n4uD30PuJ5IRfaMYE689TCaxkYxgEqSjt0.webp');
INSERT INTO `product_images` VALUES (120, 71, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/fan-11-hong-web_68VQfXquPQErWgRmHbEoAy2SZ2cpGlctNhR17J4GOnpx2M9aLx24119232447222.webp');
INSERT INTO `product_images` VALUES (121, 71, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/fan-11-xanh-web_k6sFHfziVTuo9se9AXtRA6owQXll42QJsptNtdYOX2k9nZfmM124112849561156.webp');
INSERT INTO `product_images` VALUES (122, 72, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6579922504455_ba3c9547332687fabb92d3e2bd023cd8jVqassFVyS6kHaVT85pP6MO5sAszAyOiW7RnvRr7NaxLi2ow0d2555909328598.webp');
INSERT INTO `product_images` VALUES (123, 72, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6579922471246_80ba02d26d2bd6a3f1e7af1fe0e0aca9HHFguC9mEVfL2R3cq3KwfANMlKZYddloZTGgc0Ylyr287ZYJcZ2552890330479.webp');
INSERT INTO `product_images` VALUES (124, 73, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g3-hong-web_to41NV8KimhXR32Foc8S3hSQEB96MrCwPYZJietAGo1b3Iw7qZ24114303885303.webp');
INSERT INTO `product_images` VALUES (125, 73, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g3-xanh-web_Gl6Tg2TdxNDA1rRICUrnSniX4kGC5OCwgrUO1VtbR9YmT1ay2X24117562554877.webp');
INSERT INTO `product_images` VALUES (126, 74, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6510236438554_c110d74d5abc497038f6fa342e0782e8FPJCwOMzvDQ392YtQqAehd6c7P0PCGZELn0mfwBhuoTxrWHM942546471470618.webp');
INSERT INTO `product_images` VALUES (127, 74, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6510236358436_af4b94f5f2969adfd3667346ff0fa0e2W1LligEhTHWaFEpc0vR3wc2m3qvikZwRXx5yMg1etcRmmRXD0N2544146312176.webp');
INSERT INTO `product_images` VALUES (128, 75, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g1-hong-webe67Uu8CMtuztNs2oO3YtMfHDUfeZtsTvFFPeQbXZ5JddlUEGDD24117715462794.webp');
INSERT INTO `product_images` VALUES (129, 75, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g1-xanh-web_CMe2viXUU1h82V05vISezEivyZaaNaQs0akSh785q9wnYYc0je24119690636685.webp');
INSERT INTO `product_images` VALUES (130, 76, 'https://sudospaces.com/babycuatoi/2023/11/kxht-055.png');
INSERT INTO `product_images` VALUES (131, 76, 'https://sudospaces.com/babycuatoi/uploads/09122017/canh-hang-rao-zk022-1-small.png');
INSERT INTO `product_images` VALUES (132, 77, 'https://sudospaces.com/babycuatoi/2023/07/js006-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-5-small.jpg');
INSERT INTO `product_images` VALUES (133, 77, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-1-small.jpg');
INSERT INTO `product_images` VALUES (134, 77, 'https://sudospaces.com/babycuatoi/2023/07/js006-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-7-small.jpg');
INSERT INTO `product_images` VALUES (135, 78, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-small.jpg');
INSERT INTO `product_images` VALUES (136, 78, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-small.jpg');
INSERT INTO `product_images` VALUES (137, 79, 'https://sudospaces.com/babycuatoi/2021/05/js003-thiet-bi-the-duc-cho-tre-em-2-small.jpg');
INSERT INTO `product_images` VALUES (138, 79, 'https://sudospaces.com/babycuatoi/uploads/16082018/thiet-bi-tap-the-duc-tre-em-1-small.jpg');
INSERT INTO `product_images` VALUES (139, 79, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-1-small.jpg');
INSERT INTO `product_images` VALUES (140, 80, 'https://sudospaces.com/babycuatoi/2023/12/zk1062-small.png');
INSERT INTO `product_images` VALUES (141, 80, 'https://sudospaces.com/babycuatoi/2023/12/zk1062-small.png');
INSERT INTO `product_images` VALUES (142, 81, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-3-1-small.jpg');
INSERT INTO `product_images` VALUES (143, 81, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-4-small.jpg');
INSERT INTO `product_images` VALUES (144, 81, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-2-small.jpg');
INSERT INTO `product_images` VALUES (145, 82, 'https://sudospaces.com/babycuatoi/2023/08/zk1035-ngua-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-small.jpg');
INSERT INTO `product_images` VALUES (146, 82, 'https://sudospaces.com/babycuatoi/2023/08/zk1035-ngua-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-3-small.jpg');
INSERT INTO `product_images` VALUES (147, 82, 'https://sudospaces.com/babycuatoi/2023/08/zk1035-ngua-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-1-small.jpg');
INSERT INTO `product_images` VALUES (148, 83, 'https://sudospaces.com/babycuatoi/2024/01/rk-701-do-choi-bap-benh-cho-be-huou-cao-co-doi-2-small.jpg');
INSERT INTO `product_images` VALUES (149, 83, 'https://sudospaces.com/babycuatoi/2024/01/rk-700-do-choi-bap-benh-cho-be-huou-cao-co-doi-1-small.jpg');
INSERT INTO `product_images` VALUES (150, 83, 'https://sudospaces.com/babycuatoi/2020/08/rk-701-do-choi-bap-benh-cho-be-2-small.jpg');
INSERT INTO `product_images` VALUES (151, 84, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-small.jpg');
INSERT INTO `product_images` VALUES (152, 84, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-2-small.jpg');
INSERT INTO `product_images` VALUES (153, 84, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-1-1-small.jpg');
INSERT INTO `product_images` VALUES (154, 85, 'https://sudospaces.com/babycuatoi/2023/08/zk1020-bap-benh-doi-con-ga-truong-mam-non-khu-vui-choi-2.jpg');
INSERT INTO `product_images` VALUES (155, 85, 'https://sudospaces.com/babycuatoi/uploads/20062015/bap-benh-doi-kt023-1-small.jpg');
INSERT INTO `product_images` VALUES (156, 86, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-5-small.jpg');
INSERT INTO `product_images` VALUES (157, 86, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-4-small.jpg');
INSERT INTO `product_images` VALUES (158, 86, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-3-small.jpg');
INSERT INTO `product_images` VALUES (159, 87, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-small.jpg');
INSERT INTO `product_images` VALUES (160, 87, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-1-1-small.jpg');
INSERT INTO `product_images` VALUES (161, 87, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-2-1-small.jpg');
INSERT INTO `product_images` VALUES (162, 88, 'https://sudospaces.com/babycuatoi/2023/08/zk1022-bap-benh-ngua-doi-cho-be-khu-vui-choi-truong-mam-non.jpg');
INSERT INTO `product_images` VALUES (163, 88, 'https://sudospaces.com/babycuatoi/uploads/20062015/bap-benh-doi-ngua-kt022-small.jpg');
INSERT INTO `product_images` VALUES (164, 89, 'https://sudospaces.com/babycuatoi/2020/08/zk1032-bap-benh-cho-be-6-small.jpg');
INSERT INTO `product_images` VALUES (165, 89, 'https://sudospaces.com/babycuatoi/2020/08/zk1032-bap-benh-cho-be-small.jpg');
INSERT INTO `product_images` VALUES (166, 89, 'https://sudospaces.com/babycuatoi/2020/08/zk1032-bap-benh-cho-be-1-small.jpg');
INSERT INTO `product_images` VALUES (167, 90, 'https://sudospaces.com/babycuatoi/2023/08/zk1017b-bap-benh-don-doi-ket-hop-ca-voi.jpg');
INSERT INTO `product_images` VALUES (168, 90, 'https://sudospaces.com/babycuatoi/uploads/25082018/bap-benh-doi-cho-be-zk1017-tong-hop-2-1-small.png');
INSERT INTO `product_images` VALUES (169, 90, 'https://sudospaces.com/babycuatoi/uploads/25082018/bap-benh-doi-cho-be-zk1017-vang-1-small.png');
INSERT INTO `product_images` VALUES (170, 91, 'https://sudospaces.com/babycuatoi/2023/08/zk1033-ca-heo-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-small.jpg');
INSERT INTO `product_images` VALUES (171, 91, 'https://sudospaces.com/babycuatoi/uploads/04042018/bap-benh-ca-heo-cho-be-zk1033-1-small.jpg');
INSERT INTO `product_images` VALUES (172, 91, 'https://sudospaces.com/babycuatoi/2020/08/zk1033-bap-benh-cho-be-1-small.jpg');
INSERT INTO `product_images` VALUES (173, 92, 'https://sudospaces.com/babycuatoi/2021/03/rk-701-do-choi-bap-benh-cho-be-3-small.jpg');
INSERT INTO `product_images` VALUES (174, 92, 'https://sudospaces.com/babycuatoi/2020/08/rk-701-do-choi-bap-benh-cho-be-1-small.jpg');
INSERT INTO `product_images` VALUES (175, 92, 'https://sudospaces.com/babycuatoi/2024/01/rk-701-do-choi-bap-benh-cho-be-huou-cao-co-doi-12-small.jpg');
INSERT INTO `product_images` VALUES (176, 93, 'https://sudospaces.com/babycuatoi/2022/01/rk-511b-d.png');
INSERT INTO `product_images` VALUES (177, 93, 'https://sudospaces.com/babycuatoi/2023/08/rk511b-do-choi-bap-benh-cho-be-truong-mam-non-khu-vui-choi-1-small.jpg');
INSERT INTO `product_images` VALUES (178, 93, 'https://sudospaces.com/babycuatoi/2023/08/rk511b-do-choi-bap-benh-cho-be-truong-mam-non-khu-vui-choi-3-small.jpg');
INSERT INTO `product_images` VALUES (179, 94, 'https://sudospaces.com/babycuatoi/2022/01/rk-514b-t-small.png');
INSERT INTO `product_images` VALUES (180, 94, 'https://sudospaces.com/babycuatoi/2023/08/rk-514-bap-benh-ket-hop-xe-choi-chan-cho-be-15-small.jpg');
INSERT INTO `product_images` VALUES (181, 94, 'https://sudospaces.com/babycuatoi/2023/08/rk-514-bap-benh-ket-hop-xe-choi-chan-cho-be-12-small.jpg');
INSERT INTO `product_images` VALUES (182, 95, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-small.jpg');
INSERT INTO `product_images` VALUES (183, 95, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-1-small.jpg');
INSERT INTO `product_images` VALUES (184, 95, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-2-small.jpg');
INSERT INTO `product_images` VALUES (244, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung.jpg');
INSERT INTO `product_images` VALUES (245, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung-1-1.jpg');
INSERT INTO `product_images` VALUES (246, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung.jpg');
INSERT INTO `product_images` VALUES (247, 116, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung-1-1-small.jpg');
INSERT INTO `product_images` VALUES (248, 117, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1003-nhun-dien-nhap-khau-hello-kitty.jpg');
INSERT INTO `product_images` VALUES (249, 117, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1003-nhun-dien-nhap-khau-hello-kitty-2.jpg');
INSERT INTO `product_images` VALUES (251, 117, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1003-nhun-dien-nhap-khau-hello-kitty.jpg');
INSERT INTO `product_images` VALUES (252, 117, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1003-nhun-dien-nhap-khau-hello-kitty-2-small.jpg');
INSERT INTO `product_images` VALUES (253, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-3.jpg');
INSERT INTO `product_images` VALUES (254, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-2.jpg');
INSERT INTO `product_images` VALUES (255, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-1.jpg');
INSERT INTO `product_images` VALUES (256, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b.jpg');
INSERT INTO `product_images` VALUES (257, 118, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-3-1.jpg');
INSERT INTO `product_images` VALUES (258, 119, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1040-nhun-dien-nhap-khau-khu-vui-choi-tre-em-1.jpg');
INSERT INTO `product_images` VALUES (263, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em.jpg');
INSERT INTO `product_images` VALUES (264, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-3.jpg');
INSERT INTO `product_images` VALUES (266, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-1-1.jpg');
INSERT INTO `product_images` VALUES (267, 120, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em-4.jpg');
INSERT INTO `product_images` VALUES (268, 121, 'https://sudospaces.com/babycuatoi/2023/02/game-6012-may-gap-thu-bong-khu-vui-choi-1.jpg');
INSERT INTO `product_images` VALUES (269, 121, 'https://sudospaces.com/babycuatoi/2020/10/may-gap-thu-bong-khu-vui-choi-game-6012a-1.jpg');
INSERT INTO `product_images` VALUES (270, 121, 'https://sudospaces.com/babycuatoi/2023/02/game-6012-may-gap-thu-bong-khu-vui-choi-1-small.jpg');
INSERT INTO `product_images` VALUES (271, 121, 'https://sudospaces.com/babycuatoi/2020/10/may-gap-thu-bong-khu-vui-choi-game-6012a-1-small.jpg');
INSERT INTO `product_images` VALUES (272, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014.jpg');
INSERT INTO `product_images` VALUES (273, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014-2.jpg');
INSERT INTO `product_images` VALUES (274, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014-1.jpg');
INSERT INTO `product_images` VALUES (275, 122, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014-1-1.jpg');
INSERT INTO `product_images` VALUES (277, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-2.jpg');
INSERT INTO `product_images` VALUES (278, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-3-1.jpg');
INSERT INTO `product_images` VALUES (279, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-2-1.jpg');
INSERT INTO `product_images` VALUES (280, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-1.jpg');
INSERT INTO `product_images` VALUES (281, 123, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu.jpg');
INSERT INTO `product_images` VALUES (282, 124, 'https://sudospaces.com/babycuatoi/2020/02/ndnk-1008-nhu-dien-nhap-khau-bbt-global-1.jpg');
INSERT INTO `product_images` VALUES (283, 124, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1008-nhu-dien-nhap-khau-bbt-global-5.jpg');
INSERT INTO `product_images` VALUES (284, 124, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1008-nhu-dien-nhap-khau-bbt-global-3.jpg');
INSERT INTO `product_images` VALUES (285, 124, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1008-nhu-dien-nhap-khau-bbt-global-6.jpg');
INSERT INTO `product_images` VALUES (286, 124, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1008-nhu-dien-nhap-khau-bbt-global-4.jpg');
INSERT INTO `product_images` VALUES (287, 125, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1092-nhun-dien-nhap-khau-hai-ba-con-pepa.jpg');
INSERT INTO `product_images` VALUES (288, 125, 'https://sudospaces.com/babycuatoi/uploads/05122019/thu-nhun-dien-nhap-khau-pepa-ndnk-1092-5.png');
INSERT INTO `product_images` VALUES (289, 125, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1092-nhun-dien-nhap-khau-hai-ba-con-pepa.jpg');
INSERT INTO `product_images` VALUES (290, 125, 'https://sudospaces.com/babycuatoi/uploads/05122019/thu-nhun-dien-nhap-khau-pepa-ndnk-1092-5-small.png');
INSERT INTO `product_images` VALUES (291, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-1.jpg');
INSERT INTO `product_images` VALUES (292, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-3.jpg');
INSERT INTO `product_images` VALUES (293, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-2.jpg');
INSERT INTO `product_images` VALUES (294, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan.jpg');
INSERT INTO `product_images` VALUES (295, 126, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-1.jpg');
INSERT INTO `product_images` VALUES (296, 127, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1066-nhun-dien-nhap-khau-may-bay.jpg');
INSERT INTO `product_images` VALUES (297, 127, 'https://sudospaces.com/babycuatoi/2021/01/ndnk-1066-nhun-dien-nhap-khau-may-bay-4.jpg');
INSERT INTO `product_images` VALUES (298, 127, 'https://sudospaces.com/babycuatoi/2021/01/ndnk-1066-nhun-dien-nhap-khau-may-bay-1.jpg');
INSERT INTO `product_images` VALUES (299, 127, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1066-nhun-dien-nhap-khau-may-bay.jpg');
INSERT INTO `product_images` VALUES (300, 127, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1066-nhun-dien-nhap-khau-may-bay-2.jpg');
INSERT INTO `product_images` VALUES (301, 128, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020.jpg');
INSERT INTO `product_images` VALUES (302, 128, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020.jpg');
INSERT INTO `product_images` VALUES (303, 128, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020.jpg');
INSERT INTO `product_images` VALUES (304, 128, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020-small.jpg');
INSERT INTO `product_images` VALUES (305, 129, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than.jpg');
INSERT INTO `product_images` VALUES (306, 129, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than-2.jpg');
INSERT INTO `product_images` VALUES (307, 129, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than-1-1.jpg');
INSERT INTO `product_images` VALUES (308, 129, 'https://sudospaces.com/babycuatoi/uploads/01082019/ndnk-1010-nhun-dien-nhap-khau-cho-be-2.jpg');
INSERT INTO `product_images` VALUES (309, 129, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than.jpg');
INSERT INTO `product_images` VALUES (310, 130, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang.jpg');
INSERT INTO `product_images` VALUES (311, 130, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-7.jpg');
INSERT INTO `product_images` VALUES (312, 130, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-6.jpg');
INSERT INTO `product_images` VALUES (313, 130, 'https://sudospaces.com/babycuatoi/2020/09/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-5.jpg');
INSERT INTO `product_images` VALUES (314, 130, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang-1-1.jpg');
INSERT INTO `product_images` VALUES (315, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022a-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi.jpg');
INSERT INTO `product_images` VALUES (317, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi-5.jpg');
INSERT INTO `product_images` VALUES (318, 131, 'https://sudospaces.com/babycuatoi/2024/01/game-6022a-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi.jpg');
INSERT INTO `product_images` VALUES (320, 132, 'https://sudospaces.com/babycuatoi/2021/04/game-6025-may-game-khu-vui-choi-bbt-global.jpg');
INSERT INTO `product_images` VALUES (321, 132, 'https://sudospaces.com/babycuatoi/2024/04/may-game-bat-bo-khu-vui-choi.jpg');
INSERT INTO `product_images` VALUES (324, 132, 'https://sudospaces.com/babycuatoi/2021/04/game-6025-may-game-khu-vui-choi-bbt-global-4.jpg');
INSERT INTO `product_images` VALUES (325, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041.jpg');
INSERT INTO `product_images` VALUES (326, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-3.jpg');
INSERT INTO `product_images` VALUES (327, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-2.jpg');
INSERT INTO `product_images` VALUES (328, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-1-1.jpg');
INSERT INTO `product_images` VALUES (329, 133, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041-1.jpg');
INSERT INTO `product_images` VALUES (330, 134, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-may-dap-chuot-game-3012-1-3.jpg');
INSERT INTO `product_images` VALUES (331, 134, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-may-dap-chuot-game-3012-1.jpg');
INSERT INTO `product_images` VALUES (332, 134, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-may-dap-chuot-game-3012-1-3.jpg');
INSERT INTO `product_images` VALUES (334, 135, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1007-nhun-dien-nhap-khau-o-to.jpg');
INSERT INTO `product_images` VALUES (335, 135, 'https://sudospaces.com/babycuatoi/uploads/19062019/ndnk1007-nhun-dien-nhap-khau-hinh-o-to-1.jpg');
INSERT INTO `product_images` VALUES (336, 135, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1007-nhun-dien-nhap-khau-o-to-1-1.jpg');
INSERT INTO `product_images` VALUES (338, 135, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1007-nhun-dien-nhap-khau-o-to.jpg');
INSERT INTO `product_images` VALUES (339, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no.jpg');
INSERT INTO `product_images` VALUES (340, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-5.jpg');
INSERT INTO `product_images` VALUES (342, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-3.jpg');
INSERT INTO `product_images` VALUES (343, 96, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-2.jpg');
INSERT INTO `product_images` VALUES (344, 97, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-12.jpg');
INSERT INTO `product_images` VALUES (345, 97, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-11.jpg');
INSERT INTO `product_images` VALUES (346, 97, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-6.jpg');
INSERT INTO `product_images` VALUES (347, 97, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-5.jpg');
INSERT INTO `product_images` VALUES (348, 97, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-4.jpg');
INSERT INTO `product_images` VALUES (349, 98, 'https://sudospaces.com/babycuatoi/2024/11/mo-hinh-xe-container-cho-6-xe-cong-trinh-bang-hop-kim-cho-be-818-2b.jpg');
INSERT INTO `product_images` VALUES (350, 98, 'https://sudospaces.com/babycuatoi/2024/01/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-2.jpg');
INSERT INTO `product_images` VALUES (351, 98, 'https://sudospaces.com/babycuatoi/2024/02/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-4.jpg');
INSERT INTO `product_images` VALUES (352, 98, 'https://sudospaces.com/babycuatoi/2024/02/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-3.jpg');
INSERT INTO `product_images` VALUES (353, 98, 'https://sudospaces.com/babycuatoi/2024/01/818-2b-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-cong-trinh-hop-kim-1.jpg');
INSERT INTO `product_images` VALUES (354, 99, 'https://sudospaces.com/babycuatoi/2023/02/intex-48259-nha-hoi-nha-banh-nhun-cho-be-2.jpg');
INSERT INTO `product_images` VALUES (355, 99, 'https://sudospaces.com/babycuatoi/2021/01/48259-nha-hoi-nhun-nha-phao.jpg');
INSERT INTO `product_images` VALUES (356, 99, 'https://sudospaces.com/babycuatoi/uploads/16072018/nha-nhun-lau-dai-intex-48259-1.jpg');
INSERT INTO `product_images` VALUES (357, 99, 'https://sudospaces.com/babycuatoi/2020/08/48259.jpg');
INSERT INTO `product_images` VALUES (359, 100, 'https://sudospaces.com/babycuatoi/2023/10/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai.jpg');
INSERT INTO `product_images` VALUES (360, 100, 'https://sudospaces.com/babycuatoi/2023/11/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-12.jpg');
INSERT INTO `product_images` VALUES (361, 100, 'https://sudospaces.com/babycuatoi/2023/11/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-13.jpg');
INSERT INTO `product_images` VALUES (362, 100, 'https://sudospaces.com/babycuatoi/2023/11/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-11.jpg');
INSERT INTO `product_images` VALUES (364, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-3-do-choi-trong-be-tam-cho-be-rua-ca-cua-ech-vit.jpg');
INSERT INTO `product_images` VALUES (365, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-12.jpg');
INSERT INTO `product_images` VALUES (366, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-2.jpg');
INSERT INTO `product_images` VALUES (367, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-con.jpg');
INSERT INTO `product_images` VALUES (368, 101, 'https://sudospaces.com/babycuatoi/2024/05/6688-do-choi-trong-be-tam-rua-ech-ca-heo-vit-cua-van-cot-cho-be-vui-nhon-11.jpg');
INSERT INTO `product_images` VALUES (369, 102, 'https://sudospaces.com/babycuatoi/2022/11/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap.jpg');
INSERT INTO `product_images` VALUES (371, 102, 'https://sudospaces.com/babycuatoi/2022/12/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-8.jpg');
INSERT INTO `product_images` VALUES (372, 102, 'https://sudospaces.com/babycuatoi/2022/12/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-9.jpg');
INSERT INTO `product_images` VALUES (374, 103, 'https://sudospaces.com/babycuatoi/2020/09/msn17074-do-choi-bep-nau-an-cho-be.jpg');
INSERT INTO `product_images` VALUES (375, 103, 'https://sudospaces.com/babycuatoi/2020/01/msn17074-bep-nau-an-go-cao-cap-cho-be.jpg');
INSERT INTO `product_images` VALUES (379, 104, 'https://sudospaces.com/babycuatoi/2024/07/20231-do-choi-gap-chuot-cho-be.jpg');
INSERT INTO `product_images` VALUES (380, 104, 'https://sudospaces.com/babycuatoi/2024/07/20231-do-choi-gap-chuot-cho-be.jpg');
INSERT INTO `product_images` VALUES (383, 105, 'https://sudospaces.com/babycuatoi/2024/07/158-7c-do-choi-dap-chuot-xoay-360-co-den-va-nhac.jpg');
INSERT INTO `product_images` VALUES (388, 106, 'https://sudospaces.com/babycuatoi/2024/01/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim.jpg');
INSERT INTO `product_images` VALUES (390, 106, 'https://sudospaces.com/babycuatoi/2024/01/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim-2-1.jpg');
INSERT INTO `product_images` VALUES (391, 106, 'https://sudospaces.com/babycuatoi/2024/01/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim-4.jpg');
INSERT INTO `product_images` VALUES (393, 107, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-5.jpg');
INSERT INTO `product_images` VALUES (394, 107, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-4.jpg');
INSERT INTO `product_images` VALUES (398, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu.jpg');
INSERT INTO `product_images` VALUES (401, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu-5.jpg');
INSERT INTO `product_images` VALUES (402, 108, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu-1.jpg');
INSERT INTO `product_images` VALUES (403, 109, 'https://sudospaces.com/babycuatoi/2024/05/706-130-do-choi-xep-hinh-nam-cham-130-chi-tiet-5.jpg');
INSERT INTO `product_images` VALUES (404, 109, 'https://sudospaces.com/babycuatoi/2024/03/clb-4-do-choi-xep-hinh-nam-cham-64-chi-tiet-cho-be-10-1.jpg');
INSERT INTO `product_images` VALUES (405, 109, 'https://sudospaces.com/babycuatoi/2024/03/clb-4-do-choi-xep-hinh-nam-cham-64-chi-tiet-cho-be.jpg');
INSERT INTO `product_images` VALUES (408, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac.jpg');
INSERT INTO `product_images` VALUES (409, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-2-1.jpg');
INSERT INTO `product_images` VALUES (410, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-5.jpg');
INSERT INTO `product_images` VALUES (411, 110, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-1-1.jpg');
INSERT INTO `product_images` VALUES (413, 111, 'https://sudospaces.com/babycuatoi/2024/05/bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-a189.jpg');
INSERT INTO `product_images` VALUES (415, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-17.jpg');
INSERT INTO `product_images` VALUES (416, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-9.jpg');
INSERT INTO `product_images` VALUES (417, 111, 'https://sudospaces.com/babycuatoi/2024/05/a189-bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-16.jpg');
INSERT INTO `product_images` VALUES (418, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-va-sac.jpg');
INSERT INTO `product_images` VALUES (419, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-7.jpg');
INSERT INTO `product_images` VALUES (420, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-6.jpg');
INSERT INTO `product_images` VALUES (421, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-5.jpg');
INSERT INTO `product_images` VALUES (422, 112, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-4.jpg');
INSERT INTO `product_images` VALUES (423, 113, 'https://sudospaces.com/babycuatoi/2025/03/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori.jpg');
INSERT INTO `product_images` VALUES (424, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-4.jpg');
INSERT INTO `product_images` VALUES (426, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-9.jpg');
INSERT INTO `product_images` VALUES (427, 113, 'https://sudospaces.com/babycuatoi/2025/04/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-8.jpg');
INSERT INTO `product_images` VALUES (428, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet.jpg');
INSERT INTO `product_images` VALUES (429, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-1.jpg');
INSERT INTO `product_images` VALUES (431, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-2.jpg');
INSERT INTO `product_images` VALUES (432, 114, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-5.jpg');
INSERT INTO `product_images` VALUES (433, 115, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-6.jpg');
INSERT INTO `product_images` VALUES (434, 115, 'https://sudospaces.com/babycuatoi/2024/08/839-012-do-choi-bap-nau-an-co-lon-cho-be-nau-an-nhu-that-8.jpg');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `product_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `product_price` int NULL DEFAULT NULL,
  `product_size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `product_material` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `fk_products_categories`(`category_id` ASC) USING BTREE,
  INDEX `fk_products_brands`(`brand_id` ASC) USING BTREE,
  CONSTRAINT `fk_products_brands` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 136 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (7, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm887-1-400x400.jpg', 'Rèm trẻ em TM-887', 800000, '108x203 cm', 'Polyester', '2025-12-12 12:18:41');
INSERT INTO `products` VALUES (8, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm888-400x400.jpg', 'Rèm trẻ em TM-888', 950000, '104x124 cm', 'Polyester', '2025-12-12 12:18:42');
INSERT INTO `products` VALUES (9, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm889-400x400.jpg', 'Rèm trẻ em TM-889', 830000, '138x150 cm', 'Polyester', '2025-12-12 12:18:43');
INSERT INTO `products` VALUES (10, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm891-400x400.jpg', 'Rèm phòng bé gái TM-891', 1250000, '125x181 cm', 'Polyester', '2025-12-12 12:18:44');
INSERT INTO `products` VALUES (11, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm892-400x400.jpg', 'Rèm trẻ em TM-892', 650000, '140x137 cm', 'Polyester', '2025-12-12 12:18:45');
INSERT INTO `products` VALUES (12, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm893-400x400.jpg', 'Rèm trẻ em TM-893', 950000, '151x175 cm', 'Polyester', '2025-12-12 12:18:46');
INSERT INTO `products` VALUES (13, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm894-400x400.jpg', 'Rèm trẻ em TM-894', 950000, '130x179 cm', 'Polyester', '2025-12-12 12:18:47');
INSERT INTO `products` VALUES (14, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-400x400.jpg', 'Rèm trẻ em TM-895', 1300000, '103x148 cm', 'Polyester', '2025-12-12 12:18:48');
INSERT INTO `products` VALUES (15, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-tre-em-tm895-5-400x400.jpg', 'Rèm trẻ em TM-8995', 650000, '155x182 cm', 'Polyester', '2025-12-12 12:18:49');
INSERT INTO `products` VALUES (16, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-phong-be-tm896-400x400.jpg', 'Rèm vải phòng Trai TM-896', 600000, '158x208 cm', 'Polyester', '2025-12-12 12:18:50');
INSERT INTO `products` VALUES (17, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-dep-tm-866-400x400.jpg', 'Rèm phòng bé đẹp TM 866', 650000, '141x163 cm', 'Polyester', '2025-12-12 12:18:51');
INSERT INTO `products` VALUES (18, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-tm885-400x400.jpg', 'Rèm phòng bé TM-885', 550000, '118x130 cm', 'Polyester', '2025-12-12 12:18:52');
INSERT INTO `products` VALUES (19, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-tm885-2-400x400.jpg', 'Rèm phòng bé gái đẹp TM 867', 750000, '118x202 cm', 'Polyester', '2025-12-12 12:18:53');
INSERT INTO `products` VALUES (20, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-phong-be-gai-869-400x400.jpg', 'Rèm phòng bé gái 869', 690000, '115x198 cm', 'Polyester', '2025-12-12 12:18:54');
INSERT INTO `products` VALUES (21, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-be-gai-tm-86899-400x400.jpg', 'Rèm bé gái TM 86-899', 750000, '123x200 cm', 'Polyester', '2025-12-12 12:18:55');
INSERT INTO `products` VALUES (22, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-tre-em-hoa-tiet-hoat-hinh-o-ha-noi-tr-201-400x400.jpg', 'Rèm vải trẻ em họa tiết hoạt hình', 650000, '154x163 cm', 'Polyester', '2025-12-12 12:18:56');
INSERT INTO `products` VALUES (23, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/thich-mat-voi-mau-rem-cua-cho-be-trai-tr-202-quan-tay-ho-400x400.jpg', 'Rèm cửa cho bé trai TR 202', 860000, '159x166 cm', 'Polyester', '2025-12-12 12:18:57');
INSERT INTO `products` VALUES (24, 2, 2, 'https://remkhanhduong.com/wp-content/uploads/2025/09/rem-vai-mau-hong-cho-phong-be-yeu-ma-mjl-5034-400x400.jpg', 'Rèm vải màu hồng cho phòng bé yêu', 780000, '114x161 cm', 'Polyester', '2025-12-12 12:18:58');
INSERT INTO `products` VALUES (25, 2, 3, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-phi-hanh-gia-treo-phong-be-trai.jpg', 'Tranh phi hành gia treo phòng bé trai cực chất', 1212000, '30 x 40cm', 'Vải canvas', '2025-12-12 13:51:04');
INSERT INTO `products` VALUES (26, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-tre-em-mau-nuoc-de-thuong-cho-be-gai.jpg', 'Tranh treo tường trẻ em màu nước dễ thương', 252000, '31 x 40cm', 'Vải canvas', '2025-12-12 13:51:05');
INSERT INTO `products` VALUES (27, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-gau-trang-ngo-nghinh-trang-tri-phong-be-trai.jpg', 'Tranh treo tường gấu trắng ngộ nghĩnh trang trí ', 504000, '32 x 40cm', 'Vải canvas', '2025-12-12 13:51:06');
INSERT INTO `products` VALUES (28, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong-phi-hanh-gia-trang-tri-phong-be-trai-dep.jpg', 'Tranh treo phòng phi hành gia trang trí phòng bé ', 126000, '33 x 40cm', 'Vải canvas', '2025-12-12 13:51:07');
INSERT INTO `products` VALUES (29, 2, 3, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-tuong--sweet-dream-cho-be-trai.jpg', 'Tranh treo tường Sweet Dream cho bé trai', 504000, '34 x 40cm', 'Vải canvas', '2025-12-12 13:51:08');
INSERT INTO `products` VALUES (30, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-be-gai-dang-yeu-voi-ca-heo.jpg', 'Tranh treo phòng bé gái đáng yêu với cá heo', 126000, '35 x 40cm', 'Vải canvas', '2025-12-12 13:51:09');
INSERT INTO `products` VALUES (31, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-tre-em-ca-heo-va-be-gai-cam-bong-bong.jpg', 'Tranh treo phòng trẻ em cá heo và bé cái cầm bóng ', 252000, '36 x 40cm', 'Giấy PP ', '2025-12-12 13:51:10');
INSERT INTO `products` VALUES (32, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-ky-lan-hong-va-cau-vong-de-thuong-cho-phong-be-gai.jpg', 'Tranh kỳ lân và cầu vồng đáng yêu cho bé gái', 504000, ' 40 x 60cm', 'Giấy PP ', '2025-12-12 13:51:11');
INSERT INTO `products` VALUES (33, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-khung-long-ngo-nghinh-trang-tri-phong-be-trai.jpg', 'Tranh khủng long ngộ nghĩnh trang trí phòng bé ', 126000, ' 41 x 60cm', 'Giấy PP ', '2025-12-12 13:51:12');
INSERT INTO `products` VALUES (34, 2, 3, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-dong-vat-ngo-nghinh-trang-tri-phong-tre-em.jpg', 'Tranh động vật ngộ nghĩnh trang trí phòng trẻ em', 504000, ' 42 x 60cm', 'Giấy PP ', '2025-12-12 13:51:13');
INSERT INTO `products` VALUES (35, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/set-4-trang-cong-chua-bale-trang-tri-phong-be-gai.jpg', ' Tranh công chúa múa bale trang trí phòng bé gái', 708000, ' 43 x 60cm', 'Giấy PP ', '2025-12-12 13:51:14');
INSERT INTO `products` VALUES (36, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-meo-vang-va-be-gai-dep.jpg', 'Tranh mèo vàng và bé gái màu nước cực đẹp', 168000, ' 44 x 60cm', 'Giấy PP ', '2025-12-12 13:51:15');
INSERT INTO `products` VALUES (37, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-ca-heo-xanh-va-be-gai-ngo-nghinh.jpg', 'Tranh cá heo xanh và bé gái ngộ nghĩnh', 126000, ' 45 x 60cm', 'Giấy PP ', '2025-12-12 13:51:16');
INSERT INTO `products` VALUES (38, 2, 3, 'https://xuongtranh.net/uploads/w900/2023/06/15/set-2-tranh-tho-ngo-nghinh-va-bong-bay-ngo-nghinh.jpg', 'Tranh thỏ và bóng bay ngộ nghĩnh', 336000, ' 46 x 60cm', 'Gỗ mica ', '2025-12-12 13:51:17');
INSERT INTO `products` VALUES (39, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-tranh-lovely-dong-vat-mau-sac-trang-tri-phong-cho-be.jpg', 'Tranh Lovely động vật màu sắc trang trí phòng bé', 912000, '60 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:18');
INSERT INTO `products` VALUES (40, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-6-tranh-dong-vat-ngo-nghinh-treo-phong-be-trai.jpg', 'Tranh động vật ngộ nghĩnh treo phòng bé', 1248000, '61 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:19');
INSERT INTO `products` VALUES (41, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/tranh-treo-phong-ngu-meo-de-thuong-cho-be.jpg', 'Tranh treo phòng ngủ mèo dễ thương cho bé', 252000, '62 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:20');
INSERT INTO `products` VALUES (42, 2, 3, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-3-tranh-treo-phong-be-gai-nang-tien-ca.jpg', 'Tranh treo phòng bé gái nàng tiên cá', 504000, '63 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:21');
INSERT INTO `products` VALUES (43, 2, 4, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-3-tranh-ca-heo-treo-phong-be-ngo-nghinh.jpg', 'Tranh cá heo treo phòng bé ngộ nghĩnh', 504000, '64 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:22');
INSERT INTO `products` VALUES (44, 2, 5, 'https://xuongtranh.net/uploads/w900/2023/06/15/bo-2-tranh-phi-hanh-gia-ngo-nghinh-treo-phong-be-trai.jpg', 'Tranh phi hành gia ngộ nghĩnh trang trí phòng bé ', 252000, '65 x 80cm', 'Gỗ mica ', '2025-12-12 13:51:23');
INSERT INTO `products` VALUES (45, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/d11pro-xam-web_g9k2yX3RuAxH1R5zKWYmP3NbhYmgWLUPKYJEoTfjDZzM3hU1a72511686780169.webp', 'Bàn Ghế Thông Minh Chống Gù Chống Cận D11 Pro', 12220000, '120 x 78cm', 'Gỗ tự nhiên', '2025-12-25 23:59:39');
INSERT INTO `products` VALUES (46, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-a12-xanh-web_AmvqdvIOE99w7QZ2QS2xFeaZIQIjidK8HhV5e9wrvtDiiRAzU92519937312795.webp', 'Bàn Học Thông Minh Chống Gù Chống Cận A12 Fancy', 9650000, '120 x 70cm', 'Gỗ tự nhiên', '2025-12-25 23:59:40');
INSERT INTO `products` VALUES (47, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk4-hong-web_2ZbOIazw2qSYexklNNeP3ka1EjSg5IZITVcvQNMwAQCCpfbJl72514735995555.webp', 'Bàn Học Thông Minh Chống Cận FANCY TK4 New Version', 9110000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:41');
INSERT INTO `products` VALUES (48, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-sku-xanh-web_k0XVgE8hFVTvpgooZHS46GTSkVjcQks45hhS3wxixecFIK0eMB251869949351.webp', 'Bàn Thông Minh Chống Gù Chống Cận MACARON', 9000000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:42');
INSERT INTO `products` VALUES (49, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/round-xanh-web_4zvh49M9JwyQXrNydFsatglSDEx4RcEk3OdFqgcHSwDNnauUVU2513131233892.webp', 'Bàn Học Trẻ Em Chống Gù Chống Cận ROUND', 8610000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:43');
INSERT INTO `products` VALUES (50, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/tk2-xanh-web_lAPJDFEV1siQKULuuRhQwdacuih7iCjsJb761BpUxUHqvmZsBD2511851583515.webp', 'Bàn Học Thông Minh Chống Gù Chống Cận TK2', 8290000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:44');
INSERT INTO `products` VALUES (51, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6696978444187_36b8b9d23976d7974ff74a0e6e5b36b8sAWmqEZhpbJeKELLeNt4KdVXndSiP4VXZKo16dOfhtbBh2udQy2567747169927.webp', 'Bàn Học Thông Minh Chống Cận BULL', 6190000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:45');
INSERT INTO `products` VALUES (52, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-3-hong-web_B5X23f3upZoWYxILNN1J5xvV9gK27vPdigLDXHPVlMt3gs7a3u2518188175221.webp', 'Bàn Thông Minh Chống Gù Chống Cận Lux Pro 3', 5910000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:46');
INSERT INTO `products` VALUES (53, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-h120-hong-web_SLh53OuegheTK8kUm1x5vzz3Vd9WxoIYEqtZvZbaqukzOZclNX2511481748035.webp', 'Bàn Thông Minh Chống Gù Chống Cận FANCY H120', 5310000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:47');
INSERT INTO `products` VALUES (54, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/macaron-hong-web_Dcejh6wvZ8HgRMYuJWhV0PWUaf4K6PkBxrvHobwb0mvguxMUi12514728333872.webp', 'Bàn Học Thông Minh Chống Gù Chống Cận Cho Trẻ MACA', 5290000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:48');
INSERT INTO `products` VALUES (55, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/luxpro-2-xanh-webJuEoAMxIem3R7vHBTVwPgd3NqKMlTz1FRAew2H63mty44KtxtN2519120282302.webp', 'Bàn Học Thông Minh Cho Trẻ A12 LuxPro 2', 5110000, '120 x 65cm', 'Gỗ tự nhiên', '2025-12-25 23:59:49');
INSERT INTO `products` VALUES (56, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fancy-jz-web_uNHdT1vVDQ8fpN9fPi5XXcCuxgq7F7aHXcfLQdXKdIfEhHJL492518797068308.webp', 'Bàn Học Thông Minh Cho Trẻ FANCY JZ', 5060000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:50');
INSERT INTO `products` VALUES (57, 1, 8, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/vancover-t3-hong-web_rm4FXdcag8Y4DrCS1KgCErJN2Zj9yLm3r0SF3Dap3FnuS79WXf2511719951654.webp', 'Bàn Học Thông Minh Chống Cận VANCOVER', 4850000, '120 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:51');
INSERT INTO `products` VALUES (58, 1, 6, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/z6774680876203_43ba0a48fea714275832b806ba92fe52loGeySl6SFm2vkwwFjGautypfNReKdEaSzJeUxxxJiS4Axg8fv2573034554393.webp', 'Bàn Học Thông Minh Chống Gù Chống Cận TOPSBAN ', 4600000, '100 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:52');
INSERT INTO `products` VALUES (59, 1, 9, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/t1-xanh-web-copy42D7Dki3YxA0oPKyfTSDuEB8olWZaynt4kyW5gsQFUAFlhoZfG251259067222.webp', 'Bàn Học Thông Minh Chống Gù Chống Cận T1', 4550000, '100 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:53');
INSERT INTO `products` VALUES (60, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/ros-hong-100h-web-copyqXOatHdpFk8jmwu8kdcEmdIXCWJ4vPljBJDAGtXOWZfYhVghaY251968704346.webp', 'Bàn Học Thông Minh FANCY ROS 100H', 4210000, '100 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:54');
INSERT INTO `products` VALUES (61, 1, 10, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/lux-gjhh105t-xanh-web_fC2FDjSsgiglG9gGGA2OqQxx5bE5gHh1mofIJtBoKJ93BETcu22514070387718.webp', 'Bàn Chống Gù Chống Cận GJHH105T và Y001', 4090000, '100 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:55');
INSERT INTO `products` VALUES (62, 1, 7, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/cos-hong-100-webeMFFQJASSDp358yalbM7uAAFiMOmjP2N5IzwigELY2NuDqJsHR2519749664313.webp', 'Bàn Học Thông Minh FANCY ROS 100', 3910000, '100 x 60cm', 'Gỗ tự nhiên', '2025-12-25 23:59:56');
INSERT INTO `products` VALUES (63, 1, 11, 'https://topkids.com.vn/img/upload/images/Temp_thumb/250x250/fan-02-hong-websSbMGQ9NCdzZOOynrPBsabtLOw0XbgHDmab5GsZNZtHkHIeBxQ255859856634.webp', 'Ghế Điều Chỉnh Chiều Cao Chống Gù FAN05', 4390000, '55 x 65cm', 'Thép', '2025-12-26 23:05:01');
INSERT INTO `products` VALUES (64, 1, 10, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g8-hong-web_CcPPgDUX6aA1twcqTExGC7879l4L0i6D0ZAbVfNzKhyAmfXDW224115777956158.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G8 Ultra Luxury', 4390000, '55 x 65cm', 'Thép', '2025-12-26 23:05:02');
INSERT INTO `products` VALUES (65, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2d-xanh-web_O3gxulLCFBfjR9FSTmlydAtavLGB13GyE63mAr4DnKsm10ZgRC2412379599210.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù CO2D', 3950000, '55 x 65cm', 'Thép', '2025-12-26 23:05:03');
INSERT INTO `products` VALUES (66, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6223369350553_9735dd3021a14419839c7cd98cffc81eKsdcok10A9F7m2o043MsKeyPHCJZiyJ2cASqmki8b12XDBStZx2518611067055.webp', 'Ghế Điều Chỉnh Chiều Cao Chống Gù G9', 3790000, '55 x 65cm', 'Thép', '2025-12-26 23:05:04');
INSERT INTO `products` VALUES (67, 1, 10, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g6-xanh-web_6I8LX2baInaCIDde2XgSXp3cWbtqFfceyH2SeNzoNxBQa7Rr1Q24118999348849.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G6', 3790000, '50 x 60cm', 'Thép', '2025-12-26 23:05:05');
INSERT INTO `products` VALUES (68, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g5-xanh-web_tzqtqBcflMQysF84F0JppcbjTD4TIGHf69EXVO2qczsbYkm2vu2411186942187.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G5', 3090000, '50 x 60cm', 'Thép', '2025-12-26 23:05:06');
INSERT INTO `products` VALUES (69, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/co2-ghi-web_GpR81MkxKhkIZrwPqeSiir30PNiRaoQf9IqSPz9JlcYvruVRA92519155084901.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù CO2', 2700000, '50 x 60cm', 'Thép', '2025-12-26 23:05:07');
INSERT INTO `products` VALUES (70, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g2-hong-web_ioFZBAkbsU5MtCbs7smrqZZThhd6hOjbf1FGwe4s2AGSzEftXR24112873846301.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G2', 2540000, '50 x 60cm', 'Thép', '2025-12-26 23:05:08');
INSERT INTO `products` VALUES (71, 1, 10, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/fan-11-hong-web_68VQfXquPQErWgRmHbEoAy2SZ2cpGlctNhR17J4GOnpx2M9aLx24119232447222.webp', 'Ghế Điều Chỉnh Chiều Cao Chống Gù FAN11', 2350000, '80 x 95cm', 'Thép', '2025-12-26 23:05:09');
INSERT INTO `products` VALUES (72, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6579922504455_ba3c9547332687fabb92d3e2bd023cd8jVqassFVyS6kHaVT85pP6MO5sAszAyOiW7RnvRr7NaxLi2ow0d2555909328598.webp', 'Ghế Điều Chỉnh Chiều Cao Chống Gù FAN02 New - 2025', 2290000, '80 x 95cm', 'Thép', '2025-12-26 23:05:10');
INSERT INTO `products` VALUES (73, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g3-hong-web_to41NV8KimhXR32Foc8S3hSQEB96MrCwPYZJietAGo1b3Iw7qZ24114303885303.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G3', 2230000, '80 x 95cm', 'Thép', '2025-12-26 23:05:11');
INSERT INTO `products` VALUES (74, 1, 11, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/z6510236438554_c110d74d5abc497038f6fa342e0782e8FPJCwOMzvDQ392YtQqAehd6c7P0PCGZELn0mfwBhuoTxrWHM942546471470618.webp', 'Ghế Điều Chỉnh Chiều Cao Chống Gù FAN01 - 2025', 2090000, '80 x 95cm', 'Thép', '2025-12-26 23:05:12');
INSERT INTO `products` VALUES (75, 1, 10, 'https://topkids.com.vn//img/upload/images/Temp_thumb/250x250/g1-hong-webe67Uu8CMtuztNs2oO3YtMfHDUfeZtsTvFFPeQbXZ5JddlUEGDD24117715462794.webp', 'Ghế Điều Chỉnh Độ Cao Chống Gù G1', 2090000, '80 x 95cm', 'Thép', '2025-12-26 23:05:13');
INSERT INTO `products` VALUES (76, 3, 12, 'https://sudospaces.com/babycuatoi/2023/11/kxht-055.png', 'Hàng rào nhựa khu vui chơi kích ', 314000, '100 x 65cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:47');
INSERT INTO `products` VALUES (77, 3, 12, 'https://sudospaces.com/babycuatoi/2023/07/js006-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-5-small.jpg', 'Thiết bị tập thể dục trẻ em- Đạp bộ tại chỗ ', 2150000, '68 x 43cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:48');
INSERT INTO `products` VALUES (78, 3, 12, 'https://sudospaces.com/babycuatoi/2023/07/js009-may-tap-the-duc-cho-tre-di-bo-tai-nha-va-truong-mam-non-small.jpg', 'Thiết bị tập thể dục cho bé - Máy tập chèo thuyền ', 2150000, '116 x 39cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:49');
INSERT INTO `products` VALUES (79, 3, 12, 'https://sudospaces.com/babycuatoi/2021/05/js003-thiet-bi-the-duc-cho-tre-em-2-small.jpg', 'Thiết bị tập thể dục trẻ em- xe đạp bộ ', 2150000, '133 x 58cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:50');
INSERT INTO `products` VALUES (80, 3, 12, 'https://sudospaces.com/babycuatoi/2023/12/zk1062-small.png', 'Hầm chui con sâu nhập khẩu ', 2535000, '125 x 60cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:51');
INSERT INTO `products` VALUES (81, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1063-ham-chui-con-kien-mau-moi-3-1-small.jpg', 'Hầm chui con kiến nhập khẩu ', 2535000, '125 x 45cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:52');
INSERT INTO `products` VALUES (82, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1035-ngua-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-small.jpg', 'Bập bênh Ngựa đơn nhập khẩu ', 419000, '68 x 42cm', 'Nhựa dầy', '2026-01-04 23:45:53');
INSERT INTO `products` VALUES (83, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/rk-701-do-choi-bap-benh-cho-be-huou-cao-co-doi-2-small.jpg', 'Bập bênh đôi hươu cao cổ 3 cấp độ ', 734000, '108 x 48cm', 'Nhựa dầy', '2026-01-04 23:45:54');
INSERT INTO `products` VALUES (84, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/rk-702-do-choi-bap-benh-doi-cho-be-co-lon-small.jpg', 'Bập bênh đôi Cỡ Lớn 2 cấp độ', 839000, '68 x 46cm', 'Nhựa dầy', '2026-01-04 23:45:55');
INSERT INTO `products` VALUES (85, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1020-bap-benh-doi-con-ga-truong-mam-non-khu-vui-choi-2.jpg', 'Bập bênh đôi con gà ', 871000, '134 x 58cm', 'Nhựa dầy', '2026-01-04 23:45:56');
INSERT INTO `products` VALUES (86, 3, 12, 'https://sudospaces.com/babycuatoi/2023/07/zk1019-bap-benh-3-cho-be-khu-vui-choi-5-small.jpg', 'Bập bênh 3 chỗ ngồi cá voi ', 871000, '88 x 57cm', 'Nhựa dầy', '2026-01-04 23:45:57');
INSERT INTO `products` VALUES (87, 3, 12, 'https://sudospaces.com/babycuatoi/2024/11/mq01-mam-quay-cho-be-choi-trong-nha-small.jpg', 'Mâm xoay vận động cho bé ', 1260000, '133 x 58cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:58');
INSERT INTO `products` VALUES (88, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1022-bap-benh-ngua-doi-cho-be-khu-vui-choi-truong-mam-non.jpg', 'Bập bênh đôi hình con ngựa ', 871000, '125 x 60cm', 'Nhựa nguyên sinh', '2026-01-04 23:45:59');
INSERT INTO `products` VALUES (89, 3, 12, 'https://sudospaces.com/babycuatoi/2020/08/zk1032-bap-benh-cho-be-6-small.jpg', 'Bập bênh Voi đơn nhập khẩu ', 419000, '68 x 42cm', 'Nhựa dầy', '2026-01-04 23:46:00');
INSERT INTO `products` VALUES (90, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1017b-bap-benh-don-doi-ket-hop-ca-voi.jpg', 'Bập bênh đơn đôi kết hợp cá voi ', 681000, '108 x 48cm', 'Nhựa dầy', '2026-01-04 23:46:01');
INSERT INTO `products` VALUES (91, 3, 12, 'https://sudospaces.com/babycuatoi/2023/08/zk1033-ca-heo-bap-benh-nhap-khau-truong-mam-non-khu-vui-choi-small.jpg', 'Bập bênh cá heo đơn nhập khẩu ', 419000, '100 x 65cm', 'Nhựa dầy', '2026-01-04 23:46:02');
INSERT INTO `products` VALUES (92, 3, 12, 'https://sudospaces.com/babycuatoi/2021/03/rk-701-do-choi-bap-benh-cho-be-3-small.jpg', 'Bập bênh đôi Cỡ Lớn hươu cao cổ 3 cấp độ ', 945000, '68 x 43cm', 'Nhựa dầy', '2026-01-04 23:46:03');
INSERT INTO `products` VALUES (93, 3, 12, 'https://sudospaces.com/babycuatoi/2022/01/rk-511b-d.png', 'Ngựa bập bênh kết hợp chòi chân quay 90 độ ', 399000, '116 x 39cm', 'Nhựa dầy', '2026-01-04 23:46:04');
INSERT INTO `products` VALUES (94, 3, 12, 'https://sudospaces.com/babycuatoi/2022/01/rk-514b-t-small.png', 'Ngựa bập bênh kết hợp chòi chân ', 629000, '133 x 58cm', 'Nhựa dầy', '2026-01-04 23:46:05');
INSERT INTO `products` VALUES (95, 3, 12, 'https://sudospaces.com/babycuatoi/2025/03/rk-526-ngua-bap-benh-ket-hop-choi-chan-cho-be-small.jpg', 'Ngựa bập bênh kết hợp chòi chân có nhạc ', 399000, '88 x 57cm', 'Nhựa nguyên sinh', '2026-01-04 23:46:06');
INSERT INTO `products` VALUES (96, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/qh300-1d-do-choi-dieu-khien-tu-xa-xe-mo-hinh-container-cong-ten-no-small.jpg', 'Đồ chơi ô tô điều khiển từ xa', 419000, '20 x 10cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:00');
INSERT INTO `products` VALUES (97, 3, 12, 'https://sudospaces.com/babycuatoi/2021/11/5501a-mo-hinh-duong-dua-khung-long-cho-be-12-small.jpg', 'Đồ chơi mô hình đường đua kỳ thú đường hầm khủng l', 441000, '80 x 8cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:01');
INSERT INTO `products` VALUES (98, 3, 12, 'https://sudospaces.com/babycuatoi/2024/11/mo-hinh-xe-container-cho-6-xe-cong-trinh-bang-hop-kim-cho-be-818-2b-small.jpg', 'Mô hình xe container chở 6 xe công trình', 200000, '30 x 12cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:02');
INSERT INTO `products` VALUES (99, 3, 12, 'https://sudospaces.com/babycuatoi/2023/02/intex-48259-nha-hoi-nha-banh-nhun-cho-be-2-small.jpg', 'Nhà banh nhún lâu đài cho bé NTEX 48259', 1880000, '100 x 80cm', 'PVC', '2024-01-01 10:00:03');
INSERT INTO `products` VALUES (100, 3, 12, 'https://sudospaces.com/babycuatoi/2023/10/rx-904c-do-choi-lap-rap-sua-chua-co-khi-cho-be-trai-small.jpg', 'Đồ chơi hộp dụng cụ sửa chữa lắp ráp', 264000, '25 x 8cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:04');
INSERT INTO `products` VALUES (101, 3, 12, 'https://sudospaces.com/babycuatoi/2024/05/6688-3-do-choi-trong-be-tam-cho-be-rua-ca-cua-ech-vit-small.jpg', 'Đồ chơi trong bể tắm rùa, ếch, cá heo, vịt, cua', 16000, '6 x 3cm', 'PVC', '2024-01-01 10:00:05');
INSERT INTO `products` VALUES (102, 3, 12, 'https://sudospaces.com/babycuatoi/2022/11/msn21019-do-choi-trang-diem-go-bbt-global-cao-cap-small.jpg', 'Đồ chơi trang điểm gỗ BBT Global cao cấp', 549000, '30 x 25cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:06');
INSERT INTO `products` VALUES (103, 3, 12, 'https://sudospaces.com/babycuatoi/2020/09/msn17074-do-choi-bep-nau-an-cho-be-small.jpg', 'Đồ chơi nhà bếp bằng gỗ BBT Global cao cấp', 1490000, '40 x 25cm', 'Gỗ cao cấp', '2024-01-01 10:00:07');
INSERT INTO `products` VALUES (104, 3, 12, 'https://sudospaces.com/babycuatoi/2024/07/20231-do-choi-gap-chuot-cho-be-small.jpg', 'Đồ chơi đập chuột cho bé', 88000, '70 x 60cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:08');
INSERT INTO `products` VALUES (105, 3, 12, 'https://sudospaces.com/babycuatoi/2024/07/158-7c-do-choi-dap-chuot-xoay-360-co-den-va-nhac-small.jpg', 'Đồ chơi đập chuột xoay 360 độ', 165000, '20 x 15cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:09');
INSERT INTO `products` VALUES (106, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/818-2d-mo-hinh-do-choi-container-cho-6-xe-mo-hinh-canh-sat-hop-kim-small.jpg', 'Mô hình xe container chở 6 xe cảnh sát', 200000, '45 x 50cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:10');
INSERT INTO `products` VALUES (107, 3, 12, 'https://sudospaces.com/babycuatoi/2024/08/839-013-do-choi-nau-an-co-lon-cho-be-1-small.jpg', 'Đồ chơi nhà bếp cỡ lớn', 749000, '60 x 45cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:11');
INSERT INTO `products` VALUES (108, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/660-89-do-choi-bac-si-xe-day-cao-cap-cho-be-co-tang-ao-va-mu-small.jpg', 'Đồ chơi bác sĩ xe đẩy cao cấp', 559000, '75 x 15cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:12');
INSERT INTO `products` VALUES (109, 3, 12, 'https://sudospaces.com/babycuatoi/2024/05/706-130-do-choi-xep-hinh-nam-cham-130-chi-tiet-5-small.jpg', 'Đồ chơi xếp hình nam châm', 349000, '80 x 10cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:13');
INSERT INTO `products` VALUES (110, 3, 12, 'https://sudospaces.com/babycuatoi/2023/03/1026-03-do-choi-vo-lang-lai-xe-o-to-cho-be-co-den-va-nhac-small.jpg', 'Đồ chơi vô lăng lái xe ô tô có đèn và nhạc xoay', 222000, '20 x 10cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:14');
INSERT INTO `products` VALUES (111, 3, 12, 'https://sudospaces.com/babycuatoi/2024/05/bang-ve-tre-em-co-lon-2-mat-tu-tinh-xoa-de-dang-khong-bam-bui-a189-small.jpg', 'Bảng vẽ trẻ em cỡ lớn 2 mặt từ tính', 524000, '30 x 25cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:15');
INSERT INTO `products` VALUES (112, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/mq-6106-do-choi-dan-organ-dien-tu-cho-be-61-phim-co-mic-va-sac-small.jpg', 'Đàn Organ điện tử 61 phím kèm mic cho bé', 249000, '45 x 50cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:16');
INSERT INTO `products` VALUES (113, 3, 12, 'https://sudospaces.com/babycuatoi/2025/03/jj927-do-choi-doan-tau-bang-go-giao-cu-montessori-small.jpg', 'Đồ chơi đoàn tàu 16 toa hình ô tô', 110000, '80 x 10cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:17');
INSERT INTO `products` VALUES (114, 3, 12, 'https://sudospaces.com/babycuatoi/2025/05/g675a-do-choi-cat-banh-sinh-nhat-co-lon-85-chi-tiet-small.jpg', 'Đồ chơi cắt bánh kem sinh nhật', 240000, '80 x 10cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:18');
INSERT INTO `products` VALUES (115, 3, 12, 'https://sudospaces.com/babycuatoi/2024/08/839-012-do-choi-bap-nau-an-co-lon-cho-be-nau-an-nhu-that-4-small.jpg', 'Đồ chơi nhà bếp nấu ăn cho bé cỡ lớn', 549000, '70 x 60cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:19');
INSERT INTO `products` VALUES (116, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1051-nhun-dien-nhap-khau-thu-rung.jpg', 'Nhún điện nhập khẩu thú rừng ', 9460000, '115 x 64 cm', 'Nhựa nguyên sinh', '2024-01-01 10:00:00');
INSERT INTO `products` VALUES (117, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1003-nhun-dien-nhap-khau-hello-kitty.jpg', 'Nhún điện nhập khẩu Hello kitty', 8410000, '125 x 74 cm', 'Nhựa nguyên sinh', '2024-01-01 10:01:00');
INSERT INTO `products` VALUES (118, 3, 12, 'https://sudospaces.com/babycuatoi/2021/03/may-gap-thu-bong-khu-vui-choi-game-6012b-3.jpg', 'Máy gắp thú bông khu vui chơi ', 15600000, '125 x 74 cm', 'Nhựa nguyên sinh', '2024-01-01 10:02:00');
INSERT INTO `products` VALUES (119, 3, 12, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1040-nhun-dien-nhap-khau-khu-vui-choi-tre-em-1.jpg', 'Nhún điện nhập khẩu máy bay ', 9460000, '115 x 75 cm', 'Nhựa nguyên sinh', '2024-01-01 10:03:00');
INSERT INTO `products` VALUES (120, 3, 12, 'https://sudospaces.com/babycuatoi/2023/02/ndnk-1046-nhun-dien-nhap-khau-khu-vui-choi-tre-em.jpg', 'Nhún điện nhập khẩu Tàu Hỏa cao cấp', 9870000, '132 x 62 cm', 'Nhựa nguyên sinh', '2024-01-01 10:04:00');
INSERT INTO `products` VALUES (121, 3, 12, 'https://sudospaces.com/babycuatoi/2023/02/game-6012-may-gap-thu-bong-khu-vui-choi-1.jpg', 'Máy gắp thú bông khu vui chơi GAME', 15600000, '132 x 62 cm', 'Nhựa nguyên sinh', '2024-01-01 10:05:00');
INSERT INTO `products` VALUES (122, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-ban-sung-dien-tu-game-6014.jpg', 'Trò chơi game bắn súng điện tử GAME', 17251500, '132 x 62 cm', 'Nhựa nguyên sinh', '2024-01-01 10:06:00');
INSERT INTO `products` VALUES (123, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1009-nhun-dien-nhap-khau-lon-peppa-dang-yeu-2.jpg', 'Nhún điện nhập khẩu lợn PEPPA đáng yêu', 7890000, '98 x 60 cm', 'Nhựa nguyên sinh', '2024-01-01 10:07:00');
INSERT INTO `products` VALUES (124, 3, 12, 'https://sudospaces.com/babycuatoi/2020/02/ndnk-1008-nhu-dien-nhap-khau-bbt-global-1.jpg', 'Nhún điện nhập khẩu đội bay siêu đẳng', 8410000, '100 x 60 cm', 'Nhựa nguyên sinh', '2024-01-01 10:08:00');
INSERT INTO `products` VALUES (125, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1092-nhun-dien-nhap-khau-hai-ba-con-pepa.jpg', 'Nhún điện nhập khẩu hai ba con pepa', 9460000, '100 x 60 cm', 'Nhựa nguyên sinh', '2024-01-01 10:09:00');
INSERT INTO `products` VALUES (126, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1090-nhun-dien-nhap-khau-meo-hong-xinh-xan-1.jpg', 'Nhún điện nhập khẩu mèo hồng xinh xắn', 8940000, '100 x 60 cm', 'Nhựa nguyên sinh', '2024-01-01 10:10:00');
INSERT INTO `products` VALUES (127, 3, 12, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1066-nhun-dien-nhap-khau-may-bay.jpg', 'Nhún điện nhập khẩu máy bay', 9990000, '100 x 60 cm', 'Nhựa ABS cao cấp', '2024-01-01 10:11:00');
INSERT INTO `products` VALUES (128, 3, 12, 'https://sudospaces.com/babycuatoi/2023/12/may-tro-choi-dien-tu-game-lai-xe-trong-khu-vui-choi-game-6020.jpg', 'Máy chơi đua xe ô tô điện tử khu vui chơi ', 17955000, '50 x 46 cm', 'Nhựa ABS cao cấp', '2024-01-01 10:12:00');
INSERT INTO `products` VALUES (129, 3, 12, 'https://sudospaces.com/babycuatoi/2020/07/ndnk-1010-nhun-dien-nhap-khau-ngua-than.jpg', 'Nhún điện nhập khẩu ngựa thần ', 8940000, '50 x 46 cm', 'Nhựa nguyên sinh', '2024-01-01 10:13:00');
INSERT INTO `products` VALUES (130, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1014-nhun-dien-nhap-khau-vit-phat-sang.jpg', 'Nhún điện nhập khẩu vịt phát sáng', 8410000, '107 x 57 cm', 'Nhựa nguyên sinh', '2024-01-01 10:14:00');
INSERT INTO `products` VALUES (131, 3, 12, 'https://sudospaces.com/babycuatoi/2024/01/game-6022a-may-game-choi-ban-sung-dien-tu-doi-khu-vui-choi.jpg', 'Máy game chơi bắn súng điện tử đôi khu vui chơi GA', 18301500, '55 x 55 cm', 'Nhựa ABS cao cấp', '2024-01-01 10:15:00');
INSERT INTO `products` VALUES (132, 3, 12, 'https://sudospaces.com/babycuatoi/2021/04/game-6025-may-game-khu-vui-choi-bbt-global.jpg', 'Máy game bắt bò 70 trò chơi dành cho khu vui chơi ', 12747000, '50 x 46 cm', 'Nhựa ABS cao cấp', '2024-01-01 10:16:00');
INSERT INTO `products` VALUES (133, 3, 12, 'https://sudospaces.com/babycuatoi/2025/10/nhun-dien-nhap-khau-hinh-doremon-ndnk-1041.jpg', 'Nhún điện nhập khẩu hình Doremon', 8410000, '50 x 46 cm', 'Nhựa nguyên sinh', '2024-01-01 10:17:00');
INSERT INTO `products` VALUES (134, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/tro-choi-game-may-dap-chuot-game-3012-1-3.jpg', 'Trò chơi game máy đập chuột GAME', 9387000, '46 x 61 cm', 'Nhựa ABS cao cấp', '2024-01-01 10:18:00');
INSERT INTO `products` VALUES (135, 3, 12, 'https://sudospaces.com/babycuatoi/2020/06/ndnk-1007-nhun-dien-nhap-khau-o-to.jpg', 'Nhún điện nhập khẩu ô tô', 8410000, '115 x 65 cm', 'Nhựa nguyên sinh', '2024-01-01 10:19:00');

-- ----------------------------
-- Table structure for profiles
-- ----------------------------
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`  (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gender` enum('Male','Female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`profile_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of profiles
-- ----------------------------
INSERT INTO `profiles` VALUES (1, 'lamdoanh', 'lamdoanh2468@gmail.com', '0764620472', '110/79/3 đường Trịnh Hoài Đức, phường Đông Hoà, TPHCM', 'Male', NULL, '2025-03-22', '2025-12-19 23:17:02');
INSERT INTO `profiles` VALUES (2, NULL, '22130041@st.hcmuaf.edu.vn', NULL, NULL, NULL, NULL, NULL, '2026-01-06 13:50:20');
INSERT INTO `profiles` VALUES (3, NULL, 'lamdoanh2468@gmail.com', NULL, NULL, NULL, NULL, NULL, '2026-01-07 11:12:14');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `product_id` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`review_id`) USING BTREE,
  INDEX `fk_reviews_accounts`(`account_id` ASC) USING BTREE,
  INDEX `fk_reviews_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_reviews_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reviews_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviews
-- ----------------------------

-- ----------------------------
-- Table structure for stock_products
-- ----------------------------
DROP TABLE IF EXISTS `stock_products`;
CREATE TABLE `stock_products`  (
  `stock_product_id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int NOT NULL,
  `product_id` int NOT NULL,
  `total_quantity` int NULL DEFAULT NULL,
  `sold_quantity` int NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_product_id`) USING BTREE,
  INDEX `fk_stockproducts_stocks`(`stock_id` ASC) USING BTREE,
  INDEX `fk_stockproducts_products`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_stockproducts_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stockproducts_stocks` FOREIGN KEY (`stock_id`) REFERENCES `stocks` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 238 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_products
-- ----------------------------
INSERT INTO `stock_products` VALUES (7, 1, 7, 0, 10, '2025-12-31 22:47:35');
INSERT INTO `stock_products` VALUES (8, 1, 8, 36, 8, '2026-01-06 11:18:44');
INSERT INTO `stock_products` VALUES (9, 1, 9, 56, 10, '2026-01-01 11:55:14');
INSERT INTO `stock_products` VALUES (10, 1, 10, 30, 5, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (11, 1, 11, 100, 25, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (12, 1, 12, 110, 30, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (13, 1, 13, 55, 5, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (14, 1, 14, 40, 1, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (15, 1, 15, 63, 14, '2026-01-01 14:21:26');
INSERT INTO `stock_products` VALUES (16, 1, 16, 75, 18, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (17, 1, 17, 85, 22, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (18, 1, 18, 95, 10, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (19, 1, 19, 35, 4, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (20, 1, 20, 50, 9, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (21, 1, 21, 60, 11, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (22, 1, 22, 150, 40, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (23, 1, 23, 140, 35, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (24, 1, 24, 130, 28, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (25, 1, 25, 200, 50, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (26, 1, 26, 180, 45, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (27, 1, 27, 90, 10, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (28, 1, 28, 75, 13, '2026-01-02 22:24:41');
INSERT INTO `stock_products` VALUES (29, 1, 29, 70, 15, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (30, 1, 30, 100, 20, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (31, 1, 31, 110, 12, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (32, 1, 32, 120, 30, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (33, 1, 33, 130, 40, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (34, 1, 34, 140, 25, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (35, 1, 35, 150, 10, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (36, 1, 36, 60, 5, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (37, 1, 37, 70, 8, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (38, 1, 38, 80, 12, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (39, 1, 39, 90, 15, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (40, 1, 40, 100, 18, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (41, 1, 41, 110, 22, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (42, 1, 42, 50, 2, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (43, 1, 43, 60, 6, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (44, 1, 44, 70, 9, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (50, 2, 25, 100, 20, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (51, 2, 26, 90, 15, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (52, 2, 27, 45, 5, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (53, 2, 28, 40, 4, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (54, 2, 29, 35, 8, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (55, 2, 30, 55, 12, '2025-12-15 21:02:05');
INSERT INTO `stock_products` VALUES (56, 1, 45, 50, 5, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (57, 2, 45, 30, 2, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (58, 1, 46, 60, 8, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (59, 2, 46, 40, 4, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (60, 1, 47, 55, 6, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (61, 2, 47, 35, 3, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (62, 1, 48, 45, 4, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (63, 2, 48, 25, 1, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (64, 1, 49, 70, 10, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (65, 2, 49, 50, 5, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (66, 1, 50, 80, 12, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (67, 2, 50, 60, 8, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (68, 1, 51, 65, 7, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (69, 2, 51, 45, 4, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (70, 1, 52, 90, 15, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (71, 2, 52, 70, 10, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (72, 1, 53, 40, 3, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (73, 2, 53, 20, 1, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (74, 1, 54, 50, 5, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (75, 2, 54, 30, 2, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (76, 1, 55, 60, 8, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (77, 2, 55, 40, 4, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (78, 1, 56, 75, 9, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (79, 2, 56, 55, 6, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (80, 1, 57, 45, 4, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (81, 2, 57, 25, 2, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (82, 1, 58, 55, 6, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (83, 2, 58, 35, 3, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (84, 1, 59, 85, 11, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (85, 2, 59, 65, 7, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (86, 1, 60, 50, 5, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (87, 2, 60, 30, 2, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (88, 1, 61, 40, 2, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (89, 2, 61, 20, 0, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (90, 1, 62, 60, 8, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (91, 2, 62, 40, 3, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (92, 1, 63, 50, 10, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (93, 2, 63, 30, 10, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (94, 1, 64, 50, 10, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (95, 2, 64, 30, 15, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (96, 1, 65, 50, 15, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (97, 2, 65, 30, 15, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (98, 1, 66, 50, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (99, 2, 66, 30, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (100, 1, 67, 50, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (101, 2, 67, 30, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (102, 1, 68, 50, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (103, 2, 68, 30, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (104, 1, 69, 50, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (105, 2, 69, 30, 20, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (106, 1, 70, 50, 9, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (107, 2, 70, 30, 9, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (108, 1, 71, 50, 9, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (109, 2, 71, 30, 9, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (110, 1, 72, 50, 12, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (111, 2, 72, 30, 12, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (112, 1, 73, 50, 12, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (113, 2, 73, 30, 12, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (114, 1, 74, 50, 25, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (115, 2, 74, 30, 25, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (116, 1, 75, 50, 25, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (117, 2, 75, 30, 25, '2025-12-26 10:56:59');
INSERT INTO `stock_products` VALUES (118, 1, 76, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (119, 1, 77, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (120, 1, 78, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (121, 1, 79, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (122, 1, 80, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (123, 1, 81, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (124, 1, 82, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (125, 1, 83, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (126, 1, 84, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (127, 1, 85, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (128, 1, 86, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (129, 1, 87, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (130, 1, 88, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (131, 1, 89, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (132, 1, 90, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (133, 1, 91, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (134, 1, 92, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (135, 1, 93, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (136, 1, 94, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (137, 1, 95, 100, 20, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (138, 2, 76, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (139, 2, 77, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (140, 2, 78, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (141, 2, 79, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (142, 2, 80, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (143, 2, 81, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (144, 2, 82, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (145, 2, 83, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (146, 2, 84, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (147, 2, 85, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (148, 2, 86, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (149, 2, 87, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (150, 2, 88, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (151, 2, 89, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (152, 2, 90, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (153, 2, 91, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (154, 2, 92, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (155, 2, 93, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (156, 2, 94, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (157, 2, 95, 60, 10, '2026-01-05 00:16:58');
INSERT INTO `stock_products` VALUES (158, 1, 96, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (159, 2, 96, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (160, 1, 97, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (161, 2, 97, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (162, 1, 98, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (163, 2, 98, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (164, 1, 99, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (165, 2, 99, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (166, 1, 100, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (167, 2, 100, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (168, 1, 101, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (169, 2, 101, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (170, 1, 102, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (171, 2, 102, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (172, 1, 103, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (173, 2, 103, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (174, 1, 104, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (175, 2, 104, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (176, 1, 105, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (177, 2, 105, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (178, 1, 106, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (179, 2, 106, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (180, 1, 107, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (181, 2, 107, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (182, 1, 108, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (183, 2, 108, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (184, 1, 109, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (185, 2, 109, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (186, 1, 110, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (187, 2, 110, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (188, 1, 111, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (189, 2, 111, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (190, 1, 112, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (191, 2, 112, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (192, 1, 113, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (193, 2, 113, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (194, 1, 114, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (195, 2, 114, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (196, 1, 115, 100, 20, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (197, 2, 115, 50, 5, '2026-01-05 14:06:03');
INSERT INTO `stock_products` VALUES (198, 1, 116, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (199, 2, 116, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (200, 1, 117, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (201, 2, 117, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (202, 1, 118, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (203, 2, 118, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (204, 1, 119, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (205, 2, 119, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (206, 1, 120, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (207, 2, 120, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (208, 1, 121, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (209, 2, 121, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (210, 1, 122, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (211, 2, 122, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (212, 1, 123, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (213, 2, 123, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (214, 1, 124, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (215, 2, 124, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (216, 1, 125, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (217, 2, 125, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (218, 1, 126, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (219, 2, 126, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (220, 1, 127, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (221, 2, 127, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (222, 1, 128, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (223, 2, 128, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (224, 1, 129, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (225, 2, 129, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (226, 1, 130, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (227, 2, 130, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (228, 1, 131, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (229, 2, 131, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (230, 1, 132, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (231, 2, 132, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (232, 1, 133, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (233, 2, 133, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (234, 1, 134, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (235, 2, 134, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (236, 1, 135, 50, 0, '2026-01-05 22:05:52');
INSERT INTO `stock_products` VALUES (237, 2, 135, 50, 0, '2026-01-05 22:05:52');

-- ----------------------------
-- Table structure for stocks
-- ----------------------------
DROP TABLE IF EXISTS `stocks`;
CREATE TABLE `stocks`  (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `stock_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `stock_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`stock_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stocks
-- ----------------------------
INSERT INTO `stocks` VALUES (1, 'Kho Tổng Hà Nội', '123 Đường Cầu Giấy, Q. Cầu Giấy, Hà Nội');
INSERT INTO `stocks` VALUES (2, 'Kho Chi Nhánh TP.HCM', '456 Đường Lê Lợi, Q.1, TP.HCM');

-- ----------------------------
-- Table structure for vouchers
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
  `voucher_id` int NOT NULL AUTO_INCREMENT,
  `voucher_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `voucher_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `voucher_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `discount_amount` int NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`voucher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vouchers
-- ----------------------------
INSERT INTO `vouchers` VALUES (1, 'NEW10', 'Giảm 100K', 'https://res.cloudinary.com/dijswwhab/image/upload/v1767499588/100k_dis_dvuul8.png', 'Giảm 100.000đ cho mọi đơn hàng', 100000, '2025-01-01', '2026-12-31');
INSERT INTO `vouchers` VALUES (2, 'SAVE20', 'Giảm 200K', 'https://res.cloudinary.com/dijswwhab/image/upload/v1767499604/200k_dis_kk2a4q.png', 'Giảm 200.000đ cho mọi đơn hàng', 200000, '2025-01-01', '2026-12-31');
INSERT INTO `vouchers` VALUES (3, 'DEAL30', 'Giảm 300K', 'https://res.cloudinary.com/dijswwhab/image/upload/v1767499614/300k_dis_rhrtvt.png', 'Giảm 300.000đ toàn đơn', 300000, '2025-01-01', '2026-12-31');
INSERT INTO `vouchers` VALUES (4, 'VIP50', 'Giảm 500K', 'https://res.cloudinary.com/dijswwhab/image/upload/v1767499618/500k_dis_ziiph9.png', 'Voucher ưu đãi lớn', 500000, '2025-01-01', '2026-12-31');
INSERT INTO `vouchers` VALUES (5, 'FREESHIP15', 'Free ship', 'https://res.cloudinary.com/dijswwhab/image/upload/v1767499617/free_dis_eruegp.png', 'Giảm 15.000đ phí vận chuyển', 15000, '2025-01-01', '2026-12-31');

SET FOREIGN_KEY_CHECKS = 1;
