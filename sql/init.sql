-- 创建数据库
CREATE DATABASE IF NOT EXISTS tlias DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE tlias;

-- 部门表
CREATE TABLE IF NOT EXISTS dept (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '部门ID',
    name VARCHAR(50) NOT NULL COMMENT '部门名称',
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW() COMMENT '修改时间'
) COMMENT '部门表';

-- 员工表
CREATE TABLE IF NOT EXISTS emp (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '员工ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(50) DEFAULT '123456' COMMENT '密码',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender TINYINT DEFAULT 1 COMMENT '性别, 1:男, 2:女',
    phone VARCHAR(20) COMMENT '手机号',
    job TINYINT COMMENT '职位, 1:班主任,2:讲师,3:学工主管,4:教研主管,5:咨询师',
    salary INT COMMENT '薪资',
    image VARCHAR(300) COMMENT '头像',
    entry_date DATE COMMENT '入职日期',
    dept_id INT COMMENT '关联的部门ID',
    create_time DATETIME DEFAULT NOW() COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW() COMMENT '修改时间'
) COMMENT '员工表';

-- 工作经历表
CREATE TABLE IF NOT EXISTS emp_expr (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    emp_id INT COMMENT '员工ID',
    begin DATE COMMENT '开始时间',
    end DATE COMMENT '结束时间',
    company VARCHAR(100) COMMENT '公司名称',
    job VARCHAR(100) COMMENT '职位'
) COMMENT '工作经历表';

-- 操作日志表
CREATE TABLE IF NOT EXISTS emp_log (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    operate_time DATETIME DEFAULT NOW() COMMENT '操作时间',
    info VARCHAR(500) COMMENT '详细信息'
) COMMENT '操作日志表';

-- ========================
-- 示例数据
-- ========================

-- 部门数据
INSERT INTO dept (name) VALUES ('教学部'), ('市场部'), ('教研部'), ('学工部'), ('咨询部');

-- 员工数据 (密码都是 123456)
INSERT INTO emp (username, password, name, gender, phone, job, salary, image, entry_date, dept_id) VALUES
('zhangsan', '123456', '张三', 1, '13800000001', 2, 15000, NULL, '2020-01-15', 1),
('lisi', '123456', '李四', 1, '13800000002', 4, 18000, NULL, '2019-03-10', 3),
('wangwu', '123456', '王五', 2, '13800000003', 1, 12000, NULL, '2021-06-01', 1),
('zhaoliu', '123456', '赵六', 2, '13800000004', 5, 10000, NULL, '2022-02-20', 5),
('sunqi', '123456', '孙七', 1, '13800000005', 3, 16000, NULL, '2018-09-12', 4),
('zhouba', '123456', '周八', 1, '13800000006', 2, 14000, NULL, '2020-11-03', 1),
('wujiu', '123456', '吴九', 2, '13800000007', 1, 11000, NULL, '2023-01-08', 1),
('zhengshi', '123456', '郑十', 2, '13800000008', 2, 13000, NULL, '2021-07-15', 1),
('chenyi', '123456', '陈一一', 1, '13800000009', 4, 19000, NULL, '2017-05-20', 3),
('liner', '123456', '林二二', 2, '13800000010', 5, 9500, NULL, '2022-09-01', 5);

-- 工作经历数据
INSERT INTO emp_expr (emp_id, begin, end, company, job) VALUES
(1, '2016-03-01', '2020-01-01', '某教育机构', 'Java讲师'),
(2, '2015-07-01', '2019-03-01', '某科技公司', '技术主管'),
(3, '2018-09-01', '2021-06-01', '某文化传播公司', '班主任'),
(5, '2014-04-01', '2018-09-01', '某集团', '学工主管'),
(6, '2017-08-01', '2020-11-01', '某互联网公司', '前端讲师'),
(9, '2013-06-01', '2017-05-01', '某知名企业', '架构师');
