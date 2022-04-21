/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.33 : Database - school
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE = ''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS */`school` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `school`;

/*Table structure for table `grade` */

DROP TABLE IF EXISTS `grade`;

CREATE TABLE `grade`
(
    `GradeID`   INT(11)     NOT NULL AUTO_INCREMENT COMMENT '年级编号',
    `GradeName` VARCHAR(50) NOT NULL COMMENT '年级名称',
    PRIMARY KEY (`GradeID`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8;

/*Data for the table `grade` */

INSERT INTO `grade`(`GradeID`, `GradeName`)
VALUES (1, '大一'),
       (2, '大二'),
       (3, '大三'),
       (4, '大四'),
       (5, '预科班');

/*Table structure for table `result` */

DROP TABLE IF EXISTS `result`;

CREATE TABLE `result`
(
    `StudentNo`     INT(4)   NOT NULL COMMENT '学号',
    `SubjectNo`     INT(4)   NOT NULL COMMENT '课程编号',
    `ExamDate`      DATETIME NOT NULL COMMENT '考试日期',
    `StudentResult` INT(4)   NOT NULL COMMENT '考试成绩',
    KEY `SubjectNo` (`SubjectNo`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8;

/*Data for the table `result` */

INSERT INTO `result`(`StudentNo`, `SubjectNo`, `ExamDate`, `StudentResult`)
VALUES (1000, 1, '2013-11-11 16:00:00', 85),
       (1000, 2, '2013-11-12 16:00:00', 70),
       (1000, 3, '2013-11-11 09:00:00', 68),
       (1000, 4, '2013-11-13 16:00:00', 98),
       (1000, 5, '2013-11-14 16:00:00', 58);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student`
(
    `StudentNo`    INT(4)       NOT NULL COMMENT '学号',
    `LoginPwd`     VARCHAR(20) DEFAULT NULL,
    `StudentName`  VARCHAR(20) DEFAULT NULL COMMENT '学生姓名',
    `Sex`          TINYINT(1)  DEFAULT NULL COMMENT '性别，0或1',
    `GradeId`      INT(11)     DEFAULT NULL COMMENT '年级编号',
    `Phone`        VARCHAR(50)  NOT NULL COMMENT '联系电话，允许为空',
    `Address`      VARCHAR(255) NOT NULL COMMENT '地址，允许为空',
    `BornDate`     DATETIME    DEFAULT NULL COMMENT '出生时间',
    `Email`        VARCHAR(50)  NOT NULL COMMENT '邮箱账号允许为空',
    `IdentityCard` VARCHAR(18) DEFAULT NULL COMMENT '身份证号',
    PRIMARY KEY (`StudentNo`),
    UNIQUE KEY `IdentityCard` (`IdentityCard`),
    KEY `Email` (`Email`)
) ENGINE = MYISAM
  DEFAULT CHARSET = utf8;

/*Data for the table `student` */

INSERT INTO `student`(`StudentNo`, `LoginPwd`, `StudentName`, `Sex`, `GradeId`, `Phone`, `Address`, `BornDate`, `Email`,
                      `IdentityCard`)
VALUES (1000, '123456', '张伟', 0, 2, '13800001234', '北京朝阳', '1980-01-01 00:00:00', 'text123@qq.com',
        '123456198001011234'),
       (1001, '123456', '赵强', 1, 3, '13800002222', '广东深圳', '1990-01-01 00:00:00', 'text111@qq.com',
        '123456199001011233');

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject`
(
    `SubjectNo`   INT(11) NOT NULL AUTO_INCREMENT COMMENT '课程编号',
    `SubjectName` VARCHAR(50) DEFAULT NULL COMMENT '课程名称',
    `ClassHour`   INT(4)      DEFAULT NULL COMMENT '学时',
    `GradeID`     INT(4)      DEFAULT NULL COMMENT '年级编号',
    PRIMARY KEY (`SubjectNo`)
) ENGINE = INNODB
  DEFAULT CHARSET = utf8;

/*Data for the table `subject` */

INSERT INTO `subject`(`SubjectNo`, `SubjectName`, `ClassHour`, `GradeID`)
VALUES (1, '高等数学-1', 110, 1),
       (2, '高等数学-2', 110, 2),
       (3, '高等数学-3', 100, 3),
       (4, '高等数学-4', 130, 4),
       (5, 'C语言-1', 110, 1),
       (6, 'C语言-2', 110, 2),
       (7, 'C语言-3', 100, 3),
       (8, 'C语言-4', 130, 4),
       (9, 'Java程序设计-1', 110, 1),
       (10, 'Java程序设计-2', 110, 2),
       (11, 'Java程序设计-3', 100, 3),
       (12, 'Java程序设计-4', 130, 4),
       (13, '数据库结构-1', 110, 1),
       (14, '数据库结构-2', 110, 2),
       (15, '数据库结构-3', 100, 3),
       (16, '数据库结构-4', 130, 4),
       (17, 'C#基础', 130, 1);

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;
