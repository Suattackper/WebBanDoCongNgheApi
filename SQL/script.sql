USE [webapidemo]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountCode] [int] IDENTITY(1,1) NOT NULL,
	[Password] [varchar](255) NULL,
	[Email] [varchar](30) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Avatar] [image] NULL,
	[RequestCode] [nvarchar](512) NULL,
	[CreateAt] [datetime] NULL,
	[RoleID] [int] NULL,
	[Update_By] [nvarchar](256) NULL,
	[Update_At] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountAddress]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountAddress](
	[AccountAddressCode] [int] IDENTITY(1,1) NOT NULL,
	[AccountCode] [int] NULL,
	[FullName] [nvarchar](50) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[PostalCode] [varchar](20) NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountAddressCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[BrandCode] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](100) NULL,
	[Origin] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BrandCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[AccountCode] [int] NOT NULL,
	[ProductCode] [varchar](15) NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[BrandCode] [int] NULL,
	[CategoryCode] [int] NULL,
	[ImageProduct] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[PromotionCode] [char](10) NULL,
	[Quantity] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[Rate] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountCode] ASC,
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryCode] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentCode] [int] IDENTITY(1,1) NOT NULL,
	[AccountCode] [int] NULL,
	[ProductCode] [varchar](15) NULL,
	[CommentContent] [nvarchar](max) NULL,
	[CommentTime] [smalldatetime] NULL,
	[Rate] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactCode] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](45) NULL,
	[Email] [varchar](30) NULL,
	[Status] [bit] NULL,
	[ContactDate] [datetime] NULL,
	[Message] [varchar](1000) NULL,
	[AccountCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[DeliveryCode] [varchar](10) NOT NULL,
	[DeliveryName] [nvarchar](50) NULL,
	[PriceTotal] [money] NULL,
	[DeliveryFee] [money] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliveryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderCode] [int] NOT NULL,
	[ProductCode] [varchar](15) NOT NULL,
	[Price] [money] NULL,
	[Quantity] [int] NULL,
	[Total] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductCode] ASC,
	[OrderCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderCode] [int] IDENTITY(1,1) NOT NULL,
	[PaymentCode] [int] NULL,
	[AccountCode] [int] NULL,
	[PromotionCode] [char](10) NULL,
	[OrderDate] [date] NULL,
	[Delivered] [bit] NULL,
	[DeliveryDate] [date] NULL,
	[OrderTotal] [money] NULL,
	[OrderNote] [nvarchar](100) NULL,
	[AccountAddressCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentCode] [int] IDENTITY(1,1) NOT NULL,
	[PaymentType] [varchar](20) NULL,
	[AccountNumer] [varchar](20) NULL,
	[ExpiryDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductCode] [varchar](15) NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[BrandCode] [int] NULL,
	[CategoryCode] [int] NULL,
	[ImageProduct] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[PromotionCode] [char](10) NULL,
	[Quantity] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[Rate] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImg]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImg](
	[ProductImgCode] [int] IDENTITY(1,1) NOT NULL,
	[Img] [nvarchar](max) NULL,
	[ProductCode] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductImgCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionCode] [char](10) NOT NULL,
	[PromotionPercentage] [int] NULL,
	[EndDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PromotionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14/05/2024 21:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (1, N'b2b04af9f8f3ab06229e03ac8d3c24ca', N'k@gmail.com', NULL, N'Tân', N'Nguyễn', NULL, NULL, CAST(N'2024-04-03T21:19:22.887' AS DateTime), 3, N'k@gmail.com', CAST(N'2024-04-03T21:19:22.887' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (3, N'jj', N'jj@gmail.com', NULL, N'jj', N'jj', NULL, NULL, CAST(N'2024-04-03T22:12:37.990' AS DateTime), 3, N'jj@gmail.com', CAST(N'2024-04-03T22:12:37.990' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (4, N'bf2bc2545a4a5f5683d9ef3ed0d977e0', N'tranthap@gmail.com', NULL, N'jj', N'Nguyễn', NULL, NULL, CAST(N'2024-04-03T22:26:12.833' AS DateTime), 3, N'tranthap@gmail.com', CAST(N'2024-04-03T22:26:12.833' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (5, N'0cc175b9c0f1b6a831c399e269772661', N'a@gmail.com', NULL, N'a', N'a', NULL, NULL, CAST(N'2024-04-04T01:44:23.633' AS DateTime), 3, N'a@gmail.com', CAST(N'2024-04-04T01:44:23.633' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (6, N'7694f4a66316e53c8cdd9d9954bd611d', N'q@gmail.com', NULL, N'q', N'q', NULL, NULL, CAST(N'2024-04-04T14:13:39.970' AS DateTime), 3, N'q@gmail.com', CAST(N'2024-04-04T14:13:39.970' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (7, N'415290769594460e2e485922904f345d', N'y@gmail.com', NULL, N'y', N'y', NULL, NULL, CAST(N'2024-04-04T14:14:38.620' AS DateTime), 3, N'y@gmail.com', CAST(N'2024-04-04T14:14:38.620' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (8, N'25f9e794323b453885f5181f1b624d0b', N'tranthao@gmail.com', NULL, N'tran', N'TRHAO', NULL, NULL, CAST(N'2024-04-04T14:20:20.213' AS DateTime), 3, N'tranthao@gmail.com', CAST(N'2024-04-04T14:20:20.213' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (9, N'4a8a08f09d37b73795649038408b5f33', N'c@gmail.com', NULL, N'c', N'c', NULL, NULL, CAST(N'2024-04-04T16:13:36.280' AS DateTime), 3, N'c@gmail.com', CAST(N'2024-04-04T16:13:36.280' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (10, N'bf2bc2545a4a5f5683d9ef3ed0d977e0', N'jjj@gmail.com', NULL, N'j', N'j', NULL, NULL, CAST(N'2024-04-04T16:14:11.890' AS DateTime), 3, N'jjj@gmail.com', CAST(N'2024-04-04T16:14:11.890' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (11, N'2510c39011c5be704182423e3a695e91', N'h@gmail.com', NULL, N'h', N'h', NULL, NULL, CAST(N'2024-04-04T16:16:16.670' AS DateTime), 3, N'h@gmail.com', CAST(N'2024-04-04T16:16:16.670' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (12, N'9c72446df124ddf214b698c1e2312371', N'g@gmail.com', NULL, N'g', N'g', NULL, NULL, CAST(N'2024-04-05T16:54:51.103' AS DateTime), 3, N'g@gmail.com', CAST(N'2024-04-05T16:54:51.103' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (14, N'007f6a7040011de3ed1a1124969425ab', N'l@gmail.com', NULL, N'l', N'l', NULL, NULL, CAST(N'2024-04-06T00:20:59.153' AS DateTime), 3, N'l@gmail.com', CAST(N'2024-04-06T00:20:59.153' AS DateTime))
INSERT [dbo].[Account] ([AccountCode], [Password], [Email], [PhoneNumber], [FirstName], [LastName], [Avatar], [RequestCode], [CreateAt], [RoleID], [Update_By], [Update_At]) VALUES (15, N'25d55ad283aa400af464c76d713c07ad', N'khidot@gmail.com', NULL, N'Tân', N'Anh', NULL, NULL, CAST(N'2024-04-06T17:11:45.240' AS DateTime), 3, N'khidot@gmail.com', CAST(N'2024-04-06T17:11:45.240' AS DateTime))
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[AccountAddress] ON 

INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (2, 5, NULL, N'0365859544', NULL, NULL, N'1', N'1')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (3, 5, NULL, N'0365252566', NULL, NULL, N'2', N'2')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (4, 5, NULL, N'0256859455', NULL, NULL, N'4', N'4')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (5, 5, NULL, N'0265858544', NULL, NULL, N'5', N'5')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (6, 5, NULL, N'0265858544', NULL, NULL, N'5', N'5')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (7, 5, NULL, N'0352656588', NULL, NULL, N'5', N'5')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (8, 5, NULL, N'0352656588', NULL, NULL, N'5', N'5')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (9, 5, NULL, N'0352456877', NULL, NULL, N'5', N'5')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (13, 5, NULL, N'0625484855', NULL, NULL, N'6', N'6')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (14, 5, NULL, N'0752656588', NULL, NULL, N'7', N'7')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (16, 17, NULL, N'0352685944', NULL, NULL, N'a', N'a')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (17, 5, NULL, N'0359787811', NULL, NULL, N'a', N'a')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (18, 17, NULL, N'0369787811', NULL, NULL, N'Hồ Chí Minh', N'6')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (19, 17, NULL, N'0369787811', NULL, NULL, N'Hồ Chí Minh', N'6')
INSERT [dbo].[AccountAddress] ([AccountAddressCode], [AccountCode], [FullName], [PhoneNumber], [PostalCode], [Country], [City], [Address]) VALUES (20, 17, NULL, N'0369787811', NULL, NULL, N'Hồ Chí Minh', N'6')
SET IDENTITY_INSERT [dbo].[AccountAddress] OFF
GO
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'ERGOEDRA213', N'Ghế công thái học E-DRA EEC213', NULL, 1, N'Ghế công thái học E-DRA EEC213', CAST(1900000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'MLKKLEVI1S', N'Máy lọc không khí chống dị ứng thú cưng Levoit Vital 100S', NULL, 1, N'Levoit100S', CAST(11000000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'MLKKSHGM50', N'Máy lọc không khí và bắt muỗi SHARP FP-GM50E-B', NULL, 1, N'Máy lọc không khí và bắt muỗi SHARP FP-GM50E-B', CAST(12000000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'MLKKXMIPU4P', N'Máy lọc không khí Xiaomi Air Purifier 4 Pro', NULL, 1, N'xiaomi-air-purifier-4-pro-4', CAST(150000000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'RBODREL20UL', N'Robot hút bụi lau nhà Dreame Bot L20 Ultra', NULL, 1, N'Dreame Bot L20 Ultra', CAST(12500000.00 AS Decimal(18, 2)), NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (5, N'RBOXMIX10', N'Robot hút bụi lau nhà Xiaomi Vacuum Mop X10+', NULL, 1, N'Xiaomi Vacuum Mop X10', CAST(15000000.00 AS Decimal(18, 2)), NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[Cart] ([AccountCode], [ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (17, N'METAVR30128', N'Kính thực tế ảo Meta Quest 3', NULL, 3, N'Kính thực tế ảo Meta Quest 3', CAST(15500000.00 AS Decimal(18, 2)), NULL, 2, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryCode], [CategoryName]) VALUES (1, N'Smarthome')
INSERT [dbo].[Category] ([CategoryCode], [CategoryName]) VALUES (2, N'Phụ kiện laptop - PC')
INSERT [dbo].[Category] ([CategoryCode], [CategoryName]) VALUES (3, N'GamingGear')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (5, N'BOPASGVP47', 500000.0000, 3, 1500000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (10, N'BOPASGVP47', 500000.0000, 2, 1000000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (4, N'ERGOEDRA213', 1900000.0000, 2, 3800000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (10, N'ERGOEDRA213', 1900000.0000, 1, 1900000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (13, N'ERGOEDRA213', 1900000.0000, 1, 1900000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (2, N'METAVR30128', 15500000.0000, 1, 15500000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (13, N'METAVR30128', 15500000.0000, 1, 15500000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (4, N'MLKKLEVI1S', 11000000.0000, 1, 11000000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (14, N'MLKKLEVI1S', 11000000.0000, 1, 11000000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (2, N'MLKKSHGM50', 12000000.0000, 1, 12000000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (3, N'MLKKSHGM50', 12000000.0000, 1, 12000000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (3, N'RBODREL20UL', 12500000.0000, 1, 12500000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (5, N'RBODREL20UL', 12500000.0000, 1, 12500000.0000)
INSERT [dbo].[OrderDetail] ([OrderCode], [ProductCode], [Price], [Quantity], [Total]) VALUES (3, N'RBOXMIX10', 15000000.0000, 1, 15000000.0000)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (2, 4, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 27530000.0000, NULL, 2)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (3, 4, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 39530000.0000, NULL, 3)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (4, 4, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 14830000.0000, NULL, 4)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (5, 4, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 14030000.0000, NULL, 7)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (6, 3, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 2930000.0000, NULL, 9)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (10, 3, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 2930000.0000, NULL, 13)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (11, 3, 5, NULL, CAST(N'2024-04-10' AS Date), 0, NULL, 1930000.0000, NULL, 14)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (13, 4, 17, NULL, CAST(N'2024-04-11' AS Date), NULL, NULL, 1930000.0000, NULL, 16)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (14, 4, 5, NULL, CAST(N'2024-04-11' AS Date), NULL, NULL, 11030000.0000, NULL, 17)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (15, 3, 17, NULL, CAST(N'2024-05-10' AS Date), 0, NULL, 31030000.0000, NULL, 18)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (16, 3, 17, NULL, CAST(N'2024-05-10' AS Date), 0, NULL, 31030000.0000, NULL, 19)
INSERT [dbo].[Orders] ([OrderCode], [PaymentCode], [AccountCode], [PromotionCode], [OrderDate], [Delivered], [DeliveryDate], [OrderTotal], [OrderNote], [AccountAddressCode]) VALUES (17, 3, 17, NULL, CAST(N'2024-05-10' AS Date), 0, NULL, 31030000.0000, NULL, 20)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PaymentCode], [PaymentType], [AccountNumer], [ExpiryDate]) VALUES (3, N'VNPay', NULL, NULL)
INSERT [dbo].[Payment] ([PaymentCode], [PaymentType], [AccountNumer], [ExpiryDate]) VALUES (4, N'Thanh toan truc tiep', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'BOPASGVP47', N'Balo laptop Asus TUF Gaming VP4700 ', 5, 2, N'Balo laptop Asus TUF Gaming VP4700', CAST(500000.00 AS Decimal(18, 2)), N'2         ', 9, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'ERGOEDRA213', N'Ghế công thái học E-DRA EEC213', 8, 1, N'Ghế công thái học E-DRA EEC213', CAST(1900000.00 AS Decimal(18, 2)), N'2         ', 5, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'METAVR30128', N'Kính thực tế ảo Meta Quest 3', 13, 3, N'Kính thực tế ảo Meta Quest 3', CAST(15500000.00 AS Decimal(18, 2)), N'2         ', 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'MLKKLEVI1S', N'Máy lọc không khí chống dị ứng thú cưng Levoit Vital 100S', 1, 1, N'Levoit100S', CAST(11000000.00 AS Decimal(18, 2)), N'1         ', 20, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'MLKKSHGM50', N'Máy lọc không khí và bắt muỗi SHARP FP-GM50E-B', 3, 1, N'Máy lọc không khí và bắt muỗi SHARP FP-GM50E-B', CAST(12000000.00 AS Decimal(18, 2)), N'2         ', 5, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'MLKKXMIPU4P', N'Máy lọc không khí Xiaomi Air Purifier 4 Pro', 2, 1, N'xiaomi-air-purifier-4-pro-4', CAST(150000000.00 AS Decimal(18, 2)), N'1         ', 10, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'PINEGI15UE', N'Pin sạc dự phòng Energizer 15.000 UE200', 10, 2, N'Pin sạc dự phòng Energizer 15.000 UE200', CAST(950000.00 AS Decimal(18, 2)), N'1         ', 5, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'PSVR02', N'Kính thực tế ảo Sony Playstation VR2', 4, 3, N'Kính-thực-tế-ảo-Sony-Playstation-VR2', CAST(18500000.00 AS Decimal(18, 2)), N'3         ', 5, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'RBODREL20UL', N'Robot hút bụi lau nhà Dreame Bot L20 Ultra', 7, 1, N'Dreame Bot L20 Ultra', CAST(12500000.00 AS Decimal(18, 2)), N'1         ', 2, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'RBOXMIX10', N'Robot hút bụi lau nhà Xiaomi Vacuum Mop X10+', 2, 1, N'Xiaomi Vacuum Mop X10', CAST(15000000.00 AS Decimal(18, 2)), N'1         ', 3, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'SMPENXMI', N'Bút cảm ứng Xiaomi ', 2, 2, N'Bút cảm ứng Xiaomi', CAST(750000.00 AS Decimal(18, 2)), N'2         ', 5, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductCode], [ProductName], [BrandCode], [CategoryCode], [ImageProduct], [Price], [PromotionCode], [Quantity], [Description], [ViewCount], [Rate]) VALUES (N'SOPS5MAR', N'Máy chơi game Sony PlayStation 5  Bundle Marvel''s Spiderman ', 4, 3, N'Máy chơi game Sony PlayStation 5  Bundle Marvel''s Spiderman', CAST(22000000.00 AS Decimal(18, 2)), N'1         ', 5, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ProductImg] ON 

INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (1, N'Máy chơi game Sony PlayStation 5  Bundle Marvel''s Spiderman-01', N'SOPS5MAR')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (2, N'Máy chơi game Sony PlayStation 5  Bundle Marvel''s Spiderman-02', N'SOPS5MAR')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (3, N'Balo laptop Asus TUF Gaming VP4700-01', N'BOPASGVP47')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (4, N'Ghế công thái học E-DRA EEC213-01', N'ERGOEDRA213')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (5, N'Ghế công thái học E-DRA EEC213-02', N'ERGOEDRA213')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (6, N'Ghế công thái học E-DRA EEC213-03', N'ERGOEDRA213')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (7, N'Kính thực tế ảo Meta Quest 3-01', N'METAVR30128')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (8, N'Kính thực tế ảo Meta Quest 3-02', N'METAVR30128')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (9, N'xiaomi-air-purifier-1', N'MLKKXMIPU4P')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (10, N'xiaomi-air-purifier-4-pro-4', N'MLKKXMIPU4P')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (11, N'Pin sạc dự phòng Energizer 15.000 UE200-01', N'PINEGI15UE')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (13, N'Kính thực tế ảo Sony Playstation VR2-01', N'PSVR02')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (14, N'Kính thực tế ảo Sony Playstation VR2-02', N'PSVR02')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (15, N'drame-l20-ultra-station', N'RBODREL20UL')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (16, N'Xiaomi Vacuum Mop X10-01', N'RBOXMIX10')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (17, N'Robot hút bụi lau nhà Xiaomi Vacuum Mop X10-02', N'RBOXMIX10')
INSERT [dbo].[ProductImg] ([ProductImgCode], [Img], [ProductCode]) VALUES (18, N'Bút cảm ứng Xiaomi -01', N'SMPENXMI')
SET IDENTITY_INSERT [dbo].[ProductImg] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Quản lý')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Nhân viên')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Khách hàng')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT (getdate()) FOR [CommentTime]
GO
ALTER TABLE [dbo].[Comment] ADD  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[Contact] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Contact] ADD  DEFAULT (getdate()) FOR [ContactDate]
GO
ALTER TABLE [dbo].[Delivery] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Delivered]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1000)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((1000)) FOR [Quantity]
GO
