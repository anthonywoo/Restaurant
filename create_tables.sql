CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  mentor_id INTEGER,
  FOREIGN KEY(mentor_id) REFERENCES chefs(id)

);

CREATE TABLE restaurants (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  neighborhood VARCHAR(255) NOT NULL,
  cuisine VARCHAR(255) NOT NULL
);

CREATE TABLE chef_tenures (
  id INTEGER PRIMARY KEY,
  chef_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  start_date TEXT NOT NULL, 
  end_date TEXT,
  head_chef INTEGER NOT NULL,
  FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
  FOREIGN KEY(chef_id) REFERENCES chefs(id)
);

CREATE TABLE critics (
  id INTEGER PRIMARY KEY,
  screen_name VARCHAR(255) NOT NULL
);

CREATE TABLE restaurant_reviews (
  id INTEGER PRIMARY KEY,
  critic_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  score VARCHAR(20) NOT NULL,
  review_date TEXT NOT NULL, 
  review TEXT NOT NULL,
  FOREIGN KEY(restaurant_id) REFERENCES restaurants(id)
  FOREIGN KEY(critic_id) REFERENCES critics(id)
);

INSERT INTO chefs ('first_name', 'last_name', 'mentor_id') VALUES ("Anthony", "Woo", 0);
INSERT INTO chefs ('first_name', 'last_name', 'mentor_id') VALUES ("Gordon", "Ramsey", 1);
INSERT INTO chefs ('first_name', 'last_name', 'mentor_id') VALUES ("Jack", "Jr", 0);
INSERT INTO chefs ('first_name', 'last_name', 'mentor_id') VALUES ("Jack2", "Jr2", 0);
INSERT INTO chefs ('first_name', 'last_name', 'mentor_id') VALUES ("Jack3", "Jr3", 0);


INSERT INTO restaurants ('name', 'neighborhood', 'cuisine') VALUES ("Chipotle", "FIDI", "Mexican");
INSERT INTO restaurants ('name', 'neighborhood', 'cuisine') VALUES ("Rubios", "FIDI", "Mexican");
INSERT INTO restaurants ('name', 'neighborhood', 'cuisine') VALUES ("Rubios2", "FIDI", "Mexican");

INSERT INTO chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date', 'head_chef') 
  VALUES (1, 1, '2011-12-15', '2012-12-15', 1);
INSERT INTO chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date', 'head_chef') 
  VALUES (2, 1, '2011-12-15', '2012-12-15', 0);
INSERT INTO chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date', 'head_chef') 
  VALUES (3, 1, '2013-01-15', '2013-03-22', 1);

INSERT INTO chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date', 'head_chef') 
  VALUES (4, 2, '2011-01-15', '2013-03-22', 1);
INSERT INTO chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date', 'head_chef') 
  VALUES (5, 1, '2009-01-15', 'NULL', 0);


INSERT INTO critics ('screen_name') VALUES ("cowell");
INSERT INTO critics ('screen_name') VALUES ("paula");
INSERT INTO critics ('screen_name') VALUES ("randy");


INSERT INTO restaurant_reviews('critic_id', 'restaurant_id', 'review', 'review_date', 'score') 
  VALUES (1, 1, 'great food!', '2012-01-15', "17");

INSERT INTO restaurant_reviews('critic_id', 'restaurant_id', 'review', 'review_date', 'score') 
  VALUES (1, 2, 'good food!', '2012-01-15', "15");

INSERT INTO restaurant_reviews('critic_id', 'restaurant_id', 'review', 'review_date', 'score') 
  VALUES (1, 1, 'bad service', '2012-05-15', "11");

INSERT INTO restaurant_reviews('critic_id', 'restaurant_id', 'review', 'review_date', 'score') 
  VALUES (3, 1, 'Awesome!', '2012-05-15', "11");
