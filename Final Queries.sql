--1----------------------------عرض جميع المطاعم بمحافظة قنا----------------------------------------------------------
select r.re_name as'Name of Restaurant‬',ow_name as 'Owner Name',r.re_address as 'Address',p.re_phones
from restaurant‬s r
INNER JOIN restaurant‬_phones p on p.re_id=r.re_id
INNER JOIN restaurants_owner ro ON ro.re_id = r.re_id
INNER JOIN owner ow ON ow.ow_id = ro.ow_id
WHERE r.re_address LIKE '%Qena%' and p.re_phones like '010%';

--2------------------------------------تقرير باكثر عنصر طلبا بكل مطعم--------------------------------------------------لسه مخلصش
select  re_name as 'Restaurant_Name' ,  sum(Quantity) as 'Quantity',oi.it_id as 'Item_ID' from restaurant‬s r
inner join customer_restaurant cr on cr.re_id=r.re_id
inner join customers c on c.c_id=cr.c_id
inner join orders o on o.c_id=c.c_id
inner join order_items oi on oi.or_id=o.or_id
inner join items i on i.it_id=oi.it_id

group by re_name,oi.it_id

--3-----------------------------------تقرير تفصيلي بالمبلغ الكلي للطلب لكل عميل --------------------------------------------------
select c.c_id as 'Customer_ID',c.first_name+' '+c.last_name as 'Full Name',bi_id as 'Bill_ID',sum(it_price) as 'Total Price',
re_name as 'Restaurant_Name',ca_name as 'Cashier_Name' from items i
inner join order_items os on i.it_id=os.it_id
inner join orders o on os.or_id=o.or_id
inner join customers c on c.c_id=o.c_id
inner join bill b on b.c_id=c.c_id
inner join cashers cs on cs.ca_id=b.ca_id
inner join restaurant‬s r on r.re_id=cs.re_id
group by c.first_name, c.c_id,bi_id, c.last_name, re_name, ca_name

--4-----------------------------عرض تفصيلي بوقت ونوع الطلب لكل عميل--------------------------------------
select c.first_name+'  '+c.last_name as 'Full Name',o.or_id as 'Order_ID',o.or_time as 'Order_Time',
o.or_type as 'Order_Type',table_number, sum(i.it_price) as 'price'
from orders o
inner join customers c on c.c_id=o.c_id
inner join order_items os on os.or_id=o.or_id
inner join items i on i.it_id=os.it_id
where o.or_date='2023-05-15'
group by c.first_name,o.or_time,o.or_type,c.last_name,o.or_id,table_number
order by or_time,price asc

--5---------------------------------عرض وصف للاسعار--------------------------------------------------
select it_name as 'Item_Name',it_price as 'Item_Price', 
case when it_price>=40.99 then 'Expensive Item' else 'Cheap Item' end 
as 'Description of Item' from items