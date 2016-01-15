drop table prescriptions;
drop table patients ;
drop table doctors;
drop table stuffs;
drop table medicines;
drop trigger calculate_age;

create table patients(
	patient_id number(7) , 
	patient_name varchar(10) not null,
	patient_age number(2) ,
	patient_sex varchar(6) not null,
	patient_dept varchar(3) not null,
	patient_type varchar(10) not null,
	patient_birthDate date,
	patient_residence varchar(10) , 
	primary key(patient_id)
);

create table doctors(
	doctor_id number(5) , 
	doctor_name varchar(20) not null, 
	doctor_age number(2) check(doctor_age>=20 and doctor_age<=70) , 
	doctor_degree varchar(7),
	doctor_room number(3) ,
	doctor_title varchar(10),
	primary key(doctor_id)
);

create table stuffs(
	stuff_id number(5),
	stuff_name varchar(20) not null, 
	stuff_age number(2) , 
	stuff_sex varchar(6) ,
	stuff_position varchar(25) not null,
	primary key(stuff_id)
);

create table medicines(
	medicine_id number (5),
	medicine_name varchar(10) unique,
	medicine_group varchar(15) not null,
	medicine_price number(5) ,
	primary key(medicine_id)
);

create table prescriptions(
	prescription_id number(5) ,
	prescription_date date,
	patient_id number(7),
	doctor_id number(5) ,
	stuff_id number(5),
	medicine_id number (5),
	primary key(prescription_id),
	foreign key (patient_id)  references patients(patient_id) on delete cascade,
	foreign key (doctor_id)  references doctors(doctor_id) on delete cascade,
	foreign key (stuff_id)  references stuffs(stuff_id) on delete cascade,
	foreign key (medicine_id)  references medicines(medicine_id) on delete cascade
);

describe patients;
describe doctors;
describe stuffs;
describe medicines;
describe prescriptions;

-- A trigger for calculating age of patients and insert into patient_age column
create or replace trigger calculate_age before insert or update on patients for each row
	BEGIN
		:new.patient_age := floor(Months_between(sysdate, :new.patient_birthDate)/12);
	END;
/

-- create a sequence 
create sequence prescription_id_sequence;

-- using sequence for prescription table and increemnt prescription id for every insertion
create trigger prescription_trigger before insert on prescriptions for each row
	BEGIN
		select prescription_id_sequence.nextval 
			into :new.prescription_id 
				from dual;
	END;
/

insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1107002 , 'Sun'       ,'13-Aug-1993' , 'Male' , 'CSE' , 'Student','LSH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1105029 , 'Jonaet'    ,'14-AUG-1992' , 'Male' , 'ME'  , 'Student','AEH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1109056 , 'Tahi'      ,'04-JAN-1990' , 'Male' , 'ECE' , 'Student','LSH');	
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1107046 , 'Badhon'    ,'30-JUL-1993' , 'Male' , 'CSE' , 'Student','KAH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1107039 , 'Ashik'     ,'19-DEC-1990' , 'Male' , 'CSE' , 'Student','BMH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (0702    , 'Dr.Azhar'  ,'05-FEB-1970' , 'Male' , 'CSE' , 'Teacher','R.Area-5');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (0703    , 'Mashrur'   ,'06-JUL-1980' , 'Male' , 'CSE' , 'Teacher','Canada');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1101101 , 'Qias'      ,'24-MAR-1985' , 'Male' , 'CE'  , 'Student','RH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1105085 , 'Turjo'     ,'24-MAR-1985' , 'Male' , 'ME'  , 'Student','RH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (0907022 , 'Shahid'    ,'30-JUL-1993' , 'Male' , 'CSE' , 'Student','LSH');
insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence) values (1107010 , 'Suhail'    ,'24-MAR-1985' , 'Male' , 'CSE' , 'Student','LSH');

insert into doctors values (9901 , 'Md. Momin' , 43 ,  'MBBS', 201 , 'Dr');
insert into doctors values (9902 , 'Mrs.Selina' , 35 ,  'FCPS', 203 , 'Prof.');
insert into doctors values (9903 , 'Md.Hafiz' , 40 ,  'MBBS', 106 , 'Dr.');

insert into stuffs values (9801 , 'Md. Fajal' , 50 , 'Male' , 'Head Stuff');
insert into stuffs values (9802 , 'Mrs.Sahina' , 45 , 'Famale' , 'Medicine Provider');
insert into stuffs values (9803 , 'Md.Abul' , 40 , 'Male' , 'Driver');
insert into stuffs values (9804 , 'Md.Jalil' , 35 , 'Male' , 'Helper');

insert into medicines values(50001 , 'Napa'     , 'Paracitamol' ,15);
insert into medicines values(50002 , 'Neutak'   , 'Renitidine' ,22);
insert into medicines values(50003 , 'Leo'      , 'Levofloxacine' ,120);
insert into medicines values(50004 , 'Deslor'   , 'HidroCloro..' ,25);
insert into medicines values(50005 , 'Pantonix' , 'Pantoprajol' ,400);
insert into medicines values(50006 , 'Ribosina' , 'Reboflavin' ,60);

insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('13-AUG-2014', 1107002,9901,9802,50003);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('20-AUG-2014', 0702,9903,9803,50001);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('16-AUG-2014', 1107002,9901,9801,50002);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('24-AUG-2014', 1109056,9903,9802,50004);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values( '25-AUG-2014', 1107010,9902,9804,50006);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('02-SEP-2014', 1105085,9903,9801,50005);
insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values('01-SEP-2014', 1101101,9903,9801,50004);

select patient_id , patient_name as Name , patient_birthDate as B_Date , patient_age as AGE , patient_sex as SEX , patient_dept as DEPT , patient_type as Type , patient_residence as Residence from patients ; 
select * from doctors;
select * from stuffs;
select * from medicines;
select * from prescriptions;

--Adding a column called phone
alter table patients add phone varchar(11) default '01xxxxxxxxx';

insert into patients (patient_id , patient_name , patient_birthDate , patient_sex , patient_dept , patient_type , patient_residence , phone) values (1107004 , 'Rashik' ,'12-APR-1980' , 'Male' , 'CSE' , 'Student','BSMRH','01675013080');

select patient_id , patient_name as Name, patient_birthDate as B_Date , patient_age as AGE , patient_sex as SEX , patient_dept as DEPT , patient_type as Type , patient_residence as Residence, phone from patients order by (patient_id);

select sum(medicine_price) as Total_price_of_medicine from medicines  ; 

select patient_id , patient_name from patients where patient_id in (select patient_id  from prescriptions group by patient_id);

select patient_id, patient_name from patients where patient_dept='CSE'          -- The patients of CSE dept. or Prof. Prescribed him
	UNION
		select patient_id,patient_name from patients where patient_id in 
			(select patient_id from prescriptions where doctor_id in 
				(select doctor_id from doctors where doctor_title='Prof.')
			);

select patient_id, patient_name from patients where patient_dept='CSE' and patient_residence = 'LSH';

select distinct p.patient_name , p.patient_age from patients p join prescriptions using (patient_id);

--Total medicine price for specific People
SET SERVEROUTPUT ON
	DECLARE
		totalForOne medicines.medicine_price%type;
	BEGIN
		select sum(medicine_price) into totalForOne from medicines where medicine_id in (select medicine_id from prescriptions where patient_id =1107002);
		DBMS_OUTPUT.PUT_LINE('Total price for 1107002 is: ' || totalForOne);	 
END;
/

--Total ammount of prescribed medicine using function
SET SERVEROUTPUT ON
	CREATE OR REPLACE FUNCTION Total_prescribe_ammount return number is
	total_price medicines.medicine_price%type;
	BEGIN
		select sum(medicine_price) into total_price from medicines where medicine_id in (select medicine_id from prescriptions);
		return total_price;
END;
/

-- Show Total ammount of prescribed medicine
VARIABLE spending_money number;
EXECUTE :spending_money := Total_prescribe_ammount ();
PRINT :spending_money;

-- a procedure for inserting data into prescriptions table
SET SERVEROUTPUT ON
	create or REPLACE Procedure add_prescription(dat date, p_id patients.patient_id%type, d_id doctors.doctor_id%type , s_id stuffs.stuff_id%type, m_id medicines.medicine_id%type) is
	BEGIN
	insert into prescriptions(prescription_date,patient_id,doctor_id,stuff_id,medicine_id) values(dat , p_id,d_id,s_id,m_id);
	commit;
	DBMS_OUTPUT.PUT_LINE('Successfully inserted prescription information. ');
	
END;
/

--calling add_prescriptions procedure
SET SERVEROUTPUT ON
	BEGIN
		add_prescription('26-AUG-2014',1107039,9901,9802,50002);
END;
/

select * from prescriptions;

--The Prescribed Persons

SET SERVEROUTPUT on;
	DECLARE 
		Cursor name_cur is
			select patient_name from patients where patient_id in(select patient_id from prescriptions);
		name_rec name_cur%ROWTYPE;
		num integer;
	BEGIN
		DBMS_OUTPUT.PUT_LINE('The names of the prescribed persons');
		select count(prescription_id) into num from prescriptions;
		OPEN name_cur;
			Loop
				Fetch name_cur into name_rec;
				DBMS_OUTPUT.PUT_LINE('   ' || name_cur%ROWCOUNT || '   '|| name_rec.patient_name);

				EXIT when name_cur%NOTFOUND;
				
			END Loop;
		CLOSE name_cur;
	END;
/
