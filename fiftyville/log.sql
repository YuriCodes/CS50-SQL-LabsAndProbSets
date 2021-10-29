/*FIND THE PERSON WHO STOLE CS50'S DUCK*/

-- Keep a log of any SQL queries you execute as you solve the mystery.

-- We gotta see what kind of information we have so let's check the tables and schema
-- Get report description from crime_scene_reports: 
SELECT description, id FROM crime_scene_reports WHERE SELECT license_plate FROM courthouse_security_logs WHERE (day = 28 AND month = 7 AND year = 2020 AND hour = 10 AND minute= 15);
-- Answer point out to the interview table for interview transcripts. 
SELECT transcript FROM intervies WHERE transcript LIKE"%courthouse%" AND (day = 28 AND month = 7 AND year = 2020);
--Give us the clue that the thieft arrived in the parking lot, so we need to check security footage
SELECT license_plate, activity FROM courthouse_security_logs WHERE (day = 28 AND month = 7 AND year = 2020 AND hour = 10 AND minute= 15);
--We can get more information from the licenses
SELECT name, phone_number, passport_number FROM courthouse_security_logs JOIN people ON courthouse_security_logs.license_plate = people.license_plate WHERE (day = 28 AND hour = 10 AND activity = "exit");
-- Someone saw the thieft walking by the ATM on Fifer street and saw him withdrawing some money
SELECT name FROM atm_transactions JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number JOIN people ON bank_accounts.person_id = people.id WHERE(day = 28 AND month = 7 AND atm_location ="Fifer Street");
-- "Ernest" shows up on both courthouse AND atm transactions...
-- The thief made a call for less than a minute, planning to take the earliest flight out of Fiftyville
SELECT caller, receiver, duration, name FROM phone_calls JOIN people ON phone_calls.receiver = people.phone_number WHERE (day = 28 AND month = 7 AND year = 2020 AND duration < 60);
-- "Ernest phone number shows up (367)555-5533 on Caller Column to Berthold (375) 555-8161"...
--Let's check the flights from Fiftyville 
SELECT airports.full_name, origin_airport_id, flights.id FROM flights JOIN airports ON airports.id WHERE(city LIKE"%fiftyville%") LIMIT 1; 
-- Fiftyville flights origin id is 8
-- Let's see which flight ticket the other person on the call bought the thief
SELECT airports.full_name, city, flights.id FROM flights JOIN airports ON destination_airport_id = airports.id WHERE(month = 7 AND day = 29 AND flights.origin_airport_id = 8) ORDER BY hour LIMIT 1;
-- Heathrow Airport, LONDON, id= 36
-- Let's compare(our passport numbers from the courthouse_security_logs ) with the passport numbers that boarded that flight  
SELECT passport_number FROM passengers WHERE flight_id = 36;
-- We got a match! Let's compare it to the people table
SELECT name, phone_number, license_plate FROM people WHERE (passport_number = 5773159633);
-- ERNEST (367) - 555 - 5533 94KL13X is our thief.
