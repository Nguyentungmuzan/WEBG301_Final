-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 20, 2022 lúc 03:22 AM
-- Phiên bản máy phục vụ: 10.4.24-MariaDB
-- Phiên bản PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shoppingcart`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(1, 'IPHONE', 'This category contain all IPHONE.'),
(2, 'SAMSUNG', 'This category contain all SAMSUNG Phone.'),
(3, 'XIAOMI', 'XIAOMI Phone');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221213051336', '2022-12-13 06:13:45', 52),
('DoctrineMigrations\\Version20221213051424', '2022-12-13 06:14:32', 48),
('DoctrineMigrations\\Version20221213051556', '2022-12-13 06:16:05', 154),
('DoctrineMigrations\\Version20221217060510', '2022-12-17 07:12:37', 983),
('DoctrineMigrations\\Version20221217094804', '2022-12-17 10:48:10', 41),
('DoctrineMigrations\\Version20221217094858', '2022-12-17 10:49:07', 50),
('DoctrineMigrations\\Version20221217095006', '2022-12-17 10:50:12', 30),
('DoctrineMigrations\\Version20221217095115', '2022-12-17 10:51:20', 63),
('DoctrineMigrations\\Version20221217095213', '2022-12-17 10:52:19', 51),
('DoctrineMigrations\\Version20221219162820', '2022-12-19 17:28:26', 212),
('DoctrineMigrations\\Version20221219165742', '2022-12-19 17:57:50', 33);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `total` double NOT NULL,
  `purchase_date` date NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `orders_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `imgurl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `imgurl`, `description`, `category_id`) VALUES
(34, 'IPhone 12 Mini - 256GB', 798, '34.png', 'Display technology:: OLED Resolution:: Full HD+ (1080 x 2340 Pixels) Widescreen:: 5.4\" Resolution: 2 cameras 12 MP, 12 MP Operating System: iOS 14 Processor chip (CPU): Apple A14 Bionic 6 cores Internal Memory (ROM): 256 GB RAM: 4 GB Mobile network: Suppo', 1),
(35, 'Iphone 12 64GB', 652, '35.png', 'Dimensions 146.7 x 71.5 x 7.4 mm Weight 164 g 64 GB internal memory 128 GB 256 GB SIM Type Dual SIM (nano‑SIM and eSIM) Display type Super Retina XDR OLED, HDR10, Dolby Vision, Wide color gamut, True-tone Screen size 6.1 inches Screen resolution 1170 x 25', 1),
(36, 'IPhone 12 Promax - 128GB', 1036, '36.png', 'Display technology:: OLED Resolution:: 1284 x 2778 Pixels Widescreen:: 6.1\" Resolution: 3 cameras 12 MP, 12 MP Operating System: iOS 14 Processor chip (CPU): Apple A14 Bionic 6 cores Internal memory (ROM): 128 GB RAM: 6 GB Mobile network: Support 5G Numbe', 1),
(37, 'IPhone 13 Mini - 512GB', 1072, '37.png', 'Display technology:: OLED Resolution:: Full HD+ (1080 x 2340 Pixels) Resolution: 2 cameras 12 MP, 12 MP Operating System: iOS 15 Processor chip (CPU): Apple A15 Bionic 6 cores Internal Memory (ROM): 512 GB RAM: 4 GB Mobile network: Support 5G Number of si', 1),
(38, 'IPhone 13 - 256GB', 860, '38.png', 'Display technology:: OLED Resolution:: 1170 x 2532 Pixels Resolution: 2 cameras 12 MP, 12 MP Operating System: iOS 15 Processor chip (CPU): Apple A15 Bionic 6 cores Internal Memory (ROM): 256 GB RAM: 4 GB Mobile network: Support 5G Number of sim slots: 1', 1),
(39, 'IPhone 13 Pro - 512GB', 1300, '39.png', 'Display technology:: OLED Resolution:: 1170 x 2532 Pixels Resolution: 3 cameras 12 MP, 12 MP Operating System: iOS 15 Processor chip (CPU): Apple A15 Bionic 6 cores Internal Memory (ROM): 512 GB RAM: 6 GB Mobile network: Support 5G Number of sim slots: 1', 1),
(40, 'IPhone 13 Pro Max -  256GB', 1160, '40.png', 'Display technology:: OLED Resolution:: 1284 x 2778 Pixels Resolution: 3 cameras 12 MP, 12 MP Operating System: iOS 15 Processor chip (CPU): Apple A15 Bionic 6 cores Internal Memory (ROM): 256 GB RAM: 6 GB Mobile network: Support 5G Number of sim slots: 1', 1),
(41, 'IPhone 14 - 128GB', 820, '41.png', 'Display Technology:: Super Retina XDR Resolution:: 2532 x 1170 Widescreen:: 6.1‑inch OLED OLED Resolution: 12MP x 12MP, 12MP Operating System: iOS 16 Processor (CPU): A15 Bionic Internal Memory (ROM): 128GB RAM: 6 GB Cellular: 5G (sub ‑ 6 GHz and mmWave)', 1),
(42, 'IPhone 14 Plus - 256GB', 1060, '42.png', 'Display technology:: OLED, Super Retina XDR, Resolution:: 2778 x 1284 Pixels Wide screen:: 6.7‑inch Resolution: 12MP x 12MP, 12MP Operating System: iOS 16 Processor chip (CPU): A15 Bionic 6 cores Internal Memory (ROM): 256GB RAM: 6 GB Mobile network: 5G (', 1),
(43, 'IPhone 14 Pro - 512GB', 1439, '43.png', 'Display technology:: OLED Resolution:: Super Retina XDR (2556 x 1179 Pixels) Widescreen:: 6.1\" Resolution: Primary 48 MP & Secondary 12 MP, 12 MP, 12 MP Operating System: iOS 16 Processor chip (CPU): Apple A16 Bionic 6 cores Internal Memory (ROM): 512GB R', 1),
(44, 'iPhone 14 Pro Max - 1TB', 1824, '44.png', 'Display technology:: OLED Resolution:: 2796 x 1290 Pixels Resolution: Primary 48 MP & Secondary 12 MP, 12 MP, 12 MP Operating System: iOS 16 Processor chip (CPU): Apple A16 Bionic 6 cores Internal Memory (ROM): 1TB RAM: 6 GB Mobile network: Support 5G Num', 1),
(45, 'Samsung Galaxy Z Fold4 - 512GB', 1442, '45.png', 'Display technology:: Dynamic AMOLED 2X Resolution:: Primary: QXGA+ (2176 x 1812 Pixels) & Secondary: HD+ (2316 x 904 Pixels) Widescreen:: Main 7.6\" & Sub 6.2\" - 120 Hz quét refresh rate Resolution: Main 50 MP & Secondary 12 MP, 10 MP, 10 MP & 4 MP Operati', 2),
(46, 'Samsung Galaxy Z Flip4 - 256GB', 823, '46.png', 'Display technology:: Primary: Dynamic AMOLED 2X, Secondary: Super AMOLED Resolution:: Primary: FHD+ (2640 x 1080 Pixels) x Secondary: (260 x 512 Pixels) Wide screen:: Main 6.7\" & Sub 1.9\" - 120 Hz quét refresh rate Resolution: 2 cameras 12 MP, 10 MP Opera', 2),
(47, 'Samsung Galaxy S22 - 8GB/256GB', 632, '47.png', 'Display technology:: Dynamic AMOLED 2X, 10 - 120 Hz, Infinity O Resolution:: 2340 x 1080 Widescreen:: 6.1\" Resolution: 12MP (UW) + 50MP (W) + 10MP (Tele), 10MP Operating system: Android 12 Processor (CPU): Snapdragon® 8 Gen 1 (4nm) Internal Memory (ROM):', 2),
(48, 'Samsung Galaxy S21 FE (5G) - 8GB/256GB', 476, '48.png', 'Display technology:: Dynamic AMOLED 2X Resolution:: Full HD+ (1080 x 2340 Pixels) Wide screen:: 6.4\" - 120 Hz . refresh rate Resolution: Primary 12 MP & Secondary 12 MP, 8 MP, 32 MP Processor chip (CPU): Exynos 2100 8 cores RAM: 8 GB Battery capacity: 450', 2),
(49, 'Samsung Galaxy S20 FE 256GB', 344, '49.png', 'Display technology:: Super AMOLED Resolution:: Full HD+ (1080 x 2400 Pixels) Resolution: Primary 12 MP & Secondary 12 MP, 8 MP, 32 MP Operating system: Android 11 Processor (CPU): Snapdragon 865 8-core Internal Memory (ROM): 256 GB RAM: 8 GB Mobile networ', 2),
(50, 'Samsung Galaxy A73 5G', 377, '50.png', 'Display technology:: Super AMOLED Plus Resolution:: Full HD+ (1080 x 2400 Pixels) Wide screen:: 6.7\" - 120 Hz . refresh rate Resolution: Main 108 MP & Secondary 12 MP, 5 MP, 5 MP, 32 MP Processor (CPU): Snapdragon 778G 5G 8-core Internal Memory (ROM): 128', 2),
(51, 'Samsung Galaxy S22 Plus - 8GB/256GB', 754, '51.png', 'Display technology:: Dynamic AMOLED 2X, 10 - 120 Hz, Infinity O Resolution:: 2340 x 1080 Widescreen:: 6.6\" Resolution: 12MP (UW) + 50MP (W) + 10MP (Tele), 10MP Operating system: Android 12 Processor (CPU): Snapdragon® 8 Gen 1 (4nm) Internal Memory (ROM):', 2),
(52, 'Samsung Galaxy S22 Ultra - 12GB/256GB', 999, '52.png', 'Display technology:: Dynamic AMOLED 2X Resolution:: 3088 x 1440 Wide screen:: 6.8\", Scan frequency: 1 - 120 Hz Resolution: 12MP (UW) + 108MP (W) + 12MP (Tele3x) + 12MP (Tele10x), 40MP Operating system: Android 12 Processor (CPU): Snapdragon® 8 Gen 1 (4nm)', 2),
(53, 'Samsung Galaxy S22 Ultra - 12GB/512GB', 1092, '53.png', 'Display technology:: Dynamic AMOLED 2X Resolution:: 3088 x 1440 Wide screen:: 6.8\", Scan frequency: 1 - 120 Hz Resolution: 12MP (UW) + 108MP (W) + 12MP (Tele3x) + 12MP (Tele10x), 40MP Operating system: Android 12 Processor (CPU): Snapdragon® 8 Gen 1 (4nm)', 2),
(54, 'Samsung Galaxy Tab S8 Ultra', 1030, '54.png', 'Display technology:: Dynamic AMOLED 2X Resolution:: 3088 x 1440 Wide screen:: 6.8\", Scan frequency: 1 - 120 Hz Resolution: 12MP (UW) + 108MP (W) + 12MP (Tele3x) + 12MP (Tele10x), 40MP Operating system: Android 12 Processor (CPU): Snapdragon® 8 Gen 1 (4nm)', 2),
(55, 'Xiaomi 12 Lite 5G', 339, '55.png', 'Screen technology:: AMOLED 120Hz, Dolby Vision, HDR10+ Resolution:: 2400 x 1080 FHD+ Wide screen:: 6.55” Resolution: 108MP x 8MP x 2MP, 32MP Operating system: MIUI 13 and Android 12 Processor (CPU): Snapdragon 778G Internal Memory (ROM): 128GB RAM: 8GB Nu', 3),
(56, 'Redmi Note 11 - 4GB/128GB', 168, '56.png', 'Display technology:: AMOLED 90Hz Resolution:: 1080 x 2400 pixels (FullHD+) Wide screen:: 6.43 inches Resolution: Wide-angle camera: 50 MP, f/1.8, PDAF, Super wide-angle camera: 8 MP, Macro camera: 2MP f/2.4, Portrait camera: 2MP, 13 MP, f/2.5 Operating sy', 3),
(57, 'Redmi Note 11S 8GB/128GB', 219, '57.png', 'Display technology:: AMOLED Resolution:: Full HD+ (1080 x 2400 Pixels) Wide screen:: 6.43\" - 90 Hz . refresh rate Resolution: Main 108 MP & Secondary 8 MP, 2 MP, 2 MP, 16 MP Operating system: Android 11 Processor chip (CPU): MediaTek Helio G96 8-core Inte', 3),
(58, 'Redmi Note 11 Pro', 230, '58.png', 'Display technology:: AMOLED Resolution:: Full HD+ (1080 x 2400 Pixels) Wide screen:: 6.67\" - 120 Hz . refresh rate Resolution: Main 108 MP & Secondary 8 MP, 2 MP, 2 MP, 16 MP Operating system: Android 11 Processor chip (CPU): MediaTek Helio G96 8-core Int', 3),
(59, 'Redmi Note 11 Pro 5G', 300, '59.png', 'Display technology:: AMOLED Resolution:: Full HD+ (1080 x 2400 Pixels) Resolution: Main 108 MP & Secondary 8 MP, 2 MP, 16 MP Operating system: Android 11 Processor (CPU): Snapdragon 695 5G 8-core Internal memory (ROM): 128 GB RAM: 8 GB Mobile network: Sup', 3),
(60, 'Xiaomi Redmi Note 10S', 177, '60.png', 'Display technology:: AMOLED Resolution:: Full HD+ (1080 x 2400 Pixels) Resolution: Primary 64 MP & Secondary 8 MP, 2 MP, 2 MP, 13 MP Operating system: Android 11 Processor chip (CPU): MediaTek Helio G95 8-core Internal memory (ROM): 128 GB RAM: 8 GB Mobil', 3),
(61, 'Xiaomi Redmi 10 - 4GB/128GB', 142, '61.png', 'Display technology:: IPS LCD Resolution:: Full HD+ (1080 x 2400 Pixels) Resolution: Main 50 MP & Secondary 8 MP, 2 MP, 2 MP, 8 MP Operating system: Android 11 Processor chip (CPU): MediaTek Helio G88 8-core Internal memory (ROM): 128 GB RAM: 4 GB Mobile n', 3),
(62, 'Xiaomi 11 Lite 5G NE - 8GB/128GB', 269, '62.png', 'Công nghệ màn hình:: AMOLED Độ phân giải:: Full HD+ (1080 x 2400 Pixels) Độ phân giải: Chính 64 MP & Phụ 8 MP, 5 MP, 20 MP Hệ điều hành: Android 11 Chip xử lý (CPU): Snapdragon 778G 5G 8 nhân Bộ nhớ trong (ROM): 128 GB RAM: 8 GB Mạng di động: Hỗ trợ 5G Số', 3),
(63, 'Xiaomi 12', 577, '63.png', 'Screen technology:: AMOLED, 1 billion colors, HDR10+, 120Hz, 20:9 aspect ratio, 6.28 inches, Full HD+ (1080 x 2400 pixels), Corning Gorilla Glass Victus, In-display fingerprint sensor, Electric touch multipoint capacity Resolution:: 1080 x 2400 pixels Wid', 3),
(64, 'Xiaomi 12 Pro', 846, '64.png', 'Display technology:: LTPO AMOLED, 120Hz, HDR10+ Resolution:: QuadHD+ (1440 x 3200 pixels), 20:9 aspect ratio Wide screen:: 6.73 inches Resolution: 50 MP, f/1.9 (wide angle), Dual Pixel PDAF, OIS, 50 MP, f/1.9 (telephoto), PDAF, 2x zoom, 50 MP, f/2.2, 115˚', 3),
(65, 'Xiaomi 12T', 423, '65.png', 'Display technology:: AMOLED DotDisplay Resolution:: 2712 x 1220 Widescreen:: 6.67\" Resolution: 108MP x 8MP x 2MP, 20MP OS: MIUI 13, Android 12 Processor chip (CPU): Dimensity 8100-Ultra Internal Memory (ROM): 128GB RAM: 8GB Number of sim slots: 2 nano SIM', 3),
(66, 'Xiaomi 12T Pro', 592, '66.png', 'Screen technology:: CrystalRes AMOLED Resolution:: Full HD+ Wide screen:: 6.67 inches Resolution: 200 MP x 8 MP x 2 MP., 20 MP Processor (CPU): Snapdragon 8+ Gen 1 Internal Memory (ROM): 256GB RAM: 12GB Battery capacity: 5,000 mAh', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_detail_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `user_detail_id`) VALUES
(1, 'van@gmail.com', '[]', '$2y$13$CXQs6uppH/D.7W18N8GBAOmrNDcJOR/oCr8BPS6ZwcQaLJQL5MAW2', 1),
(2, 'v@gmail.com', '[]', '$2y$13$vOx1ASxxq5MVmQT/8mPA0OGfSI/WbtMbi6LBLFG3Y/.3KoTUk5vNW', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_detail`
--

CREATE TABLE `user_detail` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_detail`
--

INSERT INTO `user_detail` (`id`, `name`, `phone`, `address`) VALUES
(1, 'vanxinh', 987678999, 'KHam Thien'),
(2, 'fff', 99888, 'KHamd');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Chỉ mục cho bảng `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_ED896F464584665A` (`product_id`),
  ADD KEY `IDX_ED896F46CFFE9AD6` (`orders_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`),
  ADD UNIQUE KEY `UNIQ_8D93D649D8308E5F` (`user_detail_id`);

--
-- Chỉ mục cho bảng `user_detail`
--
ALTER TABLE `user_detail`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `user_detail`
--
ALTER TABLE `user_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `FK_ED896F464584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_ED896F46CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Các ràng buộc cho bảng `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_8D93D649D8308E5F` FOREIGN KEY (`user_detail_id`) REFERENCES `user_detail` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
