-- Parse::SQL::Dia      version 0.27                                                             
-- Documentation        http://search.cpan.org/dist/Parse-Dia-SQL/                               
-- Environment          Perl 5.024000, /home/ramortegui/perl5/perlbrew/perls/perl-5.24.0/bin/perl
-- Architecture         x86_64-linux                                                             
-- Target Database      postgres                                                                 
-- Input file           ECommerceDB.dia                                                          
-- Generated at         Thu Dec  8 20:58:55 2016                                                 
-- Typemap for postgres not found in input file                                                  

-- get_constraints_drop 
alter table sales_orders drop constraint fk_coupon_order ;
alter table product_tags drop constraint fk_producs_product_tags ;
alter table product_tags drop constraint fk_tags_product_tags ;
alter table user_roles drop constraint fk_roles_user_roles ;
alter table user_roles drop constraint fk_users_user_roles ;
alter table product_categories drop constraint fk_category_products_categories ;
alter table sales_orders drop constraint fk_time_frame_sales_order ;
alter table sales_orders drop constraint fk_user_sales_order ;
alter table sales_orders drop constraint fk_session_sales_order ;
alter table products drop constraint fk_product_statuses_product ;
alter table order_products drop constraint fk_sales_orders_order_products ;
alter table cc_transactions drop constraint fk_sales_order_cc_transaction ;
alter table product_categories drop constraint fk_product_product_category ;

-- get_permissions_drop 

-- get_view_drop

-- get_schema_drop
drop table users;
drop table roles;
drop table user_roles;
drop table time_frames;
drop table categories;
drop table products;
drop table tags;
drop table sales_orders;
drop table coupons;
drop table product_tags;
drop table cc_transactions;
drop table sessions;
drop table product_statuses;
drop table product_categories;
drop table order_products;

-- get_smallpackage_pre_sql 

-- get_schema_create
create table users (
   id          serial                   not null,
   username    varchar(255) unique              ,
   first_name  varchar(255)                     ,
   last_name   varchar(255)                     ,
   active      bool                             ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_users primary key (id)
)   ;
create table roles (
   id          serial                   not null,
   name        varchar(255)                     ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_roles primary key (id)
)   ;
create table user_roles (
   user_id     integer                  not null,
   role_id     integer                  not null,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_user_roles primary key (user_id,role_id)
)   ;
create table time_frames (
   id          serial                   not null,
   start_time  time with time zone              ,
   end_time    time with time zone              ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_time_frames primary key (id)
)   ;
create table categories (
   id          serial                   not null,
   name        varchar(255)                     ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_categories primary key (id)
)   ;
create table products (
   sku               varchar(255)             not null,
   name              varchar(255)                     ,
   description       text                             ,
   product_status_id integer                          ,
   regular_price     numeric                          ,
   discount_price    numeric                          ,
   category_id       integer                          ,
   quantity          integer                          ,
   taxable           bool                             ,
   inserted_at       timestamp with time zone         ,
   updated_at        timestamp with time zone         ,
   constraint pk_products primary key (sku)
)   ;
create table tags (
   id          serial                   not null,
   name        varchar(255)                     ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_tags primary key (id)
)   ;
create table sales_orders (
   id           serial                   not null,
   order_date   date                             ,
   total        numeric                          ,
   coupon_id    integer                          ,
   session_id   varchar(255)                     ,
   user_id      integer                          ,
   timeframe_id integer                          ,
   inserted_at  timestamp with time zone         ,
   updated_at   timestamp with time zone         ,
   constraint pk_sales_orders primary key (id)
)   ;
create table coupons (
   id          serial                   not null      ,
   code        varchar(255)                           ,
   description text                                   ,
   active      bool                                   ,
   value       numeric                                ,
   start_date  timestamp with time zone               ,
   end_date    timestamp with time zone               ,
   multiple    bool                      default false,
   inserted_at timestamp with time zone               ,
   updated_at  timestamp with time zone               ,
   constraint pk_coupons primary key (id)
)   ;
create table product_tags (
   product_sku varchar(255)             not null,
   tag_id      integer                  not null,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_product_tags primary key (product_sku,tag_id)
)   ;
create table cc_transactions (
   code               varchar(255)             not null,
   order_id           integer                          ,
   transdate          timestamp with time zone         ,
   processor          varchar(255)                     ,
   processor_trans_id varchar(255)                     ,
   amount             numeric                          ,
   cc_num             varchar(255)                     ,
   cc_type            varchar(255)                     ,
   cc_exp             varchar(255)                     ,
   response           text                             ,
   inserted_at        timestamp with time zone         ,
   updated_at         timestamp with time zone         ,
   constraint pk_cc_transactions primary key (code)
)   ;
create table sessions (
   id          varchar(255)             not null,
   data        text                             ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_sessions primary key (id)
)   ;
create table product_statuses (
   id          serial                   not null,
   name        varchar(255)                     ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_product_statuses primary key (id)
)   ;
create table product_categories (
   category_id integer                  not null,
   product_sku varchar(255)             not null,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_product_categories primary key (category_id,product_sku)
)   ;
create table order_products (
   sku         varchar(255)             not null,
   order_id    integer                  not null,
   name        varchar(255)                     ,
   description text                             ,
   price       numeric                          ,
   quantity    integer                          ,
   subtotal    numeric                          ,
   inserted_at timestamp with time zone         ,
   updated_at  timestamp with time zone         ,
   constraint pk_order_products primary key (sku,order_id)
)   ;

-- get_view_create

-- get_permissions_create

-- get_inserts

-- get_smallpackage_post_sql

-- get_associations_create
alter table sales_orders add constraint fk_coupon_order 
    foreign key (coupon_id)
    references coupons (id) ;
alter table product_tags add constraint fk_producs_product_tags 
    foreign key (product_sku)
    references products (sku) ;
alter table product_tags add constraint fk_tags_product_tags 
    foreign key (tag_id)
    references tags (id) ;
alter table user_roles add constraint fk_roles_user_roles 
    foreign key (role_id)
    references roles (id) ;
alter table user_roles add constraint fk_users_user_roles 
    foreign key (user_id)
    references users (id) ;
alter table product_categories add constraint fk_category_products_categories 
    foreign key (category_id)
    references categories (id) ;
alter table sales_orders add constraint fk_time_frame_sales_order 
    foreign key (timeframe_id)
    references time_frames (id) ;
alter table sales_orders add constraint fk_user_sales_order 
    foreign key (user_id)
    references users (id) ;
alter table sales_orders add constraint fk_session_sales_order 
    foreign key (session_id)
    references sessions (id) ;
alter table products add constraint fk_product_statuses_product 
    foreign key (product_status_id)
    references product_statuses (id) ;
alter table order_products add constraint fk_sales_orders_order_products 
    foreign key (order_id)
    references sales_orders (id) ;
alter table cc_transactions add constraint fk_sales_order_cc_transaction 
    foreign key (order_id)
    references sales_orders (id) ;
alter table product_categories add constraint fk_product_product_category 
    foreign key (product_sku)
    references products (sku) ;
