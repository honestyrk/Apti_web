-- seed_07_quant_batch4.sql
-- Continues the "every topic gets at least 25 questions" expansion.
-- Tops up 5 more Quantitative Aptitude topics (each originally seeded
-- with 6 questions in seed_03) with 19 more each to reach 25: Height and
-- Distance, Calendar, Clock, Area, Volume and Surface Area.
-- Additive only; safe to run once after seed_06_quant_batch3.sql.

-- ============================================================
-- Quantitative Aptitude > Height and Distance (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('The angle of elevation of the top of a tower from a point 50 m away is 30 degrees. Find the height of the tower. (tan 30 deg = 1/1.732)', '25 m', '27 m', '28.87 m', '30 m', 'c', 'Height = 50/sqrt(3) ~ 28.87 m.', 'medium'),
  ('A tower stands vertically on the ground. From a point 40 m from its foot, the angle of elevation is 45 degrees. Find the height.', '35 m', '38 m', '40 m', '42 m', 'c', 'tan 45 deg = 1, so height = 40 m.', 'easy'),
  ('The angle of elevation of the top of a pole from a point 20 m away is 60 degrees. Find the height of the pole.', '30 m', '32 m', '34.64 m', '36 m', 'c', 'Height = 20 x sqrt(3) ~ 34.64 m.', 'medium'),
  ('A kite is flying at a height of 60 m, attached to a string inclined at 30 degrees to the horizontal. Find the length of the string.', '100 m', '110 m', '120 m', '130 m', 'c', 'Length = 60/sin 30 deg = 60/0.5 = 120 m.', 'medium'),
  ('From the top of a building 50 m high, the angle of depression of a car is 30 degrees. Find the distance of the car from the base.', '80 m', '83 m', '86.6 m', '90 m', 'c', 'Distance = 50/tan 30 deg = 50 x sqrt(3) ~ 86.6 m.', 'medium'),
  ('A vertical pole 6 m high casts a shadow 6 x sqrt(3) m long. Find the angle of elevation of the sun.', '30 deg', '45 deg', '60 deg', '75 deg', 'a', 'tan(theta) = 6/(6 x sqrt(3)) = 1/sqrt(3), so theta = 30 degrees.', 'medium'),
  ('The angle of elevation of the top of a tree from a point 15 m from its base is 45 degrees. Find the height of the tree.', '12 m', '13 m', '15 m', '18 m', 'c', 'tan 45 deg = 1, so height = 15 m.', 'easy'),
  ('A ladder leaning against a wall makes an angle of 45 degrees with the ground. If the foot of the ladder is 5 m from the wall, find the length of the ladder.', '6 m', '6.5 m', '7.07 m', '7.5 m', 'c', 'Length = 5/cos 45 deg = 5 x sqrt(2) ~ 7.07 m.', 'medium'),
  ('The height of a tower is 100 m. Find the angle of elevation of its top from a point 100 m from its base.', '30 deg', '45 deg', '60 deg', '90 deg', 'b', 'tan(theta) = 100/100 = 1, so theta = 45 degrees.', 'easy'),
  ('Two equal towers stand on either side of a 100 m wide road. At a point on the road, the angles of elevation of their tops are 30 and 60 degrees. Find the distance of this point from the tower with the 60 degree angle.', '20 m', '22 m', '25 m', '30 m', 'c', 'Solving x x sqrt(3) = (100-x)/sqrt(3) gives x = 25 m.', 'hard'),
  ('From a point 30 m from the base of a tower, the angle of elevation of the top is 60 degrees. Find the height.', '45 m', '48 m', '51.96 m', '55 m', 'c', 'Height = 30 x sqrt(3) ~ 51.96 m.', 'medium'),
  ('A man observes the top of a tower at an angle of elevation of 45 degrees from a point 25 m away. Find the height of the tower.', '20 m', '22 m', '25 m', '28 m', 'c', 'tan 45 deg = 1, so height = 25 m.', 'easy'),
  ('The angle of elevation of the top of a building from a point on the ground is 30 degrees. If the building is 25 m high, find the distance of the point from its base.', '38 m', '40 m', '43.3 m', '45 m', 'c', 'Distance = 25/tan 30 deg = 25 x sqrt(3) ~ 43.3 m.', 'medium'),
  ('Two buildings of heights 20 m and 50 m face each other, 40 m apart. Find the angle of elevation of the top of the taller building from the top of the shorter one.', '30 deg', '37 deg', '45 deg', '53 deg', 'b', 'tan(theta) = (50-20)/40 = 0.75, so theta ~ 37 degrees.', 'hard'),
  ('A person 40 m from a tower observes the top at 45 degrees elevation. If he moves 10 m closer, find the new angle of elevation.', '45 deg', '50 deg', '53.13 deg', '60 deg', 'c', 'Height = 40 m; at 30 m distance, tan(theta) = 40/30, so theta ~ 53.13 degrees.', 'hard'),
  ('A flagpole 10 m high casts a shadow of 10 m. Find the angle of elevation of the sun.', '30 deg', '45 deg', '60 deg', '75 deg', 'b', 'tan(theta) = 10/10 = 1, so theta = 45 degrees.', 'easy'),
  ('From the top of an 80 m cliff, the angles of depression of two boats on the same side are 30 and 45 degrees. Find the distance between the boats.', '50 m', '55 m', '58.6 m', '60 m', 'c', 'Distances are 80 m and 80 x sqrt(3) m; the difference ~ 58.6 m.', 'hard'),
  ('A tower is 50 x sqrt(3) m high. Find the angle of elevation of its top from a point 50 m from its base.', '30 deg', '45 deg', '60 deg', '75 deg', 'c', 'tan(theta) = sqrt(3), so theta = 60 degrees.', 'medium'),
  ('The shadow of a tower is 40 m longer when the sun''s altitude is 30 degrees than when it is 45 degrees. Find the height of the tower.', '50 m', '52 m', '54.64 m', '56 m', 'c', 'Solving h(sqrt(3)-1) = 40 gives h ~ 54.64 m.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'height-and-distance';

-- ============================================================
-- Quantitative Aptitude > Calendar (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('If today is Wednesday, what day will it be after 100 days?', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'b', '100 mod 7 = 2; Wednesday + 2 = Friday.', 'medium'),
  ('How many odd days are there in 1 ordinary year?', '0', '1', '2', '3', 'b', 'An ordinary year has 365 days = 52 weeks + 1 day.', 'easy'),
  ('How many odd days are there in 400 years?', '0', '1', '2', '5', 'a', 'The Gregorian calendar cycle of 400 years has exactly 0 odd days.', 'hard'),
  ('What day of the week was 15th August 1947?', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'b', '15th August 1947 fell on a Friday.', 'medium'),
  ('If 1st January 2023 was a Sunday, what day was 1st January 2024?', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'b', '2023 has 365 days = 52 weeks + 1 day; Sunday + 1 = Monday.', 'medium'),
  ('How many odd days are there in the month of February in a leap year?', '0', '1', '2', '3', 'b', 'February has 29 days in a leap year; 29 mod 7 = 1.', 'easy'),
  ('If a 30-day month has 5 Sundays, on which day can the 1st NOT fall?', 'Friday', 'Saturday', 'Sunday', 'Monday', 'd', 'A 30-day month with 5 Sundays must start on Friday, Saturday, or Sunday -- not Monday.', 'hard'),
  ('If 1st March is a Tuesday in a non-leap year, what day is 1st April?', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'b', 'March has 31 days = 4 weeks + 3 days; Tuesday + 3 = Friday.', 'medium'),
  ('Find the number of odd days in 4 consecutive years including exactly one leap year.', '3', '4', '5', '6', 'c', '3 ordinary years (1 each) + 1 leap year (2) = 5 odd days.', 'medium'),
  ('If 1st January is a Monday, what day is 1st February in a leap year?', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'b', 'January has 31 days = 4 weeks + 3 days; Monday + 3 = Thursday.', 'medium'),
  ('If a leap year starts on a Wednesday, what day does it end on?', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'c', 'A leap year has 366 days; day 366 is 365 days after day 1, and 365 mod 7 = 1, so the last day is Wednesday + 1 = Thursday.', 'hard'),
  ('How many days are there in February 2024?', '28', '29', '30', '31', 'b', '2024 is a leap year, so February has 29 days.', 'easy'),
  ('If today is Sunday, what day will it be after 200 days?', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'b', '200 mod 7 = 4; Sunday + 4 = Thursday.', 'medium'),
  ('If 1st January 2000 was a Saturday, find the day of the week on 1st January 2001. (2000 is a leap year)', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'b', '2000 has 366 days = 52 weeks + 2 days; Saturday + 2 = Monday.', 'medium'),
  ('How many odd days are in the period 1st January 2001 to 31st December 2004 (including leap year 2004)?', '3', '4', '5', '6', 'c', '3 ordinary years (1 each) + 1 leap year (2) = 5 odd days.', 'medium'),
  ('If a month starts on a Thursday and has 31 days, on what day does it end?', 'Friday', 'Saturday', 'Sunday', 'Monday', 'b', 'Day 31 is 30 days after day 1; 30 mod 7 = 2; Thursday + 2 = Saturday.', 'medium'),
  ('Which of the following years is NOT a leap year?', '2004', '2008', '2012', '2018', 'd', '2018 is not divisible by 4, so it is not a leap year.', 'easy'),
  ('If a leap year has 53 Sundays, what can be said about 1st January of that year?', 'Must be Sunday only', 'Must be Monday only', 'Must be Saturday or Sunday', 'Must be any day', 'c', 'A leap year has 2 repeating days; for 53 Sundays, 1st January must be Saturday or Sunday.', 'hard'),
  ('How many odd days are there in 200 years?', '1', '2', '3', '4', 'c', 'Using the standard rule, 100 years give 5 odd days and 200 years give 3 odd days.', 'hard')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'calendars';

-- ============================================================
-- Quantitative Aptitude > Clock (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('What is the angle between the hour and minute hands of a clock at 12:00?', '0 deg', '30 deg', '90 deg', '180 deg', 'a', 'At 12:00 both hands overlap, so the angle is 0 degrees.', 'easy'),
  ('What is the angle between the hour and minute hands of a clock at 6:00?', '90 deg', '150 deg', '180 deg', '210 deg', 'c', 'At 6:00 the hands point in opposite directions: 180 degrees.', 'easy'),
  ('What is the angle between the hour and minute hands of a clock at 9:00?', '60 deg', '75 deg', '90 deg', '105 deg', 'c', 'At 9:00 the hands form a quarter of the clock face: 90 degrees.', 'easy'),
  ('At what time between 2 and 3 o''clock will the hands of a clock first be at right angles?', '27 3/11 min past 2', '30 min past 2', '33 min past 2', '24 min past 2', 'a', 'Using the standard formula, the first right angle occurs at 27 3/11 minutes past 2.', 'hard'),
  ('How many times in 12 hours do the hands of a clock point in exactly opposite directions?', '10', '11', '12', '22', 'b', 'The hands are opposite 11 times in 12 hours.', 'medium'),
  ('Find the angle between the hands of a clock at 4:20.', '5 deg', '8 deg', '10 deg', '12 deg', 'c', 'Hour hand = 130 deg, minute hand = 120 deg; difference = 10 degrees.', 'medium'),
  ('Find the angle between the hands of a clock at 7:45.', '30 deg', '35 deg', '37.5 deg', '40 deg', 'c', 'Hour hand = 232.5 deg, minute hand = 270 deg; difference = 37.5 degrees.', 'medium'),
  ('A clock is set right at 5 am. It loses 16 minutes in 24 hours. What is the approximate true time when the clock shows 10 pm the same day?', '10:00 pm', '10:11 pm', '10:20 pm', '9:49 pm', 'b', 'Since the faulty clock runs slow, the true time is slightly ahead of what the clock shows, around 10:11 pm.', 'hard'),
  ('How many times do the hands of a clock coincide between 12 noon and 12 midnight?', '10', '11', '12', '22', 'b', 'The hands coincide 11 times in a 12-hour period.', 'medium'),
  ('At what time between 3 and 4 o''clock are the hands of a clock together?', '16 4/11 min past 3', '15 min past 3', '18 min past 3', '20 min past 3', 'a', 'Using the standard formula, the hands coincide at 16 4/11 minutes past 3.', 'hard'),
  ('Find the reflex angle between the hands of a clock at 5:00.', '180 deg', '200 deg', '210 deg', '220 deg', 'c', 'The direct angle is 150 degrees, so the reflex angle is 360-150 = 210 degrees.', 'medium'),
  ('How many degrees does the minute hand move in 20 minutes?', '100 deg', '110 deg', '120 deg', '130 deg', 'c', 'The minute hand moves 6 degrees per minute; 20 x 6 = 120 degrees.', 'easy'),
  ('How many degrees does the hour hand move in 3 hours?', '60 deg', '75 deg', '90 deg', '105 deg', 'c', 'The hour hand moves 30 degrees per hour; 3 x 30 = 90 degrees.', 'easy'),
  ('At what time between 1 and 2 o''clock will the hands of a clock be exactly opposite each other?', '38 2/11 min past 1', '40 min past 1', '36 min past 1', '42 min past 1', 'a', 'Using the standard formula, the hands are opposite at 38 2/11 minutes past 1.', 'hard'),
  ('How many times in a day do the hands of a clock form a straight line (coincide or opposite)?', '22', '33', '44', '48', 'c', '22 coincidences + 22 opposite positions = 44 times.', 'medium'),
  ('Find the angle between the hands of a clock at 2:30.', '90 deg', '100 deg', '105 deg', '110 deg', 'c', 'Hour hand = 75 deg, minute hand = 180 deg; difference = 105 degrees.', 'medium'),
  ('How many minutes does the minute hand take to complete one full rotation?', '30', '45', '60', '90', 'c', 'The minute hand completes a full rotation every 60 minutes.', 'easy'),
  ('Find the angle between the hands of a clock at 11:00.', '20 deg', '25 deg', '30 deg', '35 deg', 'c', 'Hour hand = 330 deg, minute hand = 0 deg; the smaller angle is 30 degrees.', 'easy'),
  ('At 3:15, what is the angle between the hour and minute hands?', '5 deg', '7.5 deg', '10 deg', '12 deg', 'b', 'Hour hand = 97.5 deg, minute hand = 90 deg; difference = 7.5 degrees.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'clocks';

-- ============================================================
-- Quantitative Aptitude > Area (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the area of a rectangle with length 20 m and breadth 15 m.', '280 m2', '290 m2', '300 m2', '310 m2', 'c', 'Area = 20 x 15 = 300 m2.', 'easy'),
  ('Find the perimeter of a square whose area is 64 cm2.', '28 cm', '30 cm', '32 cm', '34 cm', 'c', 'Side = 8 cm; perimeter = 4x8 = 32 cm.', 'easy'),
  ('Find the area of a right triangle with legs 6 cm and 8 cm.', '20 cm2', '22 cm2', '24 cm2', '26 cm2', 'c', 'Area = (1/2) x 6 x 8 = 24 cm2.', 'easy'),
  ('Find the area of a circle with diameter 14 cm. (use pi = 22/7)', '140 cm2', '150 cm2', '154 cm2', '160 cm2', 'c', 'Radius = 7 cm; area = 22/7 x 49 = 154 cm2.', 'medium'),
  ('The area of a square is 121 cm2. Find its side length.', '9 cm', '10 cm', '11 cm', '12 cm', 'c', 'Side = sqrt(121) = 11 cm.', 'easy'),
  ('Find the area of a trapezium with parallel sides 10 cm and 14 cm and height 5 cm.', '50 cm2', '55 cm2', '60 cm2', '65 cm2', 'c', 'Area = (1/2)(10+14) x 5 = 60 cm2.', 'medium'),
  ('The diagonal of a square is 10 x sqrt(2) cm. Find its area.', '80 cm2', '90 cm2', '100 cm2', '110 cm2', 'c', 'Side = 10 cm (since diagonal = side x sqrt(2)); area = 100 cm2.', 'medium'),
  ('The length of a rectangle is 3 times its breadth. If the area is 108 cm2, find the length.', '15 cm', '16 cm', '18 cm', '20 cm', 'c', 'Solving 3b^2 = 108 gives b=6, so length = 18 cm.', 'medium'),
  ('Find the area of a rhombus with diagonals 12 cm and 16 cm.', '84 cm2', '90 cm2', '96 cm2', '100 cm2', 'c', 'Area = (1/2) x 12 x 16 = 96 cm2.', 'medium'),
  ('A circular field has a radius of 21 m. Find its area. (use pi = 22/7)', '1350 m2', '1370 m2', '1386 m2', '1400 m2', 'c', 'Area = 22/7 x 441 = 1386 m2.', 'medium'),
  ('Find the area of an equilateral triangle with side 10 cm.', '40 cm2', '41.3 cm2', '43.3 cm2', '45 cm2', 'c', 'Area = (sqrt(3)/4) x 100 ~ 43.3 cm2.', 'hard'),
  ('The area of a square field is 2500 m2. Find the cost of fencing it at Rs. 10 per meter.', 'Rs. 1800', 'Rs. 1900', 'Rs. 2000', 'Rs. 2200', 'c', 'Side = 50 m; perimeter = 200 m; cost = Rs. 2000.', 'medium'),
  ('Find the area of a semicircle with radius 14 cm. (use pi = 22/7)', '280 cm2', '294 cm2', '308 cm2', '320 cm2', 'c', 'Full circle area = 616 cm2; semicircle = 308 cm2.', 'medium'),
  ('The length and breadth of a rectangle are increased by 10% and 20% respectively. Find the percentage increase in area.', '28%', '30%', '32%', '34%', 'c', 'Area factor = 1.1 x 1.2 = 1.32, a 32% increase.', 'medium'),
  ('Find the area of a square whose perimeter is 40 cm.', '80 cm2', '90 cm2', '100 cm2', '110 cm2', 'c', 'Side = 10 cm; area = 100 cm2.', 'easy'),
  ('A rectangular field is 80 m long and 60 m wide. Find the cost of leveling it at Rs. 5 per square meter.', 'Rs. 22000', 'Rs. 23000', 'Rs. 24000', 'Rs. 25000', 'c', 'Area = 4800 m2; cost = Rs. 24000.', 'medium'),
  ('Find the area of a triangle with sides 5 cm, 12 cm, and 13 cm.', '25 cm2', '28 cm2', '30 cm2', '32 cm2', 'c', 'Since 5-12-13 is a right triangle, area = (1/2) x 5 x 12 = 30 cm2.', 'medium'),
  ('If the side of a square is doubled, find the percentage increase in its area.', '100%', '200%', '300%', '400%', 'c', 'New area = 4 x old area, an increase of 300%.', 'medium'),
  ('Find the area of a quadrant of a circle with radius 14 cm. (use pi = 22/7)', '140 cm2', '148 cm2', '154 cm2', '160 cm2', 'c', 'Full circle area = 616 cm2; quadrant = 154 cm2.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'area';

-- ============================================================
-- Quantitative Aptitude > Volume and Surface Area (top-up)
-- ============================================================
insert into public.questions (topic_id, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
select id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d, q.correct_option, q.explanation, q.difficulty
from public.topics, (values
  ('Find the volume of a cuboid with dimensions 10 cm x 8 cm x 5 cm.', '380 cm3', '390 cm3', '400 cm3', '420 cm3', 'c', 'Volume = 10x8x5 = 400 cm3.', 'easy'),
  ('Find the total surface area of a cuboid with dimensions 6 cm x 4 cm x 3 cm.', '96 cm2', '100 cm2', '108 cm2', '112 cm2', 'c', 'TSA = 2(lb+bh+hl) = 2(24+12+18) = 108 cm2.', 'medium'),
  ('Find the volume of a cube whose surface area is 216 cm2.', '200 cm3', '210 cm3', '216 cm3', '220 cm3', 'c', '6a^2=216 gives a=6; volume = 216 cm3.', 'medium'),
  ('Find the lateral surface area of a cube with side 5 cm.', '80 cm2', '90 cm2', '100 cm2', '110 cm2', 'c', 'LSA = 4a^2 = 4x25 = 100 cm2.', 'easy'),
  ('Find the total surface area of a cylinder with radius 7 cm and height 10 cm. (use pi = 22/7)', '700 cm2', '720 cm2', '748 cm2', '760 cm2', 'c', 'TSA = 2 pi r(h+r) = 2 x 22/7 x 7 x 17 = 748 cm2.', 'medium'),
  ('Find the volume of a cone with radius 7 cm and height 24 cm. (use pi = 22/7)', '1150 cm3', '1200 cm3', '1232 cm3', '1260 cm3', 'c', 'V = 1/3 x 22/7 x 49 x 24 = 1232 cm3.', 'medium'),
  ('Find the curved surface area of a cone with radius 7 cm and slant height 25 cm. (use pi = 22/7)', '500 cm2', '525 cm2', '550 cm2', '575 cm2', 'c', 'CSA = pi r l = 22/7 x 7 x 25 = 550 cm2.', 'medium'),
  ('Find the surface area of a sphere with radius 7 cm. (use pi = 22/7)', '580 cm2', '600 cm2', '616 cm2', '630 cm2', 'c', 'SA = 4 pi r^2 = 4 x 22/7 x 49 = 616 cm2.', 'medium'),
  ('Find the volume of a hemisphere with radius 3 cm. (use pi = 22/7)', '50 cm3', '53 cm3', '56.57 cm3', '60 cm3', 'c', 'V = 2/3 x 22/7 x 27 ~ 56.57 cm3.', 'hard'),
  ('A cube has a volume of 512 cm3. Find its side length.', '6 cm', '7 cm', '8 cm', '9 cm', 'c', 'Side = cube root of 512 = 8 cm.', 'medium'),
  ('Find the ratio of the volumes of two cubes with sides 2 cm and 4 cm.', '1:2', '1:4', '1:8', '1:16', 'c', 'Volume ratio = 2^3:4^3 = 8:64 = 1:8.', 'medium'),
  ('A cylindrical tank has radius 3.5 m and height 10 m. Find its volume. (use pi = 22/7)', '350 m3', '370 m3', '385 m3', '400 m3', 'c', 'V = 22/7 x 12.25 x 10 = 385 m3.', 'medium'),
  ('Find the total surface area of a hemisphere with radius 7 cm. (use pi = 22/7)', '420 cm2', '440 cm2', '462 cm2', '480 cm2', 'c', 'TSA = 3 pi r^2 = 3 x 22/7 x 49 = 462 cm2.', 'medium'),
  ('A rectangular tank measures 5 m x 4 m x 3 m. Find its capacity in liters (1 m3 = 1000 L).', '55000 L', '58000 L', '60000 L', '62000 L', 'c', 'Volume = 60 m3 = 60000 liters.', 'easy'),
  ('Find the diagonal of a cube with side 6 cm.', '9 cm', '10 cm', '10.39 cm', '11 cm', 'c', 'Diagonal = side x sqrt(3) = 6 x 1.732 ~ 10.39 cm.', 'medium'),
  ('If the radius of a sphere is doubled, find the ratio of the new volume to the old volume.', '2:1', '4:1', '8:1', '16:1', 'c', 'Volume scales as r^3, so the ratio is 2^3:1 = 8:1.', 'medium'),
  ('Find the volume of a cone with base radius 6 cm and height 7 cm. (use pi = 22/7)', '250 cm3', '258 cm3', '264 cm3', '270 cm3', 'c', 'V = 1/3 x 22/7 x 36 x 7 = 264 cm3.', 'medium'),
  ('A cuboid has length 12 cm, breadth 9 cm, and volume 540 cm3. Find its height.', '4 cm', '4.5 cm', '5 cm', '5.5 cm', 'c', 'Height = 540/(12x9) = 5 cm.', 'medium'),
  ('Find the number of cubes of side 2 cm that can be cut from a cube of side 8 cm.', '32', '48', '64', '72', 'c', 'Large volume = 512, small volume = 8; number = 64.', 'medium')
) as q(question_text, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty)
where topics.slug = 'volume-and-surface-area';
