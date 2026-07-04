# Tlias Web Management

企业级员工管理系统后端服务，基于 Spring Boot 3 与 MyBatis 构建，提供部门管理、员工信息管理、文件存储及数据统计分析等 RESTful API。

## 技术架构

| 组件 | 选型 | 版本 |
|------|------|------|
| 运行环境 | Java | 17 |
| 应用框架 | Spring Boot | 3.2.10 |
| ORM 框架 | MyBatis (Spring Boot Starter) | 3.0.3 |
| 数据库 | MySQL | 8.x+ |
| 分页插件 | PageHelper | 1.4.7 |
| 构建工具 | Maven | 3.x+ |

## 项目结构

```
com.itheima
├── config/
│   └── WebConfig.java              # CORS 跨域配置
├── controller/
│   ├── DeptController.java         # 部门管理 HTTP 接口
│   ├── EmpController.java          # 员工管理 HTTP 接口
│   ├── ReportController.java       # 数据报表 HTTP 接口
│   └── UploadController.java       # 文件上传 HTTP 接口
├── exception/
│   └── GlobalExceptionHandler.java # 全局异常处理器
├── mapper/
│   ├── DeptMapper.java             # 部门数据访问
│   ├── EmpMapper.java              # 员工数据访问
│   ├── EmpExprMapper.java          # 工作经历数据访问
│   └── EmpLogMapper.java           # 操作日志数据访问
├── pojo/
│   ├── Dept.java                   # 部门实体
│   ├── Emp.java                    # 员工实体
│   ├── EmpExpr.java                # 工作经历实体
│   ├── EmpLog.java                 # 操作日志实体
│   ├── EmpQueryParam.java          # 员工查询参数封装
│   ├── JobOption.java              # 职位统计数据视图
│   ├── PageResult.java             # 分页结果通用封装
│   └── Result.java                 # 统一响应体
├── service/
│   ├── DeptService.java
│   ├── EmpService.java
│   ├── EmpLogService.java
│   ├── ReportService.java
│   └── impl/                       # 服务层实现
└── TliasWebManagementApplication.java
```

## 快速启动

### 前置条件

- JDK 17+
- Maven 3.x
- MySQL 8.0+
- IDE（推荐 IntelliJ IDEA）

### 步骤

#### 1. 初始化数据库

执行项目根目录下的 SQL 脚本以创建数据库、表结构及示例数据：

```bash
mysql -u root -p < sql/init.sql
```

该脚本将自动创建 `tlias` 数据库以及 `dept`、`emp`、`emp_expr`、`emp_log` 四张表，并写入预设的测试数据。

#### 2. 配置数据源

编辑 `src/main/resources/application.yml`，配置数据库连接信息：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/tlias?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: your_username
    password: your_password
```

#### 3. 启动服务

```bash
# 开发模式
mvn spring-boot:run

# 生产部署
mvn clean package -DskipTests
java -jar target/tlias-0.0.1-SNAPSHOT.jar
```

服务启动后默认监听 `http://localhost:8080`。

## API 参考

### 部门管理

| HTTP 方法 | 路径 | 功能描述 |
|-----------|------|----------|
| GET | `/depts` | 获取部门列表 |
| POST | `/depts` | 新增部门 |
| PUT | `/depts` | 编辑部门信息 |
| DELETE | `/depts/{id}` | 删除指定部门 |

### 员工管理

| HTTP 方法 | 路径 | 功能描述 |
|-----------|------|----------|
| GET | `/emps` | 分页查询员工（支持按姓名、性别、入职日期范围筛选） |
| GET | `/emps/{id}` | 查询员工详情（含工作经历） |
| POST | `/emps` | 新增员工 |
| PUT | `/emps` | 编辑员工信息 |
| DELETE | `/emps/{id}` | 删除指定员工 |

### 文件上传

| HTTP 方法 | 路径 | 功能描述 |
|-----------|------|----------|
| POST | `/upload` | 上传文件（单文件上限 10MB，请求上限 100MB） |

### 数据报表

| HTTP 方法 | 路径 | 功能描述 |
|-----------|------|----------|
| GET | `/report/job` | 各职位人数统计 |
| GET | `/report/emp` | 员工人数统计 |

### 通用响应格式

所有接口遵循统一的 JSON 响应结构：

```json
{
  "code": 1,
  "message": "success",
  "data": {}
}
```

## 数据库模型

| 表名 | 说明 | 核心字段 |
|------|------|----------|
| `dept` | 部门 | id, name, create_time, update_time |
| `emp` | 员工 | id, username, password, name, gender, phone, job, salary, image, entry_date, dept_id |
| `emp_expr` | 工作经历 | id, emp_id, begin, end, company, job |
| `emp_log` | 操作日志 | id, operate_time, info |

## 设计规范

- **统一响应**：所有控制器返回 `Result` 封装体，包含状态码、消息与数据三要素
- **全局异常**：通过 `GlobalExceptionHandler` 集中处理业务异常与系统异常，避免异常处理逻辑分散在各业务层
- **分页抽象**：基于 PageHelper 实现物理分页，查询结果统一封装为 `PageResult` 返回
- **自动映射**：启用 MyBatis `map-underscore-to-camel-case`，数据库下划线命名自动映射为 Java 驼峰命名属性
- **跨域支持**：`WebConfig` 中统一配置 CORS，支持跨域访问
- **日志记录**：员工关键操作通过 `EmpLog` 表记录操作日志，实现操作可追溯
