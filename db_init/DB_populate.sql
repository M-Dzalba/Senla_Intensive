INSERT INTO cd.members (surname, firstname, address, zipcode, telephone, recommendedby, joindate)
--sample script for populating tables, not all educational queries may work with this data

VALUES 
('Smith', 'John', '123 Elm St', 12345, '555-1234', 1, '2023-01-01'),
('Doe', 'Jane', '456 Oak St', 23456, '555-5678', 1, '2023-02-01'),
('Brown', 'Charlie', '789 Pine St', 34567, '555-8765', 1, '2023-03-01'),
('Johnson', 'Emily', '101 Maple St', 45678, '555-2345', 2, '2023-04-01'),
('Williams', 'Michael', '202 Birch St', 56789, '555-3456', 3, '2023-05-01'),
('Jones', 'Sarah', '303 Cedar St', 67890, '555-4567', 4, '2023-06-01'),
('Miller', 'David', '404 Walnut St', 78901, '555-5678', 5, '2023-07-01'),
('Davis', 'Laura', '505 Aspen St', 89012, '555-6789', 6, '2023-08-01'),
('Garcia', 'James', '606 Fir St', 90123, '555-7890', 7, '2023-09-01'),
('Martinez', 'Anna', '707 Spruce St', 10123, '555-8901', 8, '2023-10-01');

INSERT INTO cd.bookings (facid, memid, starttime, slots)
VALUES 
(1, 1, '2023-06-01 10:00:00', 2),
(2, 2, '2023-06-02 11:00:00', 3),
(3, 3, '2023-06-03 12:00:00', 1),
(4, 4, '2023-06-04 13:00:00', 2),
(5, 5, '2023-06-05 14:00:00', 4),
(1, 6, '2023-06-06 15:00:00', 2),
(2, 7, '2023-06-07 16:00:00', 3),
(3, 8, '2023-06-08 17:00:00', 1),
(4, 9, '2023-06-09 18:00:00', 2),
(5, 10, '2023-06-10 19:00:00', 4);

INSERT INTO cd.facilities (name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES 
('Tennis Court 1', 5.00, 25.00, 10000.00, 200.00),
('Tennis Court 2', 5.00, 25.00, 10000.00, 200.00),
('Badminton Court 1', 2.50, 10.00, 8000.00, 100.00),
('Badminton Court 2', 2.50, 10.00, 8000.00, 100.00),
('Pool Table 1', 1.50, 5.00, 2000.00, 50.00),
('Pool Table 2', 1.50, 5.00, 2000.00, 50.00),
('Gym', 10.00, 40.00, 50000.00, 500.00),
('Sauna', 3.00, 12.00, 3000.00, 150.00),
('Table Tennis', 2.00, 8.00, 1000.00, 25.00),
('Squash Court', 4.00, 20.00, 7000.00, 300.00);