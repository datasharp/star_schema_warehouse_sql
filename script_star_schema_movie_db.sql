USE [master]
GO
/****** Object:  Database [movie_db]    Script Date: 8/13/2023 3:22:06 PM ******/
CREATE DATABASE [movie_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'movie_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\movie_db.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'movie_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\movie_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [movie_db] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [movie_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [movie_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [movie_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [movie_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [movie_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [movie_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [movie_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [movie_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [movie_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [movie_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [movie_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [movie_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [movie_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [movie_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [movie_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [movie_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [movie_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [movie_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [movie_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [movie_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [movie_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [movie_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [movie_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [movie_db] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [movie_db] SET  MULTI_USER 
GO
ALTER DATABASE [movie_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [movie_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [movie_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [movie_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [movie_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [movie_db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [movie_db] SET QUERY_STORE = ON
GO
ALTER DATABASE [movie_db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [movie_db]
GO
/****** Object:  Table [dbo].[dim_actor]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_actor](
	[actor_id] [int] NOT NULL,
	[actor] [nvarchar](155) NULL,
 CONSTRAINT [PK_dim_actor] PRIMARY KEY CLUSTERED 
(
	[actor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_actor_movie_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_actor_movie_assoc](
	[dim_actor_movie_assoc_id] [int] NOT NULL,
	[actor_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
 CONSTRAINT [PK_dim_actor_movie_assoc] PRIMARY KEY CLUSTERED 
(
	[dim_actor_movie_assoc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_director]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_director](
	[director_id] [int] NOT NULL,
	[director] [nvarchar](255) NULL,
 CONSTRAINT [PK_dim_director] PRIMARY KEY CLUSTERED 
(
	[director_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_genre_movie_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_genre_movie_assoc](
	[dim_genre_movie_assoc_id] [int] NOT NULL,
	[genre_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
 CONSTRAINT [PK_dim_genre_movie_assoc] PRIMARY KEY CLUSTERED 
(
	[dim_genre_movie_assoc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_movie]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_movie](
	[film_id] [int] NOT NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](450) NULL,
 CONSTRAINT [PK_dim_movie] PRIMARY KEY CLUSTERED 
(
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_year]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_year](
	[date_id] [int] NOT NULL,
	[year] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_film]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_film](
	[runtime_minutes] [float] NULL,
	[rating] [float] NULL,
	[revenue_millions] [float] NULL,
	[votes] [int] NULL,
	[metascore] [int] NULL,
	[film_id] [int] NOT NULL,
	[director_id] [int] NOT NULL,
	[year_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[land_movies]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[land_movies](
	[Rank] [smallint] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Genre] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Director] [nvarchar](50) NOT NULL,
	[Actors] [nvarchar](100) NOT NULL,
	[Year] [smallint] NOT NULL,
	[Runtime_Minutes] [tinyint] NOT NULL,
	[Rating] [float] NOT NULL,
	[Votes] [int] NOT NULL,
	[Revenue_Millions] [float] NULL,
	[Metascore] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_actor]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_actor](
	[actor_id] [int] IDENTITY(1,1) NOT NULL,
	[actor] [nvarchar](155) NULL,
 CONSTRAINT [PK_map_actor] PRIMARY KEY CLUSTERED 
(
	[actor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_director]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_director](
	[director_id] [int] IDENTITY(1,1) NOT NULL,
	[director] [nvarchar](155) NULL,
 CONSTRAINT [PK_map_director] PRIMARY KEY CLUSTERED 
(
	[director_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_film]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_film](
	[film_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[film_year] [int] NULL,
	[director] [nvarchar](155) NULL,
 CONSTRAINT [PK_map_film] PRIMARY KEY CLUSTERED 
(
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_genre]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_genre](
	[genre_id] [int] IDENTITY(1,1) NOT NULL,
	[genre] [nvarchar](155) NULL,
 CONSTRAINT [PK_map_genre] PRIMARY KEY CLUSTERED 
(
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_year]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_year](
	[year_id] [int] IDENTITY(1,1) NOT NULL,
	[year] [int] NOT NULL,
 CONSTRAINT [year_year] PRIMARY KEY CLUSTERED 
(
	[year_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_actor]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_actor](
	[actor_id] [int] NOT NULL,
	[actor] [nvarchar](155) NULL,
 CONSTRAINT [PK_stg_actor] PRIMARY KEY CLUSTERED 
(
	[actor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_actor_film_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_actor_film_assoc](
	[stg_actor_film_id] [int] IDENTITY(1,1) NOT NULL,
	[actor_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
 CONSTRAINT [PK_stg_actor_film] PRIMARY KEY CLUSTERED 
(
	[stg_actor_film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_film]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_film](
	[film_id] [int] NOT NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[director] [nvarchar](155) NULL,
	[film_year] [int] NULL,
	[runtime_minutes] [int] NULL,
	[rating] [float] NULL,
	[votes] [int] NULL,
	[revenue_millions] [float] NULL,
	[metascore] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_genre]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_genre](
	[genre_id] [int] NOT NULL,
	[genre] [nvarchar](155) NULL,
 CONSTRAINT [PK_stg_genre] PRIMARY KEY CLUSTERED 
(
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stg_genre_film_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_genre_film_assoc](
	[stg_genre_film_id] [int] IDENTITY(1,1) NOT NULL,
	[genre_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
 CONSTRAINT [PK_stg_genre_film_id] PRIMARY KEY CLUSTERED 
(
	[stg_genre_film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [uidx_dim_actor_movie_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uidx_dim_actor_movie_assoc] ON [dbo].[dim_actor_movie_assoc]
(
	[actor_id] ASC,
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uidx_dim_genre_movie_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uidx_dim_genre_movie_assoc] ON [dbo].[dim_genre_movie_assoc]
(
	[genre_id] ASC,
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uidx_title_film_year_director]    Script Date: 8/13/2023 3:22:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uidx_title_film_year_director] ON [dbo].[map_film]
(
	[title] ASC,
	[film_year] ASC,
	[director] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uidx_actor_id_film_id]    Script Date: 8/13/2023 3:22:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uidx_actor_id_film_id] ON [dbo].[stg_actor_film_assoc]
(
	[actor_id] ASC,
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uidx_stg_genre_film_assoc]    Script Date: 8/13/2023 3:22:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uidx_stg_genre_film_assoc] ON [dbo].[stg_genre_film_assoc]
(
	[genre_id] ASC,
	[film_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [movie_db] SET  READ_WRITE 
GO
