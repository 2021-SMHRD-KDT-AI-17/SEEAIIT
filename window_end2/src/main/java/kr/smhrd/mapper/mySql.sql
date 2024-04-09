-- member table 생성 
create table member(
	email varchar(100) not null,
	pw varchar(100) not null,
	tel varchar(100) not null,
	address varchar(100) not null,
	primary key(email)
);

-- test 데이터 넣기
insert into member values('admin@smhrd.com', '1234', '010-0000-0000', '동구 동명동');
insert into member values('admin', '1234', '010-0000-0000', '동구 동명동');
-- 조회하기
select * from member;

-- message table 생성
create table message(
	num int not null auto_increment,
	sendE varchar(100),
	receiveE varchar(100),
	message varchar(2000),
	m_date datetime default now(),
	primary key(num)
);

-- test 데이터
insert into message(sendE, receiveE, message) values('test1', 'test1', 'test1');
insert into message(sendE, receiveE, message) values('test2', 'test2', 'test2');

-- 조회하기
select * from message;

-- board table 생성
create table board(
	num int not null auto_increment,
	title varchar(100) not null,
	writer varchar(100) not null,
	filename varchar(100),
	content varchar(2000) not null,
	b_date datetime default now(),
	primary key(num)
);

-- test 데이터
insert into board(title, writer, filename, content) values('test1', 'test1', 'test1', 'test1');
insert into board(title, writer, filename, content) values('test1', 'test1', 'test1', 'test1');

-- 조회
select * from board;

drop table test_member;

-- test_member table 생성 
create table user_info(
	rank_num int not null,
	id varchar(100) not null,
	pw varchar(100) not null,
	name varchar(100) not null,
	email varchar(100) not null,
	tel varchar(100) not null,
	birthday date not null,
	primary key(id)
);

insert into user_info values(2,'admin', '1234', '박상윤', 'sysy0514@naver.com','010-5026-1135','1995-05-14');

select * from user_info;

update user_info set rank_num=2 where id='admin';

ALTER TABLE user_info ADD COLUMN point int not null;

create table comment(
   num int,
   writer varchar(50),
   comment varchar(2000)
);

delete from user_info where name='test2';


select * from tCalendar3;
update user_info set point=2 where name='고현우';
update user_info set point=3 where name='고희청';
update user_info set point=4 where name='권승호';
update user_info set point=5 where name='김대원';
update user_info set point=6 where name='김동준';
update user_info set point=7 where name='김혜린';
update user_info set point=8 where name='나유정';
update user_info set point=9 where name='박상윤';
update user_info set point=10 where name='서동현';
update user_info set point=11 where name='신혜선';
update user_info set point=12 where name='양세진';
update user_info set point=13 where name='오현진';
update user_info set point=14 where name='유승주';
update user_info set point=15 where name='윤옥산';
update user_info set point=16 where name='윤정원';
update user_info set point=17 where name='이봄';
update user_info set point=18 where name='임명택';
update user_info set point=19 where name='장지오';
update user_info set point=20 where name='정두연';
update user_info set point=21 where name='정재원';
update user_info set point=22 where name='조가현';
update user_info set point=23 where name='조영훈';
update user_info set point=24 where name='홍창민';
