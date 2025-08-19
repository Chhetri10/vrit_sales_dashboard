select top (1) * from appointments
select top (1) * from treatments
select top (1) * from billing
select top (1) * from doctors
select top (1) * from patients
--TASK1
select appointment_id, Doctors_Fullname, Patient_Fullname from
(select a.appointment_id,concat(p.first_name,' ', p.last_name) as Patient_Fullname,
concat(d.first_name,' ',d.last_name) as Doctors_Fullname from appointments a
join patients p on p.patient_id=a.patient_id
join doctors d on d.doctor_id=a.doctor_id) as sub
group by appointment_id, Doctors_Fullname, Patient_Fullname
--TASK2
-- List all bills with patient full name, treatment type, and bill amount.
select concat(p.first_name,' ', p.last_name) as Patient_Fullname, 
t.treatment_type, b.amount as bill_amount from treatments t
inner join billing b on t.treatment_id=b.treatment_id
inner join patients p on p.patient_id=b.patient_id
--TASK3
--Show doctor specialization, appointment date, and reason for visit for each appointment.
select d.specialization, a.appointment_date, a.reason_for_visit 
from appointments a 
inner join doctors d 
on a.doctor_id=d.doctor_id

--TASK4
--Display patient name, treatment type, treatment date, and doctor name.
select concat(p.first_name,' ', p.last_name) as Patient_Fullname, t.treatment_type, t.treatment_date, 
concat(d.first_name,' ',d.last_name) as Doctors_Fullname from treatments t
inner join appointments a on a.appointment_id=t.appointment_id
inner join patients p on a.patient_id=p.patient_id
inner join doctors d on a.doctor_id=d.doctor_id
--TASK5
--Show all patients with their total billed amount.
select p.patient_id, b.amount from patients p
inner join billing b on b.patient_id=p.patient_id

--TASK6
--Count how many appointments each doctor has.
select d.first_name, count(a.appointment_id) as 'Total appointments'
from appointments a 
inner join doctors d
on a.doctor_id=d.doctor_id
group by d.first_name

--TASK7
-- Show total billing amount collected per payment method.
select "payment_method", sum("amount") as 'total_amount' from billing
group by payment_method

--TASK8
-- Find the number of treatments performed for each treatment type.
select "treatment_type", count("treatment_id") as "no. of treatments" from treatments
group by treatment_type

--TASK9
-- Find patients who have paid more than the average bill amount.
select patient_id from
	(select p.patient_id, avg(amount) as avg_amount from patients p
	inner join billing b on b.patient_id=p.patient_id) as sub
	group by patient_id

SELECT p.patient_id
FROM patients p
JOIN billing b ON b.patient_id = p.patient_id
GROUP BY p.patient_id
HAVING SUM(b.amount) > (
    SELECT AVG(amount) FROM billing)