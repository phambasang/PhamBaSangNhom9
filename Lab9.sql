create table Lop(
MaLop char(5) not null primary key,
TenLop nvarchar(20),
SiSo int)
create table Sinhvien(
MaSV char(5) not null primary key,
Hoten nvarchar(20),
Ngaysinh date,
MaLop char(5) constraint fk_malop references lop(malop))
create table MonHoc(
MaMH char(5) not null primary key,
TenMH nvarchar(20))

insert Sinhvien values
('01','NGUYEN HOC KHA','2002-7-8','CNTT1'),
('02','KIM HUNG','1999-10-9','CNTT2'),
('03','HOANG MINH TRIET','2002-5-6','CNTT3')
insert Lop values
('CNTT1','lop CNTT1',38),
('CNTT2','lop CNTT2',40),
('CNTT3','lop CNTT3',39)

insert MonHoc values
('XLA','Xu Ly Anh'),
('CSDL','Co so du lieu'),
('SQL','He quan tri CSDL'),
('PTW','Phat trien Web')

insert KetQua values
('01','XLA',8),
('01','SQL',7),
('02','XLA',8),
('01','CSDL',5),
('02','PTW',5)

--câu1
create function diemtb (@msv char(5))
returns float
as
begin
 declare @tb float
 set @tb = (select avg(Diemthi)
 from KetQua
where MaSV=@msv)
 return @tb
end
go
select dbo.diemtb ('01')
--câu 2
create function trbinhlop(@malop char(5))
returns table
as
return
 select s.masv, Hoten, trungbinh=dbo.diemtb(s.MaSV)
 from Sinhvien s join KetQua k on s.MaSV=k.MaSV
 where MaLop=@malop
 group by s.masv, Hoten

 --cau lenh chay
 
select*from trbinhlop1('CNTT1')
--câu 3
create proc ktra @msv char(5)
as
begin
 declare @n int
 set @n=(select count(*) from ketqua where Masv=@msv)
 if @n=0
 print 'sinh vien '+@msv + 'khong thi mon nao'
 else
 print 'sinh vien '+ @msv+ 'thi '+cast(@n as char(2))+ 'mon'
end
-- cau lenh chay
exec ktra '01'
--câu 4
go
create trigger updatesslop
on Sinhvien
for insert
as
begin
 declare @ss int
 set @ss=(select count(*) from Sinhvien s
 where MaLop in(select MaLop from inserted))
 if @ss>10
 begin
 print 'Lop day'
 rollback tran
 end
 else
 begin
 update Lop
 set SiSo=@ss
 where MaLop in (select MaLop from inserted)
 end