USE [master]
GO
/****** Object:  Database [RetailSalesDWStaging]    Script Date: 30/05/2025 11:44:50 CH ******/
CREATE DATABASE [RetailSalesDWStaging]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RetailSalesDWStaging', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RetailSalesDWStaging.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RetailSalesDWStaging_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RetailSalesDWStaging_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [RetailSalesDWStaging] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RetailSalesDWStaging].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RetailSalesDWStaging] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ARITHABORT OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RetailSalesDWStaging] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RetailSalesDWStaging] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RetailSalesDWStaging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RetailSalesDWStaging] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET RECOVERY FULL 
GO
ALTER DATABASE [RetailSalesDWStaging] SET  MULTI_USER 
GO
ALTER DATABASE [RetailSalesDWStaging] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RetailSalesDWStaging] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RetailSalesDWStaging] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RetailSalesDWStaging] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RetailSalesDWStaging] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RetailSalesDWStaging] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RetailSalesDWStaging', N'ON'
GO
ALTER DATABASE [RetailSalesDWStaging] SET QUERY_STORE = ON
GO
ALTER DATABASE [RetailSalesDWStaging] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RetailSalesDWStaging]
GO
/****** Object:  Table [dbo].[stgCurrency]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgCurrency](
	[ModifiedDate] [datetime] NULL,
	[CurrencyCode] [nvarchar](3) NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgCustomer]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgCustomer](
	[CustomerKey] [int] NULL,
	[CustomerAlternateKey] [varchar](10) NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[Phone] [nvarchar](25) NULL,
	[GeographyKey] [int] NULL,
	[AddressLine1] [nvarchar](60) NULL,
	[City] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgDimDate]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgDimDate](
	[TransactionDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgEmployee]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgEmployee](
	[EmployeeKey] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[JobTitle] [nvarchar](50) NULL,
	[HireDate] [date] NULL,
	[BirthDate] [date] NULL,
	[PhoneNumber] [nvarchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgGeography]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgGeography](
	[GeographyKey] [int] NULL,
	[StateProvinceCode] [nvarchar](3) NULL,
	[StateProvinceName] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL,
	[CountryRegionName] [nvarchar](50) NULL,
	[City] [nvarchar](30) NULL,
	[PostalCode] [nvarchar](15) NULL,
	[SalesTerritoryKey] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgInternetSales]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgInternetSales](
	[ProductKey] [int] NULL,
	[OrderDateKey] [int] NULL,
	[DueDateKey] [int] NULL,
	[ShipDateKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[PromotionKey] [int] NULL,
	[CurrencyKey] [int] NULL,
	[SalesTerritoryKey] [int] NULL,
	[SalesOrderNumber] [nvarchar](25) NULL,
	[SalesOrderLineNumber] [int] NULL,
	[RevisionNumber] [tinyint] NULL,
	[OrderQuantity] [smallint] NULL,
	[UnitPrice] [money] NULL,
	[ExtendedAmount] [numeric](38, 6) NULL,
	[UnitPriceDiscountPct] [money] NULL,
	[DiscountAmount] [numeric](38, 6) NULL,
	[ProductStandardCost] [money] NULL,
	[TotalProductCost] [money] NULL,
	[SalesAmount] [numeric](38, 6) NULL,
	[TaxAmount] [money] NULL,
	[Freight] [money] NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL,
	[CurrencyCode] [nvarchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgOrganization]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgOrganization](
	[DepartmentID] [smallint] NULL,
	[Name] [nvarchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgProduct]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgProduct](
	[ProductID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[MakeFlag] [bit] NULL,
	[FinishedGoodsFlag] [bit] NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NULL,
	[ReorderPoint] [smallint] NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nvarchar](3) NULL,
	[WeightUnitMeasureCode] [nvarchar](3) NULL,
	[Weight] [numeric](8, 2) NULL,
	[DaysToManufacture] [int] NULL,
	[ProductLine] [nvarchar](2) NULL,
	[Class] [nvarchar](2) NULL,
	[Style] [nvarchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgProductCategory]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgProductCategory](
	[ProductCategoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgProductInventory]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgProductInventory](
	[ProductKey] [int] NULL,
	[DateKey] [int] NULL,
	[UnitsIn] [int] NULL,
	[UnitsOut] [int] NULL,
	[QuantityOnHand] [smallint] NULL,
	[UnitCost] [money] NULL,
	[InventoryValue] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgProductSubcategory]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgProductSubcategory](
	[ProductSubcategoryID] [int] NULL,
	[ProductCategoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgPromotion]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgPromotion](
	[PromotionKey] [int] NULL,
	[EnglishPromotionName] [nvarchar](255) NULL,
	[DiscountPct] [money] NULL,
	[PromotionType] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgReseller]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgReseller](
	[BusinessEntityID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[SalesPersonID] [int] NULL,
	[Demographics] [nvarchar](max) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgResellerSales]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgResellerSales](
	[OrderDateKey] [int] NULL,
	[DueDateKey] [int] NULL,
	[ShipDateKey] [int] NULL,
	[SalesOrderNumber] [nvarchar](25) NULL,
	[SalesOrderLineNumber] [int] NULL,
	[RevisionNumber] [tinyint] NULL,
	[OrderQuantity] [smallint] NULL,
	[UnitPrice] [money] NULL,
	[ExtendedAmount] [numeric](38, 6) NULL,
	[UnitPriceDiscountPct] [money] NULL,
	[DiscountAmount] [numeric](38, 6) NULL,
	[ProductStandardCost] [money] NULL,
	[TotalProductCost] [money] NULL,
	[SalesAmount] [numeric](38, 6) NULL,
	[TaxAmount] [money] NULL,
	[Freight] [money] NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL,
	[CurrencyCode] [nvarchar](3) NULL,
	[ProductAlternateKey] [int] NULL,
	[EmployeeAlternateKey] [int] NULL,
	[OrganizationAlternateKey] [smallint] NULL,
	[PromotionAlternateKey] [int] NULL,
	[SalesTerritoryAlternateKey] [int] NULL,
	[ResellerAlternateKey] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgSalesTerritory]    Script Date: 30/05/2025 11:44:51 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgSalesTerritory](
	[TerritoryID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL,
	[Group] [nvarchar](50) NULL,
	[SalesYTD] [money] NULL,
	[SalesLastYear] [money] NULL,
	[CostYTD] [money] NULL,
	[CostLastYear] [money] NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [RetailSalesDWStaging] SET  READ_WRITE 
GO
