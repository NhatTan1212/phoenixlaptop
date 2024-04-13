USE [master]
GO
/****** Object:  Database [QUANLYBANLAPTOP]    Script Date: 12/04/2024 20:09:59 ******/
CREATE DATABASE [QUANLYBANLAPTOP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUANLYBANLAPTOP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NHATTAN\MSSQL\DATA\QUANLYBANLAPTOP.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QUANLYBANLAPTOP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NHATTAN\MSSQL\DATA\QUANLYBANLAPTOP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUANLYBANLAPTOP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET RECOVERY FULL 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET  MULTI_USER 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QUANLYBANLAPTOP', N'ON'
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET QUERY_STORE = ON
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QUANLYBANLAPTOP]
GO
/****** Object:  Table [dbo].[BRANDS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRANDS](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[image] [nvarchar](255) NULL,
	[slug] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CARTS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTS](
	[user_id] [int] NULL,
	[product_id] [int] NULL,
	[prod_name] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[avatar] [nvarchar](255) NULL,
	[price] [float] NULL,
	[is_possible_to_order] [int] NULL,
	[count] [int] NULL,
	[product_total] [float] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[guest_id] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIES]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIES](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[slug] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DELIVERY_ADDRESS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DELIVERY_ADDRESS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[detail_address] [nvarchar](100) NOT NULL,
	[province] [nvarchar](50) NOT NULL,
	[district] [nvarchar](50) NOT NULL,
	[ward] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IMAGES]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMAGES](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[image_url] [nvarchar](255) NULL,
	[url] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_DETAILS](
	[product_id] [int] NULL,
	[order_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paymentMethods] [varchar](255) NULL,
	[total] [float] NULL,
	[user_id] [int] NULL,
	[name] [nvarchar](100) NOT NULL,
	[email] [varchar](100) NULL,
	[user_address] [nvarchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[trading_code] [varchar](255) NULL,
	[is_payment] [int] NULL,
	[is_transported] [int] NULL,
	[is_success] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_rated] [int] NULL,
	[note] [nvarchar](255) NULL,
	[guest_id] [varchar](50) NULL,
	[avatar] [nvarchar](255) NULL,
	[is_approved] [int] NULL,
	[is_being_shipped] [int] NULL,
	[approved_at] [datetime] NULL,
	[being_shipped_at] [datetime] NULL,
	[transported_at] [datetime] NULL,
	[successful_at] [datetime] NULL,
	[paid_at] [datetime] NULL,
	[vnp_TransactionNo] [varchar](50) NULL,
	[vnp_OrderInfo] [varchar](50) NULL,
	[vnp_CardType] [varchar](50) NULL,
	[vnp_BankCode] [varchar](50) NULL,
	[vnp_PayDate] [varchar](50) NULL,
	[prod_name] [nvarchar](255) NULL,
	[quantity] [int] NULL,
	[total_product] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand_id] [int] NULL,
	[category_id] [int] NULL,
	[prod_name] [nvarchar](255) NOT NULL,
	[avatar] [nvarchar](255) NULL,
	[prod_description] [nvarchar](max) NULL,
	[manufacturer] [nvarchar](255) NULL,
	[price] [float] NULL,
	[cost] [float] NULL,
	[quantity] [int] NULL,
	[prod_percent] [float] NULL,
	[cpu] [nvarchar](255) NULL,
	[hard_drive] [nvarchar](255) NULL,
	[mux_switch] [nvarchar](255) NULL,
	[screen] [nvarchar](255) NULL,
	[webcam] [nvarchar](255) NULL,
	[connection] [nvarchar](255) NULL,
	[prod_weight] [nvarchar](255) NULL,
	[pin] [nvarchar](255) NULL,
	[operation_system] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[ram] [nvarchar](125) NULL,
	[graphics] [nvarchar](125) NULL,
	[on_board] [varchar](255) NULL,
	[detailed_evaluation] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVIDED_USERS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVIDED_USERS](
	[user_id] [int] NULL,
	[name] [nvarchar](100) NULL,
	[email] [varchar](100) NULL,
	[provider] [varchar](255) NULL,
	[subject] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REVIEWS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REVIEWS](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[user_id] [int] NULL,
	[rating] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 12/04/2024 20:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[password] [varchar](255) NULL,
	[email] [varchar](100) NULL,
	[role] [varchar](50) NULL,
	[provider] [varchar](255) NULL,
	[phone] [varchar](15) NULL,
	[registration_token] [varchar](255) NULL,
	[confirmation_status] [varchar](10) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[subject] [varchar](255) NULL,
	[default_address] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BRANDS] ON 
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (1, N'DELL', N'Dell là một công ty công nghệ đa quốc gia chuyên sản xuất máy tính và các thiết bị công nghệ thông tin khác.', CAST(N'2023-08-22T08:36:21.503' AS DateTime), CAST(N'2024-03-01T21:40:14.470' AS DateTime), N'http://localhost:8000/upload/1709304014457-dell.png', N'dell')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (2, N'MSI', N'MSI là một công ty công nghệ có trụ sở tại Đài Loan, chuyên sản xuất laptop, bo mạch chủ, và các sản phẩm gaming.', CAST(N'2023-08-22T08:36:27.777' AS DateTime), CAST(N'2023-08-22T08:36:27.777' AS DateTime), N'http://localhost:8000/upload/msi.png', N'msi')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (3, N'ASUS', N'ASUS là một công ty công nghệ Đài Loan nổi tiếng với các sản phẩm laptop, bo mạch chủ, điện thoại di động, và thiết bị gaming.', CAST(N'2023-08-22T08:36:47.613' AS DateTime), CAST(N'2023-08-22T08:36:47.613' AS DateTime), N'http://localhost:8000/upload/asus.png', N'asus')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (4, N'ACER', N'Acer là một công ty công nghệ của Đài Loan chuyên sản xuất laptop, máy tính bảng, và các sản phẩm điện tử tiêu dùng khác.', CAST(N'2023-08-22T08:36:52.253' AS DateTime), CAST(N'2023-08-22T08:36:52.253' AS DateTime), N'http://localhost:8000/upload/acer.png', N'acer')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (5, N'LENOVO', N'Lenovo là một công ty công nghệ Trung Quốc có trụ sở tại Bắc Kinh và Morrisville, chuyên sản xuất laptop, máy tính bảng, và máy tính cá nhân.', CAST(N'2023-08-22T08:37:00.953' AS DateTime), CAST(N'2023-08-22T08:37:00.953' AS DateTime), N'http://localhost:8000/upload/lenovo.png', N'lenovo')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (6, N'HP', N'HP (Hewlett-Packard) là một công ty công nghệ Mỹ chuyên sản xuất máy in, máy tính cá nhân, laptop, và thiết bị văn phòng.', CAST(N'2023-08-22T08:37:15.767' AS DateTime), CAST(N'2023-08-22T08:37:15.767' AS DateTime), N'http://localhost:8000/upload/hp.png', N'hp')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (7, N'LG', N'LG là một công ty điện tử tiêu dùng và công nghệ đa quốc gia của Hàn Quốc, sản xuất các sản phẩm từ điện tử gia dụng đến smartphone.', CAST(N'2023-08-22T08:37:21.980' AS DateTime), CAST(N'2023-08-22T08:37:21.980' AS DateTime), N'http://localhost:8000/upload/lg.png', N'lg')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (8, N'MICROSOFT', N'Microsoft là một công ty công nghệ Mỹ, nổi tiếng với hệ điều hành Windows, Office, và các dịch vụ và sản phẩm công nghệ khác.', CAST(N'2023-08-22T08:38:28.877' AS DateTime), CAST(N'2023-08-22T08:38:28.877' AS DateTime), N'http://localhost:8000/upload/microsoft.png', N'microsoft')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (9, N'MACBOOK', N'MacBook là dòng sản phẩm laptop của Apple, chạy hệ điều hành macOS, nổi tiếng với thiết kế đẹp và hiệu suất ổn định.', CAST(N'2023-08-29T09:50:19.780' AS DateTime), CAST(N'2023-08-29T09:50:19.780' AS DateTime), N'http://localhost:8000/upload/macbook.png', N'macbook')
GO
INSERT [dbo].[BRANDS] ([brand_id], [name], [description], [created_at], [updated_at], [image], [slug]) VALUES (10, N'GIGABYTE', N'GIGABYTE là một thương hiệu hàng đầu về công nghệ, nổi tiếng với chất lượng sản phẩm cao và sự tiên phong trong việc áp dụng công nghệ mới.', CAST(N'2024-03-08T15:49:39.627' AS DateTime), CAST(N'2024-03-08T15:49:39.627' AS DateTime), N'http://localhost:8000/upload/1709887779570-BrandGIGABYTE.png', N'gigabyte')
GO
SET IDENTITY_INSERT [dbo].[BRANDS] OFF
GO
SET IDENTITY_INSERT [dbo].[CARTS] ON 
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 24, N'Dell Inspirion 15', N'Thiet ke hien dai dep de, tre trung', N'1683708021359-dellinspirion.png', 4000000, 8, 3, 12000000, CAST(N'2023-06-04T21:48:07.283' AS DateTime), CAST(N'2023-07-12T21:41:07.373' AS DateTime), 6, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 32, N'Laprtop Dell XPS 15 9520', N'Intel Core i7 12700H, Ram 16GB, SSD 1TB, VGA Nvidia GeForce RTX 3050Ti 44GB GDDR6, 15.6inch Full HD, Windows 11 Home, Vỏ nhôm nguyên khối màu bạc, Hàng chính hãng , Bảo hành 12 Tháng', N'1683865425452-Laprtop Dell XPS 15 9520.jpg', 58500000, 12, 2, 117000000, CAST(N'2023-06-06T16:16:57.587' AS DateTime), CAST(N'2023-06-06T16:16:57.587' AS DateTime), 7, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 23, N'Dell Vostro', N'Dell Vostro 2022', N'1683707853284-dellvostro.png', 500000, 8, 2, 1000000, CAST(N'2023-07-06T07:31:17.250' AS DateTime), CAST(N'2023-07-06T07:31:21.160' AS DateTime), 8, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 24, N'Dell Inspirion 15', N'Laptop Dell Inspiron 15 N3520 - i7 1255U/RAM 8GB/SSD 512GB/15.6"FHD/Win11', N'http://localhost:8000/upload/1694141619104-dellinspirion.png', 19690000, 6, 1, 19690000, CAST(N'2024-03-08T17:11:01.427' AS DateTime), CAST(N'2024-03-08T17:11:01.427' AS DateTime), 2074, N'14fe0778-f517-4fcc-912a-973d404bf232')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2047, N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB', N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB/13" Touchscreen/Win11', N'http://localhost:8000/upload/1709888528528-microSurfacePro9.png', 27490000, 1, 1, 27490000, CAST(N'2024-03-08T17:15:02.300' AS DateTime), CAST(N'2024-03-08T17:15:02.300' AS DateTime), 2075, N'14fe0778-f517-4fcc-912a-973d404bf232')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2046, N'Gigabyte Gaming G5 MF5-H2VN353SH i7 13620H', N'15.6 inch, 1920 x 1080 Pixels, 1920 x 1080 Pixels, IPS, IPS, 144, Anti-Glare LED-Backlit Display, Anti-Glare LED-Backlit Display', N'http://localhost:8000/upload/1709886868277-gigabyteGamingG5.png', 24490000, 8, 1, 24490000, CAST(N'2024-03-10T08:53:14.780' AS DateTime), CAST(N'2024-03-10T08:53:14.780' AS DateTime), 2079, N'5dd5f836-c9be-4100-84b4-91b3845d395f')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 21, 1, 43990000, CAST(N'2024-03-10T08:53:16.833' AS DateTime), CAST(N'2024-03-10T08:53:16.833' AS DateTime), 2080, N'5dd5f836-c9be-4100-84b4-91b3845d395f')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 34, N'MacBook Pro 14 inch M2 Pro 2023 ', N'MacBook Pro 14 inch M2 Pro 2023 10CPU 16GPU 32GB/512GB', N'http://localhost:8000/upload/1690807519733-macbookpro14.jpg', 57490000, 27, 1, 57490000, CAST(N'2024-03-11T08:08:27.963' AS DateTime), CAST(N'2024-03-11T08:08:27.963' AS DateTime), 3084, N'b26fa6b9-636c-4a68-be29-0ea6de426f21')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 21, 1, 43990000, CAST(N'2024-03-11T08:08:27.963' AS DateTime), CAST(N'2024-03-11T08:08:27.963' AS DateTime), 3085, N'b26fa6b9-636c-4a68-be29-0ea6de426f21')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2074, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 27490000, 4, 1, 27490000, CAST(N'2024-03-15T07:46:12.453' AS DateTime), CAST(N'2024-03-15T07:46:12.453' AS DateTime), 3130, N'1a1f7c36-0194-4a1c-8b57-289450f0d4e5')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2074, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 27490000, 4, 1, 27490000, CAST(N'2024-03-17T17:06:30.637' AS DateTime), CAST(N'2024-03-17T17:06:30.637' AS DateTime), 3145, N'4d875478-e7d3-4706-b0bb-c0dd2f06e017')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2047, N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB', N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB/13" Touchscreen/Win11', N'http://localhost:8000/upload/1709888528528-microSurfacePro9.png', 27490000, 0, 1, 27490000, CAST(N'2024-03-17T17:06:34.380' AS DateTime), CAST(N'2024-03-17T17:06:34.380' AS DateTime), 3146, N'4d875478-e7d3-4706-b0bb-c0dd2f06e017')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 1034, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 20990000, 3, 1, 20990000, CAST(N'2024-03-17T18:18:15.807' AS DateTime), CAST(N'2024-03-17T18:18:15.807' AS DateTime), 3150, N'7bdd9c06-dbb3-4ece-9ebd-291bad649c7f')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 1034, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 20990000, 3, 2, 41980000, CAST(N'2024-03-18T11:41:16.050' AS DateTime), CAST(N'2024-03-18T11:41:20.407' AS DateTime), 3151, N'2b1401cb-ce0b-4b23-a374-3cec657b269d')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 5, 1, 43990000, CAST(N'2024-03-18T15:23:37.797' AS DateTime), CAST(N'2024-03-18T15:23:37.797' AS DateTime), 3153, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 5, 1, 43990000, CAST(N'2024-03-18T15:31:52.993' AS DateTime), CAST(N'2024-03-18T15:31:52.993' AS DateTime), 3154, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 1034, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 20990000, 3, 1, 20990000, CAST(N'2024-03-18T16:05:47.713' AS DateTime), CAST(N'2024-03-18T16:05:47.713' AS DateTime), 3156, N'493a5236-40ea-4cdf-bb08-270c97cfaf15')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 1034, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 20990000, 3, 1, 20990000, CAST(N'2024-03-18T16:07:22.067' AS DateTime), CAST(N'2024-03-18T16:07:22.067' AS DateTime), 3157, N'5d71036b-ca1b-4500-80be-cef1002a922b')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 5, 1, 43990000, CAST(N'2024-03-18T16:21:29.007' AS DateTime), CAST(N'2024-03-18T16:21:29.007' AS DateTime), 3158, N'b691a3c2-3612-4cc3-836d-a6119f6784a3')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 5, 1, 43990000, CAST(N'2024-03-19T09:52:03.037' AS DateTime), CAST(N'2024-03-19T09:52:03.037' AS DateTime), 3165, N'c8deda6e-2928-4357-a632-0f88e862e0d0')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2074, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 27490000, 4, 1, 27490000, CAST(N'2024-03-23T21:01:53.720' AS DateTime), CAST(N'2024-03-23T21:01:53.720' AS DateTime), 3170, N'007c92a7-f71a-4904-b7f7-30ebe15fd27b')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (NULL, 2074, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 27490000, 4, 1, 27490000, CAST(N'2024-04-01T18:57:07.860' AS DateTime), CAST(N'2024-04-01T18:57:07.860' AS DateTime), 4171, N'ce351e86-21d0-48ad-bf23-089a9581883b')
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (8413, 33, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 43990000, 5, 1, 43990000, CAST(N'2024-04-08T19:19:59.637' AS DateTime), CAST(N'2024-04-09T19:19:28.770' AS DateTime), 5172, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (8413, 1034, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 20990000, 3, 1, 20990000, CAST(N'2024-04-09T20:51:53.483' AS DateTime), CAST(N'2024-04-09T20:51:53.483' AS DateTime), 5173, NULL)
GO
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (2015, 26, N'MacBook Air M1 2020', N'MacBook Air M1 2020', N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 21900000, 5, 1, 21900000, CAST(N'2024-04-11T19:47:31.120' AS DateTime), CAST(N'2024-04-12T19:27:56.740' AS DateTime), 5174, NULL)
GO
SET IDENTITY_INSERT [dbo].[CARTS] OFF
GO
SET IDENTITY_INSERT [dbo].[CATEGORIES] ON 
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (1, N'Laptop Gaming', N'Laptop Gaming', CAST(N'2023-06-08T14:52:47.057' AS DateTime), CAST(N'2024-02-24T22:57:02.973' AS DateTime), N'laptop-gaming')
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (2, N'Laptop Văn Phòng', N'Laptop Văn Phòng', CAST(N'2023-08-22T08:20:28.473' AS DateTime), CAST(N'2023-08-22T08:20:28.473' AS DateTime), N'laptop-vanphong')
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (3, N'Laptop Cao Cấp - Sang Trọng', N'Laptop Cao Cấp - Sang Trọng', CAST(N'2023-08-22T08:20:50.647' AS DateTime), CAST(N'2023-08-22T08:20:50.647' AS DateTime), N'laptop-caocap-sangtrong')
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (4, N'Laptop Đồ Họa - Kỹ Thuật', N'Laptop Đồ Họa - Kỹ Thuật', CAST(N'2023-08-22T08:21:44.203' AS DateTime), CAST(N'2023-08-22T08:21:44.203' AS DateTime), N'laptop-dohoa-kythuat')
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (5, N'Laptop Mỏng Nhẹ - Thời Trang', N'Laptop Mỏng Nhẹ - Thời Trang', CAST(N'2023-08-22T08:23:41.190' AS DateTime), CAST(N'2023-08-22T08:23:41.190' AS DateTime), N'laptop-mongnhe-thoitrang')
GO
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (8, N'Laptop Giá Rẻ', N'Laptop Giá Rẻ', CAST(N'2024-02-29T19:57:07.910' AS DateTime), CAST(N'2024-02-29T19:57:07.910' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[CATEGORIES] OFF
GO
SET IDENTITY_INSERT [dbo].[DELIVERY_ADDRESS] ON 
GO
INSERT [dbo].[DELIVERY_ADDRESS] ([id], [user_id], [detail_address], [province], [district], [ward]) VALUES (24, 2015, N'1', N'Tỉnh Cao Bằng', N'Huyện Bảo Lâm', N'Xã Đức Hạnh')
GO
INSERT [dbo].[DELIVERY_ADDRESS] ([id], [user_id], [detail_address], [province], [district], [ward]) VALUES (26, 8413, N'1', N'Thành phố Hà Nội', N'Quận Ba Đình', N'Phường Phúc Xá')
GO
INSERT [dbo].[DELIVERY_ADDRESS] ([id], [user_id], [detail_address], [province], [district], [ward]) VALUES (27, 8413, N'2', N'Tỉnh Hà Giang', N'Huyện Mèo Vạc', N'Xã Pải Lủng')
GO
INSERT [dbo].[DELIVERY_ADDRESS] ([id], [user_id], [detail_address], [province], [district], [ward]) VALUES (28, 2015, N'123', N'Tỉnh Lào Cai', N'Huyện Si Ma Cai', N'Xã Sán Chải')
GO
SET IDENTITY_INSERT [dbo].[DELIVERY_ADDRESS] OFF
GO
SET IDENTITY_INSERT [dbo].[IMAGES] ON 
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (1018, 1034, N'http://localhost:8000/upload/laptop-hp-victus-16-fullsz.png', N'http://localhost:8000/upload/laptop-hp-victus-16-fullsz.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2021, 1034, NULL, N'http://localhost:8000/upload/1695746410040-1695746295892-laptop-hp-victus-16-2.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2022, 1034, NULL, N'http://localhost:8000/upload/1695746410040-1695746333687-1695745919554-laptop-hp-victus-16-3.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2023, 1034, NULL, N'http://localhost:8000/upload/1695746410041-1695743480946-laptop-hp-victus-16-4.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2024, 1034, NULL, N'http://localhost:8000/upload/1695746410041-1695743480947-laptop-hp-victus-16-5.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2027, 24, NULL, N'http://localhost:8000/upload/1695746554027-1683708021359-dellinspirion.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2029, 26, NULL, N'http://localhost:8000/upload/1695746563393-1683708250019-macbook-air-m1-2020.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2030, 27, NULL, N'http://localhost:8000/upload/1695746572831-1683863062655-29171-laptop_asus_gaming_rog.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2032, 32, NULL, N'http://localhost:8000/upload/1695746590098-1683865425452-Laprtop Dell XPS 15 9520.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2033, 35, NULL, N'http://localhost:8000/upload/1695746606854-1690802127060-acer_nitro5_515_56.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2043, 33, NULL, N'http://localhost:8000/upload/1695788712824-Laptop LG Gram Style 2023 16Z90RS-G.AH54A5.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2044, 33, NULL, N'http://localhost:8000/upload/1695788712826-lg-gram-style-2023-i5-16z90rsgah54a5-1.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2045, 33, NULL, N'http://localhost:8000/upload/1695788712827-lg-gram-style-2023-i5-16z90rsgah54a5-4.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2046, 33, NULL, N'http://localhost:8000/upload/1695788712826-lg-gram-style-2023-i5-16z90rsgah54a5-2.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2047, 33, NULL, N'http://localhost:8000/upload/1695788776744-lg-gram-style-2023-i5-16z90rsgah54a5-3.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3041, 34, NULL, N'http://localhost:8000/upload/1695918142885-1690645379602-macbookpro14.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3048, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-1.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3049, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-5.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3050, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-2.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3051, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-3.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3052, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-4.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3063, 2043, NULL, N'http://localhost:8000/upload/1705379345655-msi-1.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3064, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-2.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3065, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-3.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3066, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-4.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3067, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-5.jpg')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3072, 2046, NULL, N'http://localhost:8000/upload/1709886974419-gigabyteGamingG5.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3073, 2046, NULL, N'http://localhost:8000/upload/1709886974422-gigabyteGamingG5(3).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3074, 2046, NULL, N'http://localhost:8000/upload/1709886974422-gigabyteGamingG5(4).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3075, 2046, NULL, N'http://localhost:8000/upload/1709886974421-gigabyteGamingG5(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3076, 2046, NULL, N'http://localhost:8000/upload/1709888528533-microSurfacePro9.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3077, 2046, NULL, N'http://localhost:8000/upload/1709888528534-microSurfacePro9(1).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3078, 2046, NULL, N'http://localhost:8000/upload/1709888528534-microSurfacePro9(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3079, 2046, NULL, N'http://localhost:8000/upload/1709888528534-microSurfacePro9(3).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3089, 2047, NULL, N'http://localhost:8000/upload/1709889590839-microSurfacePro9.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3091, 2047, NULL, N'http://localhost:8000/upload/1709889590842-microSurfacePro9(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3092, 2047, NULL, N'http://localhost:8000/upload/1709889590843-microSurfacePro9(3).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3093, 2047, NULL, N'http://localhost:8000/upload/1709988618723-microSurfacePro9(1).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3157, NULL, NULL, N'http://localhost:8000/upload/1710077239120-microSurfacePro9(1).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3158, NULL, NULL, N'http://localhost:8000/upload/1710077239118-microSurfacePro9.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3159, NULL, NULL, N'http://localhost:8000/upload/1710077239120-microSurfacePro9(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3160, NULL, NULL, N'http://localhost:8000/upload/1710077381760-microSurfacePro9.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3161, NULL, NULL, N'http://localhost:8000/upload/1710077381762-microSurfacePro9(1).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3162, NULL, NULL, N'http://localhost:8000/upload/1710077381762-microSurfacePro9(3).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3163, NULL, NULL, N'http://localhost:8000/upload/1710077381762-microSurfacePro9(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3164, NULL, NULL, N'http://localhost:8000/upload/1710077535433-microSurfacePro9(2).png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3165, NULL, NULL, N'http://localhost:8000/upload/1710077535432-microSurfacePro9.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3174, 2074, NULL, N'http://localhost:8000/upload/1710078977557-lenovo-legion5-1.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3175, 2074, NULL, N'http://localhost:8000/upload/1710078977560-lenovo-legion5-2.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3176, 2074, NULL, N'http://localhost:8000/upload/1710078977561-lenovo-legion5-3.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3177, 2074, NULL, N'http://localhost:8000/upload/1710078977562-lenovo-legion5-4.png')
GO
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3178, 2074, NULL, N'http://localhost:8000/upload/1710078977563-lenovo-legion5-5.png')
GO
SET IDENTITY_INSERT [dbo].[IMAGES] OFF
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (23, 16810, 2, 18990000, CAST(N'2024-03-16T15:12:22.030' AS DateTime), CAST(N'2024-03-16T15:12:22.030' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2043, 16814, 1, 20490000, CAST(N'2024-03-18T16:58:41.997' AS DateTime), CAST(N'2024-03-18T16:58:41.997' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 16814, 1, 21900000, CAST(N'2024-03-18T16:58:42.003' AS DateTime), CAST(N'2024-03-18T16:58:42.003' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 16815, 1, 20990000, CAST(N'2024-03-18T17:00:24.020' AS DateTime), CAST(N'2024-03-18T17:00:24.020' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2043, 16816, 1, 20490000, CAST(N'2024-03-18T17:05:41.507' AS DateTime), CAST(N'2024-03-18T17:05:41.507' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 16817, 1, 19690000, CAST(N'2024-03-19T09:38:33.507' AS DateTime), CAST(N'2024-03-19T09:38:33.507' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (33, 16818, 1, 43990000, CAST(N'2024-03-19T09:53:48.010' AS DateTime), CAST(N'2024-03-19T09:53:48.010' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 16819, 1, 21900000, CAST(N'2024-03-19T09:57:09.923' AS DateTime), CAST(N'2024-03-19T09:57:09.923' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 16820, 1, 19690000, CAST(N'2024-03-19T09:58:06.167' AS DateTime), CAST(N'2024-03-19T09:58:06.167' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (34, 17822, 1, 57490000, CAST(N'2024-03-28T19:45:48.853' AS DateTime), CAST(N'2024-03-28T19:45:48.853' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (33, 17822, 1, 43990000, CAST(N'2024-03-28T19:45:48.850' AS DateTime), CAST(N'2024-03-28T19:45:48.850' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 17822, 1, 19690000, CAST(N'2024-03-28T19:45:48.883' AS DateTime), CAST(N'2024-03-28T19:45:48.883' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (23, 17823, 1, 18990000, CAST(N'2024-04-05T19:30:42.627' AS DateTime), CAST(N'2024-04-05T19:30:42.627' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 17824, 1, 21900000, CAST(N'2024-04-05T19:31:32.993' AS DateTime), CAST(N'2024-04-05T19:31:32.993' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2074, 17822, 1, 27490000, CAST(N'2024-03-28T19:45:48.893' AS DateTime), CAST(N'2024-03-28T19:45:48.893' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2047, 16809, 1, 27490000, CAST(N'2024-03-16T15:11:19.367' AS DateTime), CAST(N'2024-03-16T15:11:19.367' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 16812, 1, 20990000, CAST(N'2024-03-17T18:15:18.960' AS DateTime), CAST(N'2024-03-17T18:15:18.960' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2074, 16811, 1, 27490000, CAST(N'2024-03-17T17:25:38.503' AS DateTime), CAST(N'2024-03-17T17:25:38.503' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2074, 16809, 1, 27490000, CAST(N'2024-03-16T15:11:19.367' AS DateTime), CAST(N'2024-03-16T15:11:19.367' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 16814, 1, 20990000, CAST(N'2024-03-18T16:58:41.973' AS DateTime), CAST(N'2024-03-18T16:58:41.973' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (34, 16817, 1, 57490000, CAST(N'2024-03-19T09:38:33.520' AS DateTime), CAST(N'2024-03-19T09:38:33.520' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2074, 16822, 1, 27490000, CAST(N'2024-03-20T15:14:38.630' AS DateTime), CAST(N'2024-03-20T15:14:38.630' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 16822, 1, 20990000, CAST(N'2024-03-20T15:14:38.633' AS DateTime), CAST(N'2024-03-20T15:14:38.633' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (2047, 16813, 1, 27490000, CAST(N'2024-03-17T18:16:56.057' AS DateTime), CAST(N'2024-03-17T18:16:56.057' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 16821, 1, 19690000, CAST(N'2024-03-19T10:01:05.240' AS DateTime), CAST(N'2024-03-19T10:01:05.240' AS DateTime))
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (33, 16823, 1, 43990000, CAST(N'2024-03-23T21:11:16.883' AS DateTime), CAST(N'2024-03-23T21:11:16.883' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ORDERS] ON 
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16809, N'COD', 54980000, 2015, N'1', N'asdawd12@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 1, 0, 1, CAST(N'2024-03-16T15:11:19.340' AS DateTime), CAST(N'2024-03-16T15:11:19.340' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 0, 0, NULL, NULL, NULL, CAST(N'2024-03-17T18:55:15.610' AS DateTime), CAST(N'2024-03-17T18:55:15.607' AS DateTime), NULL, NULL, NULL, NULL, NULL, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', 1, 2)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16810, N'COD', 37980000, 2015, N'1', N'awzs123123@gmail.com', N'39/46 Cù Chính Lan, Phường Hòa Khê, Quận Thanh Khê, Thành phố Đà Nẵng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-16T15:12:22.017' AS DateTime), CAST(N'2024-03-16T15:12:22.017' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1705125871316-dell-vostro-i5-1.jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Dell Vostro V5620 i5 1240P', 2, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16811, N'COD', 27490000, NULL, N'1', N'hoawkdmaw2@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-17T17:25:38.480' AS DateTime), CAST(N'2024-03-17T17:25:38.480' AS DateTime), NULL, N'', N'fce1a59d-0278-40e2-b666-44d8d600e07e', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16812, N'COD', 20990000, NULL, N'1', N'dawdawkm12@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-17T18:15:18.940' AS DateTime), CAST(N'2024-03-17T18:15:18.940' AS DateTime), NULL, N'', N'7bdd9c06-dbb3-4ece-9ebd-291bad649c7f', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16813, N'COD', 27490000, NULL, N'1', N'adwdawjd12@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-17T18:16:56.040' AS DateTime), CAST(N'2024-03-17T18:16:56.040' AS DateTime), NULL, N'', N'7bdd9c06-dbb3-4ece-9ebd-291bad649c7f', N'http://localhost:8000/upload/1709888528528-microSurfacePro9.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16814, N'COD', 63380000, 8424, N'2', N'awjdoiawdjo@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-18T16:58:41.943' AS DateTime), CAST(N'2024-03-18T16:58:41.943' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', 1, 3)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16815, N'COD', 20990000, 8424, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 0, 0, 0, CAST(N'2024-03-18T17:00:24.007' AS DateTime), CAST(N'2024-03-18T17:00:24.007' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16816, N'COD', 20490000, 8424, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 0, 0, 0, CAST(N'2024-03-18T17:05:41.490' AS DateTime), CAST(N'2024-03-18T17:05:41.490' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1705379345655-msi-1.jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MSI Gaming Thin GF63 12VE-454VN i5 12450H', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16817, N'COD', 77180000, 8426, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 0, 0, 0, CAST(N'2024-03-19T09:38:33.487' AS DateTime), CAST(N'2024-03-19T09:38:33.487' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1694141619104-dellinspirion.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Dell Inspirion 15', 1, 2)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16818, N'VNPAY', 43990000, 8426, N'1', N'aakwmdkw@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 1, 0, 0, CAST(N'2024-03-19T09:53:47.990' AS DateTime), CAST(N'2024-03-19T09:53:47.990' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 0, 0, NULL, NULL, NULL, NULL, CAST(N'2024-03-19T09:53:41.000' AS DateTime), N'14346501', N'Thanh toan cho ma GD:19095238', N'ATM', N'NCB', N'2024-03-19 09:53:41', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16819, N'COD', 21900000, NULL, N'1', N'awdawd@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-19T09:57:09.910' AS DateTime), CAST(N'2024-03-19T09:57:09.910' AS DateTime), NULL, N'', N'b3c92ce3-a4ad-45aa-b284-961f994b4f94', N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MacBook Air M1 2020', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16820, N'COD', 19690000, NULL, N'1', N'hawoaowk12@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-19T09:58:06.157' AS DateTime), CAST(N'2024-03-19T09:58:06.157' AS DateTime), NULL, N'', N'b3c92ce3-a4ad-45aa-b284-961f994b4f94', N'http://localhost:8000/upload/1694141619104-dellinspirion.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Dell Inspirion 15', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16821, N'COD', 19690000, 8424, N'1', N'awdawd@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-19T10:01:05.230' AS DateTime), CAST(N'2024-03-19T10:01:05.230' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1694141619104-dellinspirion.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Dell Inspirion 15', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16822, N'VNPAY', 48480000, 2015, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 1, 0, 0, CAST(N'2024-03-20T15:14:38.600' AS DateTime), CAST(N'2024-03-20T15:14:38.600' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', 0, 0, NULL, NULL, NULL, NULL, CAST(N'2024-03-20T15:14:31.000' AS DateTime), N'14348667', N'Thanh toan cho ma GD:20151301', N'ATM', N'NCB', N'2024-03-20 15:14:31', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', 1, 2)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (16823, N'VNPAY', 43990000, 8425, N'1', N'hoawkdaw@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 1, 0, 0, CAST(N'2024-03-23T21:11:16.853' AS DateTime), CAST(N'2024-03-23T21:11:16.853' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 0, 0, NULL, NULL, NULL, NULL, CAST(N'2024-03-23T21:09:53.000' AS DateTime), N'14353042', N'Thanh toan cho ma GD:23210241', N'ATM', N'NCB', N'2024-03-23 21:09:53', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (17822, N'COD', 148660000, 8413, N'1', N'adawdaw2@gmail.com', N'Nhận hàng tại cửa hàng', N'1', N'0', 0, 0, 0, CAST(N'2024-03-28T19:45:48.820' AS DateTime), CAST(N'2024-03-28T19:45:48.820' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', 1, 4)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (17823, N'COD', 18990000, 2015, N'1', N'aowdkaowd12@gmail.com', N'39/46 Cù Chính Lan, Phường Hòa Khê, Quận Thanh Khê, Thành phố Đà Nẵng', N'1', N'0', 0, 0, 0, CAST(N'2024-04-05T19:30:42.550' AS DateTime), CAST(N'2024-04-05T19:30:42.550' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1705125871316-dell-vostro-i5-1.jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Dell Vostro V5620 i5 1240P', 1, 1)
GO
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate], [prod_name], [quantity], [total_product]) VALUES (17824, N'COD', 21900000, 2015, N'1', N'aodkoaw@gmail.com', N'1, Xã Pải Lủng, Huyện Mèo Vạc, Tỉnh Tuyên Quang', N'1', N'0', 0, 0, 0, CAST(N'2024-04-05T19:31:32.970' AS DateTime), CAST(N'2024-04-05T19:31:32.970' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'MacBook Air M1 2020', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ORDERS] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTS] ON 
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (23, 1, 2, N'Dell Vostro V5620 i5 1240P', N'http://localhost:8000/upload/1705125871316-dell-vostro-i5-1.jpg', N'Laptop Dell Vostro V5620 i5 1240P/8GB/512GB/16"FHD+/Nvidia MX570 2GB/Win11', NULL, 18990000, 21490000, 10, 0, N'Intel,Core i5,1240P,3.30 GHz,	4.4 GHz,	,	,	', N'SSD, M.2 NVMe,512 GB,,', NULL, N'16.0 inch,Anti-Glare LED-Backlit Display,1920 x 1200 Pixels,60 Hz ,WVA', N' Full HD Webcam (1080p Webcam)', N'1 HDMI-1 USB 3.2,802.11 ax ,v5.2', N'1.97 kg', N'3420 mAh', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'	8 GB (1 thanh 8 GB),DDR4,,2 ,1,0,32 GB', N'GeForce MX570, 2 GB', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (24, 1, 2, N'Dell Inspirion 15', N'http://localhost:8000/upload/1694141619104-dellinspirion.png', N'Laptop Dell Inspiron 15 N3520 - i7 1255U/RAM 8GB/SSD 512GB/15.6"FHD/Win11', NULL, 19690000, 20690000, 6, 15, N'Intel, Core i7, 1255U', N'SSD 512GB', NULL, N'15.6 inch, 1920 x 1080 Pixels, WVA, 120, WVA Anti-glare LED Backlit Narrow Border', N'1.6MGp', N'Wifi, AirPlay', N'1.7kg', N'54 Wh', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'8GB', N'GeForce MX550', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (26, 9, 3, N'MacBook Air M1 2020', N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', N'MacBook Air M1 2020', NULL, 21900000, 22900000, 5, 15, N'Apple, M1', N'ssd 512Gb', NULL, N'FullHd', N'1.6MGp', N'Wifi, AirPlay', N'2kg', N'3 Cell', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'null', N'null', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (27, 3, 1, N'Laptop Gaming Asus ROG Strix SCAR 18 G834JY-N6039W', N'http://localhost:8000/upload/1690807275761-29171-laptop_asus_gaming_rog.jpg', N'Laptop Gaming Asus ROG Strix SCAR 18 G834JY-N6039W Intel Core i9-13980HX, RAM 64GB, SSD 2TB, RTX 4090 16GB, Màn Hình 18 inch QHD+ 240Hz, Windows 11, Màu Đen', NULL, 125000000, 129000000, 26, 10, N'Intel, Core i9, 13980HX (upto 5.60 GHz), ,,,, 36MB', N'SSD,PCIe 4.0 NVMe M.2,2TB,,', NULL, N'18 inch WQXGA (2560 x 1600) 16:10, 240Hz, 3ms, IPS-level, DCI-P3 100%, anti-glare display, G-Sync, ROG Nebula Display', N'720p HD Camera', N'Wifi, AirPlay', N'2kg', N'4 Cell 90WHrs', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'64 GB,DDR5, 4800 MHz, 2, Không, 0, 64 GB', N'	NVIDIA GeForce RTX 4090,16 GB GDDR6 - Intel,	UHD', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (32, 1, 1, N'Laprtop Dell XPS 15 9520', N'http://localhost:8000/upload/1690807317488-Laprtop_Dell_XPS_15_9520.jpg', N'Laprtop Dell XPS 15 9520 Intel Core i7 12700H, Ram 16GB, SSD 1TB, VGA Nvidia GeForce RTX 3050Ti 44GB GDDR6, 15.6inch Full HD, Windows 11 Home, Vỏ nhôm nguyên khối màu bạc, Hàng chính hãng , Bảo hành 12 Tháng', NULL, 58500000, 59900000, 12, 10, N'Intel, Core i7, 12700H', N'SSD 1TB', NULL, N'15.6inch Full HD', N'Có', N'Wifi, AirPlay', N'null', N'6 cell', N'Window 11 Home', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'16GB, DDR5,4800Mhz,2,Không,0,64GB', N'Intel UHD Graphics, Share', N'null', NULL)
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (33, 7, 3, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', NULL, 43990000, 44990000, 5, 15, N'Intel, Core i5, 1340P', N'512GB M.2 NVMe™ PCIe® 4.0 SSD (2 slot, còn trống 1 khe M.2)', NULL, N'16inch WQHD+ OLED 120Hz', N'Webcam IR FHD IR with Dual Mic', N'Wifi, AirPlay', N'null', N'80WHr', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'16 GB (1 thanh 16 GB), DDR5 6000 MHz', N' ', N' Intel Iris Plus Graphics', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (34, 9, 1, N'MacBook Pro 14 inch M2 Pro 2023 ', N'http://localhost:8000/upload/1690807519733-macbookpro14.jpg', N'MacBook Pro 14 inch M2 Pro 2023 10CPU 16GPU 32GB/512GB', NULL, 57490000, 63990000, 27, 12, N'Apple, M2 Pro, 10-Core', N'SSD,, 512 GB', NULL, N'14.2 inch, Retina,3024 x 1964 Pixels,	120 Hz', N'Full HD Webcam (1080p Webcam)', N'1 HDMI, 3 Type C, 1 Jack 3.5 mm', N'null', N'Lithium polymer 67 W', N'Ventura', CAST(N'2023-07-30T10:28:44.363' AS DateTime), CAST(N'2023-07-30T10:28:44.363' AS DateTime), N'32 GB', N'Apple M1', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (35, 4, 1, N'Laptop Acer Nitro Gaming AN515 56 51N4', N'http://localhost:8000/upload/1690802127060-acer_nitro5_515_56.jpg', N'Laptop Acer Nitro Gaming AN515 56 51N4 i5 11300H/8GB/512GB SSD/Nvidia GTX1650 4GB/Win11', NULL, 17999000, 19798900, 0, 15, N'Intel, Core i5, 11300H,	3 Ghz,4.4 GHz,4,8,8 MB', N'SSD,M2. PCIe, 512Gb,	1 SSD + 1 HDD,	1 HDD', NULL, N'15.6 inch, 1920 x 1080 Pixels, 144 Hz', N'HD webcam', N'USB Type-C  Jack tai nghe 3.5 mm  3 x USB 3.2  HDMI  LAN (RJ45)', N'null', N'4-cell Li-ion, 57.5 Wh', N'Window 11', CAST(N'2023-07-31T18:15:27.113' AS DateTime), CAST(N'2023-07-31T18:15:27.113' AS DateTime), N'8 GB (1 thanh 8 GB), ,3200 MHz', N'NVIDIA GeForce GTX 1650, 4GB', N'Intel Iris Xe Graphics', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (1034, 6, 1, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', NULL, 20990000, 27990000, 3, 25, N'AMD, Ryzen 5,6600H (up to 4.50 GHz/ 6 nhân/ 12 luồng/16MB)', N' 512GB PCIe NVMe TLC M.2 SSD', NULL, N'16.1 inch, FullHD (1920 x 1080), 144Hz', N'HP Wide Vision 720p HD camera with integrated dual array digital microphones', N'Intel Wi-Fi 6E AX211 (2x2), Bluetooth® 5.3 compatible combo (supporting gigabit data rate)', N'2.5kg', N'4-cell, 70 Wh Li-ion polymer', N' Windows 11 Home 64', CAST(N'2023-08-29T11:31:11.667' AS DateTime), CAST(N'2023-08-29T11:31:11.667' AS DateTime), N'8 GB (1 thanh 8 GB), DDR5, 4800 MHz', N' NVIDIA GeForce RTX 3050, 4GB', NULL, NULL)
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (2043, 2, 1, N'MSI Gaming Thin GF63 12VE-454VN i5 12450H', N'http://localhost:8000/upload/1705379345655-msi-1.jpg', N'Laptop MSI Gaming Thin GF63 12VE-454VN i5 12450H/16GB/512GB/15.6" FHD/GeForce RTX 4050 6GB/Win 11', NULL, 20490000, 22990000, 3, 0, N'Intel, Core i5, 12450H', N'SSD 512 GB', NULL, N'15.6 inch, IPS FHD, 1920 x 1080 Pixels, Màn hình phẳng, 144 Hz, IPS, 45% NTSC', N'HD Webcam (720p Webcam)', N'1 DC-in jack 1 HDMI 1 Jack 3.5 mm 1 LAN 1 Type C 1 Type C 3 USB 3.2, Wifi 6', N'1.86kg', N'52.4 Wh', N'Windows 11 Home', CAST(N'2024-01-16T11:29:05.740' AS DateTime), CAST(N'2024-01-16T11:29:05.740' AS DateTime), N'16 GB, DDR4, 3200 MHz', N'NVIDIA GeForce RTX 4050, 6GB GDDR6 - Intel Iris Xe Graphics', NULL, NULL)
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (2046, 10, 1, N'Gigabyte Gaming G5 MF5-H2VN353SH i7 13620H', N'http://localhost:8000/upload/1709886868277-gigabyteGamingG5.png', N'Gigabyte Gaming G5 MF5-H2VN353SH i7 13620H 
15.6 inch, 1920 x 1080 Pixels, 1920 x 1080 Pixels, IPS, IPS, 144, Anti-Glare LED-Backlit Display, Anti-Glare LED-Backlit Display', NULL, 24490000, 27990000, 7, 10, N'Intel, Core i7, 13620H,	2.4 GHz,	4.9 GHz,10,16,24 MB', N'SSD,M.2 NVMe, 512 GB,2,1', NULL, N'15.6 inch, 1920 x 1080 Pixels, 1920 x 1080 Pixels, IPS, IPS, 144, Anti-Glare LED-Backlit Display, Anti-Glare LED-Backlit Display', N'HD Webcam (720p Webcam)', N'Cổng giao tiếp	 1 DC-in jack 1 HDMI 1 MicroSD card reader 1 Mini Display Port 1 RJ45 Gigabit Ethernet 1 USB 2.0 1 USB 3.2 Gen 1 Type-A 2 USB 3.2 Gen 2 Type-C Wifi	 Wifi 6E Bluetooth	v5.2', N'	2.08 kg', N'54 Wh', N'	Windows 11', CAST(N'2024-03-08T15:34:28.363' AS DateTime), CAST(N'2024-03-08T15:34:28.363' AS DateTime), N'16 GB (2 thanh 8 GB), DDR5,4800,2,0,0,64 GB', N'NVIDIA GeForce RTX 4050, 6GB GDDR6', N'null', N'null')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (2047, 8, 1, N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB', N'http://localhost:8000/upload/1709888528528-microSurfacePro9.png', N'Laptop Microsoft Surface Pro 9 i5 1235U/8GB/256GB/13" Touchscreen/Win11', NULL, 27490000, 30990000, 0, 11, N' Intel, Core i5, 1235U', N'SSD, 256 GB', NULL, N' 13.0 Chính: inch, 2880 x 1920 Pixels, IPS, 120, IPS Chính:', N'Full HD Webcam (1080p Webcam)', N' Cổng giao tiếp	 Type C Wifi	 Wifi 6E Bluetooth	v5.1', N'	879 g', N'47.7 Wh', N'Windows 11 Home', CAST(N'2024-03-08T16:02:08.593' AS DateTime), CAST(N'2024-03-08T16:02:08.593' AS DateTime), N' 8 GB (1 thanh 8 GB), DDR5, 4800 MHz', N'', N'Intel UHD Graphics', N'<h2 class="st-pd-contentTitle" style="box-sizing: inherit; margin: 0px 0px 24px; padding: 0px; border: 0px; font-size: 20px; font-weight: 500; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 28px; text-align: center; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Đánh giá chi tiết<span>&nbsp;</span>Laptop Microsoft Surface Pro 9 i5 1235U</h2><p><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-size: 16px; line-height: inherit; color: rgb(73, 80, 87); font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Một chiếc laptop mạnh mẽ hay một chiếc máy tính bảng linh hoạt, dù trong bất cứ vai trò nào, Microsoft Surface Pro 9 vẫn thể hiện vô cùng xuất sắc, cho bạn sản phẩm có hiệu suất cao, thời lượng pin cả ngày và một thiết kế cực chất mà ai cũng phải ngước nhìn.</strong></p><p><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-size: 16px; line-height: inherit; color: rgb(73, 80, 87); font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><img src="http://localhost:8000/upload/1709889102347-microSurfacePro9.png" alt="surface1" width="665" height="443" style="display: block; margin-left: auto; margin-right: auto;"></strong></p><h3 style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 700; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Thỏa sức sáng tạo trên màn hình cảm ứng tràn viền</strong></h3><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;">Sẽ thật thú vị khi cầm trên tay và thao tác trực tiếp lên màn hình<span>&nbsp;</span><a href="https://fptshop.com.vn/may-tinh-xach-tay/microsoft-surface-pro-9-i5-1235u" style="box-sizing: inherit; margin: 0px; padding: 0px; font-size: 16px; vertical-align: baseline; background: 0px 0px transparent; outline: 0px; text-decoration: none; color: rgb(1, 104, 250); cursor: pointer;">Surface Pro 9</a>. Bạn sẽ có một thiết bị màn hình tuyệt đẹp với độ phân giải 2880 x 1920 pixels. Dù rất nhỏ gọn nhưng Surface Pro 9 vẫn có màn hình kích thước 13 inch, tỉ lệ 3:2 cho diện tích hiển thị cực rộng. Với chuẩn màu sRGB và tần số quét lên tới 120Hz, mọi thứ xuất hiện trước mắt bạn đều thật sống động và mượt mà. Không chỉ hiển thị xuất sắc, màn hình này còn hỗ trợ cảm ứng 10 điểm và tương thích với bút cảm ứng. Đối với công việc sáng tạo, hội họa, phụ kiện bút Surface Slim Pen 2 cho trải nghiệm thực tế như đang viết, vẽ trên giấy để bạn nhanh chóng ghi lại ý tưởng mọi lúc mọi nơi.</p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><img src="https://images.fpt.shop/unsafe/filters:quality(90)/fptshop.com.vn/Uploads/images/2015/0511/surface-pro-9-3.jpg" alt="surface2" width="608" height="405" style="display: block; margin-left: auto; margin-right: auto;"></p><h3 style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 700; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Thiết kế khác biệt, cao cấp và linh hoạt</strong></h3><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;">Thiết kế, sự sang chảnh, tính công nghệ và khí chất riêng của Surface Pro 9 là điều bạn không tìm thấy trên bất cứ sản phẩm nào khác. Vẫn là một sản phẩm đẹp như kiệt tác, phần giá đỡ thông minh, logo Microsoft tinh tế thu hút mọi ánh nhìn. Surface Pro 9 đáp ứng hoàn hảo mọi nhu cầu trong một thiết kế mỏng nhẹ không tưởng với trọng lượng chỉ 879 gram và độ mỏng 9,3mm. Làm từ kim loại cao cấp, khả năng tương thích với nhiều phụ kiện, Surface Pro 9 vừa đẹp lại vừa tiện dụng. Việc sử dụng bàn phím rời hay bút Surface Pen sẽ biến Surface Pro 9 thành một sản phẩm đa năng hơn bao giờ hết.</p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><img src="https://images.fpt.shop/unsafe/filters:quality(90)/fptshop.com.vn/Uploads/images/2015/0511/surface-pro-9-8.jpg" alt="surface3" width="607" height="404" style="display: block; margin-left: auto; margin-right: auto;"></p>')
GO
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics], [on_board], [detailed_evaluation]) VALUES (2074, 5, 1, N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', N'http://localhost:8000/upload/1710078977554-lenovo-legion5-1.png', N'Laptop Lenovo Gaming Legion 5 16IRX9 i714650HX/16GB/512GB/16"WQXGA/RTX4060 8GB/Win 11H ', NULL, 27490000, 30990000, 4, 20, N' Intel, Core i7, 14650HX', N'SSD,, 512 GB', NULL, N'16 inch, 2560 x 1600 Pixels, IPS, 165, 350 nits, IPS LCD', N'Trước Full HD Webcam (1080p Webcam)', N' Cổng giao tiếp	 1 HDMI 2.1 1 Jack 3.5 mm 1 Power connector 1 RJ45 Gigabit Ethernet 1 Thunderbolt 4 2 USB 3.2 Gen 2 Type-C 3 USB 3.2 Gen 1 Wifi	 Wifi 6E Bluetooth	v5.3', N'	2.3 kg', N' Loại PIN	Lithium-ion Power Supply	150 W Dung lượng pin	 80', N'	Windows 11', CAST(N'2024-03-10T20:56:17.607' AS DateTime), CAST(N'2024-03-10T20:56:17.607' AS DateTime), N'16 GB (1 thanh 16 GB), DDR5, 5600', N'NVIDIA GeForce RTX 4060, 8GB', N'null', N'<h2 class="card-title" style="box-sizing: inherit; margin: 0px 0px 15px; padding: 0px; border: 0px; font-size: 20px; font-weight: 500; vertical-align: baseline; background: 0px 0px; font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 28px; display: flex; -webkit-box-align: baseline; align-items: baseline; -webkit-box-pack: justify; justify-content: space-between; position: relative; flex-shrink: 0; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: center; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Đặc điểm nổi bật của Lenovo Gaming Legion 5 16IRX9 i7-14650HX (83DG004YVN)</h2><div class="card-body" style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-size: 14px; font-weight: 400; vertical-align: baseline; background: 0px 0px; -webkit-box-flex: 1; flex: 1 1 auto; color: rgb(68, 75, 82); font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><div class="st-pd-content" style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; font-size: 14px; font-weight: 400; vertical-align: baseline; background: 0px 0px;"><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px; color: rgb(73, 80, 87); line-height: 24px; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Được trang bị “siêu chip” Intel Core i7 14650HX thế hệ mới nhất cực mạnh và chip AI LA1 riêng biệt, Lenovo Gaming Legion 5 16IRX9 cho bạn chơi game với tốc độ nhanh chưa từng thấy trên một chiếc laptop nhỏ gọn. Tha hồ thể hiện kỹ năng với màn hình lớn 15,6 inch 2K 165Hz đầy chuyên nghiệp.</strong></p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px; color: rgb(73, 80, 87); line-height: 24px; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;"><img src="http://localhost:8000/upload/1710078977557-lenovo-legion5-1.png" alt="example" style="display: block; margin-left: auto; margin-right: auto;"></strong></p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px; color: rgb(73, 80, 87); line-height: 24px; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;"><h3 style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 700; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Hiệu năng vượt xa những gì bạn tưởng tượng</strong></h3><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;">Sức mạnh của một chiếc laptop di động giờ đây khủng khiếp hơn những gì bạn nghĩ rất nhiều. Bộ vi xử lý Intel Core i7 14650HX có mặt trên<span>&nbsp;</span><a href="https://fptshop.com.vn/may-tinh-xach-tay/lenovo-gaming-legion-5-16irx9-i7-14650hx" target="_blank" style="box-sizing: inherit; margin: 0px; padding: 0px; font-size: 16px; vertical-align: baseline; background: 0px 0px transparent; outline: 0px; text-decoration: none; color: rgb(1, 104, 250); cursor: pointer;">Lenovo Gaming Legion 5 16IRX9</a><span>&nbsp;</span>xứng đáng được gọi là một “siêu chip máy tính” với 16 nhân 24 luồng và tốc độ khó tin lên tới 5.2 GHz. Điều này đồng nghĩa với việc Lenovo Gaming Legion 5i có sức mạnh tương đương với những máy tính chơi game để bàn hàng đầu hiện nay. Ngay cả những tác vụ nặng, các ứng dụng đòi hỏi khắt khe về cấu hình hay cả những tựa game đời mới cũng không thể làm khó được chiếc laptop này, một sản phẩm có đủ sức mạnh đáp ứng mọi nhu cầu.</p><img src="http://localhost:8000/upload/1710078977561-lenovo-legion5-3.png" alt="example" style="display: block; margin-left: auto; margin-right: auto;"><h3 style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 700; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Giảm nhiệt nhanh chóng, chơi game liên tục</strong></h3><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;">Hệ thống tản nhiệt Legion ColdFront Hyper trên Lenovo Gaming Legion 5 16IRX9 là một bước đột phá cho máy tính chơi game. Được thiết kế dành riêng cho game thủ, hệ thống tản nhiệt này có các quạt quay hướng vào trong, hoạt động song song để đẩy khí nóng ra phía sau máy một cách hiệu quả. Việc tản nhiệt ra phía sau là một giải pháp thông minh khi tay bạn sẽ không bị nóng trong lúc chơi game dù là đang thao tác với bàn phím hay chuột. Lenovo Gaming Legion 5 còn sử dụng một buồng kín chuyên dụng để chứa nhiệt, giúp duy trì nhiệt độ tối ưu, giảm nhiệt độ xuống 2 độ C, đồng thời giảm tiếng ồn xuống 2dB so với thế hệ trước.</p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: center;"><img alt="Lenovo Gaming Legion 5 16IRX9 (ảnh 4)" class="" src="https://images.fpt.shop/unsafe/filters:quality(90)/fptshop.com.vn/Uploads/images/2015/0511/Lenovo-Gaming-Legion-5-16IRX9-3.jpg" style="box-sizing: inherit; margin: 0px auto; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: middle; background: 0px 0px; max-width: 100%; border-radius: 6px; width: 665px; height: auto !important; display: block;"></p><h3 style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 700; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); font-family: Roboto, sans-serif; color: rgb(33, 37, 41); line-height: 24px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;"><strong style="box-sizing: inherit; margin: 0px; padding: 0px; border: 0px; vertical-align: baseline; background: 0px 0px; font-size: inherit; line-height: inherit;">Chơi game thông minh hơn với chip AI chuyên dụng</strong></h3><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: justify;">Hành trình chơi game của bạn sẽ trở nên trơn tru hơn nhờ hệ thống trí tuệ nhân tạo Lenovo AI Engine+ thông minh. Không chỉ dừng lại ở phần mềm, con chip chuyên dụng AI LA1 sẽ giúp bạn đơn giản hóa mọi sự phức tạp. Thay vì phải loay hoay thiết lập các tùy chọn cho từng tựa game, AI sẽ tinh chỉnh cấu hình tự động và cài đặt tối ưu để hiệu suất CPU, GPU đạt hiệu quả tốt nhất. AI Engine+ của Lenovo dễ dàng khai phá tiềm năng chơi game cho chiếc máy tính Lenovo Gaming Legion 5 16IRX9 của bạn.</p><p style="box-sizing: inherit; margin: 0px 0px 11px; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: baseline; background: 0px 0px rgb(255, 255, 255); color: rgb(73, 80, 87); line-height: 24px; font-family: Roboto, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; text-align: center;"><img alt="Lenovo Gaming Legion 5 16IRX9 (ảnh 5)" class="" src="https://images.fpt.shop/unsafe/filters:quality(90)/fptshop.com.vn/Uploads/images/2015/0511/Lenovo-Gaming-Legion-5-16IRX9-7.jpg" style="box-sizing: inherit; margin: 0px auto; padding: 0px; border: 0px; font-size: 16px; font-weight: 400; vertical-align: middle; background: 0px 0px; max-width: 100%; border-radius: 6px; width: 665px; height: auto !important; display: block;"></p></strong></p></div></div>')
GO
SET IDENTITY_INSERT [dbo].[PRODUCTS] OFF
GO
INSERT [dbo].[PROVIDED_USERS] ([user_id], [name], [email], [provider], [subject]) VALUES (8424, N'Hồ Nhật Tân', NULL, N'https://www.facebook.com', N'2050501595295196')
GO
INSERT [dbo].[PROVIDED_USERS] ([user_id], [name], [email], [provider], [subject]) VALUES (8425, N'Hồ Nhật Tân', NULL, N'https://www.google.com', N'109797169202293568077')
GO
INSERT [dbo].[PROVIDED_USERS] ([user_id], [name], [email], [provider], [subject]) VALUES (8426, N'Website bán laptop', NULL, N'https://www.google.com', N'102377724684428310442')
GO
SET IDENTITY_INSERT [dbo].[REVIEWS] ON 
GO
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (2, 33, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
GO
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (3, 27, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
GO
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (5, 24, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
GO
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (6, 32, 3002, 3, N'OK', CAST(N'2023-06-06T16:19:54.307' AS DateTime))
GO
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (7, 23, 3002, 2, N'OK', CAST(N'2023-06-06T16:19:54.307' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[REVIEWS] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (1999, N'Hồ Hiển', N'$2b$10$3kNqGWDDCJ2swQzZC2JcHeLZ9a.GvUTkD8hIwZH5hXK.eaY.9lRYW', N'imadoki.fa@gmail.com', N'admin', NULL, NULL, N'$2b$10$8qeAF6swA1b0WNwcFn1hFeUgwMBBTDFUhBZX5ji9lVkifYgXQcrRO', N'1', CAST(N'2024-03-03T16:03:33.463' AS DateTime), CAST(N'2024-03-03T16:03:33.463' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (2015, N'Nhật Tân', N'$2b$10$lsSsuZfs1Z4UzDE7kgVGfO/iDG3wxRR68Ms6T6oon5H7yMBocQL9O', N'admin@gmail.com', N'admin', NULL, N'0359973209', NULL, N'1', CAST(N'2024-03-03T16:03:33.463' AS DateTime), CAST(N'2024-03-03T16:03:33.463' AS DateTime), NULL, N'24')
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (3002, N'test1', N'$2b$10$6KIa/jjaannA7Xvs4knBF.j20HvQAWzutDs0OoX.XnP9gAlp1ATyi', N'test1@gmail.com', N'user', NULL, NULL, NULL, NULL, CAST(N'2024-03-03T16:03:33.463' AS DateTime), CAST(N'2024-03-03T16:03:33.463' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (3003, N'Hiếu', N'$2b$10$PC8QvkDXUGjdN0nmKOIqBe4rav5xNgpdpq41z4KBSCBW0MoyxIjDK', N'test3@gmail.com', N'user', NULL, NULL, NULL, NULL, CAST(N'2024-03-03T16:03:33.463' AS DateTime), CAST(N'2024-03-03T16:03:33.463' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7019, N'ADMIN', N'$2b$10$.ER6GYIwlZTDWzchWh89/uP4WlOTVNxHaIEE7zJr8KDRAgF0qWGf.', N'websitebanlaptop1212@gmail.com', N'admin', NULL, NULL, N'$2b$10$7nwDogUuP8mzcsuw3TvF/On.xAAHEAndfKPgC0QSRRw.CNhraHptK', N'1', CAST(N'2024-03-03T16:03:33.463' AS DateTime), CAST(N'2024-03-03T16:03:33.463' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7020, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-20T16:16:20.163' AS DateTime), CAST(N'2024-03-03T16:16:20.163' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7021, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-27T16:16:51.603' AS DateTime), CAST(N'2024-03-03T16:16:51.603' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7022, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-30T16:16:52.400' AS DateTime), CAST(N'2024-03-03T16:16:52.400' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7023, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-22T16:16:52.890' AS DateTime), CAST(N'2024-03-03T16:16:52.890' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7024, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-23T16:18:04.747' AS DateTime), CAST(N'2024-03-03T16:18:04.747' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7025, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-11T16:18:05.153' AS DateTime), CAST(N'2024-03-03T16:18:05.153' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7026, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-07T16:18:05.547' AS DateTime), CAST(N'2024-03-03T16:18:05.547' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7027, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-03T16:18:05.890' AS DateTime), CAST(N'2024-03-03T16:18:05.890' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7028, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-30T16:18:06.220' AS DateTime), CAST(N'2024-03-03T16:18:06.220' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7029, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-26T16:18:06.593' AS DateTime), CAST(N'2024-03-03T16:18:06.593' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7030, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-25T16:18:07.033' AS DateTime), CAST(N'2024-03-03T16:18:07.033' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7031, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-30T16:18:07.493' AS DateTime), CAST(N'2024-03-03T16:18:07.493' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7032, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-13T16:18:08.760' AS DateTime), CAST(N'2024-03-03T16:18:08.760' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7033, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-07T16:18:09.220' AS DateTime), CAST(N'2024-03-03T16:18:09.220' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7034, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.607' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7035, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7036, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7037, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7038, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7039, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7040, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7041, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7042, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7043, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7044, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7045, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7046, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7047, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7048, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7049, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7050, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7051, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7052, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7053, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.610' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7054, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7055, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7056, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7057, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7058, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7059, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7060, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7061, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7062, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7063, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.613' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7064, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7065, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7066, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7067, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7068, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7069, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7070, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7071, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7072, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7073, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7074, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7075, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7076, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7077, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7078, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7079, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7080, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7081, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7082, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7083, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7084, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7085, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7086, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7087, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7088, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7089, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7090, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7091, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7092, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7093, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7094, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7095, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7096, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7097, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7098, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7099, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7100, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7101, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7102, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7103, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.627' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7104, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7105, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7106, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7107, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7108, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7109, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7110, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7111, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7112, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7113, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-03-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7114, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7115, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7116, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7117, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7118, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7119, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7120, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7121, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7122, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7123, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7124, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7125, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7126, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7127, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7128, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7129, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7130, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7131, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7132, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7133, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7134, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7135, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7136, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7137, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7138, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7139, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7140, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7141, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7142, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7143, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7144, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7145, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7146, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.633' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7147, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7148, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7149, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7150, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7151, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7152, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7153, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7154, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7155, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7156, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7157, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7158, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7159, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7160, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7161, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7162, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7163, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7164, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7165, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7166, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7167, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7168, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7169, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7170, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7171, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.637' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7172, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7173, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7174, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7175, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7176, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7177, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7178, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7179, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7180, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7181, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7182, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7183, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7184, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7185, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7186, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7187, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7188, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7189, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7190, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7191, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-03-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7192, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7193, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7194, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7195, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7196, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7197, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7198, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7199, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7200, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7201, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7202, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7203, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7204, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7205, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7206, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7207, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7208, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7209, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7210, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7211, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7212, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7213, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7214, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7215, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7216, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7217, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7218, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7219, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7220, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7221, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7222, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7223, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7224, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.650' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7225, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.650' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7226, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.650' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7227, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.650' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7228, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.650' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7229, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7230, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7231, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7232, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7233, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7234, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7235, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7236, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7237, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7238, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7239, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7240, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7241, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7242, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7243, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7244, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7245, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7246, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7247, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7248, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7249, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7250, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7251, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7252, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7253, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7254, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7255, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.653' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7256, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7257, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7258, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7259, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7260, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7261, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7262, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7263, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7264, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7265, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7266, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7267, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7268, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7269, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7270, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7271, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7272, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7273, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7274, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7275, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7276, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7277, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7278, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7279, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7280, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7281, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-12-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7282, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7283, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7284, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7285, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7286, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7287, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.657' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7288, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7289, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7290, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7291, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7292, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7293, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7294, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7295, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7296, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-24T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7297, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7298, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7299, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7300, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7301, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-07T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7302, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7303, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7304, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7305, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7306, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-01-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7307, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-04-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7308, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7309, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7310, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7311, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7312, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-14T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7313, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7314, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7315, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7316, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7317, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7318, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7319, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7320, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7321, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7322, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7323, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7324, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7325, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7326, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7327, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7328, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7329, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-10T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7330, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7331, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7332, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7333, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-09-29T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7334, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7335, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7336, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7337, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7338, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-23T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.660' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7339, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7340, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7341, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-07-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7342, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7343, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-02T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7344, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7345, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7346, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7347, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-28T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.663' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7348, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.707' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7349, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-26T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.707' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7350, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.707' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7351, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7352, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-19T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7353, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-30T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7354, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7355, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7356, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7357, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7358, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-09T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7359, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7360, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-18T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7361, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-31T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7362, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7363, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2024-02-11T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7364, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7365, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7366, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7367, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-10-03T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7368, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7369, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-06T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7370, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-31T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7371, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-11-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7372, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-04-08T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7373, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7374, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7375, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7376, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-06-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7377, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7378, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-06-04T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7379, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-05T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7380, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-27T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7381, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7382, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7383, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-01-20T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7384, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.710' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7385, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-03-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7386, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-11-01T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7387, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-05-12T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7388, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-22T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7389, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-07-13T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7390, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-17T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7391, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-08-25T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7392, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-09-15T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7393, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-12-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7394, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2024-02-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7395, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-05-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7396, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-10-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7397, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'1', CAST(N'2023-08-21T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (7398, N'John Doe', N'password123', N'john.doe@example.com', N'user', N'local', N'1234567890', N'abc123def456', N'0', CAST(N'2023-03-16T16:19:57.607' AS DateTime), CAST(N'2024-03-03T16:19:57.713' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (8413, N'Nhật Tân', N'$2b$10$mzxf3XDZ5ReKDWUQ9BeeguPofrxE42ugtrYlo7cy3Ed21v4faqr2q', N'honhattan121@gmail.com', N'user', NULL, N'0359973209', N'$2b$10$vmCuCas2tDh3eQPs/BiGhewIVrJ3pAsi5T4bGfXWcyOR3ukqX8IYS', N'1', NULL, NULL, NULL, N'27')
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (8424, N'Hồ Nhật Tân', NULL, NULL, N'user', N'https://www.facebook.com', NULL, NULL, NULL, NULL, NULL, N'2050501595295196', NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (8425, N'Hồ Nhật Tân', NULL, NULL, N'user', N'https://www.google.com', NULL, NULL, NULL, NULL, NULL, N'109797169202293568077', NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (8426, N'Website bán laptop', NULL, NULL, N'user', N'https://www.google.com', NULL, NULL, NULL, NULL, NULL, N'102377724684428310442', NULL)
GO
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status], [created_at], [updated_at], [subject], [default_address]) VALUES (8427, N'Tân ', N'$2b$10$tl3E9RFooL0TKkE4cAytoeMvZFaLdKXH2Coyczwmrg5Qu83yYKndS', N'honhattan121212@gmail.com', N'user', NULL, NULL, N'$2b$10$4LFzsNR2uY1t45tU/7FDrO5sbtdD8TsM15whn0F/VGmYKdixaW146', N'0', NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
ALTER TABLE [dbo].[BRANDS] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[BRANDS] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[CATEGORIES] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CATEGORIES] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[PRODUCTS] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[PRODUCTS] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[CARTS]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[PRODUCTS] ([id])
GO
ALTER TABLE [dbo].[CARTS]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([id])
GO
ALTER TABLE [dbo].[DELIVERY_ADDRESS]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([id])
GO
ALTER TABLE [dbo].[IMAGES]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[PRODUCTS] ([id])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[ORDERS] ([id])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[PRODUCTS] ([id])
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([id])
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD FOREIGN KEY([brand_id])
REFERENCES [dbo].[BRANDS] ([brand_id])
GO
ALTER TABLE [dbo].[PRODUCTS]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[CATEGORIES] ([category_id])
GO
ALTER TABLE [dbo].[PROVIDED_USERS]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([id])
GO
ALTER TABLE [dbo].[REVIEWS]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[PRODUCTS] ([id])
GO
ALTER TABLE [dbo].[REVIEWS]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([id])
GO
USE [master]
GO
ALTER DATABASE [QUANLYBANLAPTOP] SET  READ_WRITE 
GO
