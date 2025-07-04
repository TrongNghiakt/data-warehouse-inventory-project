Create database RetailSalesInventoryDW;
GO
Use RetailSalesInventoryDW;
GO
-- 1.1 DimDate (vẫn giữ natural key nên không đặt IDENTITY)
IF OBJECT_ID('dbo.DimDate','U') IS NOT NULL DROP TABLE dbo.DimDate;
GO
CREATE TABLE dbo.DimDate
(
    DateKey              INT         NOT NULL PRIMARY KEY,    -- YYYYMMDD
    FullDateAlternateKey DATE        NOT NULL,
    DayNumberOfWeek      TINYINT     NULL,
    EnglishDayNameOfWeek NVARCHAR(10) NULL,
    DayNumberOfMonth     TINYINT     NULL,
    WeekNumberOfYear     TINYINT     NULL,
    MonthNumberOfYear    TINYINT     NULL,
    EnglishMonthName     NVARCHAR(20) NULL,
    CalendarQuarter      TINYINT     NULL,
    CalendarYear         SMALLINT    NULL
);
GO

-- 1.2 DimProductCategory với surrogate key tự tăng
IF OBJECT_ID('dbo.DimProductCategory','U') IS NOT NULL DROP TABLE dbo.DimProductCategory;
GO
CREATE TABLE dbo.DimProductCategory
(
    ProductCategoryKey          INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductCategoryAlternateKey INT             NULL,
    EnglishProductCategoryName  NVARCHAR(50)    NULL
);
GO

-- 1.3 DimProductSubcategory
IF OBJECT_ID('dbo.DimProductSubcategory','U') IS NOT NULL DROP TABLE dbo.DimProductSubcategory;
GO
CREATE TABLE dbo.DimProductSubcategory
(
    ProductSubcategoryKey          INT           IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductSubcategoryAlternateKey INT           NULL,
    EnglishProductSubcategoryName  NVARCHAR(50)  NULL,
    ProductCategoryKey             INT           NOT NULL
        CONSTRAINT FK_Subcat_Cat REFERENCES dbo.DimProductCategory(ProductCategoryKey)
);
GO

-- 1.4 DimProduct
IF OBJECT_ID('dbo.DimProduct','U') IS NOT NULL DROP TABLE dbo.DimProduct;
GO
CREATE TABLE dbo.DimProduct
(
    ProductKey            INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductAlternateKey   INT    NOT NULL,
    EnglishProductName    NVARCHAR(100)   NULL,
    ProductLine           nvarCHAR(10)         NULL,
    Color                 NVARCHAR(15)    NULL,
    Size                  NVARCHAR(5)     NULL,
    Weight                DECIMAL(8,2)    NULL,
    StandardCost          MONEY           NULL,
    ListPrice             MONEY           NULL,
    SellStartDate         DATE            NULL,
    SellEndDate           DATE            NULL,
    ProductSubcategoryKey INT             NULL
        CONSTRAINT FK_Product_Subcat REFERENCES dbo.DimProductSubcategory(ProductSubcategoryKey)
);
GO

-- 1.5 DimCurrency
IF OBJECT_ID('dbo.DimCurrency','U') IS NOT NULL DROP TABLE dbo.DimCurrency;
GO
CREATE TABLE dbo.DimCurrency
(
    CurrencyKey           INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CurrencyCode  NVARCHAR(3)  NULL,
    CurrencyName          NVARCHAR(50) NULL
);
GO

-- 1.6 DimSalesTerritory
IF OBJECT_ID('dbo.DimSalesTerritory','U') IS NOT NULL DROP TABLE dbo.DimSalesTerritory;
GO
CREATE TABLE dbo.DimSalesTerritory
(
    SalesTerritoryKey           INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SalesTerritoryAlternateKey  INT          NULL,
    SalesTerritoryRegion        NVARCHAR(50) NULL,
    SalesTerritoryCode       NVARCHAR(50) NULL,
    SalesTerritoryGroup         NVARCHAR(50) NULL
);
GO

-- 1.7 DimGeography
IF OBJECT_ID('dbo.DimGeography','U') IS NOT NULL DROP TABLE dbo.DimGeography;
GO
CREATE TABLE dbo.DimGeography
(
    GeographyKey        INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StateProvinceCode   NVARCHAR(5)  NULL,
    StateProvinceName   NVARCHAR(50) NULL,
    CountryRegionCode   NVARCHAR(5)  NULL,
    CountryRegionName   NVARCHAR(50) NULL,
    City                NVARCHAR(50) NULL,
    PostalCode          NVARCHAR(10) NULL,
    SalesTerritoryKey   INT          NULL
        CONSTRAINT FK_Geog_Terr FOREIGN KEY REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);
GO

-- 1.8 DimCustomer
IF OBJECT_ID('dbo.DimCustomer','U') IS NOT NULL DROP TABLE dbo.DimCustomer;
GO
CREATE TABLE dbo.DimCustomer
(
    CustomerKey          INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomerAlternateKey NVARCHAR(10)    NULL,
    FirstName            NVARCHAR(50)    NULL,
    LastName             NVARCHAR(50)    NULL,
    Title             NVARCHAR(8)    NULL,
    Phone                NVARCHAR(20)    NULL
);
GO

-- 1.9 DimPromotion
IF OBJECT_ID('dbo.DimPromotion','U') IS NOT NULL DROP TABLE dbo.DimPromotion;
GO
CREATE TABLE dbo.DimPromotion
(
    PromotionKey           INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PromotionAlternateKey  INT          NULL,
    EnglishPromotionName   NVARCHAR(255) NULL,
    DiscountPct            DECIMAL(5,2) NULL,
    PromotionType          NVARCHAR(50) NULL,
    StartDate              DATE         NULL,
    EndDate                DATE         NULL
);
GO

-- 1.10 DimReseller
IF OBJECT_ID('dbo.DimReseller','U') IS NOT NULL DROP TABLE dbo.DimReseller;
GO
CREATE TABLE dbo.DimReseller
(
    ResellerKey          INT           IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ResellerAlternateKey INT  NULL,
    ResellerName         NVARCHAR(100) NULL
);
GO

-- 1.11 DimEmployee
IF OBJECT_ID('dbo.DimEmployee','U') IS NOT NULL DROP TABLE dbo.DimEmployee;
GO
CREATE TABLE dbo.DimEmployee
(
    EmployeeKey           INT         IDENTITY(1,1) NOT NULL PRIMARY KEY,
    EmployeeAlternateKey  INT         NULL,
    JobTitle              NVARCHAR(50) NULL,
	FirstName              NVARCHAR(50) NULL,
	LastName              NVARCHAR(50) NULL,
    HireDate              DATE        NULL,
    BirthDate             DATE        NULL,
    Phone                 NVARCHAR(25) NULL
);
GO

-- 1.12 DimOrganization
IF OBJECT_ID('dbo.DimOrganization','U') IS NOT NULL DROP TABLE dbo.DimOrganization;
GO
CREATE TABLE dbo.DimOrganization
(
    OrganizationKey        INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ParentOrganizationKey  INT          NULL REFERENCES dbo.DimOrganization(OrganizationKey),
    OrganizationName       NVARCHAR(100) NULL,
	OrganizationGroupName	NVARCHAR(100) NULL
);
GO


-- 1. FactInternetSales
IF OBJECT_ID('dbo.FactInternetSales','U') IS NOT NULL
    DROP TABLE dbo.FactInternetSales;
GO

CREATE TABLE dbo.FactInternetSales
(
    FactInternetSalesKey    INT           IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductKey              INT           NOT NULL,  -- FK → DimProduct
    OrderDateKey            INT           NOT NULL,  -- FK → DimDate
    DueDateKey              INT           NULL,      -- FK → DimDate
    ShipDateKey             INT           NULL,      -- FK → DimDate
    CustomerKey             INT           NOT NULL,  -- FK → DimCustomer
    PromotionKey            INT           NULL,      -- FK → DimPromotion
    CurrencyKey             INT           NULL,      -- FK → DimCurrency
    SalesTerritoryKey       INT           NULL,      -- FK → DimSalesTerritory
    OrderQuantity           INT			  NULL,
    ExtendedAmount          MONEY         NULL,
    UnitPriceDiscountPct    DECIMAL(5,2)  NULL,
    DiscountAmount          MONEY         NULL,
    TotalProductCost        MONEY         NULL,
    SalesAmount             MONEY         NULL,
    TaxAmount               MONEY         NULL,
    Freight                 MONEY         NULL,

    CONSTRAINT FK_FIS_Product
        FOREIGN KEY(ProductKey) REFERENCES dbo.DimProduct(ProductKey),
    CONSTRAINT FK_FIS_OrderDate
        FOREIGN KEY(OrderDateKey) REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FIS_DueDate
        FOREIGN KEY(DueDateKey)   REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FIS_ShipDate
        FOREIGN KEY(ShipDateKey)  REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FIS_Customer
        FOREIGN KEY(CustomerKey)  REFERENCES dbo.DimCustomer(CustomerKey),
    CONSTRAINT FK_FIS_Promotion
        FOREIGN KEY(PromotionKey) REFERENCES dbo.DimPromotion(PromotionKey),
    CONSTRAINT FK_FIS_Currency
        FOREIGN KEY(CurrencyKey)  REFERENCES dbo.DimCurrency(CurrencyKey),
    CONSTRAINT FK_FIS_Territory
        FOREIGN KEY(SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);
GO

-- 2. FactResellerSales
IF OBJECT_ID('dbo.FactResellerSales','U') IS NOT NULL
    DROP TABLE dbo.FactResellerSales;
GO

CREATE TABLE dbo.FactResellerSales
(
    FactResellerSalesKey   INT            IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductKey             INT            NOT NULL,  -- FK → DimProduct
    OrderDateKey           INT            NOT NULL,  -- FK → DimDate
    DueDateKey             INT            NULL,      -- FK → DimDate
    ShipDateKey            INT            NULL,      -- FK → DimDate
    ResellerKey            INT            NOT NULL,  -- FK → DimReseller
    EmployeeKey            INT            NULL,      -- FK → DimEmployee
    OrganizationKey        INT            NULL,      -- FK → DimOrganization
    PromotionKey           INT            NULL,      -- FK → DimPromotion
    CurrencyKey            INT            NULL,      -- FK → DimCurrency
    SalesTerritoryKey      INT            NULL,      -- FK → DimSalesTerritory
    OrderQuantity          INT       NULL,
    ExtendedAmount         MONEY          NULL,
    UnitPriceDiscountPct   DECIMAL(5,2)   NULL,
    DiscountAmount         MONEY          NULL,
    TotalProductCost       MONEY          NULL,
    SalesAmount            MONEY          NULL,
    TaxAmount              MONEY          NULL,
    Freight                MONEY          NULL,


    CONSTRAINT FK_FRS_Product
        FOREIGN KEY(ProductKey) REFERENCES dbo.DimProduct(ProductKey),
    CONSTRAINT FK_FRS_OrderDate
        FOREIGN KEY(OrderDateKey) REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FRS_DueDate
        FOREIGN KEY(DueDateKey)   REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FRS_ShipDate
        FOREIGN KEY(ShipDateKey)  REFERENCES dbo.DimDate(DateKey),
    CONSTRAINT FK_FRS_Reseller
        FOREIGN KEY(ResellerKey)  REFERENCES dbo.DimReseller(ResellerKey),
    CONSTRAINT FK_FRS_Employee
        FOREIGN KEY(EmployeeKey)  REFERENCES dbo.DimEmployee(EmployeeKey),
    CONSTRAINT FK_FRS_Org
        FOREIGN KEY(OrganizationKey) REFERENCES dbo.DimOrganization(OrganizationKey),
    CONSTRAINT FK_FRS_Promotion
        FOREIGN KEY(PromotionKey) REFERENCES dbo.DimPromotion(PromotionKey),
    CONSTRAINT FK_FRS_Currency
        FOREIGN KEY(CurrencyKey)  REFERENCES dbo.DimCurrency(CurrencyKey),
    CONSTRAINT FK_FRS_Territory
        FOREIGN KEY(SalesTerritoryKey) REFERENCES dbo.DimSalesTerritory(SalesTerritoryKey)
);
GO


CREATE TABLE dbo.FactProductInventory
(
    FactProductInventoryKey INT           IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductKey              INT           NOT NULL,  -- FK → DimProduct
    DateKey                 INT           NOT NULL,  -- FK → DimDate
    UnitsIn                 INT           NULL,
    UnitsOut                INT           NULL,
    QuantityOnHand            INT           NULL,
    UnitCost                MONEY         NULL,
    InventoryValue          MONEY         NULL,

    CONSTRAINT FK_FPI_Product
        FOREIGN KEY(ProductKey) REFERENCES dbo.DimProduct(ProductKey),
    CONSTRAINT FK_FPI_Date
        FOREIGN KEY(DateKey) REFERENCES dbo.DimDate(DateKey)
);
GO
