# README

A Ruby on Rails with ReactJS application which imports data (users, products and order). It allows to download the order histories based on the user.

### Instructions
1. Install ruby 3.3.2. Make sure you have postgresql as well.
2. Install redis `brew install redis`
3. Clone the application
4. Run `bundle install`
5. Run `rails db:migrate` and `rails db:seed`
6. Run `bundle exec rails s` and start the sidekiq `bundle exec sidekiq`
7. Go into the client folder `cd client` and do `npm install` to download all client related dependencies.
8. From the client folder run `npm run dev`
9. Visit `http://localhost:5173/` and you should see the

### Importing data from CSV
The data folder has sample `order_details.csv`, `products.csv` and `users.csv`. For different data, make sure to have respective file names and data similar to the sample.
Ignore the `csv` files under the test as they are for unit test case.

#### Rules for CSV:
- `users.csv` needs to have `USERNAME`, `EMAIL` and `PHONE`. The username and email is mandatory.
- `products.csv` needs to have `CODE`, `NAME`, `CATEGORY`. The code, name and category is mandatory.
- `order_details.csv` needs to have `USER_EMAIL`, `PRODUCT_CODE` and `ORDER_DATE`. The user email, product code and order date is mandatory.

If any of the mandatory fields have problem, then they will not be imported into the system.
