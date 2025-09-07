# Dataset Overview

This repository contains multiple datasets related to **food delivery, restaurant menus, and movies**.  
These datasets can be used for **data analysis, SQL practice, machine learning experiments, and visualization projects**.  

---

## Datasets

### 1. `delivery_partner.csv`
- **Rows:** 5  
- **Columns:**  
  - `partner_id` → Unique identifier for each delivery partner  
  - `partner_name` → Name of the delivery partner  
- **Purpose:** Helps identify delivery personnel for each order.

---

### 2. `food.csv`
- **Rows:** 11  
- **Columns:**  
  - `f_id` → Food item ID  
  - `f_name` → Food item name  
  - `type` → Category (Veg / Non-Veg)  
- **Purpose:** Master list of available food items.

---

### 3. `menu.csv`
- **Rows:** 15  
- **Columns:**  
  - `menu_id` → Menu entry ID  
  - `r_id` → Restaurant ID  
  - `f_id` → Food item ID (linked with `food.csv`)  
  - `price` → Price of the food item  
- **Purpose:** Shows which restaurant sells which food item and at what price.  

---

### 4. `movies.csv`
- **Rows:** 4000  
- **Columns:**  
  - `name` → Movie title  
  - `rating` → Movie rating (G, PG, R, etc.)  
  - `genre` → Genre of the movie  
  - `year` → Release year  
  - `released` → Release date with region  
  - `score` → IMDb score  
  - `votes` → Number of votes received  
  - `director` → Movie director  
  - `writer` → Screenplay writer  
  - `star` → Lead actor/actress  
  - `country` → Country of production  
  - `budget` → Budget in dollars  
  - `gross` → Gross earnings  
  - `company` → Production company  
  - `runtime` → Runtime in minutes  
- **Purpose:** Rich dataset for movie analysis, recommendation systems, and predictive modeling.

---

### 5. `new_order_details.csv`
- **Rows:** 50  
- **Columns:**  
  - `id` → Row identifier  
  - `order_id` → Linked to `new_orders.csv`  
  - `f_id` → Food item ID (linked with `food.csv`)  
- **Purpose:** Provides detailed breakdown of items included in each order.  

---

### 6. `new_orders.csv`
- **Rows:** 25  
- **Columns:**  
  - `order_id` → Unique order ID  
  - `user_id` → ID of the customer  
  - `r_id` → Restaurant ID  
  - `amount` → Total order amount  
  - `date` → Order date  
  - `partner_id` → Delivery partner (linked with `delivery_partner.csv`)  
  - `delivery_time` → Delivery duration (minutes)  
  - `delivery_rating` → Customer rating for delivery service  
  - `restaurant_rating` → Customer rating for restaurant food  
- **Purpose:** Contains complete order information for analysis of delivery performance and restaurant feedback.  

