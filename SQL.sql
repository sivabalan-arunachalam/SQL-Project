Select payment_Status,  Sum (AMOUNT),   Extract ( YEAR FROm to_date ( PAYMENT_DATE,'YYYY-MM-DD')   )   from PROJ_PAYMENT_DTL

Group BY payment_Status, Extract ( YEAR FROm to_date ( PAYMENT_DATE,'YYYY-MM-DD')   )

Order by Extract ( YEAR FROm to_date ( PAYMENT_DATE,'YYYY-MM-DD')   ) , payment_Status;

 

Select SR_ADDR from PROJ_SHIPMENT  -- 200

UNION all

Select C_ADDR from proj_customer;  --200

 

Select Distinct SR_ADDR from PROJ_SHIPMENT;  -- 184

 

Select Distinct C_ADDR from proj_customer  -- 193

 

Select SR_ADDR from PROJ_SHIPMENT

UNION

Select C_ADDR from proj_customer;

 

Select 184+193, 377 -19  from dual; 

 

Select SR_ADDR from PROJ_SHIPMENT

Intersect

Select C_ADDR from proj_customer;

 

 

 

Select * from PROJ_CUSTOMER;

Select * from PROJ_EMPLOYEE;

Select * from PROJ_EMPLOYEE_SHIPMENT_STATUS;

Select * from PROJ_MEMBERSHIP;

Select * from PROJ_PAYMENT_DTL;

Select * from PROJ_SHIPMENT;

Select * from PROJ_STATUS;

Select * from PROJ_STATUS_BACKUP;

 

 

 

 

Select * from PROJ_EMPLOYEE_SHIPMENT_STATUS;

 

Select cust.c_id,cust.c_name, cust.c_type, cust.c_cont_no, 

      --emp.*

      emp.e_id, emp.E_NAME, emp.E_DESIGNATION, emp.E_ADDR, emp.E_BRANCH, emp.E_CONT_NO,

      --ship.* ,

      ship.SH_CONTENT, ship.SH_DOMAIN, ship.SER_TYPE, ship.SH_WEIGHT, ship.SH_CHARGES, ship.SR_ADDR, ship.DS_ADDR,

      --status.* ,

      Status.CURRENT_STATUS, Status.SENT_DATE, Status.DELIVERY_DATE,

      --Payment.*,

      Payment.AMOUNT, Payment.PAYMENT_STATUS, Payment.PAYMENT_MODE, Payment.PAYMENT_DATE,

      membership.Start_date Membership_start_date, membership.end_date Membership_end_date

from PROJ_CUSTOMER cust

Left Outer Join PROJ_SHIPMENT ship

On cust.c_id = ship.c_id

Left Outer Join PROJ_EMPLOYEE_SHIPMENT_STATUS lkp

On ship.sh_id = lkp.shipment_sh_id

Left Outer Join PROJ_EMPLOYEE emp

On emp.e_id = lkp.employee_e_id

Left Outer Join PROJ_STATUS status

On status.sh_id = lkp.shipment_sh_id

Left Outer Join PROJ_PAYMENT_DTL payment

On payment.c_id = cust.c_id And payment.sh_id = ship.sh_id

Left Outer Join PROJ_MEMBERSHIP membership

On membership.m_id= cust.m_id

--Where emp.e_name ='Ryan'

;

 

 

Customer - Employee -  Shipment

 

  -- 1 Employee - How many customer's shipment has handled - what is the Amount collected

 

Select emp.E_NAME ,  Payment.PAYMENT_STATUS,  Count( cust.c_id) no_of_customer_handled, Sum ( Amount) Tot_amount_collected_by_emp

from PROJ_CUSTOMER cust

Left Outer Join PROJ_SHIPMENT ship

On cust.c_id = ship.c_id

Left Outer Join PROJ_EMPLOYEE_SHIPMENT_STATUS lkp

On ship.sh_id = lkp.shipment_sh_id

Left Outer Join PROJ_EMPLOYEE emp

On emp.e_id = lkp.employee_e_id

Left Outer Join PROJ_STATUS status

On status.sh_id = lkp.shipment_sh_id

Left Outer Join PROJ_PAYMENT_DTL payment

On payment.c_id = cust.c_id And payment.sh_id = ship.sh_id

Left Outer Join PROJ_MEMBERSHIP membership

On membership.m_id= cust.m_id

group by emp.E_NAME, Payment.PAYMENT_STATUS

Having Count( cust.c_id) > 1 Order by 1,2;
