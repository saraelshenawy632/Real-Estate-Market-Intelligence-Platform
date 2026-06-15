CREATE TABLE [Location] (
  [Location_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Governorate] nvarchar(255),
  [City] nvarchar(255),
  [Region] nvarchar(255),
  [Latitude] decimal(10,6),
  [Longitude] decimal(10,6)
)
GO

CREATE TABLE [Demographics] (
  [Location_ID] int PRIMARY KEY,
  [Population_Total] int,
  [Population_Male] int,
  [Population_Female] int,
  [Youth_Percentage] decimal,
  [Avg_Monthly_Income] decimal
)
GO

CREATE TABLE [University_Students] (
  [Uni_Student_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [University] nvarchar(255),
  [University_Type] nvarchar(255),
  [Num_Male] int,
  [Num_Female] int,
  [Total_Students] int
)
GO

CREATE TABLE [Labor_Force] (
  [Labor_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [Num_Male] int,
  [Num_Female] int,
  [Total_Labor_Force] int
)
GO

CREATE TABLE [Employment_By_Industry] (
  [Employment_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [Industry] nvarchar(255),
  [Num_Male] int,
  [Num_Female] int,
  [Total_Employed] int
)
GO

CREATE TABLE [CostOfLiving] (
  [Cost_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [Category] nvarchar(255),
  [Item] nvarchar(255),
  [Avg_Price_EGP] decimal,
  [Min_Price_EGP] decimal,
  [Max_Price_EGP] decimal
)
GO

CREATE TABLE [BusinessType] (
  [BusinessType_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Type_Name] nvarchar(255)
)
GO

CREATE TABLE [Competitor] (
  [Competitor_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [Business_Name] nvarchar(255),
  [BusinessType_ID] int,
  [Category] nvarchar(255),
  [Rating] decimal,
  [Reviews_Count] int,
  [Price_Level] nvarchar(255)
)
GO

CREATE TABLE [Property] (
  [Property_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Location_ID] int,
  [Property_Type] nvarchar(255),
  [Size_sqm] decimal,
  [Latitude] decimal(10,6),
  [Longitude] decimal(10,6)
)
GO

CREATE TABLE [Listing] (
  [Listing_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Property_ID] int,
  [Listing_Type] nvarchar(255),
  [Price_EGP] decimal,
  [Price_Per_Sqm] decimal,
  [Price_Period] nvarchar(255),
  [Title] nvarchar(255),
  [Date_Listed] date
)
GO

ALTER TABLE [Demographics] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [University_Students] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [Labor_Force] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [Employment_By_Industry] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [CostOfLiving] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [Competitor] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [Competitor] ADD FOREIGN KEY ([BusinessType_ID]) REFERENCES [BusinessType] ([BusinessType_ID])
GO

ALTER TABLE [Property] ADD FOREIGN KEY ([Location_ID]) REFERENCES [Location] ([Location_ID])
GO

ALTER TABLE [Listing] ADD FOREIGN KEY ([Property_ID]) REFERENCES [Property] ([Property_ID])
GO
