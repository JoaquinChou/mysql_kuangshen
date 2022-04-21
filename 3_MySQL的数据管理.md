# 3、MySQL的数据管理
## 3.1、外键(了解即可)
> 方式一：创建表的时候，增加约束（麻烦，比较复杂）
```sql
CREATE TABLE `grade`(
	`grade_id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '年级id',
	`grade_name` VARCHAR(20) NOT NULL COMMENT '年级名称',
	PRIMARY KEY(`grade_id`)
)ENGINE=INNODB CHARSET=utf8;

-- 学生表的 grade_id字段要去引用年级表的 grade_id
-- 定义外键key
-- 给这个外键添加约束(执行引用) references
CREATE TABLE `student`(
	`id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '学号',
	`name` VARCHAR(20) NOT NULL DEFAULT '匿名' COMMENT '姓名',
	`pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '登录密码',
	`sex` VARCHAR(2) NOT NULL DEFAULT '女' COMMENT '性别',
	`birthday` DATETIME DEFAULT NULL COMMENT '出生日期',
	`grade_id` INT(10) NOT NULL COMMENT '学生的年级',
	`address` VARCHAR(100) DEFAULT NULL COMMENT '家庭住址',
	`email` VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
	PRIMARY KEY(`id`),
	KEY `FK_grade_id` (`grade_id`),
	CONSTRAINT `FK_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`grade_id`)
	
)ENGINE=INNODB CHARSET=utf8;
```
删除有外键关系的表的时候，必须删除引用别人的表(从表)，再删除被引用的表(主表)。

> 方式二：创建表成功后，添加外键约束。
```sql
-- 创建表的时候没有外键关系
ALTER TABLE `student` 
ADD CONSTRAINT `FK_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`grade_id`);

-- ALTER TABLE 表名 ADD CONSTRAINT 约束名 FOREIGN KEY (作为外键的列) REFENCES 哪个表(哪个字段);
```
以上操作是物理外键，数据库级别的外键，不建议使用(避免数据库过多造成困扰，这里了解即可~)

<font color='red'>最佳实现</font>
- 数据库就是单纯的表，只用来存数据，只有行(数据)和列(字段)；
- 如果想使用多张表的数据，考虑程序去实现。



## 3.2、DML语言(全部记住)
<b>数据库的意义：</b>数据存储和数据管理。

DML语言：数据操作语言。
- insert
- update
- delete


## 3.3、添加
> insert
```sql
-- 插入语句(添加)
-- 由于主键自增可以省略(如果不写表的字段，他就会一一匹配)
-- 写插入语句，数据和字段要一一对应
-- insert into 表名([字段1，字段2，字段3，...]) values('值1','值2','值3',...)
INSERT INTO `grade` (`grade_name`) VALUES('大二');

-- 插入多条数据
-- insert into 表名([字段，...]) values('值1'),('值2'),('值3');
INSERT INTO `grade`(`grade_name`) VALUES('大一'),('大二'),('大三');

-- 插入多个字段
INSERT INTO `student`(`name`) VALUES('张三');
INSERT INTO `student`(`name`, `pwd`, `sex`) VALUES('张三', 'aaaaa', '男');
INSERT INTO `student`(`name`, `pwd`, `sex`) VALUE('王五', 'sssss', '女');
```
语法：insert into 表名([字段1，字段2，字段3，...]) values('值1','值2','值3',...)

注意事项：
- 字段与字段之间使用英文逗号隔开
- 字段是可以省略的，但是后面的值要一一对应，不能少
- 可以同时插入多条数据，VALUES后面的值，需要使用逗号隔开——`VALUES(),()`
  
## 3.4、修改
> update 修改谁 （条件） set原来的值=新值
```sql
-- 修改学员的名字，记得带条件！
UPDATE `student` SET `name`='狂神' WHERE id = 1;

-- 不指定条件，则会改动所有的表！
UPDATE `student` SET `name`='长江七号';

-- 修改多个属性，逗号隔开即可
UPDATE `student` SET `name`='狂神', email='100249585@qq.com' WHERE id=1;

```
语法：`UPDATE 表名 SET 列名=value[列名=value,列名=value...] WHERE [条件]`

条件：where子句 运算符 id=某个值 >某个值 <某个值，在某个区间进行修改

操作符会返回布尔值

|操作符|含义|范围|结果|
|:-:|:-:|:-:|:-:|
|=|等于|5=6|false|
|<>或!=|不等于|5<>6|true|
|>|大于|5>6|false|
|<|小于|5<6|true|
|<=|小于等于|5<=6|true|
|>=|大于等于|5>=6|false|
|BETWRRN...AND...|在某个范围内|[2,5]||
|AND|我和你&&|5>1 and 1>2|false|
|or|我或你\|\||5>1 or 1>2|true|

```sql
-- 通过多个条件定位数据，无上限！ && ||
UPDATE `student` SET `name`='长江七号' WHERE `name`='狂神99' AND `sex`='女';
```
语法：`UPDATE 表名 SET 列名=value,[列名=value...] WHERE [条件]`

注意：
- 列名是数据库的列，尽量带上``
- 条件：筛选的条件，如果没有指定，则会修改所有的列
- value，是一个具体的值，也可以是一个变量
- 多个设置的属性之间，使用英文逗号隔开

```sql
-- 通过多个条件定位数据，无上限！ && ||
UPDATE `student` SET `birthday`=SYSDATE(), `name`='长江七号' WHERE `name`='狂神99' AND `sex`='男';

```
## 3.5、删除
> delete命令

语法：`delete from 表名 [where 条件]`
```sql
-- 删除数据(避免这样写，会全部删除)
DELETE FROM `student`;

-- 删除指定数据
DELETE FROM `student` WHERE `id`=1;
```

> TRUNCATE 命令

作用：完全清空一个数据库表，表的结构和索引约束不会变！
```sql
-- 清空 student 表
TRUNCATE `student`;
```

> delete 和 TRUNCATE 的区别
- 相同点：都能删除表的数据，都不会删除表的结构
- 不同点：
    + TRUNCATE 会重新设置 自增列，会使得计数器归零
    + TRUNCATE 不会影响事务

```sql
-- 测试 delete 和 TRANCATE 区别
CREATE TABLE `test`(
	`id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '序号',
	`coll` VARCHAR(20) NOT NULL COMMENT '对应值',
	PRIMARY KEY(`id`)
)ENGINE=INNODB CHARSET=utf8;

INSERT INTO `test`(`coll`) VALUES('1'),('2'),('3');

DELETE FROM `test`; -- 不会影响自增
TRUNCATE `test`; -- 自增会归零
```
了解即可：`DELETE删除的问题`，重启数据库的现象
- 如果表是INNODB引擎，自增列会从1开始 （因为INNODB的数据是存储在内存中的，断电即失）
- 如果表是MyISAM引擎，自增列会从上一个自增量开始（因为MyISAM的数据是存储在本地文件中，不会丢失）