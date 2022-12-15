--Cau1
create table MonHoc(
MaMon char(5) not null primary key,
TenMon nvarchar(20),
SoTC int)

create table SinhVien(
MaSV char(5) not null primary key,
HoTen nvarchar(30),
NgaySinh smalldatetime)

create table Diem(
MaSV char(5) not null,
MaMon char(5) not null,
Diemthi float,
constraint fk_Masv foreign key(MaSV) references SinhVien(MaSV),
constraint fk_Mamh foreign key(MaMon) references MonHoc(MaMon),
constraint pk_Masv_Mamh primary key(MaSV, MaMon))
 
 go 
 insert into MonHoc values
 ('Ma1','Co so du lieu nang cao ',1),
 ('Ma2','He Quan Tri Co So Du Lieu',2),
 ('Ma3','Xu ly anh',3)
 insert into SinhVien values
 ('SV01','ly bach','2002-2-7'),
 ('SV02','ho nam','2002-8-6'),
 ('SV03','bach ho','2002-3-8')
 insert into Diem values
 ('SV01','Ma1',6),
 ('SV02','Ma2',7),
 ('SV03','Ma3',8),
 ('SV01','Ma2',10),
 ('SV02','Ma3',9)
 go

-- xem du lieu
 select *
 from MonHoc

 go

 select *
 from SinhVien

 go
 select *
 from Diem


 --Cau2
 go
create function tksv (@tmh nvarchar(20))
returns int
as
begin
 declare @dem int
 set @dem = (select count(*)
 from Diem
where @dem<5)
 return @dem
end
go
select dbo.tksv ('He Quan Tri Co So Du Lieu')


--cau3
go
create procedure nhapDiem(@MaSV char(5),@MaMon char(5), @DiemThi float)
as
insert into Diem(MaSV,MaMon,Diemthi) values(@MaSV,@MaMon,@DiemThi)
go
nhapDiem '003','MH3',9

--cau4
go
create trigger them_sua
on Diem
FOR  INSERT, UPDATE
AS
if(select DiemThi From inserted)>10 and (select DiemThi From inserted)<0
begin
print
'khong cho phep'
rollback transaction
end
insert into Diem
values ('SV1','MM3','2')
