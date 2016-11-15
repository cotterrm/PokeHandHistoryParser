
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/14/2016 19:52:45
-- Generated from EDMX file: C:\EpicSource\WTC\ModelFirst\Poker Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ThisDataBase];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_HandActionPerforms]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Performs] DROP CONSTRAINT [FK_HandActionPerforms];
GO
IF OBJECT_ID(N'[dbo].[FK_PerformsPlayer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Performs] DROP CONSTRAINT [FK_PerformsPlayer];
GO
IF OBJECT_ID(N'[dbo].[FK_PlayerPlays]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Plays] DROP CONSTRAINT [FK_PlayerPlays];
GO
IF OBJECT_ID(N'[dbo].[FK_HandPlays]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Plays] DROP CONSTRAINT [FK_HandPlays];
GO
IF OBJECT_ID(N'[dbo].[FK_HandActionFurthers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Furthers1] DROP CONSTRAINT [FK_HandActionFurthers];
GO
IF OBJECT_ID(N'[dbo].[FK_FurthersHand]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Furthers1] DROP CONSTRAINT [FK_FurthersHand];
GO
IF OBJECT_ID(N'[dbo].[FK_PlayedOnHand]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PlayedOns] DROP CONSTRAINT [FK_PlayedOnHand];
GO
IF OBJECT_ID(N'[dbo].[FK_PlayedOnTable]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PlayedOns] DROP CONSTRAINT [FK_PlayedOnTable];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Players]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Players];
GO
IF OBJECT_ID(N'[dbo].[Hands]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Hands];
GO
IF OBJECT_ID(N'[dbo].[Tables]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tables];
GO
IF OBJECT_ID(N'[dbo].[HandActions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[HandActions];
GO
IF OBJECT_ID(N'[dbo].[Plays]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Plays];
GO
IF OBJECT_ID(N'[dbo].[Furthers1]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Furthers1];
GO
IF OBJECT_ID(N'[dbo].[PlayedOns]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PlayedOns];
GO
IF OBJECT_ID(N'[dbo].[Performs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Performs];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Players'
CREATE TABLE [dbo].[Players] (
    [Winnings] nvarchar(max)  NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Hands'
CREATE TABLE [dbo].[Hands] (
    [HandId] bigint IDENTITY(1,1) NOT NULL,
    [PotSize] decimal(18,0)  NOT NULL,
    [ButtonPosition] int  NOT NULL,
    [Time] datetime  NOT NULL,
    [NumberOfPlayers] int  NOT NULL,
    [RiverCard] nvarchar(max)  NULL,
    [TurnCard] nvarchar(max)  NULL,
    [FlopCard3] nvarchar(max)  NULL,
    [FlopCard2] nvarchar(max)  NULL,
    [FlopCard1] nvarchar(max)  NULL
);
GO

-- Creating table 'Tables'
CREATE TABLE [dbo].[Tables] (
    [TableID] nvarchar(100)  NOT NULL,
    [MaxPlayers] int  NOT NULL,
    [Stakes] nvarchar(max)  NOT NULL,
    [Limit] nvarchar(max)  NOT NULL,
    [Site] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'HandActions'
CREATE TABLE [dbo].[HandActions] (
    [ActionID] bigint IDENTITY(1,1) NOT NULL,
    [ActionName] nvarchar(max)  NOT NULL,
    [Street] nvarchar(max)  NOT NULL,
    [Amount] decimal(18,0)  NOT NULL,
    [IsPFR] bit  NOT NULL,
    [IsVPIP] bit  NOT NULL,
    [HandHandId] bigint  NOT NULL
);
GO

-- Creating table 'Plays'
CREATE TABLE [dbo].[Plays] (
    [HoleCard1] nvarchar(max)  NOT NULL,
    [HoleCard2] nvarchar(max)  NOT NULL,
    [StartingStack] decimal(18,0)  NOT NULL,
    [EndingStack] decimal(18,0)  NOT NULL,
    [SeatPosition] int  NOT NULL,
    [HandId] bigint  NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Furthers1'
CREATE TABLE [dbo].[Furthers1] (
    [HandId] bigint  NOT NULL,
    [ActionID] bigint  NOT NULL
);
GO

-- Creating table 'PlayedOns'
CREATE TABLE [dbo].[PlayedOns] (
    [HandId] bigint  NOT NULL,
    [TableID] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'Performs'
CREATE TABLE [dbo].[Performs] (
    [ActionID] bigint  NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Name] in table 'Players'
ALTER TABLE [dbo].[Players]
ADD CONSTRAINT [PK_Players]
    PRIMARY KEY CLUSTERED ([Name] ASC);
GO

-- Creating primary key on [HandId] in table 'Hands'
ALTER TABLE [dbo].[Hands]
ADD CONSTRAINT [PK_Hands]
    PRIMARY KEY CLUSTERED ([HandId] ASC);
GO

-- Creating primary key on [TableID] in table 'Tables'
ALTER TABLE [dbo].[Tables]
ADD CONSTRAINT [PK_Tables]
    PRIMARY KEY CLUSTERED ([TableID] ASC);
GO

-- Creating primary key on [ActionID] in table 'HandActions'
ALTER TABLE [dbo].[HandActions]
ADD CONSTRAINT [PK_HandActions]
    PRIMARY KEY CLUSTERED ([ActionID] ASC);
GO

-- Creating primary key on [HandId], [Name] in table 'Plays'
ALTER TABLE [dbo].[Plays]
ADD CONSTRAINT [PK_Plays]
    PRIMARY KEY CLUSTERED ([HandId], [Name] ASC);
GO

-- Creating primary key on [HandId], [ActionID] in table 'Furthers1'
ALTER TABLE [dbo].[Furthers1]
ADD CONSTRAINT [PK_Furthers1]
    PRIMARY KEY CLUSTERED ([HandId], [ActionID] ASC);
GO

-- Creating primary key on [HandId], [TableID] in table 'PlayedOns'
ALTER TABLE [dbo].[PlayedOns]
ADD CONSTRAINT [PK_PlayedOns]
    PRIMARY KEY CLUSTERED ([HandId], [TableID] ASC);
GO

-- Creating primary key on [ActionID], [Name] in table 'Performs'
ALTER TABLE [dbo].[Performs]
ADD CONSTRAINT [PK_Performs]
    PRIMARY KEY CLUSTERED ([ActionID], [Name] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ActionID] in table 'Performs'
ALTER TABLE [dbo].[Performs]
ADD CONSTRAINT [FK_HandActionPerforms]
    FOREIGN KEY ([ActionID])
    REFERENCES [dbo].[HandActions]
        ([ActionID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Name] in table 'Performs'
ALTER TABLE [dbo].[Performs]
ADD CONSTRAINT [FK_PerformsPlayer]
    FOREIGN KEY ([Name])
    REFERENCES [dbo].[Players]
        ([Name])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PerformsPlayer'
CREATE INDEX [IX_FK_PerformsPlayer]
ON [dbo].[Performs]
    ([Name]);
GO

-- Creating foreign key on [Name] in table 'Plays'
ALTER TABLE [dbo].[Plays]
ADD CONSTRAINT [FK_PlayerPlays]
    FOREIGN KEY ([Name])
    REFERENCES [dbo].[Players]
        ([Name])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PlayerPlays'
CREATE INDEX [IX_FK_PlayerPlays]
ON [dbo].[Plays]
    ([Name]);
GO

-- Creating foreign key on [HandId] in table 'Plays'
ALTER TABLE [dbo].[Plays]
ADD CONSTRAINT [FK_HandPlays]
    FOREIGN KEY ([HandId])
    REFERENCES [dbo].[Hands]
        ([HandId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ActionID] in table 'Furthers1'
ALTER TABLE [dbo].[Furthers1]
ADD CONSTRAINT [FK_HandActionFurthers]
    FOREIGN KEY ([ActionID])
    REFERENCES [dbo].[HandActions]
        ([ActionID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_HandActionFurthers'
CREATE INDEX [IX_FK_HandActionFurthers]
ON [dbo].[Furthers1]
    ([ActionID]);
GO

-- Creating foreign key on [HandId] in table 'Furthers1'
ALTER TABLE [dbo].[Furthers1]
ADD CONSTRAINT [FK_FurthersHand]
    FOREIGN KEY ([HandId])
    REFERENCES [dbo].[Hands]
        ([HandId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [HandId] in table 'PlayedOns'
ALTER TABLE [dbo].[PlayedOns]
ADD CONSTRAINT [FK_PlayedOnHand]
    FOREIGN KEY ([HandId])
    REFERENCES [dbo].[Hands]
        ([HandId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [TableID] in table 'PlayedOns'
ALTER TABLE [dbo].[PlayedOns]
ADD CONSTRAINT [FK_PlayedOnTable]
    FOREIGN KEY ([TableID])
    REFERENCES [dbo].[Tables]
        ([TableID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PlayedOnTable'
CREATE INDEX [IX_FK_PlayedOnTable]
ON [dbo].[PlayedOns]
    ([TableID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------