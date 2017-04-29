﻿USE [master]
GO

CREATE DATABASE [FileSharing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FileSharing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FileSharing.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FileSharing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FileSharing_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [FileSharing] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FileSharing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [FileSharing] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [FileSharing] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [FileSharing] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [FileSharing] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [FileSharing] SET ARITHABORT OFF 
GO

ALTER DATABASE [FileSharing] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [FileSharing] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [FileSharing] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [FileSharing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [FileSharing] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [FileSharing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [FileSharing] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [FileSharing] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [FileSharing] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [FileSharing] SET  DISABLE_BROKER 
GO

ALTER DATABASE [FileSharing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [FileSharing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [FileSharing] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [FileSharing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [FileSharing] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [FileSharing] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [FileSharing] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [FileSharing] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [FileSharing] SET  MULTI_USER 
GO

ALTER DATABASE [FileSharing] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [FileSharing] SET DB_CHAINING OFF 
GO

ALTER DATABASE [FileSharing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [FileSharing] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [FileSharing] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [FileSharing] SET QUERY_STORE = OFF
GO

USE [FileSharing]
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [FileSharing] SET  READ_WRITE 
GO


USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[User](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_User] UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Session](
	[SecurityToken] [varchar](200) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[DateLastAccess] [datetime] NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[SecurityToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_User]
GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Group](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IdAdmin] [bigint] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Group] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_User] FOREIGN KEY([IdAdmin])
REFERENCES [dbo].[User] ([Id])
GO

ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_User]
GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserGroup](
	[IdUser] [bigint] NOT NULL,
	[IdGroup] [bigint] NOT NULL,
	[DateInclusionRequest] [datetime] NOT NULL,
	[DateInclusionApproval] [datetime] NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_UserGroup_Group] FOREIGN KEY([IdGroup])
REFERENCES [dbo].[Group] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK_UserGroup_Group]
GO

ALTER TABLE [dbo].[UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_UserGroup_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK_UserGroup_User]
GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Folder](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IdFolderRoot] [bigint] NULL,
 CONSTRAINT [PK_Folder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_Folder_Folder] FOREIGN KEY([IdFolderRoot])
REFERENCES [dbo].[Folder] ([Id])
GO

ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_Folder_Folder]
GO

ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_Folder_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
GO

ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_Folder_User]
GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Document](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Filename] [varchar](200) NOT NULL,
	[IsPublic] [bigint] NOT NULL,
	[IdGroup] [bigint] NULL,
	[IdFolder] [bigint] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Folder] FOREIGN KEY([IdFolder])
REFERENCES [dbo].[Folder] ([Id])
GO

ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Folder]
GO

ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Group] FOREIGN KEY([IdGroup])
REFERENCES [dbo].[Group] ([Id])
GO

ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Group]
GO

ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_User] FOREIGN KEY([IdUser])
REFERENCES [dbo].[User] ([Id])
GO

ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_User]
GO

USE [FileSharing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Audit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Object] [varchar](50) NOT NULL,
	[IdObject] [varchar](50) NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[Description] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO