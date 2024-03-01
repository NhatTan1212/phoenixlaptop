USE [QUANLYBANLAPTOP]
GO
/****** Object:  Table [dbo].[BRANDS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[CARTS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[CATEGORIES]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[DELIVERY_ADDRESS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[IMAGES]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[ORDERS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVIDED_USERS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[REVIEWS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
/****** Object:  Table [dbo].[USERS]    Script Date: 3/1/2024 10:36:35 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'DELL', N'Dell là một công ty công nghệ đa quốc gia chuyên sản xuất máy tính và các thiết bị công nghệ thông tin khác.', CAST(N'2023-08-22T08:36:21.503' AS DateTime), CAST(N'2023-08-22T08:36:21.503' AS DateTime), N'http://localhost:8000/upload/dell.png', N'dell')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'MSI', N'MSI là một công ty công nghệ có trụ sở tại Đài Loan, chuyên sản xuất laptop, bo mạch chủ, và các sản phẩm gaming.', CAST(N'2023-08-22T08:36:27.777' AS DateTime), CAST(N'2023-08-22T08:36:27.777' AS DateTime), N'http://localhost:8000/upload/msi.png', N'msi')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'ASUS', N'ASUS là một công ty công nghệ Đài Loan nổi tiếng với các sản phẩm laptop, bo mạch chủ, điện thoại di động, và thiết bị gaming.', CAST(N'2023-08-22T08:36:47.613' AS DateTime), CAST(N'2023-08-22T08:36:47.613' AS DateTime), N'http://localhost:8000/upload/asus.png', N'asus')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'ACER', N'Acer là một công ty công nghệ của Đài Loan chuyên sản xuất laptop, máy tính bảng, và các sản phẩm điện tử tiêu dùng khác.', CAST(N'2023-08-22T08:36:52.253' AS DateTime), CAST(N'2023-08-22T08:36:52.253' AS DateTime), N'http://localhost:8000/upload/acer.png', N'acer')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'LENOVO', N'Lenovo là một công ty công nghệ Trung Quốc có trụ sở tại Bắc Kinh và Morrisville, chuyên sản xuất laptop, máy tính bảng, và máy tính cá nhân.', CAST(N'2023-08-22T08:37:00.953' AS DateTime), CAST(N'2023-08-22T08:37:00.953' AS DateTime), N'http://localhost:8000/upload/lenovo.png', N'lenovo')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'HP', N'HP (Hewlett-Packard) là một công ty công nghệ Mỹ chuyên sản xuất máy in, máy tính cá nhân, laptop, và thiết bị văn phòng.', CAST(N'2023-08-22T08:37:15.767' AS DateTime), CAST(N'2023-08-22T08:37:15.767' AS DateTime), N'http://localhost:8000/upload/hp.png', N'hp')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'LG', N'LG là một công ty điện tử tiêu dùng và công nghệ đa quốc gia của Hàn Quốc, sản xuất các sản phẩm từ điện tử gia dụng đến smartphone.', CAST(N'2023-08-22T08:37:21.980' AS DateTime), CAST(N'2023-08-22T08:37:21.980' AS DateTime), N'http://localhost:8000/upload/lg.png', N'lg')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'MICROSOFT', N'Microsoft là một công ty công nghệ Mỹ, nổi tiếng với hệ điều hành Windows, Office, và các dịch vụ và sản phẩm công nghệ khác.', CAST(N'2023-08-22T08:38:28.877' AS DateTime), CAST(N'2023-08-22T08:38:28.877' AS DateTime), N'http://localhost:8000/upload/microsoft.png', N'microsoft')
INSERT [dbo].[BRANDS] ([name], [description], [created_at], [updated_at], [image], [slug]) VALUES (N'MACBOOK', N'MacBook là dòng sản phẩm laptop của Apple, chạy hệ điều hành macOS, nổi tiếng với thiết kế đẹp và hiệu suất ổn định.', CAST(N'2023-08-29T09:50:19.780' AS DateTime), CAST(N'2023-08-29T09:50:19.780' AS DateTime), N'http://localhost:8000/upload/macbook.png', N'macbook')
GO
SET IDENTITY_INSERT [dbo].[CARTS] ON 

INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 24, N'Dell Inspirion 15', N'Thiet ke hien dai dep de, tre trung', N'1683708021359-dellinspirion.png', 4000000, 12, 3, 12000000, CAST(N'2023-06-04T21:48:07.283' AS DateTime), CAST(N'2023-07-12T21:41:07.373' AS DateTime), 6, NULL)
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 32, N'Laprtop Dell XPS 15 9520', N'Intel Core i7 12700H, Ram 16GB, SSD 1TB, VGA Nvidia GeForce RTX 3050Ti 44GB GDDR6, 15.6inch Full HD, Windows 11 Home, Vỏ nhôm nguyên khối màu bạc, Hàng chính hãng , Bảo hành 12 Tháng', N'1683865425452-Laprtop Dell XPS 15 9520.jpg', 58500000, 12, 2, 117000000, CAST(N'2023-06-06T16:16:57.587' AS DateTime), CAST(N'2023-06-06T16:16:57.587' AS DateTime), 7, NULL)
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 23, N'Dell Vostro', N'Dell Vostro 2022', N'1683707853284-dellvostro.png', 500000, 11, 2, 1000000, CAST(N'2023-07-06T07:31:17.250' AS DateTime), CAST(N'2023-07-06T07:31:21.160' AS DateTime), 8, NULL)
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (3002, 25, N'HP A1503ZA', N'Thiet ke hien dai dep de, tre trung', N'1683708160360-hp-a1503za.png', 20000000, 11, 1, 20000000, CAST(N'2023-07-12T13:50:46.663' AS DateTime), CAST(N'2023-07-12T13:50:46.663' AS DateTime), 13, NULL)
INSERT [dbo].[CARTS] ([user_id], [product_id], [prod_name], [description], [avatar], [price], [is_possible_to_order], [count], [product_total], [created_at], [updated_at], [id], [guest_id]) VALUES (5004, 26, N'MacBook Air M1 2020', N'MacBook Air M1 2020', N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 21900000, 11, 1, 21900000, CAST(N'2023-11-02T12:09:17.523' AS DateTime), CAST(N'2023-11-02T12:09:17.523' AS DateTime), 1068, NULL)
SET IDENTITY_INSERT [dbo].[CARTS] OFF
GO
SET IDENTITY_INSERT [dbo].[CATEGORIES] ON 

INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (1, N'Laptop Gaming', N'Laptop Gaming', CAST(N'2023-06-08T14:52:47.057' AS DateTime), CAST(N'2024-02-24T22:57:02.973' AS DateTime), N'laptop-gaming')
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (2, N'Laptop Văn Phòng', N'Laptop Văn Phòng', CAST(N'2023-08-22T08:20:28.473' AS DateTime), CAST(N'2023-08-22T08:20:28.473' AS DateTime), N'laptop-vanphong')
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (3, N'Laptop Cao Cấp - Sang Trọng', N'Laptop Cao Cấp - Sang Trọng', CAST(N'2023-08-22T08:20:50.647' AS DateTime), CAST(N'2023-08-22T08:20:50.647' AS DateTime), N'laptop-caocap-sangtrong')
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (4, N'Laptop Đồ Họa - Kỹ Thuật', N'Laptop Đồ Họa - Kỹ Thuật', CAST(N'2023-08-22T08:21:44.203' AS DateTime), CAST(N'2023-08-22T08:21:44.203' AS DateTime), N'laptop-dohoa-kythuat')
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (5, N'Laptop Mỏng Nhẹ - Thời Trang', N'Laptop Mỏng Nhẹ - Thời Trang', CAST(N'2023-08-22T08:23:41.190' AS DateTime), CAST(N'2023-08-22T08:23:41.190' AS DateTime), N'laptop-mongnhe-thoitrang')
INSERT [dbo].[CATEGORIES] ([category_id], [name], [description], [created_at], [updated_at], [slug]) VALUES (8, N'Laptop Giá Rẻ', N'Laptop Giá Rẻ', CAST(N'2024-02-29T19:57:07.910' AS DateTime), CAST(N'2024-02-29T19:57:07.910' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[CATEGORIES] OFF
GO
SET IDENTITY_INSERT [dbo].[DELIVERY_ADDRESS] ON 

INSERT [dbo].[DELIVERY_ADDRESS] ([id], [user_id], [detail_address], [province], [district], [ward]) VALUES (1, 2015, N'39/46 Cù Chính Lan', N'Thành phố Đà Nẵng', N'Quận Thanh Khê', N'Phường Hòa Khê')
SET IDENTITY_INSERT [dbo].[DELIVERY_ADDRESS] OFF
GO
SET IDENTITY_INSERT [dbo].[IMAGES] ON 

INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (1018, 1034, N'http://localhost:8000/upload/laptop-hp-victus-16-fullsz.png', N'http://localhost:8000/upload/laptop-hp-victus-16-fullsz.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2021, 1034, NULL, N'http://localhost:8000/upload/1695746410040-1695746295892-laptop-hp-victus-16-2.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2022, 1034, NULL, N'http://localhost:8000/upload/1695746410040-1695746333687-1695745919554-laptop-hp-victus-16-3.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2023, 1034, NULL, N'http://localhost:8000/upload/1695746410041-1695743480946-laptop-hp-victus-16-4.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2024, 1034, NULL, N'http://localhost:8000/upload/1695746410041-1695743480947-laptop-hp-victus-16-5.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2027, 24, NULL, N'http://localhost:8000/upload/1695746554027-1683708021359-dellinspirion.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2028, 25, NULL, N'http://localhost:8000/upload/1695746558978-1683708160360-hp-a1503za.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2029, 26, NULL, N'http://localhost:8000/upload/1695746563393-1683708250019-macbook-air-m1-2020.png')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2030, 27, NULL, N'http://localhost:8000/upload/1695746572831-1683863062655-29171-laptop_asus_gaming_rog.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2031, 31, NULL, N'http://localhost:8000/upload/1695746582113-1690807304036-2320_laptopaz_acer_nitro_5_an515_57_1.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2032, 32, NULL, N'http://localhost:8000/upload/1695746590098-1683865425452-Laprtop Dell XPS 15 9520.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2033, 35, NULL, N'http://localhost:8000/upload/1695746606854-1690802127060-acer_nitro5_515_56.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2043, 33, NULL, N'http://localhost:8000/upload/1695788712824-Laptop LG Gram Style 2023 16Z90RS-G.AH54A5.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2044, 33, NULL, N'http://localhost:8000/upload/1695788712826-lg-gram-style-2023-i5-16z90rsgah54a5-1.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2045, 33, NULL, N'http://localhost:8000/upload/1695788712827-lg-gram-style-2023-i5-16z90rsgah54a5-4.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2046, 33, NULL, N'http://localhost:8000/upload/1695788712826-lg-gram-style-2023-i5-16z90rsgah54a5-2.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (2047, 33, NULL, N'http://localhost:8000/upload/1695788776744-lg-gram-style-2023-i5-16z90rsgah54a5-3.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3041, 34, NULL, N'http://localhost:8000/upload/1695918142885-1690645379602-macbookpro14.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3048, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-1.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3049, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-5.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3050, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-2.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3051, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-3.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3052, 23, NULL, N'http://localhost:8000/upload/1705065632197-dell-vostro-i5-4.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3063, 2043, NULL, N'http://localhost:8000/upload/1705379345655-msi-1.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3064, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-2.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3065, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-3.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3066, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-4.jpg')
INSERT [dbo].[IMAGES] ([image_id], [product_id], [image_url], [url]) VALUES (3067, 2043, NULL, N'http://localhost:8000/upload/1705379345657-msi-5.jpg')
SET IDENTITY_INSERT [dbo].[IMAGES] OFF
GO
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 15033, 1, 21900000, CAST(N'2024-02-24T23:15:55.140' AS DateTime), CAST(N'2024-02-24T23:15:55.140' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 15034, 5, 19690000, CAST(N'2024-02-27T12:19:13.017' AS DateTime), CAST(N'2024-02-27T12:19:13.017' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 15034, 1, 21900000, CAST(N'2024-02-29T19:52:49.780' AS DateTime), CAST(N'2024-02-29T19:52:49.780' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (35, 15034, 1, 17999000, CAST(N'2024-02-29T19:52:49.783' AS DateTime), CAST(N'2024-02-29T19:52:49.783' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (24, 15035, 1, 19690000, CAST(N'2024-03-01T10:27:57.770' AS DateTime), CAST(N'2024-03-01T10:27:57.770' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 15035, 1, 21900000, CAST(N'2024-03-01T10:27:57.773' AS DateTime), CAST(N'2024-03-01T10:27:57.773' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (25, 15025, 1, 20000000, CAST(N'2023-10-27T06:38:06.680' AS DateTime), CAST(N'2023-10-27T06:38:06.680' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (25, 15026, 1, 20000000, CAST(N'2023-10-29T05:47:46.470' AS DateTime), CAST(N'2023-10-29T05:47:46.470' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (33, 15026, 1, 43990000, CAST(N'2023-10-29T05:47:46.480' AS DateTime), CAST(N'2023-10-29T05:47:46.480' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 15026, 1, 20990000, CAST(N'2023-10-29T05:47:46.483' AS DateTime), CAST(N'2023-10-29T05:47:46.483' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (33, 15030, 1, 43990000, CAST(N'2023-11-02T11:28:08.057' AS DateTime), CAST(N'2023-11-02T11:28:08.057' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (1034, 15030, 1, 20990000, CAST(N'2023-11-02T11:28:08.063' AS DateTime), CAST(N'2023-11-02T11:28:08.063' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (26, 15031, 1, 21900000, CAST(N'2023-11-02T12:09:48.550' AS DateTime), CAST(N'2023-11-02T12:09:48.550' AS DateTime))
INSERT [dbo].[ORDER_DETAILS] ([product_id], [order_id], [quantity], [price], [created_at], [updated_at]) VALUES (27, 14026, 1, 125000000, CAST(N'2023-10-25T19:24:58.047' AS DateTime), CAST(N'2023-10-25T19:24:58.047' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ORDERS] ON 

INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (14014, N'COD', 4000000, 5004, N'Bí mật', N'honhattan121@gmail.com', N'123 Hoàng Diệu, Phường Nhật Tân, Quận Tây Hồ, Thành phố Hà Nội', N'0123456789', N'0', 0, 0, 0, CAST(N'2023-10-24T11:33:35.603' AS DateTime), CAST(N'2023-10-24T11:33:35.603' AS DateTime), NULL, N'user', NULL, N'http://localhost:8000/upload/1694141619104-dellinspirion.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (14026, N'Bank', 125000000, 5004, N'hi', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 1, 0, 1, CAST(N'2023-10-25T19:24:58.037' AS DateTime), CAST(N'2023-10-25T19:24:58.037' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807275761-29171-laptop_asus_gaming_rog.jpg', 1, 1, CAST(N'2024-02-14T13:15:15.363' AS DateTime), CAST(N'2024-02-14T13:15:15.370' AS DateTime), NULL, CAST(N'2024-02-15T09:54:07.757' AS DateTime), CAST(N'2024-02-14T13:15:15.360' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15025, N'COD', 20000000, 5004, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'Nhận hàng tại cửa hàng', N'0359973209', N'0', 1, 0, 1, CAST(N'2023-10-27T06:38:06.660' AS DateTime), CAST(N'2023-10-27T06:38:06.660' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807254756-hp-a1503za.png', 1, NULL, CAST(N'2024-01-16T16:20:08.650' AS DateTime), NULL, NULL, CAST(N'2024-01-16T16:20:08.660' AS DateTime), CAST(N'2024-01-16T16:20:08.640' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15026, N'COD', 84980000, 5004, N'Hồ Nhật Tân', N'honhattan121@gmail.com', N'123 ĐBP, Phường An Mỹ, Thành phố Tam Kỳ, Tỉnh Quảng Nam', N'0359973209', N'0', 0, 0, 0, CAST(N'2023-10-29T05:47:46.437' AS DateTime), CAST(N'2023-10-29T05:47:46.437' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807254756-hp-a1503za.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15030, N'Bank', 64980000, 5004, N'Tân', N'honhattan121@gmail.com', N'362 Hoàng Diệu, Phường Bình Thuận, Quận Hải Châu, Thành phố Đà Nẵng', N'0359973209', N'0', 1, 1, 1, CAST(N'2023-11-02T11:28:08.043' AS DateTime), CAST(N'2023-11-02T11:28:08.043' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807324890-Laptop LG Gram Style 2023 16Z90RS-G.AH54A5.jpg', 1, 1, CAST(N'2024-02-15T09:20:15.030' AS DateTime), CAST(N'2024-02-15T09:20:35.477' AS DateTime), CAST(N'2024-02-15T09:20:39.940' AS DateTime), CAST(N'2024-02-15T09:21:25.947' AS DateTime), CAST(N'2023-11-02T11:28:30.697' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15031, N'Bank', 21900000, 5004, N'test', N'test@gmail.com', N'123, Xã Pải Lủng, Huyện Mèo Vạc, Tỉnh Hà Giang', N'0', N'0', 1, 1, 0, CAST(N'2023-11-02T12:09:48.533' AS DateTime), CAST(N'2023-11-02T12:09:48.533' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 1, 1, CAST(N'2023-11-02T21:27:08.760' AS DateTime), CAST(N'2023-11-02T21:27:08.763' AS DateTime), CAST(N'2024-02-15T09:26:54.007' AS DateTime), NULL, CAST(N'2023-11-02T21:27:08.743' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15033, N'COD', 21900000, 1999, N'Hồ Thanh Hiển', N'imadoki.fa@gmail.com', N'39/46 Cù Chính Lan, Phường Hòa Khê, Quận Thanh Khê, Thành phố Đà Nẵng', N'0354086520', N'0', 0, 0, 0, CAST(N'2024-02-24T23:15:55.130' AS DateTime), CAST(N'2024-02-24T23:15:55.130' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 1, 1, CAST(N'2024-02-24T23:18:42.443' AS DateTime), CAST(N'2024-02-24T23:18:37.863' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15034, N'COD', 98450000, 1999, N'Ho Thanh Hien', N'imadoki.fa@gmail.com', N'21 đường số 7, Xã Điện Phong, Thị xã Điện Bàn, Tỉnh Quảng Nam', N'0354086520', N'0', 1, 1, 1, CAST(N'2024-02-27T12:19:13.003' AS DateTime), CAST(N'2024-02-27T12:19:13.003' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1694141619104-dellinspirion.png', 1, 1, CAST(N'2024-02-27T12:20:22.250' AS DateTime), CAST(N'2024-02-27T12:20:45.527' AS DateTime), CAST(N'2024-02-27T12:20:50.597' AS DateTime), CAST(N'2024-02-27T12:20:57.770' AS DateTime), CAST(N'2024-02-27T12:21:02.917' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ORDERS] ([id], [paymentMethods], [total], [user_id], [name], [email], [user_address], [phone], [trading_code], [is_payment], [is_transported], [is_success], [created_at], [updated_at], [is_rated], [note], [guest_id], [avatar], [is_approved], [is_being_shipped], [approved_at], [being_shipped_at], [transported_at], [successful_at], [paid_at], [vnp_TransactionNo], [vnp_OrderInfo], [vnp_CardType], [vnp_BankCode], [vnp_PayDate]) VALUES (15035, N'VNPAY', 41590000, 2015, N'Hồ Thanh Hiển', N'imadoki.fa@gmail.com', N'39/46 Cù Chính Lan, Phường Hòa Khê, Quận Thanh Khê, Thành phố Đà Nẵng', N'0354086520', N'0', 1, 0, 0, CAST(N'2024-03-01T10:27:57.747' AS DateTime), CAST(N'2024-03-01T10:27:57.747' AS DateTime), NULL, N'', NULL, N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', 0, 0, NULL, NULL, NULL, NULL, CAST(N'2024-03-01T10:27:47.000' AS DateTime), N'14310015', N'Thanh toan cho ma GD:01102737', N'ATM', N'NCB', N'2024-03-01 10:27:47')
SET IDENTITY_INSERT [dbo].[ORDERS] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTS] ON 

INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (23, 1, 1, N'Dell Vostro V5620 i5 1240P', N'http://localhost:8000/upload/1705125871316-dell-vostro-i5-1.jpg', N'Laptop Dell Vostro V5620 i5 1240P/8GB/512GB/16"FHD+/Nvidia MX570 2GB/Win11', NULL, 18990000, 21490000, 13, 0, N'Intel,Core i5,1240P,3.30 GHz,	4.50 GHz', N'SSD,	M2. PCIe,512 GB', NULL, N'16.0 inch,Anti-Glare LED-Backlit Display,1920 x 1200 Pixels,60 Hz ,WVA', N' Full HD Webcam (1080p Webcam)', N'1 HDMI-1 USB 3.2,802.11 ax ,v5.2', N'1.97 kg', N'3420 mAh', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'	8 GB (1 thanh 8 GB),DDR4,2 ,1,0,32 GB', N'GeForce MX570, 2 GB')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (24, 1, 1, N'Dell Inspirion 15', N'http://localhost:8000/upload/1694141619104-dellinspirion.png', N'Laptop Dell Inspiron 15 N3520 - i7 1255U/RAM 8GB/SSD 512GB/15.6"FHD/Win11', NULL, 19690000, 20690000, 11, 15, N'Intel, Core i7, 1255U', N'SSD 512GB', NULL, N'15.6 inch, 1920 x 1080 Pixels, WVA, 120, WVA Anti-glare LED Backlit Narrow Border', N'1.6MGp', N'Wifi, AirPlay', N'1.7kg', N'54 Wh', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'8GB', N'GeForce MX550')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (25, 6, 1, N'HP A1503ZA', N'http://localhost:8000/upload/1690807254756-hp-a1503za.png', N'HP A1503ZA', NULL, 20000000, 22000000, 11, 10, N'Intel, Core i5, 10300h', N'ssd 512Gb', NULL, N'FullHd', N'1.6MGp', N'Wifi, AirPlay', N'2kg', N'3 Cell', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'8GB', N'GeForce MX550')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (26, 9, 1, N'MacBook Air M1 2020', N'http://localhost:8000/upload/1690807261763-macbook-air-m1-2020.png', N'MacBook Air M1 2020', NULL, 21900000, 22900000, 9, 15, N'Apple, M1', N'ssd 512Gb', NULL, N'FullHd', N'1.6MGp', N'Wifi, AirPlay', N'2kg', N'3 Cell', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'null', N'null')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (27, 3, 1, N'Laptop Gaming Asus ROG Strix SCAR 18 G834JY-N6039W', N'http://localhost:8000/upload/1690807275761-29171-laptop_asus_gaming_rog.jpg', N'Laptop Gaming Asus ROG Strix SCAR 18 G834JY-N6039W Intel Core i9-13980HX, RAM 64GB, SSD 2TB, RTX 4090 16GB, Màn Hình 18 inch QHD+ 240Hz, Windows 11, Màu Đen', NULL, 125000000, 129000000, 25, 10, N'Intel, Core i9, 13980HX (upto 5.60 GHz, 36MB)', N'2TB PCIe 4.0 NVMe M.2 SSD', NULL, N'18 inch WQXGA (2560 x 1600) 16:10, 240Hz, 3ms, IPS-level, DCI-P3 100%, anti-glare display, G-Sync, ROG Nebula Display', N'720p HD Camera', N'Wifi, AirPlay', N'2kg', N'4 Cell 90WHrs', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'64 GB,DDR5, 4800 MHz, 2, Không, 0, 64 GB', N'	NVIDIA GeForce RTX 4090,16 GB GDDR6 - Intel,	UHD')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (31, 4, 1, N'Laptop Gaming Acer Nitro 5 2021 AN515-57', N'http://localhost:8000/upload/1690807304036-2320_laptopaz_acer_nitro_5_an515_57_1.jpg', N'Laptop Gaming Acer Nitro 5 2021 AN515-57 I5-10300h SSD 512Gb', NULL, 16000000, 21900000, 30, 10, N'Intel,Core i5, 10300h', N'ssd 512Gb', NULL, N'FullHd', N'1.6MGp', N'Wifi, AirPlay', N'2.5kg', N'3 Cell', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'8 GB (1 thanh 8 GB), DDR4, 3200 MHz', N'NVIDIA GeForce RTX 3050, 4GB')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (32, 1, 1, N'Laprtop Dell XPS 15 9520', N'http://localhost:8000/upload/1690807317488-Laprtop_Dell_XPS_15_9520.jpg', N'Laprtop Dell XPS 15 9520 Intel Core i7 12700H, Ram 16GB, SSD 1TB, VGA Nvidia GeForce RTX 3050Ti 44GB GDDR6, 15.6inch Full HD, Windows 11 Home, Vỏ nhôm nguyên khối màu bạc, Hàng chính hãng , Bảo hành 12 Tháng', NULL, 58500000, 59900000, 12, 10, N'Intel, Core i7, 12700H', N'SSD 1TB', NULL, N'15.6inch Full HD', N'Có', N'Wifi, AirPlay', N'null', N'6 cell', N'Window 11 Home', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N', DDR4 2933 MHz', N'Intel UHD Graphics, Share')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (33, 7, 1, N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5', N'http://localhost:8000/upload/1690807324890-Laptop_LG_Gram_Style_2023_16Z90RS-G.AH54A5.jpg', N'Laptop LG Gram Style 2023 16Z90RS-G.AH54A5 Intel Core i5-1340P, RAM 16GB, SSD 512GB, VGA Intel Iris Xe Graphics, Màn Hình 16inch WQHD+ OLED 120Hz, Windows 11', NULL, 43990000, 44990000, 27, 15, N'Intel, Core i5, 1340P', N'512GB M.2 NVMe™ PCIe® 4.0 SSD (2 slot, còn trống 1 khe M.2)', NULL, N'16inch WQHD+ OLED 120Hz', N'Webcam IR FHD IR with Dual Mic', N'Wifi, AirPlay', N'null', N'80WHr', N'Window 11', CAST(N'2023-07-30T10:05:37.327' AS DateTime), CAST(N'2023-07-30T10:05:37.327' AS DateTime), N'16 GB (1 thanh 16 GB), DDR5 6000 MHz', N' Intel Iris Plus Graphics')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (34, 9, 1, N'MacBook Pro 14 inch M2 Pro 2023 ', N'http://localhost:8000/upload/1690807519733-macbookpro14.jpg', N'MacBook Pro 14 inch M2 Pro 2023 10CPU 16GPU 32GB/512GB', NULL, 57490000, 63990000, 29, 12, N'Apple, M2 Pro, 10-Core', N'SSD 512 GB', NULL, N'14.2 inch, Retina,3024 x 1964 Pixels,	120 Hz', N'Full HD Webcam (1080p Webcam)', N'1 HDMI, 3 Type C, 1 Jack 3.5 mm', N'null', N'Lithium polymer 67 W', N'Ventura', CAST(N'2023-07-30T10:28:44.363' AS DateTime), CAST(N'2023-07-30T10:28:44.363' AS DateTime), N'32 GB', N'Apple M1')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (35, 4, 1, N'Laptop Acer Nitro Gaming AN515 56 51N4', N'http://localhost:8000/upload/1690802127060-acer_nitro5_515_56.jpg', N'Laptop Acer Nitro Gaming AN515 56 51N4 i5 11300H/8GB/512GB SSD/Nvidia GTX1650 4GB/Win11', NULL, 17999000, 19798900, 0, 15, N'Intel, Core i5, 11300H', N'ssd 512Gb', NULL, N'15.6 inch, 1920 x 1080 Pixels, 144 Hz', N'HD webcam', N'USB Type-C  Jack tai nghe 3.5 mm  3 x USB 3.2  HDMI  LAN (RJ45)', N'null', N'4-cell Li-ion, 57.5 Wh', N'Window 11', CAST(N'2023-07-31T18:15:27.113' AS DateTime), CAST(N'2023-07-31T18:15:27.113' AS DateTime), N'8 GB (1 thanh 8 GB), ,3200 MHz', N'NVIDIA GeForce GTX 1650, 4GB-Intel Iris Xe Graphics')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (1034, 6, 1, N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) ', N'http://localhost:8000/upload/1695519558964-laptop-hp-victus-16-fullsz.png', N'Laptop HP VICTUS 16-e1105AX(7C0T0PA) (AMD Ryzen 5-6600H, Ram 16GB, SSD 512GB, Đồ họa RTX 3050Ti 4GB, màn hình 16.1 inch FHD, Windows 11 bản quyền, màu xanh)', NULL, 20990000, 27990000, 3, 25, N'AMD, Ryzen 5,6600H (up to 4.50 GHz/ 6 nhân/ 12 luồng/16MB)', N' 512GB PCIe NVMe TLC M.2 SSD', NULL, N'16.1 inch, FullHD (1920 x 1080), 144Hz', N'HP Wide Vision 720p HD camera with integrated dual array digital microphones', N'Intel Wi-Fi 6E AX211 (2x2), Bluetooth® 5.3 compatible combo (supporting gigabit data rate)', N'2.5kg', N'4-cell, 70 Wh Li-ion polymer', N' Windows 11 Home 64', CAST(N'2023-08-29T11:31:11.667' AS DateTime), CAST(N'2023-08-29T11:31:11.667' AS DateTime), N'8 GB (1 thanh 8 GB), DDR5, 4800 MHz', N' NVIDIA GeForce RTX 3050, 4GB')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (2043, 2, 1, N'MSI Gaming Thin GF63 12VE-454VN i5 12450H', N'http://localhost:8000/upload/1705379345655-msi-1.jpg', N'Laptop MSI Gaming Thin GF63 12VE-454VN i5 12450H/16GB/512GB/15.6" FHD/GeForce RTX 4050 6GB/Win 11', NULL, 20490000, 22990000, 5, 0, N'Intel, Core i5, 12450H', N'SSD 512 GB', NULL, N'15.6 inch, IPS FHD, 1920 x 1080 Pixels, Màn hình phẳng, 144 Hz, IPS, 45% NTSC', N'HD Webcam (720p Webcam)', N'1 DC-in jack 1 HDMI 1 Jack 3.5 mm 1 LAN 1 Type C 1 Type C 3 USB 3.2, Wifi 6', N'1.86kg', N'52.4 Wh', N'Windows 11 Home', CAST(N'2024-01-16T11:29:05.740' AS DateTime), CAST(N'2024-01-16T11:29:05.740' AS DateTime), N'16 GB, DDR4, 3200 MHz', N'NVIDIA GeForce RTX 4050, 6GB GDDR6 - Intel Iris Xe Graphics')
INSERT [dbo].[PRODUCTS] ([id], [brand_id], [category_id], [prod_name], [avatar], [prod_description], [manufacturer], [price], [cost], [quantity], [prod_percent], [cpu], [hard_drive], [mux_switch], [screen], [webcam], [connection], [prod_weight], [pin], [operation_system], [created_at], [updated_at], [ram], [graphics]) VALUES (2045, 3, 1, N'2023 ROG Strix SCAR 17 (G733PZ-LL980W)', N'http://localhost:8000/upload/1708793134388-03_real_scar_g733_17_l.jpg', N'2023 ROG Strix SCAR 17 G733PZ-LL980W (AMD Ryzen 9 7945HX, RTX 4080)
', NULL, 60990000, 66990000, 25, 10, N'AMD Ryzen™ 9 7945HX', N'1TB PCIe® 4.0 NVMe™ M.2 SSD', NULL, N'17.3" WQHD (2560 x 1440) tỉ lệ 16:9 240Hz/3ms, chống chói, G-Sync', N'Có', N'1x 2.5G LAN port 1x USB 3.2 Gen 2 Type-C support DisplayPort™ / G-SYNC 1x USB 3.2 Gen 2 Type-C support DisplayPort™ / power delivery / G-SYNC 2x USB 3.2 Gen 1 Type-A', N'3kg', N'90WHrs, 4S1P, 4-cell Li-ion', N'Windows 11 Home', CAST(N'2024-02-24T23:45:34.430' AS DateTime), CAST(N'2024-02-24T23:45:34.430' AS DateTime), N'16GB DDR5-4800 SO-DIMM *2', N'NVIDIA® GeForce RTX™ 4080')
SET IDENTITY_INSERT [dbo].[PRODUCTS] OFF
GO
SET IDENTITY_INSERT [dbo].[REVIEWS] ON 

INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (1, 31, 3002, 5, N'Ngon', CAST(N'2023-06-05T17:04:22.840' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (2, 33, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (3, 27, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (4, 31, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (5, 24, 3002, 5, N'Máy tính mới, xịn', CAST(N'2023-06-05T17:26:40.573' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (6, 32, 3002, 3, N'OK', CAST(N'2023-06-06T16:19:54.307' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (7, 23, 3002, 2, N'OK', CAST(N'2023-06-06T16:19:54.307' AS DateTime))
INSERT [dbo].[REVIEWS] ([review_id], [product_id], [user_id], [rating], [comment], [created_at]) VALUES (14, 24, 5004, 2, N'Cũng tạm', CAST(N'2023-07-06T07:44:48.303' AS DateTime))
SET IDENTITY_INSERT [dbo].[REVIEWS] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (1999, N'Hồ Hiển', N'$2b$10$t1eQW.xV4H6Kb2RPtj3Ng.CIMTY4EmN1O9lIEwZBlNFZr03yJNiGC', N'imadoki.fa@gmail.com', N'admin', NULL, NULL, N'$2b$10$8qeAF6swA1b0WNwcFn1hFeUgwMBBTDFUhBZX5ji9lVkifYgXQcrRO', N'1')
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (2015, N'Hồ Nhật Tân', N'$2b$10$Bu08cYmxfA/jH7k.F/76ae5scS0iE/4jZCx8b6.29t41uXNNtb8WO', N'admin@gmail.com', N'admin', NULL, N'0359973209', NULL, N'1')
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (3002, N'test1', N'$2b$10$6KIa/jjaannA7Xvs4knBF.j20HvQAWzutDs0OoX.XnP9gAlp1ATyi', N'test1@gmail.com', N'user', NULL, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (3003, N'Hiếu', N'$2b$10$PC8QvkDXUGjdN0nmKOIqBe4rav5xNgpdpq41z4KBSCBW0MoyxIjDK', N'test3@gmail.com', N'user', NULL, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (5004, N'Nhật Tân', N'$2b$10$lOoVnS8Gu8RoBJb0SLMUUO4Yjl0K1WYvbmaZDxtO2Sqn7D/X73ik2', N'honhattan121@gmail.com', N'user', NULL, NULL, NULL, N'1')
INSERT [dbo].[USERS] ([id], [name], [password], [email], [role], [provider], [phone], [registration_token], [confirmation_status]) VALUES (7019, N'ADMIN', N'$2b$10$.ER6GYIwlZTDWzchWh89/uP4WlOTVNxHaIEE7zJr8KDRAgF0qWGf.', N'websitebanlaptop1212@gmail.com', N'admin', NULL, NULL, N'$2b$10$7nwDogUuP8mzcsuw3TvF/On.xAAHEAndfKPgC0QSRRw.CNhraHptK', N'1')
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
