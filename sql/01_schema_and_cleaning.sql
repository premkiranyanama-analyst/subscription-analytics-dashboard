CREATE DATABASE project;
USE project;

CREATE TABLE subscriptions (
  customer_id INT,
  created_date DATE,
  canceled_date DATE,
  subscription_cost DECIMAL(10,2),
  subscription_interval VARCHAR(20),
  was_subscription_paid TINYINT(1)
);

