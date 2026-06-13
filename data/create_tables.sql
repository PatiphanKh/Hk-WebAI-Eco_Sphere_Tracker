CREATE TABLE IF NOT EXISTS public.users (
  user_id text PRIMARY KEY,
  name text,
  email text,
  phone text,
  loyalty_points integer,
  role text
);

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.users
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.users
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.products (
  product_id text PRIMARY KEY,
  name text,
  category text,
  price integer,
  stock integer,
  image text
);

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.products
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.products
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.ecommerce_orders (
  order_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  items jsonb,
  total_price integer,
  status text,
  timestamp timestamptz
);

ALTER TABLE public.ecommerce_orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.ecommerce_orders
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.ecommerce_orders
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.hotels (
  hotel_id text PRIMARY KEY,
  name text,
  location text,
  rating numeric,
  price_per_night integer,
  amenities jsonb
);

ALTER TABLE public.hotels ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.hotels
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.hotels
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.hotel_bookings (
  booking_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  hotel_id text REFERENCES public.hotels(hotel_id) ON DELETE CASCADE,
  check_in date,
  check_out date,
  guests integer,
  total_price integer,
  status text
);

ALTER TABLE public.hotel_bookings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.hotel_bookings
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.hotel_bookings
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.flights (
  flight_id text PRIMARY KEY,
  airline text,
  origin text,
  destination text,
  departure_time timestamptz,
  price integer
);

ALTER TABLE public.flights ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.flights
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.flights
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.flight_tickets (
  ticket_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  flight_id text REFERENCES public.flights(flight_id) ON DELETE CASCADE,
  seat text,
  status text
);

ALTER TABLE public.flight_tickets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.flight_tickets
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.flight_tickets
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.transactions (
  txn_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  type text,
  category text,
  amount integer,
  date timestamptz,
  note text
);

ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.transactions
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.transactions
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.restaurants (
  res_id text PRIMARY KEY,
  name text,
  cuisine text,
  rating numeric,
  delivery_time_min integer
);

ALTER TABLE public.restaurants ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.restaurants
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.restaurants
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.food_orders (
  order_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  restaurant_id text REFERENCES public.restaurants(res_id) ON DELETE CASCADE,
  menu_items jsonb,
  total_price integer,
  status text,
  rider_name text
);

ALTER TABLE public.food_orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.food_orders
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.food_orders
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.doctors (
  doctor_id text PRIMARY KEY,
  name text,
  department text,
  hospital text
);

ALTER TABLE public.doctors ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.doctors
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.doctors
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.appointments (
  apt_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  doctor_id text REFERENCES public.doctors(doctor_id) ON DELETE CASCADE,
  date timestamptz,
  symptom text,
  status text
);

ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.appointments
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.appointments
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.courses (
  course_id text PRIMARY KEY,
  title text,
  instructor text,
  total_lessons integer
);

ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.courses
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.courses
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.enrollments (
  enroll_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  course_id text REFERENCES public.courses(course_id) ON DELETE CASCADE,
  progress_percent integer,
  status text
);

ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.enrollments
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.enrollments
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.events (
  event_id text PRIMARY KEY,
  title text,
  date timestamptz,
  location text,
  ticket_price integer
);

ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.events
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.events
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.event_tickets (
  ticket_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  event_id text REFERENCES public.events(event_id) ON DELETE CASCADE,
  seat_zone text,
  status text
);

ALTER TABLE public.event_tickets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.event_tickets
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.event_tickets
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.projects (
  project_id text PRIMARY KEY,
  name text,
  deadline date
);

ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.projects
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.projects
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.tasks (
  task_id text PRIMARY KEY,
  project_id text REFERENCES public.projects(project_id) ON DELETE CASCADE,
  assigned_to text REFERENCES public.users(user_id) ON DELETE CASCADE,
  title text,
  status text,
  priority text
);

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.tasks
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.tasks
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.chats (
  chat_id text PRIMARY KEY,
  user_id text,
  shop_id text,
  status text,
  messages jsonb
);

ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.chats
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.chats
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.locations (
  location_id text PRIMARY KEY,
  name text,
  type text,
  ref_id text,
  address text,
  coordinates jsonb,
  operating_hours text
);

ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.locations
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.locations
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.notifications (
  notif_id text,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  type text,
  title text,
  message text,
  is_read boolean,
  timestamp timestamptz,
  action_link text
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.notifications
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.notifications
  TO service_role USING (true) WITH CHECK (true);

CREATE TABLE IF NOT EXISTS public.reviews (
  review_id text PRIMARY KEY,
  user_id text REFERENCES public.users(user_id) ON DELETE CASCADE,
  target_id text,
  target_type text,
  rating integer,
  comment text,
  timestamp timestamptz,
  images jsonb
);

ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON public.reviews
  FOR SELECT TO public USING (true);

CREATE POLICY "Enable all access for service role" ON public.reviews
  TO service_role USING (true) WITH CHECK (true);

INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u001', 'Somchai Jaidee', 'somchai@example.com', '081-111-1111', 500, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u002', 'Alice Smith', 'alice@example.com', '089-999-9999', 1200, 'VIP') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u003', 'Mana Dee', 'mana.d@example.com', '082-222-3333', 50, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u004', 'Somsri Jai-ngam', 'somsri.j@example.com', '083-444-5555', 850, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u005', 'John Doe', 'john.doe@example.com', '091-234-5678', 2100, 'VIP') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u006', 'Prasit Kung', 'prasit.k@example.com', '061-888-7777', 300, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u007', 'Mary Johnson', 'mary.j@example.com', '092-333-4444', 150, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u008', 'Wipa Rattanaporn', 'wipa.r@example.com', '084-555-6666', 3500, 'VIP') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u009', 'Kenji Sato', 'kenji.s@example.com', '085-777-8888', 20, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u010', 'Nida Patchara', 'nida.p@example.com', '093-666-9999', 900, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u011', 'David Brown', 'david.b@example.com', '086-123-0000', 4500, 'VIP') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u012', 'Kanda Munkong', 'kanda.m@example.com', '062-987-6543', 600, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u013', 'Sarah Lee', 'sarah.l@example.com', '087-654-3210', 1250, 'VIP') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u014', 'Arthit Suriya', 'arthit.s@example.com', '094-111-2222', 45, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.users (user_id, name, email, phone, loyalty_points, role) VALUES ('u015', 'Pimchanok Luea', 'pimchanok.l@example.com', '088-222-1111', 780, 'MEMBER') ON CONFLICT DO NOTHING;

INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-101', 'Wireless Noise Cancelling Headphones', 'Electronics', 2500, 50, 'https://placehold.co/300x300?text=Headphones') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-102', 'Running Shoes Gen 5', 'Fashion', 1800, 10, 'https://placehold.co/300x300?text=Shoes') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-103', 'Smart Watch Series X', 'Electronics', 4500, 25, 'https://placehold.co/300x300?text=Smart+Watch') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-104', 'Mechanical Keyboard RGB', 'Electronics', 3200, 5, 'https://placehold.co/300x300?text=Keyboard') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-105', 'Gaming Mouse Wireless', 'Electronics', 1200, 0, 'https://placehold.co/300x300?text=Mouse') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-106', '4K Monitor 27 inch', 'Electronics', 8900, 12, 'https://placehold.co/300x300?text=Monitor') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-107', 'USB-C Fast Charger', 'Electronics', 550, 100, 'https://placehold.co/300x300?text=Charger') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-108', 'Bluetooth Speaker Mini', 'Electronics', 790, 30, 'https://placehold.co/300x300?text=Speaker') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-109', 'Laptop Stand Aluminum', 'Electronics', 450, 45, 'https://placehold.co/300x300?text=Stand') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-110', 'Webcam HD 1080p', 'Electronics', 1100, 8, 'https://placehold.co/300x300?text=Webcam') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-111', 'Cotton T-Shirt Black', 'Fashion', 250, 60, 'https://placehold.co/300x300?text=T-Shirt') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-112', 'Denim Jeans Slim Fit', 'Fashion', 990, 20, 'https://placehold.co/300x300?text=Jeans') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-113', 'Leather Wallet', 'Fashion', 1500, 15, 'https://placehold.co/300x300?text=Wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-114', 'Aviator Sunglasses', 'Fashion', 500, 35, 'https://placehold.co/300x300?text=Sunglasses') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-115', 'Hoodie Sweatshirt Grey', 'Fashion', 750, 0, 'https://placehold.co/300x300?text=Hoodie') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-116', 'Canvas Backpack', 'Fashion', 1200, 18, 'https://placehold.co/300x300?text=Backpack') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-117', 'Sports Cap', 'Fashion', 300, 50, 'https://placehold.co/300x300?text=Cap') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-118', 'Formal Shirt White', 'Fashion', 600, 25, 'https://placehold.co/300x300?text=Shirt') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-119', 'Winter Jacket', 'Fashion', 2200, 5, 'https://placehold.co/300x300?text=Jacket') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-120', 'Ankle Socks (Pack of 3)', 'Fashion', 150, 100, 'https://placehold.co/300x300?text=Socks') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-121', 'Modern Desk Lamp', 'Home', 850, 20, 'https://placehold.co/300x300?text=Lamp') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-122', 'Memory Foam Pillow', 'Home', 600, 30, 'https://placehold.co/300x300?text=Pillow') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-123', 'Ceramic Coffee Mug', 'Home', 120, 80, 'https://placehold.co/300x300?text=Mug') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-124', 'Bath Towel Set', 'Home', 450, 22, 'https://placehold.co/300x300?text=Towel') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-125', 'Minimalist Wall Clock', 'Home', 550, 14, 'https://placehold.co/300x300?text=Clock') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-126', 'Plant Pot (Indoor)', 'Home', 250, 0, 'https://placehold.co/300x300?text=Pot') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-127', 'Essential Oil Diffuser', 'Home', 990, 15, 'https://placehold.co/300x300?text=Diffuser') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-128', 'Non-Stick Frying Pan', 'Home', 750, 28, 'https://placehold.co/300x300?text=Pan') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-129', 'Picture Frame 8x10', 'Home', 180, 60, 'https://placehold.co/300x300?text=Frame') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-130', 'Floor Rug (Grey)', 'Home', 1200, 8, 'https://placehold.co/300x300?text=Rug') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-131', 'Yoga Mat', 'Sports', 350, 40, 'https://placehold.co/300x300?text=Yoga+Mat') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-132', 'Dumbbell Set (5kg)', 'Sports', 900, 12, 'https://placehold.co/300x300?text=Dumbbell') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-133', 'Sports Water Bottle', 'Sports', 150, 100, 'https://placehold.co/300x300?text=Bottle') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-134', 'Football Size 5', 'Sports', 550, 25, 'https://placehold.co/300x300?text=Football') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-135', 'Badminton Racket', 'Sports', 1200, 10, 'https://placehold.co/300x300?text=Racket') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-136', 'Resistance Bands Set', 'Sports', 250, 55, 'https://placehold.co/300x300?text=Bands') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-137', 'Camping Tent (2 Person)', 'Sports', 1800, 5, 'https://placehold.co/300x300?text=Tent') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-138', 'Jump Rope', 'Sports', 120, 70, 'https://placehold.co/300x300?text=Rope') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-139', 'Cycling Helmet', 'Sports', 850, 15, 'https://placehold.co/300x300?text=Helmet') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-140', 'Foam Roller', 'Sports', 300, 30, 'https://placehold.co/300x300?text=Roller') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-141', 'Vitamin C Serum', 'Beauty', 590, 45, 'https://placehold.co/300x300?text=Serum') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-142', 'Matte Lipstick Red', 'Beauty', 290, 60, 'https://placehold.co/300x300?text=Lipstick') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-143', 'Moisturizing Cream', 'Beauty', 450, 20, 'https://placehold.co/300x300?text=Cream') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-144', 'Sunscreen SPF 50', 'Beauty', 390, 10, 'https://placehold.co/300x300?text=Sunscreen') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-145', 'Perfume 50ml', 'Beauty', 2500, 0, 'https://placehold.co/300x300?text=Perfume') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-146', 'Face Wash Gentle', 'Beauty', 190, 80, 'https://placehold.co/300x300?text=Face+Wash') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-147', 'Action Figure Hero', 'Toys', 1200, 12, 'https://placehold.co/300x300?text=Figure') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-148', 'Board Game Strategy', 'Toys', 1500, 8, 'https://placehold.co/300x300?text=Board+Game') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-149', 'Plush Bear Toy', 'Toys', 400, 35, 'https://placehold.co/300x300?text=Bear') ON CONFLICT DO NOTHING;
INSERT INTO public.products (product_id, name, category, price, stock, image) VALUES ('p-150', 'Building Blocks Set', 'Toys', 850, 25, 'https://placehold.co/300x300?text=Blocks') ON CONFLICT DO NOTHING;

INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-001', 'u001', '[{"product_id":"p-101","qty":1}]'::jsonb, 2500, 'DELIVERED', '2024-11-10T10:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-002', 'u002', '[{"product_id":"p-102","qty":1},{"product_id":"p-111","qty":2}]'::jsonb, 2300, 'SHIPPED', '2025-01-15T09:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-003', 'u005', '[{"product_id":"p-103","qty":1}]'::jsonb, 4500, 'PENDING', '2026-02-09T14:20:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-004', 'u003', '[{"product_id":"p-120","qty":5}]'::jsonb, 750, 'PAID', '2026-02-08T11:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-005', 'u008', '[{"product_id":"p-106","qty":1},{"product_id":"p-104","qty":1}]'::jsonb, 12100, 'DELIVERED', '2025-12-20T16:45:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-006', 'u011', '[{"product_id":"p-145","qty":1}]'::jsonb, 2500, 'CANCELLED', '2025-10-05T08:15:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-007', 'u001', '[{"product_id":"p-133","qty":2}]'::jsonb, 300, 'DELIVERED', '2025-08-12T13:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-008', 'u004', '[{"product_id":"p-112","qty":1}]'::jsonb, 990, 'SHIPPED', '2026-02-05T10:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-009', 'u015', '[{"product_id":"p-123","qty":4}]'::jsonb, 480, 'DELIVERED', '2025-09-09T19:20:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-010', 'u002', '[{"product_id":"p-141","qty":1},{"product_id":"p-144","qty":1}]'::jsonb, 980, 'PAID', '2026-02-10T09:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-011', 'u006', '[{"product_id":"p-107","qty":2}]'::jsonb, 1100, 'DELIVERED', '2025-07-25T15:10:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-012', 'u007', '[{"product_id":"p-116","qty":1}]'::jsonb, 1200, 'PENDING', '2026-02-09T20:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-013', 'u010', '[{"product_id":"p-131","qty":1},{"product_id":"p-132","qty":2}]'::jsonb, 2150, 'DELIVERED', '2025-06-18T11:45:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-014', 'u012', '[{"product_id":"p-150","qty":1}]'::jsonb, 850, 'SHIPPED', '2026-02-06T14:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-015', 'u013', '[{"product_id":"p-105","qty":1}]'::jsonb, 1200, 'DELIVERED', '2025-05-30T10:20:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-016', 'u009', '[{"product_id":"p-121","qty":1}]'::jsonb, 850, 'CANCELLED', '2025-11-11T12:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-017', 'u001', '[{"product_id":"p-111","qty":3},{"product_id":"p-112","qty":1}]'::jsonb, 1740, 'DELIVERED', '2025-04-14T09:15:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-018', 'u014', '[{"product_id":"p-127","qty":1}]'::jsonb, 990, 'PAID', '2026-02-08T16:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-019', 'u005', '[{"product_id":"p-101","qty":2}]'::jsonb, 5000, 'DELIVERED', '2025-03-22T18:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-020', 'u003', '[{"product_id":"p-142","qty":1},{"product_id":"p-146","qty":1}]'::jsonb, 480, 'SHIPPED', '2026-02-07T13:45:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-021', 'u008', '[{"product_id":"p-102","qty":1}]'::jsonb, 1800, 'DELIVERED', '2025-02-15T11:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-022', 'u011', '[{"product_id":"p-138","qty":2}]'::jsonb, 240, 'DELIVERED', '2025-01-10T14:10:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-023', 'u002', '[{"product_id":"p-113","qty":1}]'::jsonb, 1500, 'PENDING', '2026-02-10T08:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-024', 'u006', '[{"product_id":"p-125","qty":1}]'::jsonb, 550, 'DELIVERED', '2024-12-05T17:20:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-025', 'u015', '[{"product_id":"p-149","qty":1}]'::jsonb, 400, 'SHIPPED', '2026-02-05T09:50:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-026', 'u004', '[{"product_id":"p-118","qty":2}]'::jsonb, 1200, 'CANCELLED', '2025-09-18T12:15:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-027', 'u007', '[{"product_id":"p-134","qty":1}]'::jsonb, 550, 'DELIVERED', '2025-08-30T16:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-028', 'u013', '[{"product_id":"p-108","qty":1}]'::jsonb, 790, 'PAID', '2026-02-09T11:25:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-029', 'u010', '[{"product_id":"p-119","qty":1}]'::jsonb, 2200, 'DELIVERED', '2025-11-25T10:40:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-030', 'u001', '[{"product_id":"p-143","qty":2}]'::jsonb, 900, 'SHIPPED', '2026-02-06T15:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-031', 'u012', '[{"product_id":"p-122","qty":1}]'::jsonb, 600, 'DELIVERED', '2025-04-05T13:10:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-032', 'u009', '[{"product_id":"p-115","qty":1}]'::jsonb, 750, 'DELIVERED', '2025-06-22T09:45:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-033', 'u005', '[{"product_id":"p-137","qty":1}]'::jsonb, 1800, 'PENDING', '2026-02-10T10:15:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-034', 'u014', '[{"product_id":"p-114","qty":1}]'::jsonb, 500, 'DELIVERED', '2025-12-12T14:50:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-035', 'u003', '[{"product_id":"p-148","qty":1}]'::jsonb, 1500, 'SHIPPED', '2026-02-04T11:20:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-036', 'u008', '[{"product_id":"p-129","qty":3}]'::jsonb, 540, 'DELIVERED', '2025-03-15T16:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-037', 'u002', '[{"product_id":"p-104","qty":1}]'::jsonb, 3200, 'PAID', '2026-02-08T12:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-038', 'u011', '[{"product_id":"p-130","qty":1}]'::jsonb, 1200, 'DELIVERED', '2025-07-08T09:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-039', 'u006', '[{"product_id":"p-147","qty":1}]'::jsonb, 1200, 'CANCELLED', '2025-10-30T15:40:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-040', 'u015', '[{"product_id":"p-110","qty":1}]'::jsonb, 1100, 'DELIVERED', '2025-05-18T10:10:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-041', 'u004', '[{"product_id":"p-124","qty":2}]'::jsonb, 900, 'SHIPPED', '2026-02-07T14:25:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-042', 'u001', '[{"product_id":"p-136","qty":1}]'::jsonb, 250, 'DELIVERED', '2025-02-28T11:50:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-043', 'u013', '[{"product_id":"p-117","qty":1},{"product_id":"p-120","qty":1}]'::jsonb, 450, 'PENDING', '2026-02-10T11:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-044', 'u007', '[{"product_id":"p-139","qty":1}]'::jsonb, 850, 'DELIVERED', '2025-09-05T13:30:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-045', 'u010', '[{"product_id":"p-128","qty":1}]'::jsonb, 750, 'PAID', '2026-02-09T10:05:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-046', 'u012', '[{"product_id":"p-135","qty":2}]'::jsonb, 2400, 'DELIVERED', '2025-06-12T16:15:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-047', 'u005', '[{"product_id":"p-140","qty":1}]'::jsonb, 300, 'SHIPPED', '2026-02-05T08:45:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-048', 'u014', '[{"product_id":"p-109","qty":1}]'::jsonb, 450, 'DELIVERED', '2025-11-02T12:00:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-049', 'u009', '[{"product_id":"p-126","qty":2}]'::jsonb, 500, 'CANCELLED', '2025-04-20T14:40:00Z') ON CONFLICT DO NOTHING;
INSERT INTO public.ecommerce_orders (order_id, user_id, items, total_price, status, timestamp) VALUES ('ord-050', 'u002', '[{"product_id":"p-133","qty":1},{"product_id":"p-138","qty":1}]'::jsonb, 270, 'PENDING', '2026-02-10T12:00:00Z') ON CONFLICT DO NOTHING;

INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-001', 'Siam Grand Hotel', 'Bangkok', 4.8, 3500, '["Pool","Wifi","Gym","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-002', 'Phuket Ocean Breeze Resort', 'Phuket', 4.5, 4200, '["Pool","Wifi","Beach Access","Spa","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-003', 'Chiang Mai Lanna Boutique', 'Chiang Mai', 4.7, 1800, '["Wifi","Breakfast","Garden"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-004', 'Pattaya City Center Hotel', 'Pattaya', 4, 1200, '["Wifi","Parking","Gym"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-005', 'Samui Sunset Villa', 'Koh Samui', 4.9, 8500, '["Private Pool","Wifi","Kitchen","Beach Access","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-006', 'Krabi Beachfront Bungalow', 'Krabi', 4.3, 2500, '["Wifi","Beach Access","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-007', 'Hua Hin Golf Resort', 'Hua Hin', 4.6, 3800, '["Pool","Golf Course","Wifi","Spa"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-008', 'Bangkok Riverside Suites', 'Bangkok', 4.4, 2900, '["Pool","Wifi","Gym","River View"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-009', 'The Old City Hostel', 'Chiang Mai', 4.2, 500, '["Wifi","Shared Lounge","Lockers"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-010', 'Patong Party Hotel', 'Phuket', 3.8, 1500, '["Pool","Wifi","Bar","DJ"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-011', 'Sukhumvit Luxury Residence', 'Bangkok', 4.7, 4500, '["Pool","Wifi","Gym","Sauna","Parking"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-012', 'Ayutthaya Historical Inn', 'Ayutthaya', 4.5, 1200, '["Wifi","Breakfast","Bicycle Rental"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-013', 'Khao Yai Nature Resort', 'Nakhon Ratchasima', 4.6, 3200, '["Garden","Wifi","Breakfast","Camping Area"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-014', 'Koh Tao Dive Resort', 'Koh Tao', 4.4, 2000, '["Wifi","Pool","Diving Center","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-015', 'Pai Mountain View', 'Mae Hong Son', 4.3, 900, '["Wifi","Garden","Fireplace"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-016', 'Sathorn Business Hotel', 'Bangkok', 4.1, 2200, '["Wifi","Meeting Room","Gym","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-017', 'Rayong Beach Hotel', 'Rayong', 3.9, 1400, '["Wifi","Pool","Parking"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-018', 'Kanchanaburi River Raft', 'Kanchanaburi', 4.5, 2800, '["Wifi","River View","Breakfast","Kayak"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-019', 'Trang Island Hop Resort', 'Trang', 4.2, 2100, '["Wifi","Beach Access","Tour Desk"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-020', 'Hat Yai Central', 'Songkhla', 4, 1100, '["Wifi","Parking","Restaurant"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-021', 'The Royal Suite Bangkok', 'Bangkok', 4.9, 12000, '["Pool","Wifi","Gym","Spa","Butler Service","Lounge"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-022', 'Nimman Art Hotel', 'Chiang Mai', 4.6, 2400, '["Wifi","Gallery","Coffee Shop","Parking"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-023', 'Ao Nang Paradise', 'Krabi', 4.4, 3000, '["Pool","Wifi","Spa","Kids Club"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-024', 'Jomtien Family Resort', 'Pattaya', 4.1, 1800, '["Pool","Wifi","Slide","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-025', 'Udon Thani City Hotel', 'Udon Thani', 3.8, 800, '["Wifi","Parking","Meeting Room"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-026', 'Koh Chang Hideaway', 'Trat', 4.5, 3500, '["Beach Access","Wifi","Pool","Spa"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-027', 'Chiang Rai Golden Triangle', 'Chiang Rai', 4.7, 5500, '["Pool","Wifi","Spa","Elephant Camp"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-028', 'Khao Lak Family Resort', 'Phang Nga', 4.6, 4000, '["Pool","Wifi","Beach Access","Kids Club","Gym"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-029', 'Bangkok Budget Inn', 'Bangkok', 3.5, 650, '["Wifi","Shared Bathroom","24h Reception"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-030', 'Samui Zen Hotel', 'Koh Samui', 4.3, 2800, '["Pool","Wifi","Yoga Studio","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-031', 'Phitsanulok Grand', 'Phitsanulok', 4, 1200, '["Wifi","Parking","Restaurant","Meeting Room"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-032', 'Koh Lipe Blue Sea', 'Satun', 4.5, 3200, '["Beach Access","Wifi","Snorkeling Gear"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-033', 'Khon Kaen Pullman', 'Khon Kaen', 4.7, 2500, '["Pool","Wifi","Gym","Spa","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-034', 'Surat Thani Airport Hotel', 'Surat Thani', 3.9, 900, '["Wifi","Parking","Shuttle Service"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-035', 'Koh Samet White Sand', 'Rayong', 4.2, 2400, '["Beach Access","Wifi","Fire Show","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-036', 'Nan Riverside Art Gallery', 'Nan', 4.6, 1600, '["Wifi","Garden","Gallery","River View"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-037', 'Betong Skywalk Hotel', 'Yala', 4.1, 1300, '["Wifi","Parking","Restaurant"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-038', 'Chatuchak Weekend Stay', 'Bangkok', 4, 950, '["Wifi","Near BTS","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-039', 'Amphawa Floating Market Homestay', 'Samut Songkhram', 4.4, 1500, '["Wifi","River View","Boat Tour","Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-040', 'Buriram United Hotel', 'Buriram', 4.3, 1800, '["Wifi","Pool","Gym","Parking"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-041', 'Ekkamai Hipster Hotel', 'Bangkok', 4.5, 2100, '["Wifi","Cafe","Co-working Space","Bar"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-042', 'Similan Island Liveaboard', 'Phang Nga', 4.8, 6000, '["Diving Equipment","All Meals","Wifi (Weak)"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-043', 'Ratchaburi Farm Stay', 'Ratchaburi', 4.2, 1200, '["Wifi","Farm Animals","Organic Breakfast"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-044', 'Terminal 21 Grande', 'Bangkok', 4.7, 3800, '["Pool","Wifi","Gym","Shopping Mall Access"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-045', 'Mae Sot Border Hotel', 'Tak', 3.7, 700, '["Wifi","Parking","Restaurant"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-046', 'Chinatown Boutique', 'Bangkok', 4.3, 1900, '["Wifi","Restaurant","Bar","Decorated Rooms"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-047', 'Ranong Hot Spring Resort', 'Ranong', 4.4, 2600, '["Hot Spring","Wifi","Spa","Restaurant"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-048', 'Lopburi Monkey Hotel', 'Lopburi', 3.6, 600, '["Wifi","Parking"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-049', 'Nakhon Si Thammarat Heritage', 'Nakhon Si Thammarat', 4.2, 1400, '["Wifi","Parking","Restaurant","Garden"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.hotels (hotel_id, name, location, rating, price_per_night, amenities) VALUES ('h-050', 'Suvarnabhumi Transit Hotel', 'Bangkok', 4, 2000, '["Wifi","Airport Shuttle","24h Check-in"]'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-001', 'u002', 'h-001', '2026-04-12', '2026-04-15', 2, 10500, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-002', 'u001', 'h-005', '2025-12-25', '2025-12-30', 2, 42500, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-003', 'u005', 'h-010', '2026-02-09', '2026-02-12', 4, 4500, 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-004', 'u003', 'h-020', '2025-11-10', '2025-11-12', 1, 2200, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-005', 'u008', 'h-002', '2026-03-01', '2026-03-05', 2, 16800, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-006', 'u012', 'h-015', '2025-01-05', '2025-01-08', 2, 2700, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-007', 'u004', 'h-033', '2026-05-20', '2026-05-22', 1, 5000, 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-008', 'u015', 'h-007', '2025-10-15', '2025-10-18', 3, 11400, 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-009', 'u010', 'h-042', '2026-01-15', '2026-01-20', 2, 30000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-010', 'u002', 'h-050', '2026-02-10', '2026-02-11', 1, 2000, 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-011', 'u006', 'h-025', '2025-08-08', '2025-08-10', 2, 1600, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-012', 'u009', 'h-012', '2026-04-13', '2026-04-14', 4, 2400, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-013', 'u014', 'h-018', '2025-12-05', '2025-12-07', 2, 5600, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-014', 'u007', 'h-030', '2026-06-01', '2026-06-05', 2, 11200, 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-015', 'u011', 'h-021', '2025-09-09', '2025-09-12', 2, 36000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-016', 'u001', 'h-003', '2024-12-28', '2025-01-02', 2, 9000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-017', 'u013', 'h-045', '2025-07-20', '2025-07-21', 1, 700, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-018', 'u005', 'h-006', '2026-03-15', '2026-03-20', 3, 12500, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-019', 'u002', 'h-041', '2026-02-14', '2026-02-15', 2, 2100, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-020', 'u008', 'h-027', '2025-11-20', '2025-11-23', 2, 16500, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-021', 'u003', 'h-009', '2025-04-10', '2025-04-12', 1, 1000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-022', 'u012', 'h-036', '2026-01-05', '2026-01-07', 2, 3200, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-023', 'u015', 'h-014', '2026-04-01', '2026-04-05', 2, 8000, 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-024', 'u010', 'h-008', '2025-06-15', '2025-06-16', 2, 2900, 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-025', 'u004', 'h-048', '2025-03-20', '2025-03-21', 2, 600, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-026', 'u006', 'h-023', '2026-02-08', '2026-02-15', 4, 21000, 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-027', 'u009', 'h-032', '2025-12-31', '2026-01-03', 2, 9600, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-028', 'u014', 'h-017', '2025-05-01', '2025-05-03', 2, 2800, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-029', 'u001', 'h-038', '2026-02-28', '2026-03-01', 1, 950, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-030', 'u007', 'h-044', '2025-08-25', '2025-08-28', 2, 11400, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-031', 'u011', 'h-013', '2026-01-20', '2026-01-22', 2, 6400, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-032', 'u005', 'h-026', '2026-04-10', '2026-04-15', 2, 17500, 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-033', 'u002', 'h-040', '2025-10-05', '2025-10-06', 1, 1800, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-034', 'u008', 'h-011', '2026-03-05', '2026-03-07', 2, 9000, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-035', 'u013', 'h-046', '2025-02-14', '2025-02-16', 2, 3800, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-036', 'u003', 'h-019', '2026-05-10', '2026-05-13', 2, 6300, 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-037', 'u010', 'h-004', '2025-07-07', '2025-07-10', 3, 3600, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-038', 'u006', 'h-029', '2026-02-10', '2026-02-12', 1, 1300, 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-039', 'u015', 'h-035', '2025-11-15', '2025-11-17', 2, 4800, 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-040', 'u012', 'h-022', '2025-12-20', '2025-12-25', 2, 12000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-041', 'u009', 'h-049', '2025-09-01', '2025-09-02', 1, 1400, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-042', 'u001', 'h-016', '2026-02-20', '2026-02-21', 1, 2200, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-043', 'u004', 'h-039', '2025-10-22', '2025-10-23', 2, 1500, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-044', 'u007', 'h-024', '2026-04-12', '2026-04-14', 4, 3600, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-045', 'u014', 'h-031', '2025-06-05', '2025-06-06', 1, 1200, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-046', 'u008', 'h-047', '2026-01-08', '2026-01-10', 2, 5200, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-047', 'u002', 'h-037', '2025-03-15', '2025-03-16', 2, 1300, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-048', 'u011', 'h-001', '2026-03-30', '2026-04-02', 2, 10500, 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-049', 'u005', 'h-028', '2025-11-28', '2025-11-30', 3, 8000, 'CHECKED_OUT') ON CONFLICT DO NOTHING;
INSERT INTO public.hotel_bookings (booking_id, user_id, hotel_id, check_in, check_out, guests, total_price, status) VALUES ('bk-h-050', 'u003', 'h-043', '2026-02-18', '2026-02-19', 2, 1200, 'CONFIRMED') ON CONFLICT DO NOTHING;

INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-001', 'Thai Sky', 'BKK', 'CNX', '2026-04-12T08:00:00Z', 1200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-002', 'Siam Airways', 'BKK', 'HKT', '2026-04-12T09:30:00Z', 1500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-003', 'Andaman Jet', 'DMK', 'KBV', '2026-04-13T07:15:00Z', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-004', 'Royal Thai', 'BKK', 'NRT', '2026-05-01T23:00:00Z', 18500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-005', 'Eco Jet', 'DMK', 'CNX', '2026-02-20T06:00:00Z', 850) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-006', 'Thai Sky', 'BKK', 'USM', '2026-03-15T10:45:00Z', 3200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-007', 'Siam Airways', 'BKK', 'SIN', '2026-02-28T14:00:00Z', 4500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-008', 'North Star', 'CNX', 'BKK', '2026-04-15T18:30:00Z', 1100) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-009', 'Andaman Jet', 'HKT', 'DMK', '2026-04-16T11:20:00Z', 1300) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-010', 'Royal Thai', 'BKK', 'LHR', '2026-06-10T01:00:00Z', 35000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-011', 'Thai Sky', 'DMK', 'UBP', '2025-12-25T08:00:00Z', 950) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-012', 'Siam Airways', 'BKK', 'HDY', '2026-02-14T15:00:00Z', 1600) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-013', 'Eco Jet', 'DMK', 'UTH', '2026-03-05T07:30:00Z', 800) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-014', 'Royal Thai', 'BKK', 'HKG', '2025-11-10T09:00:00Z', 6500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-015', 'Bangkok Flyer', 'BKK', 'CEI', '2026-01-20T13:45:00Z', 1400) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-016', 'Thai Sky', 'BKK', 'KKC', '2026-02-25T19:00:00Z', 1050) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-017', 'Andaman Jet', 'KBV', 'BKK', '2026-04-18T10:00:00Z', 1100) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-018', 'Siam Airways', 'BKK', 'ICN', '2026-05-20T22:30:00Z', 12500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-019', 'Eco Jet', 'DMK', 'NST', '2025-10-05T08:45:00Z', 900) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-020', 'Royal Thai', 'BKK', 'CDG', '2026-07-01T00:30:00Z', 32000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-021', 'Thai Sky', 'BKK', 'CNX', '2026-04-12T12:00:00Z', 1350) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-022', 'Thai Sky', 'BKK', 'CNX', '2026-04-12T16:00:00Z', 1450) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-023', 'Siam Airways', 'BKK', 'HKT', '2026-04-12T18:00:00Z', 1700) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-024', 'North Star', 'CEI', 'DMK', '2026-03-30T09:15:00Z', 1200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-025', 'Bangkok Flyer', 'BKK', 'TDX', '2026-04-05T11:00:00Z', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-026', 'Eco Jet', 'DMK', 'ROI', '2025-09-15T07:00:00Z', 750) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-027', 'Royal Thai', 'BKK', 'JFK', '2026-08-15T04:00:00Z', 45000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-028', 'Thai Sky', 'BKK', 'URT', '2026-02-12T14:30:00Z', 1100) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-029', 'Siam Airways', 'BKK', 'TPE', '2026-03-10T10:00:00Z', 6200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-030', 'Andaman Jet', 'DMK', 'TST', '2025-12-10T13:00:00Z', 1200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-031', 'Eco Jet', 'DMK', 'KOP', '2026-01-05T15:45:00Z', 850) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-032', 'Royal Thai', 'BKK', 'SYD', '2026-11-20T19:00:00Z', 28000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-033', 'Thai Sky', 'CNX', 'HKT', '2026-04-14T09:30:00Z', 2200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-034', 'Siam Airways', 'HKT', 'USM', '2026-04-15T11:00:00Z', 2800) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-035', 'North Star', 'BKK', 'MAQ', '2026-02-18T16:20:00Z', 1500) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-036', 'Bangkok Flyer', 'DMK', 'PRH', '2025-08-20T08:30:00Z', 1300) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-037', 'Eco Jet', 'DMK', 'LOE', '2026-01-25T12:00:00Z', 950) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-038', 'Royal Thai', 'BKK', 'DXB', '2026-04-22T02:00:00Z', 22000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-039', 'Thai Sky', 'BKK', 'PHS', '2026-03-08T17:15:00Z', 1000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-040', 'Siam Airways', 'BKK', 'KUL', '2026-02-15T09:45:00Z', 3800) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-041', 'Andaman Jet', 'DMK', 'NAW', '2025-11-25T14:20:00Z', 1150) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-042', 'Eco Jet', 'DMK', 'SNO', '2026-02-02T10:10:00Z', 800) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-043', 'Royal Thai', 'BKK', 'ZRH', '2026-06-15T23:55:00Z', 34000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-044', 'Thai Sky', 'BKK', 'CJM', '2026-03-20T13:30:00Z', 1200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-045', 'Siam Airways', 'BKK', 'SGN', '2026-04-02T08:15:00Z', 4200) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-046', 'North Star', 'DMK', 'NNT', '2025-12-05T15:50:00Z', 1100) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-047', 'Bangkok Flyer', 'BKK', 'KKC', '2026-05-05T18:40:00Z', 1000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-048', 'Eco Jet', 'DMK', 'HGN', '2026-01-30T06:45:00Z', 700) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-049', 'Royal Thai', 'BKK', 'PEK', '2026-05-18T10:30:00Z', 15000) ON CONFLICT DO NOTHING;
INSERT INTO public.flights (flight_id, airline, origin, destination, departure_time, price) VALUES ('fl-050', 'Thai Sky', 'DMK', 'CNX', '2026-04-12T20:00:00Z', 1100) ON CONFLICT DO NOTHING;

INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-001', 'u015', 'fl-037', '18F', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-002', 'u014', 'fl-011', '24A', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-003', 'u012', 'fl-035', '25C', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-004', 'u012', 'fl-040', '25F', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-005', 'u004', 'fl-019', '5A', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-006', 'u006', 'fl-021', '1E', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-007', 'u001', 'fl-012', '12B', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-008', 'u004', 'fl-009', '17B', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-009', 'u009', 'fl-011', '5E', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-010', 'u008', 'fl-030', '2E', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-011', 'u014', 'fl-032', '18B', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-012', 'u004', 'fl-030', '30E', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-013', 'u002', 'fl-031', '4B', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-014', 'u009', 'fl-035', '4F', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-015', 'u004', 'fl-024', '15C', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-016', 'u003', 'fl-045', '7B', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-017', 'u002', 'fl-024', '2D', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-018', 'u003', 'fl-044', '27E', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-019', 'u010', 'fl-019', '24D', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-020', 'u012', 'fl-041', '25E', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-021', 'u008', 'fl-048', '3E', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-022', 'u003', 'fl-034', '27E', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-023', 'u001', 'fl-003', '28F', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-024', 'u006', 'fl-040', '8A', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-025', 'u009', 'fl-009', '20B', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-026', 'u002', 'fl-008', '30D', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-027', 'u009', 'fl-018', '3C', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-028', 'u013', 'fl-020', '4A', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-029', 'u003', 'fl-009', '13A', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-030', 'u006', 'fl-003', '18D', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-031', 'u004', 'fl-004', '9D', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-032', 'u006', 'fl-015', '11A', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-033', 'u004', 'fl-029', '19C', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-034', 'u001', 'fl-015', '12C', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-035', 'u011', 'fl-028', '2B', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-036', 'u014', 'fl-048', '12C', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-037', 'u007', 'fl-014', '15C', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-038', 'u012', 'fl-017', '18D', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-039', 'u004', 'fl-008', '27B', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-040', 'u013', 'fl-042', '1F', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-041', 'u008', 'fl-006', '28F', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-042', 'u006', 'fl-049', '11A', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-043', 'u003', 'fl-018', '10D', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-044', 'u008', 'fl-020', '17C', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-045', 'u003', 'fl-043', '3E', 'CHECKED_IN') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-046', 'u008', 'fl-016', '17A', 'ISSUED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-047', 'u006', 'fl-026', '5C', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-048', 'u009', 'fl-034', '5A', 'BOARDED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-049', 'u005', 'fl-021', '26B', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.flight_tickets (ticket_id, user_id, flight_id, seat, status) VALUES ('tkt-050', 'u008', 'fl-033', '18B', 'CHECKED_IN') ON CONFLICT DO NOTHING;

INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-101', 'u010', 'EXPENSE', 'Entertainment', 2811, '2025-01-07T17:43:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-102', 'u003', 'EXPENSE', 'Rent', 6602, '2024-12-28T15:10:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-103', 'u010', 'EXPENSE', 'Food', 677, '2024-12-19T10:00:00Z', 'Coffee') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-104', 'u013', 'INCOME', 'Bonus', 22034, '2024-04-01T20:48:00Z', 'Year End Bonus') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-105', 'u006', 'EXPENSE', 'Entertainment', 707, '2024-01-01T09:23:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-106', 'u011', 'EXPENSE', 'Transport', 2160, '2024-09-09T11:37:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-107', 'u006', 'EXPENSE', 'Shopping', 2277, '2025-06-06T13:39:00Z', 'Online Shopping') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-108', 'u003', 'EXPENSE', 'Shopping', 2393, '2025-03-01T09:03:00Z', 'Online Shopping') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-109', 'u010', 'EXPENSE', 'Transport', 2513, '2025-01-23T08:52:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-110', 'u010', 'EXPENSE', 'Education', 1895, '2026-01-22T14:16:00Z', 'Payment for Education') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-111', 'u003', 'EXPENSE', 'Entertainment', 1380, '2025-06-20T18:11:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-112', 'u011', 'EXPENSE', 'Food', 413, '2025-06-06T16:54:00Z', 'Coffee') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-113', 'u010', 'EXPENSE', 'Rent', 9935, '2025-12-09T20:09:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-114', 'u011', 'EXPENSE', 'Rent', 10087, '2024-10-07T16:00:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-115', 'u013', 'INCOME', 'Freelance', 3696, '2024-06-04T08:55:00Z', 'Project Payment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-116', 'u009', 'EXPENSE', 'Food', 373, '2024-04-10T13:16:00Z', 'Groceries') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-117', 'u002', 'EXPENSE', 'Rent', 10186, '2025-08-27T10:56:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-118', 'u004', 'EXPENSE', 'Food', 520, '2024-09-04T17:37:00Z', 'Groceries') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-119', 'u014', 'EXPENSE', 'Education', 2213, '2024-03-12T11:50:00Z', 'Payment for Education') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-120', 'u012', 'EXPENSE', 'Education', 2589, '2025-07-15T14:44:00Z', 'Payment for Education') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-121', 'u009', 'INCOME', 'Bonus', 17062, '2024-11-19T19:35:00Z', 'Year End Bonus') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-122', 'u015', 'INCOME', 'Gift', 1085, '2025-07-30T11:36:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-123', 'u015', 'EXPENSE', 'Entertainment', 2878, '2024-03-05T12:23:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-124', 'u012', 'EXPENSE', 'Health', 2616, '2024-03-06T16:03:00Z', 'Payment for Health') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-125', 'u006', 'INCOME', 'Gift', 2305, '2025-09-23T13:09:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-126', 'u006', 'EXPENSE', 'Rent', 9139, '2024-03-29T11:57:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-127', 'u015', 'EXPENSE', 'Transport', 1352, '2024-11-20T13:04:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-128', 'u007', 'EXPENSE', 'Utilities', 1018, '2025-01-25T12:41:00Z', 'Water/Electric Bill') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-129', 'u007', 'EXPENSE', 'Transport', 1443, '2024-08-22T09:36:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-130', 'u008', 'EXPENSE', 'Transport', 2884, '2024-07-26T10:55:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-131', 'u013', 'EXPENSE', 'Food', 94, '2025-09-25T20:50:00Z', 'Lunch') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-132', 'u013', 'EXPENSE', 'Shopping', 4429, '2024-05-11T20:30:00Z', 'Online Shopping') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-133', 'u002', 'EXPENSE', 'Shopping', 3869, '2025-08-01T16:15:00Z', 'Online Shopping') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-134', 'u004', 'INCOME', 'Salary', 38310, '2024-09-13T08:13:00Z', 'Monthly Salary') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-135', 'u012', 'EXPENSE', 'Entertainment', 183, '2025-10-10T10:18:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-136', 'u012', 'EXPENSE', 'Food', 109, '2024-09-14T15:47:00Z', 'Coffee') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-137', 'u015', 'INCOME', 'Bonus', 10934, '2024-11-30T18:14:00Z', 'Year End Bonus') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-138', 'u005', 'EXPENSE', 'Health', 2942, '2024-01-20T08:59:00Z', 'Payment for Health') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-139', 'u015', 'INCOME', 'Gift', 665, '2025-06-12T15:34:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-140', 'u013', 'EXPENSE', 'Entertainment', 994, '2024-09-29T12:06:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-141', 'u015', 'EXPENSE', 'Transport', 2858, '2025-07-21T15:55:00Z', 'Payment for Transport') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-142', 'u014', 'EXPENSE', 'Rent', 12735, '2024-06-13T17:48:00Z', 'Monthly Rent') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-143', 'u008', 'INCOME', 'Gift', 4141, '2024-08-25T10:01:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-144', 'u005', 'INCOME', 'Investment', 903, '2024-03-16T12:03:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-145', 'u009', 'INCOME', 'Freelance', 13457, '2024-09-22T17:47:00Z', 'Project Payment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-146', 'u014', 'EXPENSE', 'Entertainment', 2314, '2025-01-07T13:24:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-147', 'u006', 'EXPENSE', 'Food', 336, '2025-01-05T14:54:00Z', 'Lunch') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-148', 'u005', 'EXPENSE', 'Entertainment', 2122, '2025-12-07T09:28:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-149', 'u006', 'INCOME', 'Investment', 2416, '2025-12-09T08:12:00Z', 'Received money') ON CONFLICT DO NOTHING;
INSERT INTO public.transactions (txn_id, user_id, type, category, amount, date, note) VALUES ('tx-150', 'u006', 'EXPENSE', 'Entertainment', 2752, '2024-08-30T16:45:00Z', 'Payment for Entertainment') ON CONFLICT DO NOTHING;

INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-001', 'Spicy Kitchen Indian', 'Indian', 4.1, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-002', 'Tasty Cafe Chinese', 'Chinese', 5, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-003', 'Urban Spoon Chinese', 'Chinese', 4, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-004', 'Tasty Garden Dessert', 'Dessert', 4.3, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-005', 'Fresh Garden Thai', 'Thai', 4.9, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-006', 'Golden Spoon Thai', 'Thai', 3.7, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-007', 'Fresh Garden Chinese', 'Chinese', 4.3, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-008', 'Royal Plate Healthy', 'Healthy', 4.1, 60) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-009', 'Spicy Garden Indian', 'Indian', 4.4, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-010', 'Fresh Bistro Dessert', 'Dessert', 4.3, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-011', 'Local Kitchen Chinese', 'Chinese', 3.8, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-012', 'Spicy Bistro Japanese', 'Japanese', 3.7, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-013', 'Tasty Bowl Japanese', 'Japanese', 4.1, 20) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-014', 'Golden Garden Vietnamese', 'Vietnamese', 3.5, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-015', 'Tasty Bistro Italian', 'Italian', 5, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-016', 'Local House Dessert', 'Dessert', 3.6, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-017', 'Green House Dessert', 'Dessert', 3.6, 20) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-018', 'Royal Bowl Indian', 'Indian', 4.3, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-019', 'Local House Japanese', 'Japanese', 4.1, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-020', 'Green Kitchen Chinese', 'Chinese', 4.4, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-021', 'Tasty Cafe Japanese', 'Japanese', 4.4, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-022', 'Tasty Grill Indian', 'Indian', 3.9, 20) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-023', 'Spicy Grill American', 'American', 4.9, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-024', 'Urban Bowl Healthy', 'Healthy', 4.9, 60) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-025', 'Green Cafe Indian', 'Indian', 3.6, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-026', 'Happy Plate Italian', 'Italian', 4.1, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-027', 'Fresh Kitchen Vietnamese', 'Vietnamese', 4, 40) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-028', 'Tasty Wok American', 'American', 4.9, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-029', 'Royal House Thai', 'Thai', 4.8, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-030', 'Green Cafe Chinese', 'Chinese', 5, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-031', 'Happy Spoon Dessert', 'Dessert', 4.5, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-032', 'Spicy Cafe Healthy', 'Healthy', 4.2, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-033', 'Golden Grill Vietnamese', 'Vietnamese', 3.9, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-034', 'Tasty Bistro Japanese', 'Japanese', 4.8, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-035', 'Golden Cafe Japanese', 'Japanese', 4.4, 60) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-036', 'Happy House Vietnamese', 'Vietnamese', 3.9, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-037', 'Royal Kitchen Japanese', 'Japanese', 3.9, 60) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-038', 'Royal House Chinese', 'Chinese', 3.5, 45) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-039', 'Lucky Garden American', 'American', 4.5, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-040', 'Lucky Garden Korean', 'Korean', 4, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-041', 'Lucky Bistro Healthy', 'Healthy', 3.9, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-042', 'Golden Kitchen Korean', 'Korean', 3.8, 60) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-043', 'Urban Wok Italian', 'Italian', 4.1, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-044', 'Urban House Italian', 'Italian', 4.6, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-045', 'Local Wok Vietnamese', 'Vietnamese', 3.7, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-046', 'Local Cafe Healthy', 'Healthy', 3.9, 35) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-047', 'Spicy Kitchen Vietnamese', 'Vietnamese', 4.2, 30) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-048', 'Tasty Kitchen Italian', 'Italian', 4.2, 25) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-049', 'Urban Garden Vietnamese', 'Vietnamese', 3.9, 50) ON CONFLICT DO NOTHING;
INSERT INTO public.restaurants (res_id, name, cuisine, rating, delivery_time_min) VALUES ('r-050', 'Urban Cafe Healthy', 'Healthy', 4.6, 45) ON CONFLICT DO NOTHING;

INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1000', 'u008', 'r-027', '["Salad","Pizza","Tom Yum Kung","Water"]'::jsonb, 775, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1001', 'u013', 'r-039', '["Tom Yum Kung","Sushi Set","Spaghetti","Iced Tea","Green Tea"]'::jsonb, 1037, 'COOKING', 'Dave') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1002', 'u014', 'r-043', '["Pad Thai","Burger","Green Tea","Water"]'::jsonb, 933, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1003', 'u002', 'r-011', '["Fried Chicken","Tom Yum Kung","Som Tum","Coffee"]'::jsonb, 1098, 'PICKED_UP', 'Sarah') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1004', 'u001', 'r-016', '["Steak","Water"]'::jsonb, 823, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1005', 'u008', 'r-027', '["Steak","Tom Yum Kung"]'::jsonb, 513, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1006', 'u010', 'r-017', '["Ramen","Salad","Water"]'::jsonb, 1138, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1007', 'u011', 'r-030', '["Steak","Burger","Green Curry","Orange Juice","Coffee"]'::jsonb, 869, 'DELIVERED', 'Mike') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1008', 'u014', 'r-050', '["Spaghetti","Ramen","Pad Thai"]'::jsonb, 710, 'COOKING', 'Sarah') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1009', 'u004', 'r-014', '["Burger","Steak","Water"]'::jsonb, 1168, 'PICKED_UP', 'Mike') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1010', 'u015', 'r-017', '["Ramen","Green Tea","Orange Juice"]'::jsonb, 840, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1011', 'u005', 'r-043', '["Fried Rice","Burger","Pad Thai","Green Tea"]'::jsonb, 521, 'COOKING', 'Art') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1012', 'u006', 'r-046', '["Tom Yum Kung","Ramen","Green Curry","Orange Juice"]'::jsonb, 406, 'PICKED_UP', 'Manop') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1013', 'u013', 'r-025', '["Salad"]'::jsonb, 321, 'PICKED_UP', 'Ken') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1014', 'u010', 'r-049', '["Burger","Pad Thai","Fried Chicken"]'::jsonb, 678, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1015', 'u008', 'r-048', '["Fried Chicken","Fried Rice","Smoothie","Green Tea"]'::jsonb, 540, 'COOKING', 'Mike') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1016', 'u010', 'r-012', '["Fried Rice","Green Curry","Pad Thai"]'::jsonb, 658, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1017', 'u006', 'r-033', '["Fried Rice"]'::jsonb, 195, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1018', 'u003', 'r-024', '["Pad Thai","Iced Tea"]'::jsonb, 731, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1019', 'u012', 'r-025', '["Green Curry"]'::jsonb, 548, 'PICKED_UP', 'Boy') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1020', 'u012', 'r-025', '["Pad Thai","Sushi Set","Water"]'::jsonb, 884, 'PICKED_UP', 'Ken') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1021', 'u004', 'r-008', '["Fried Rice","Green Tea"]'::jsonb, 677, 'PICKED_UP', 'Somsak') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1022', 'u001', 'r-025', '["Pad Thai","Green Tea"]'::jsonb, 1038, 'COOKING', 'Sarah') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1023', 'u015', 'r-036', '["Fried Chicken","Orange Juice","Coke"]'::jsonb, 740, 'PICKED_UP', 'Mike') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1024', 'u011', 'r-045', '["Pad Thai","Coke"]'::jsonb, 284, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1025', 'u005', 'r-048', '["Sushi Set","Orange Juice","Coffee"]'::jsonb, 812, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1026', 'u014', 'r-024', '["Tom Yum Kung","Green Tea","Iced Tea"]'::jsonb, 868, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1027', 'u009', 'r-042', '["Pizza","Salad","Coffee"]'::jsonb, 416, 'PICKED_UP', 'John') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1028', 'u002', 'r-028', '["Burger","Smoothie"]'::jsonb, 686, 'PICKED_UP', 'Mike') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1029', 'u015', 'r-019', '["Fried Chicken","Pad Thai","Fried Rice","Smoothie","Water"]'::jsonb, 202, 'COOKING', 'Sarah') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1030', 'u004', 'r-021', '["Fried Chicken","Spaghetti","Fried Rice","Smoothie"]'::jsonb, 1040, 'PICKED_UP', 'Art') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1031', 'u010', 'r-045', '["Pad Thai","Green Curry","Sushi Set"]'::jsonb, 1149, 'DELIVERED', 'John') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1032', 'u011', 'r-004', '["Ramen","Iced Tea"]'::jsonb, 746, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1033', 'u007', 'r-011', '["Sushi Set","Green Curry"]'::jsonb, 865, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1034', 'u008', 'r-038', '["Sushi Set"]'::jsonb, 629, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1035', 'u014', 'r-032', '["Ramen","Som Tum"]'::jsonb, 1001, 'COOKING', 'Somsak') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1036', 'u007', 'r-015', '["Ramen","Orange Juice","Water"]'::jsonb, 835, 'DELIVERED', 'Golf') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1037', 'u006', 'r-032', '["Pad Thai","Pizza","Fried Rice","Smoothie"]'::jsonb, 355, 'PICKED_UP', 'Boy') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1038', 'u008', 'r-021', '["Ramen","Pizza","Salad"]'::jsonb, 483, 'COOKING', 'Art') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1039', 'u005', 'r-021', '["Tom Yum Kung","Sushi Set","Fried Rice","Green Tea"]'::jsonb, 873, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1040', 'u009', 'r-033', '["Pad Thai","Ramen"]'::jsonb, 334, 'PICKED_UP', 'Boy') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1041', 'u013', 'r-036', '["Som Tum"]'::jsonb, 216, 'CANCELLED', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1042', 'u009', 'r-017', '["Burger","Spaghetti","Pizza"]'::jsonb, 1001, 'PICKED_UP', 'Sarah') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1043', 'u013', 'r-044', '["Spaghetti","Som Tum","Sushi Set"]'::jsonb, 702, 'DELIVERED', 'Boy') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1044', 'u015', 'r-035', '["Tom Yum Kung","Pizza","Spaghetti","Iced Tea"]'::jsonb, 479, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1045', 'u010', 'r-041', '["Spaghetti","Pizza","Sushi Set","Green Tea","Water"]'::jsonb, 765, 'PICKED_UP', 'Dave') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1046', 'u002', 'r-023', '["Burger","Green Curry","Coffee"]'::jsonb, 974, 'PENDING', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1047', 'u015', 'r-047', '["Ramen","Salad","Fried Rice"]'::jsonb, 849, 'PICKED_UP', 'Dave') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1048', 'u007', 'r-030', '["Spaghetti","Steak","Water","Green Tea"]'::jsonb, 359, 'DELIVERED', 'John') ON CONFLICT DO NOTHING;
INSERT INTO public.food_orders (order_id, user_id, restaurant_id, menu_items, total_price, status, rider_name) VALUES ('fd-1049', 'u009', 'r-042', '["Spaghetti","Tom Yum Kung","Smoothie","Coffee"]'::jsonb, 461, 'DELIVERED', 'Ken') ON CONFLICT DO NOTHING;

INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-01', 'Dr. Alice Smith', 'Psychiatry', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-02', 'Dr. Kenji Rodriguez', 'Dermatology', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-03', 'Dr. Jennifer Johnson', 'Gynecology', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-04', 'Dr. Jennifer Sato', 'Gynecology', 'Chiang Mai Ram') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-05', 'Dr. Sarah Brown', 'Dermatology', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-06', 'Dr. Kenji Jai-ngam', 'Cardiology', 'Chiang Mai Ram') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-07', 'Dr. Michael Lee', 'Gynecology', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-08', 'Dr. Michael Jaidee', 'Pediatrics', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-09', 'Dr. Somchai Suriya', 'Pediatrics', 'Bumrungrad') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-10', 'Dr. Nida Jones', 'Urology', 'Siam Medical') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-11', 'Dr. Prasit Smith', 'Dermatology', 'Bangkok General') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-12', 'Dr. Mary Wilson', 'Psychiatry', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-13', 'Dr. Wipa Williams', 'Pediatrics', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-14', 'Dr. Michael Patchara', 'Neurology', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-15', 'Dr. Nida Williams', 'Pediatrics', 'Thonburi Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-16', 'Dr. David Sato', 'Gynecology', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-17', 'Dr. Michael Brown', 'Oncology', 'Thonburi Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-18', 'Dr. Jennifer Jai-ngam', 'Urology', 'Bangkok General') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-19', 'Dr. Kenji Munkong', 'Gynecology', 'Bumrungrad') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-20', 'Dr. Wipa Doe', 'Oncology', 'Thonburi Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-21', 'Dr. Jennifer Lee', 'Urology', 'Thonburi Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-22', 'Dr. Wipa Patchara', 'Urology', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-23', 'Dr. David Jaidee', 'Urology', 'Samitivej') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-24', 'Dr. Peter Doe', 'Gynecology', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-25', 'Dr. Michael Jones', 'Neurology', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-26', 'Dr. Jennifer Jaidee', 'Orthopedics', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-27', 'Dr. David Suriya', 'Psychiatry', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-28', 'Dr. Wipa Williams', 'Pediatrics', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-29', 'Dr. Linda Sato', 'Psychiatry', 'Bangkok General') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-30', 'Dr. Sarah Miller', 'Orthopedics', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-31', 'Dr. Somsak Munkong', 'Dermatology', 'Chiang Mai Ram') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-32', 'Dr. Robert Suriya', 'Gynecology', 'Siam Medical') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-33', 'Dr. Jennifer Garcia', 'Cardiology', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-34', 'Dr. Michael Miller', 'Gynecology', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-35', 'Dr. Wipa Munkong', 'Pediatrics', 'Siam Medical') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-36', 'Dr. Peter Jai-ngam', 'Oncology', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-37', 'Dr. Jennifer Jaidee', 'Neurology', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-38', 'Dr. Mary Jai-ngam', 'Oncology', 'Siriraj') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-39', 'Dr. Mary Doe', 'Gynecology', 'Samitivej') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-40', 'Dr. John Johnson', 'Pediatrics', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-41', 'Dr. James Smith', 'Orthopedics', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-42', 'Dr. Nida Garcia', 'Orthopedics', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-43', 'Dr. Nida Jai-ngam', 'Dermatology', 'Thonburi Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-44', 'Dr. Alice Davis', 'Cardiology', 'Chiang Mai Ram') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-45', 'Dr. Alice Suriya', 'Oncology', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-46', 'Dr. Somchai Garcia', 'Cardiology', 'City Hospital') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-47', 'Dr. Mary Wilson', 'Gynecology', 'Central Health') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-48', 'Dr. Mary Luea', 'Pediatrics', 'Chiang Mai Ram') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-49', 'Dr. Wipa Davis', 'Dermatology', 'Phuket International') ON CONFLICT DO NOTHING;
INSERT INTO public.doctors (doctor_id, name, department, hospital) VALUES ('doc-50', 'Dr. Nida Davis', 'Oncology', 'Phuket International') ON CONFLICT DO NOTHING;

INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-001', 'u009', 'doc-10', '2026-07-31T00:00:00Z', 'Chest pain', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-002', 'u007', 'doc-24', '2025-02-03T00:00:00Z', 'Headache', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-003', 'u010', 'doc-10', '2026-08-24T00:00:00Z', 'Allergy', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-004', 'u013', 'doc-30', '2026-08-17T00:00:00Z', 'Sore throat', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-005', 'u007', 'doc-31', '2026-06-20T00:00:00Z', 'Flu symptoms', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-006', 'u008', 'doc-32', '2025-01-10T00:00:00Z', 'Dizziness', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-007', 'u007', 'doc-17', '2026-09-20T00:00:00Z', 'Joint pain', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-008', 'u010', 'doc-48', '2026-06-28T00:00:00Z', 'Pregnancy checkup', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-009', 'u013', 'doc-25', '2025-11-04T00:00:00Z', 'Acne', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-010', 'u012', 'doc-09', '2026-10-09T00:00:00Z', 'Vision problem', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-011', 'u010', 'doc-15', '2025-10-27T00:00:00Z', 'Anxiety', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-012', 'u013', 'doc-30', '2025-11-15T00:00:00Z', 'Back pain', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-013', 'u007', 'doc-34', '2026-10-14T00:00:00Z', 'Dizziness', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-014', 'u004', 'doc-06', '2026-11-28T00:00:00Z', 'Toothache', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-015', 'u014', 'doc-33', '2025-10-01T00:00:00Z', 'Headache', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-016', 'u005', 'doc-06', '2025-02-26T00:00:00Z', 'Stomach ache', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-017', 'u001', 'doc-37', '2026-09-23T00:00:00Z', 'Flu symptoms', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-018', 'u013', 'doc-15', '2026-11-08T00:00:00Z', 'Sleep disorder', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-019', 'u010', 'doc-35', '2025-12-06T00:00:00Z', 'Toothache', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-020', 'u001', 'doc-29', '2025-01-15T00:00:00Z', 'Vision problem', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-021', 'u001', 'doc-16', '2025-02-03T00:00:00Z', 'Back pain', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-022', 'u005', 'doc-37', '2025-01-25T00:00:00Z', 'Allergy', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-023', 'u012', 'doc-03', '2025-04-14T00:00:00Z', 'Skin rash', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-024', 'u012', 'doc-27', '2026-06-27T00:00:00Z', 'Back pain', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-025', 'u003', 'doc-08', '2026-10-23T00:00:00Z', 'Pregnancy checkup', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-026', 'u008', 'doc-35', '2025-12-09T00:00:00Z', 'Pregnancy checkup', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-027', 'u014', 'doc-34', '2025-02-14T00:00:00Z', 'Pregnancy checkup', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-028', 'u007', 'doc-43', '2026-09-26T00:00:00Z', 'Vaccination', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-029', 'u007', 'doc-11', '2025-03-03T00:00:00Z', 'Dizziness', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-030', 'u014', 'doc-38', '2026-02-13T00:00:00Z', 'Annual Checkup', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-031', 'u003', 'doc-12', '2025-04-02T00:00:00Z', 'Skin rash', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-032', 'u006', 'doc-10', '2026-05-20T00:00:00Z', 'Vision problem', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-033', 'u002', 'doc-42', '2026-07-24T00:00:00Z', 'Allergy', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-034', 'u007', 'doc-17', '2025-11-02T00:00:00Z', 'Sore throat', 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-035', 'u013', 'doc-42', '2026-05-06T00:00:00Z', 'Acne', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-036', 'u007', 'doc-05', '2026-12-03T00:00:00Z', 'Pregnancy checkup', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-037', 'u002', 'doc-30', '2025-03-12T00:00:00Z', 'Annual Checkup', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-038', 'u013', 'doc-28', '2025-06-27T00:00:00Z', 'Sleep disorder', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-039', 'u003', 'doc-42', '2026-08-25T00:00:00Z', 'Annual Checkup', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-040', 'u010', 'doc-28', '2026-11-02T00:00:00Z', 'Chest pain', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-041', 'u007', 'doc-01', '2025-09-17T00:00:00Z', 'Stomach ache', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-042', 'u006', 'doc-33', '2025-02-14T00:00:00Z', 'Sleep disorder', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-043', 'u007', 'doc-06', '2026-05-11T00:00:00Z', 'Back pain', 'CONFIRMED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-044', 'u003', 'doc-24', '2025-11-13T00:00:00Z', 'Back pain', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-045', 'u008', 'doc-16', '2025-03-12T00:00:00Z', 'Headache', 'NO_SHOW') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-046', 'u010', 'doc-28', '2025-08-16T00:00:00Z', 'Skin rash', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-047', 'u007', 'doc-22', '2026-06-05T00:00:00Z', 'Vaccination', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-048', 'u006', 'doc-32', '2025-04-01T00:00:00Z', 'Anxiety', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-049', 'u012', 'doc-14', '2026-06-20T00:00:00Z', 'Toothache', 'PENDING') ON CONFLICT DO NOTHING;
INSERT INTO public.appointments (apt_id, user_id, doctor_id, date, symptom, status) VALUES ('apt-050', 'u005', 'doc-08', '2025-02-18T00:00:00Z', 'Allergy', 'CANCELLED') ON CONFLICT DO NOTHING;

INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-101', 'Basic Python for Beginners', 'Coach C', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-102', 'Intermediate Business English', 'Kru Dev', 14) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-103', 'Fundamentals Web Development', 'Dr. B', 36) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-104', 'Crash Course Cloud Computing', 'Kru Dev', 19) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-105', 'Advanced Web Development', 'John Smith', 29) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-106', 'Basic Web Development', 'Kru Dev', 23) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-107', 'Intermediate Web Development', 'John Smith', 50) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-108', 'Advanced Web Development', 'Teacher D', 40) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-109', 'Mastery Web Development', 'Ajarn A', 29) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-110', 'Fundamentals Blockchain Basics', 'Dr. B', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-111', 'Fundamentals Mobile App Dev', 'Jane Doe', 49) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-112', 'Crash Course Project Management', 'Coach C', 36) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-113', 'Crash Course Video Editing', 'Kru Dev', 35) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-114', 'Advanced SEO Mastery', 'Sarah Wilson', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-115', 'Mastery Blockchain Basics', 'John Smith', 36) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-116', 'Advanced React JS', 'Jane Doe', 15) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-117', 'Advanced Data Science with R', 'Ajarn A', 18) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-118', 'Basic Cybersecurity', 'Ajarn A', 35) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-119', 'Advanced Vue JS', 'John Smith', 22) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-120', 'Advanced Photography', 'Sarah Wilson', 34) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-121', 'Mastery Creative Writing', 'Dr. B', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-122', 'Intermediate Digital Marketing', 'Kru Dev', 25) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-123', 'Advanced Angular', 'Coach C', 49) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-124', 'Basic UX/UI Design', 'Sarah Wilson', 26) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-125', 'Mastery UX/UI Design', 'Michael Brown', 20) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-126', 'Fundamentals Video Editing', 'Dr. B', 23) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-127', 'Basic Photography', 'Professor E', 50) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-128', 'Crash Course Video Editing', 'Professor E', 42) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-129', 'Mastery Data Science with R', 'Sarah Wilson', 36) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-130', 'Basic Data Science with R', 'Ajarn A', 17) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-131', 'Basic Photography', 'John Smith', 45) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-132', 'Crash Course Vue JS', 'Michael Brown', 40) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-133', 'Advanced Data Science with R', 'Sarah Wilson', 39) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-134', 'Intermediate Python for Beginners', 'Sarah Wilson', 37) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-135', 'Mastery React JS', 'Jane Doe', 24) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-136', 'Intermediate Graphic Design', 'John Smith', 29) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-137', 'Fundamentals Cryptocurrency', 'Coach C', 12) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-138', 'Intermediate SEO Mastery', 'Ajarn A', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-139', 'Intermediate Cybersecurity', 'Professor E', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-140', 'Advanced SEO Mastery', 'Dr. B', 28) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-141', 'Intermediate Creative Writing', 'John Smith', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-142', 'Intermediate Angular', 'Teacher D', 33) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-143', 'Advanced Video Editing', 'Sarah Wilson', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-144', 'Basic Cloud Computing', 'Michael Brown', 49) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-145', 'Mastery Graphic Design', 'John Smith', 12) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-146', 'Intermediate Cybersecurity', 'John Smith', 29) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-147', 'Intermediate Cybersecurity', 'Teacher D', 39) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-148', 'Fundamentals Blockchain Basics', 'Michael Brown', 34) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-149', 'Mastery Graphic Design', 'Kru Dev', 22) ON CONFLICT DO NOTHING;
INSERT INTO public.courses (course_id, title, instructor, total_lessons) VALUES ('c-150', 'Basic Machine Learning', 'Michael Brown', 36) ON CONFLICT DO NOTHING;

INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-001', 'u002', 'c-101', 80, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-002', 'u005', 'c-115', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-003', 'u010', 'c-102', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-004', 'u001', 'c-145', 25, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-005', 'u014', 'c-120', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-006', 'u003', 'c-110', 10, 'DROPPED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-007', 'u008', 'c-133', 55, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-008', 'u012', 'c-105', 90, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-009', 'u006', 'c-148', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-010', 'u009', 'c-122', 40, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-011', 'u015', 'c-101', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-012', 'u004', 'c-130', 5, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-013', 'u011', 'c-118', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-014', 'u007', 'c-140', 75, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-015', 'u002', 'c-125', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-016', 'u013', 'c-112', 15, 'DROPPED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-017', 'u005', 'c-108', 60, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-018', 'u010', 'c-135', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-019', 'u001', 'c-129', 30, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-020', 'u008', 'c-104', 95, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-021', 'u014', 'c-150', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-022', 'u003', 'c-111', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-023', 'u006', 'c-142', 45, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-024', 'u012', 'c-131', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-025', 'u009', 'c-103', 12, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-026', 'u015', 'c-127', 85, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-027', 'u004', 'c-116', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-028', 'u011', 'c-138', 20, 'DROPPED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-029', 'u007', 'c-149', 50, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-030', 'u002', 'c-107', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-031', 'u005', 'c-114', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-032', 'u013', 'c-124', 65, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-033', 'u010', 'c-144', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-034', 'u001', 'c-132', 33, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-035', 'u008', 'c-119', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-036', 'u014', 'c-106', 8, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-037', 'u003', 'c-136', 98, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-038', 'u006', 'c-147', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-039', 'u012', 'c-121', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-040', 'u009', 'c-113', 42, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-041', 'u015', 'c-139', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-042', 'u004', 'c-109', 18, 'DROPPED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-043', 'u011', 'c-126', 70, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-044', 'u007', 'c-141', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-045', 'u002', 'c-134', 88, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-046', 'u005', 'c-117', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-047', 'u013', 'c-146', 2, 'IN_PROGRESS') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-048', 'u010', 'c-123', 100, 'COMPLETED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-049', 'u001', 'c-137', 0, 'NOT_STARTED') ON CONFLICT DO NOTHING;
INSERT INTO public.enrollments (enroll_id, user_id, course_id, progress_percent, status) VALUES ('en-050', 'u008', 'c-128', 50, 'IN_PROGRESS') ON CONFLICT DO NOTHING;

INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-001', 'Art Exhibition 2026', '2026-03-27T00:00:00Z', 'BITEC Bangna', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-002', 'Blockchain Expo 2026', '2026-12-30T00:00:00Z', 'Impact Arena', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-003', 'Book Launch 2026', '2026-03-04T00:00:00Z', 'Thunder Dome', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-004', 'Yoga Retreat 2026', '2026-05-03T00:00:00Z', 'Siam Paragon', 500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-005', 'Book Launch 2026', '2026-05-05T00:00:00Z', 'Impact Arena', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-006', 'Book Launch 2026', '2026-11-19T00:00:00Z', 'BITEC Bangna', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-007', 'Pet Expo 2026', '2026-07-07T00:00:00Z', 'Union Hall', 1500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-008', 'Startup Pitch 2026', '2027-02-17T00:00:00Z', 'Central World', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-009', 'Blockchain Expo 2026', '2026-07-29T00:00:00Z', 'Phuket Convention Center', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-010', 'Charity Run 2026', '2026-12-28T00:00:00Z', 'Thunder Dome', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-011', 'Design Week 2026', '2027-02-02T00:00:00Z', 'Thunder Dome', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-012', 'Tech Conference 2025', '2025-07-03T00:00:00Z', 'True Digital Park', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-013', 'Book Launch 2026', '2026-07-11T00:00:00Z', 'Central World', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-014', 'Pet Expo 2025', '2025-03-12T00:00:00Z', 'BITEC Bangna', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-015', 'Coding Bootcamp 2026', '2027-01-31T00:00:00Z', 'Central World', 1500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-016', 'Yoga Retreat 2027', '2026-03-27T00:00:00Z', 'True Digital Park', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-017', 'Startup Pitch 2025', '2025-09-09T00:00:00Z', 'Union Hall', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-018', 'Book Launch 2025', '2025-07-27T00:00:00Z', 'Impact Arena', 200) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-019', 'Music Festival 2026', '2026-06-23T00:00:00Z', 'Central World', 200) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-020', 'Design Week 2025', '2025-09-30T00:00:00Z', 'Union Hall', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-021', 'Art Exhibition 2027', '2026-07-16T00:00:00Z', 'QSNCC', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-022', 'Music Festival 2026', '2026-03-12T00:00:00Z', 'Impact Arena', 200) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-023', 'Blockchain Expo 2027', '2026-07-08T00:00:00Z', 'Central World', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-024', 'Blockchain Expo 2026', '2026-10-13T00:00:00Z', 'QSNCC', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-025', 'Business Summit 2026', '2026-05-14T00:00:00Z', 'Union Hall', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-026', 'Car Show 2025', '2025-12-09T00:00:00Z', 'Phuket Convention Center', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-027', 'AI Workshop 2026', '2026-04-18T00:00:00Z', 'Union Hall', 200) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-028', 'Design Week 2026', '2026-11-27T00:00:00Z', 'Chiang Mai Hall', 1500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-029', 'Business Summit 2026', '2027-03-17T00:00:00Z', 'Union Hall', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-030', 'Book Launch 2027', '2026-07-16T00:00:00Z', 'Chiang Mai Hall', 500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-031', 'Book Launch 2026', '2027-02-28T00:00:00Z', 'Thunder Dome', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-032', 'AI Workshop 2026', '2027-01-27T00:00:00Z', 'BITEC Bangna', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-033', 'Film Festival 2025', '2025-06-26T00:00:00Z', 'Phuket Convention Center', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-034', 'Science Fair 2026', '2027-02-12T00:00:00Z', 'QSNCC', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-035', 'Film Festival 2026', '2026-10-28T00:00:00Z', 'Siam Paragon', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-036', 'Game Jam 2025', '2025-06-05T00:00:00Z', 'True Digital Park', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-037', 'Game Jam 2026', '2026-06-01T00:00:00Z', 'Impact Arena', 100) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-038', 'Yoga Retreat 2026', '2026-05-23T00:00:00Z', 'Central World', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-039', 'Startup Pitch 2027', '2026-07-18T00:00:00Z', 'Thunder Dome', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-040', 'Pet Expo 2026', '2026-05-04T00:00:00Z', 'Thunder Dome', 990) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-041', 'AI Workshop 2026', '2026-09-28T00:00:00Z', 'Impact Arena', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-042', 'Coding Bootcamp 2026', '2026-08-01T00:00:00Z', 'BITEC Bangna', 500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-043', 'Startup Pitch 2026', '2026-06-05T00:00:00Z', 'Thunder Dome', 2500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-044', 'Blockchain Expo 2027', '2026-08-13T00:00:00Z', 'Thunder Dome', 500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-045', 'Marketing Seminar 2025', '2025-07-28T00:00:00Z', 'Siam Paragon', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-046', 'E-sports Tournament 2025', '2025-09-13T00:00:00Z', 'Chiang Mai Hall', 500) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-047', 'Book Launch 2027', '2026-04-10T00:00:00Z', 'Chiang Mai Hall', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-048', 'Art Exhibition 2026', '2026-04-11T00:00:00Z', 'Siam Paragon', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-049', 'Business Summit 2025', '2025-08-20T00:00:00Z', 'Siam Paragon', 5000) ON CONFLICT DO NOTHING;
INSERT INTO public.events (event_id, title, date, location, ticket_price) VALUES ('ev-050', 'Business Summit 2026', '2026-11-21T00:00:00Z', 'Union Hall', 5000) ON CONFLICT DO NOTHING;

INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-001', 'u009', 'ev-041', 'D', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-002', 'u008', 'ev-042', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-003', 'u012', 'ev-015', 'D', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-004', 'u006', 'ev-039', 'Regular', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-005', 'u006', 'ev-017', 'C', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-006', 'u005', 'ev-047', 'B', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-007', 'u003', 'ev-048', 'B', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-008', 'u003', 'ev-020', 'D', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-009', 'u014', 'ev-031', 'Regular', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-010', 'u013', 'ev-001', 'B', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-011', 'u004', 'ev-019', 'C', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-012', 'u011', 'ev-026', 'Standing', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-013', 'u004', 'ev-042', 'A', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-014', 'u013', 'ev-029', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-015', 'u010', 'ev-033', 'Standing', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-016', 'u001', 'ev-020', 'Regular', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-017', 'u015', 'ev-042', 'Regular', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-018', 'u002', 'ev-020', 'C', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-019', 'u006', 'ev-028', 'A', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-020', 'u007', 'ev-043', 'D', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-021', 'u011', 'ev-034', 'A', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-022', 'u006', 'ev-010', 'C', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-023', 'u010', 'ev-019', 'A', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-024', 'u007', 'ev-009', 'C', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-025', 'u005', 'ev-037', 'A', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-026', 'u007', 'ev-026', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-027', 'u009', 'ev-039', 'Standing', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-028', 'u006', 'ev-043', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-029', 'u013', 'ev-003', 'Standing', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-030', 'u007', 'ev-006', 'Standing', 'CANCELLED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-031', 'u005', 'ev-032', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-032', 'u012', 'ev-027', 'D', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-033', 'u012', 'ev-034', 'Standing', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-034', 'u010', 'ev-014', 'B', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-035', 'u001', 'ev-025', 'C', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-036', 'u005', 'ev-007', 'Standing', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-037', 'u005', 'ev-041', 'D', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-038', 'u002', 'ev-033', 'D', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-039', 'u006', 'ev-011', 'Regular', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-040', 'u003', 'ev-019', 'C', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-041', 'u014', 'ev-025', 'B', 'RESERVED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-042', 'u013', 'ev-044', 'B', 'REFUNDED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-043', 'u012', 'ev-012', 'A', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-044', 'u014', 'ev-019', 'Standing', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-045', 'u015', 'ev-031', 'VIP', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-046', 'u013', 'ev-031', 'VIP', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-047', 'u011', 'ev-021', 'Standing', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-048', 'u012', 'ev-037', 'Standing', 'USED') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-049', 'u006', 'ev-049', 'A', 'PAID') ON CONFLICT DO NOTHING;
INSERT INTO public.event_tickets (ticket_id, user_id, event_id, seat_zone, status) VALUES ('et-050', 'u011', 'ev-044', 'D', 'REFUNDED') ON CONFLICT DO NOTHING;

INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-001', 'Employee Training Program', '2026-06-19') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-002', 'Mobile App Launch', '2025-11-24') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-003', 'Employee Training Program', '2026-07-20') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-004', 'Security Audit', '2025-10-22') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-005', 'Employee Training Program', '2026-02-11') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-006', 'Product Roadmap 2026', '2026-10-09') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-007', 'Vendor Selection', '2025-12-28') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-008', 'Vendor Selection', '2025-12-04') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-009', 'SEO Improvement', '2026-01-13') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-010', 'Product Roadmap 2026', '2026-08-12') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-011', 'New Feature Development', '2026-02-04') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-012', 'Mobile App Launch', '2025-10-29') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-013', 'Office Relocation', '2025-09-27') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-014', 'Product Roadmap 2026', '2026-02-08') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-015', 'Mobile App Launch', '2026-09-27') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-016', 'Product Roadmap 2026', '2026-03-18') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-017', 'Mobile App Launch', '2026-08-18') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-018', 'Data Migration', '2026-05-13') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-019', 'API Integration', '2026-01-11') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-020', 'Product Roadmap 2026', '2025-08-31') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-021', 'Budget Planning', '2025-11-06') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-022', 'Marketing Campaign Q1', '2026-10-03') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-023', 'Website Redesign', '2026-02-08') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-024', 'Legal Compliance Check', '2026-10-17') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-025', 'Mobile App Launch', '2025-10-18') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-026', 'Website Redesign', '2026-11-14') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-027', 'API Integration', '2026-06-11') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-028', 'Budget Planning', '2026-10-04') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-029', 'API Integration', '2026-08-11') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-030', 'Marketing Campaign Q1', '2026-04-19') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-031', 'Data Migration', '2025-09-12') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-032', 'Data Migration', '2026-01-25') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-033', 'Customer Survey Analysis', '2026-06-08') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-034', 'Product Roadmap 2026', '2026-09-15') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-035', 'Content Strategy', '2026-10-31') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-036', 'Social Media Plan', '2025-10-17') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-037', 'Social Media Plan', '2026-07-29') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-038', 'Website Redesign', '2026-11-09') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-039', 'Website Redesign', '2026-11-08') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-040', 'SEO Improvement', '2025-11-16') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-041', 'Content Strategy', '2025-12-02') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-042', 'Legal Compliance Check', '2026-07-05') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-043', 'Office Relocation', '2026-03-05') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-044', 'Brand Rebranding', '2026-03-25') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-045', 'New Feature Development', '2026-10-07') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-046', 'Office Relocation', '2025-08-23') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-047', 'API Integration', '2026-03-30') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-048', 'Customer Survey Analysis', '2025-09-29') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-049', 'Database Optimization', '2026-02-28') ON CONFLICT DO NOTHING;
INSERT INTO public.projects (project_id, name, deadline) VALUES ('pj-050', 'Content Strategy', '2026-02-23') ON CONFLICT DO NOTHING;

INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-001', 'pj-033', 'u008', 'Write Documentation', 'BLOCKED', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-002', 'pj-013', 'u010', 'Analyze Analytics', 'TODO', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-003', 'pj-003', 'u015', 'Refactor Code', 'BLOCKED', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-004', 'pj-044', 'u003', 'Optimize Images', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-005', 'pj-019', 'u011', 'Write Documentation', 'TODO', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-006', 'pj-005', 'u011', 'Refactor Code', 'BLOCKED', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-007', 'pj-032', 'u012', 'Test Payment Gateway', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-008', 'pj-032', 'u014', 'Deploy to Server', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-009', 'pj-014', 'u002', 'Setup Database', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-010', 'pj-036', 'u005', 'Conduct User Testing', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-011', 'pj-029', 'u008', 'Write Documentation', 'TODO', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-012', 'pj-009', 'u012', 'Setup Database', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-013', 'pj-026', 'u006', 'Update User Profile', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-014', 'pj-016', 'u005', 'Update User Profile', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-015', 'pj-029', 'u009', 'Update User Profile', 'DONE', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-016', 'pj-001', 'u001', 'Write Unit Tests', 'TODO', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-017', 'pj-029', 'u010', 'Review Pull Requests', 'DONE', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-018', 'pj-048', 'u001', 'Create Marketing Assets', 'TODO', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-019', 'pj-048', 'u014', 'Backup Data', 'BLOCKED', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-020', 'pj-047', 'u008', 'Fix Login Bug', 'TODO', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-021', 'pj-043', 'u005', 'Write Unit Tests', 'BLOCKED', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-022', 'pj-038', 'u013', 'Design Homepage', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-023', 'pj-004', 'u004', 'Design Logo', 'TODO', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-024', 'pj-030', 'u010', 'Refactor Code', 'TODO', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-025', 'pj-024', 'u010', 'Write Unit Tests', 'DOING', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-026', 'pj-017', 'u010', 'Client Meeting', 'BLOCKED', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-027', 'pj-030', 'u012', 'Write Unit Tests', 'DONE', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-028', 'pj-010', 'u010', 'Design Logo', 'DOING', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-029', 'pj-019', 'u001', 'Client Meeting', 'BLOCKED', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-030', 'pj-002', 'u010', 'Setup CI/CD', 'TODO', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-031', 'pj-035', 'u001', 'Design Logo', 'BLOCKED', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-032', 'pj-036', 'u003', 'Deploy to Server', 'BLOCKED', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-033', 'pj-029', 'u005', 'Update Libraries', 'TODO', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-034', 'pj-002', 'u001', 'Optimize Images', 'BLOCKED', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-035', 'pj-035', 'u013', 'Design Homepage', 'TODO', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-036', 'pj-006', 'u003', 'Write Unit Tests', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-037', 'pj-048', 'u009', 'Create API', 'BLOCKED', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-038', 'pj-038', 'u001', 'Update Libraries', 'BLOCKED', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-039', 'pj-018', 'u004', 'Conduct User Testing', 'DONE', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-040', 'pj-035', 'u005', 'Backup Data', 'BLOCKED', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-041', 'pj-037', 'u007', 'Create Marketing Assets', 'TODO', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-042', 'pj-019', 'u011', 'Deploy to Server', 'DONE', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-043', 'pj-034', 'u004', 'Update User Profile', 'DOING', 'LOW') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-044', 'pj-002', 'u014', 'Design Logo', 'DOING', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-045', 'pj-037', 'u003', 'Setup CI/CD', 'BLOCKED', 'HIGH') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-046', 'pj-037', 'u002', 'Conduct User Testing', 'BLOCKED', 'MEDIUM') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-047', 'pj-035', 'u008', 'Design Homepage', 'DOING', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-048', 'pj-010', 'u015', 'Backup Data', 'DONE', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-049', 'pj-018', 'u008', 'Backup Data', 'DOING', 'CRITICAL') ON CONFLICT DO NOTHING;
INSERT INTO public.tasks (task_id, project_id, assigned_to, title, status, priority) VALUES ('tk-050', 'pj-044', 'u011', 'Setup CI/CD', 'TODO', 'CRITICAL') ON CONFLICT DO NOTHING;

INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-556', 'u007', 'shop-03', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-02-05T12:20:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-02-05T12:21:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-02-05T12:29:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-02-05T12:38:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-557', 'u014', 'shop-12', 'OPEN', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-02-03T19:43:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-02-03T19:52:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-02-03T19:59:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-02-03T20:03:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-558', 'u001', 'shop-04', 'CLOSED', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-29T19:11:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-29T19:19:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-29T19:25:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-29T19:29:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-559', 'u015', 'shop-09', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-01-23T15:39:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-01-23T15:47:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-01-23T15:57:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-01-23T16:06:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-560', 'u007', 'shop-09', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-01-18T16:33:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-01-18T16:35:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-01-18T16:43:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-01-18T16:47:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-561', 'u005', 'shop-05', 'CLOSED', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-06T16:04:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-06T16:12:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-06T16:21:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-06T16:30:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-562', 'u002', 'shop-05', 'CLOSED', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-05T13:23:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-05T13:28:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-05T13:34:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-05T13:39:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-563', 'u014', 'shop-12', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-02-03T12:58:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-02-03T13:07:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-02-03T13:10:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-02-03T13:16:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-564', 'u006', 'shop-04', 'OPEN', '[{"sender":"USER","text":"ลดราคาได้อีกไหมครับ?","timestamp":"2026-02-09T15:47:00Z"},{"sender":"SHOP","text":"ตอนนี้เป็นราคาโปรโมชั่นแล้วครับ ลดเพิ่มไม่ได้แล้ว","timestamp":"2026-02-09T15:50:00Z"},{"sender":"USER","text":"โอเคครับ","timestamp":"2026-02-09T16:00:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-565', 'u003', 'shop-11', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-01-16T17:58:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-01-16T18:03:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-01-16T18:09:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-01-16T18:15:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-566', 'u013', 'shop-15', 'OPEN', '[{"sender":"USER","text":"ลดราคาได้อีกไหมครับ?","timestamp":"2026-01-18T20:50:00Z"},{"sender":"SHOP","text":"ตอนนี้เป็นราคาโปรโมชั่นแล้วครับ ลดเพิ่มไม่ได้แล้ว","timestamp":"2026-01-18T20:56:00Z"},{"sender":"USER","text":"โอเคครับ","timestamp":"2026-01-18T21:03:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-567', 'u013', 'shop-12', 'CLOSED', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-01-19T17:26:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-01-19T17:33:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-01-19T17:36:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-01-19T17:44:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-568', 'u007', 'shop-02', 'CLOSED', '[{"sender":"USER","text":"ลดราคาได้อีกไหมครับ?","timestamp":"2026-01-29T16:58:00Z"},{"sender":"SHOP","text":"ตอนนี้เป็นราคาโปรโมชั่นแล้วครับ ลดเพิ่มไม่ได้แล้ว","timestamp":"2026-01-29T17:02:00Z"},{"sender":"USER","text":"โอเคครับ","timestamp":"2026-01-29T17:06:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-569', 'u014', 'shop-08', 'CLOSED', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-25T19:20:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-25T19:24:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-25T19:33:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-25T19:37:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-570', 'u014', 'shop-20', 'CLOSED', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-04T08:41:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-04T08:51:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-04T08:55:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-04T09:04:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-571', 'u001', 'shop-08', 'OPEN', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-01-26T14:22:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-01-26T14:31:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-01-26T14:39:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-01-26T14:41:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-572', 'u011', 'shop-05', 'CLOSED', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-02-08T17:25:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-02-08T17:31:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-02-08T17:35:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-02-08T17:36:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-573', 'u004', 'shop-17', 'CLOSED', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-02-06T16:26:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-02-06T16:27:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-02-06T16:36:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-02-06T16:46:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-574', 'u007', 'shop-16', 'CLOSED', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-21T12:55:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-21T13:04:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-21T13:13:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-21T13:15:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-575', 'u004', 'shop-20', 'OPEN', '[{"sender":"USER","text":"ลดราคาได้อีกไหมครับ?","timestamp":"2026-01-29T16:07:00Z"},{"sender":"SHOP","text":"ตอนนี้เป็นราคาโปรโมชั่นแล้วครับ ลดเพิ่มไม่ได้แล้ว","timestamp":"2026-01-29T16:16:00Z"},{"sender":"USER","text":"โอเคครับ","timestamp":"2026-01-29T16:18:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-576', 'u007', 'shop-09', 'CLOSED', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-09T13:18:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-09T13:27:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-09T13:34:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-09T13:42:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-577', 'u013', 'shop-11', 'OPEN', '[{"sender":"USER","text":"ลดราคาได้อีกไหมครับ?","timestamp":"2026-01-23T16:41:00Z"},{"sender":"SHOP","text":"ตอนนี้เป็นราคาโปรโมชั่นแล้วครับ ลดเพิ่มไม่ได้แล้ว","timestamp":"2026-01-23T16:47:00Z"},{"sender":"USER","text":"โอเคครับ","timestamp":"2026-01-23T16:50:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-578', 'u008', 'shop-15', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-01-28T08:53:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-01-28T09:00:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-01-28T09:06:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-01-28T09:13:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-579', 'u010', 'shop-09', 'CLOSED', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-01-27T19:00:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-01-27T19:09:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-01-27T19:17:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-01-27T19:24:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-580', 'u007', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-01-31T20:23:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-01-31T20:25:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-01-31T20:29:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-01-31T20:31:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-581', 'u002', 'shop-12', 'CLOSED', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-05T12:38:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-05T12:47:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-05T12:51:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-05T12:57:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-582', 'u002', 'shop-13', 'OPEN', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-02-09T17:42:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-02-09T17:48:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-02-09T17:54:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-02-09T18:03:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-583', 'u002', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-01-26T20:24:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-01-26T20:31:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-01-26T20:39:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-01-26T20:43:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-584', 'u007', 'shop-12', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-02-09T18:59:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-02-09T19:02:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-02-09T19:07:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-02-09T19:11:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-585', 'u004', 'shop-12', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-02T13:42:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-02T13:46:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-02T13:51:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-02T13:59:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-586', 'u009', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-02T16:20:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-02T16:21:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-02T16:22:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-02T16:32:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-587', 'u007', 'shop-19', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-22T19:20:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-22T19:22:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-22T19:23:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-22T19:28:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-588', 'u007', 'shop-13', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-09T17:15:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-09T17:21:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-09T17:23:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-09T17:27:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-589', 'u001', 'shop-14', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-02-02T19:33:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-02-02T19:40:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-02-02T19:46:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-02-02T19:54:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-590', 'u004', 'shop-14', 'OPEN', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-01-20T17:34:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-01-20T17:41:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-01-20T17:42:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-01-20T17:47:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-591', 'u004', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-09T17:28:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-09T17:37:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-09T17:41:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-09T17:47:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-592', 'u006', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-02-09T13:48:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-02-09T13:50:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-02-09T13:59:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-02-09T14:04:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-593', 'u004', 'shop-14', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-01-30T17:15:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-01-30T17:21:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-01-30T17:30:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-01-30T17:35:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-594', 'u002', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-09T20:30:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-09T20:37:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-09T20:41:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-09T20:43:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-595', 'u002', 'shop-13', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-20T19:33:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-20T19:40:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-20T19:43:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-20T19:48:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-596', 'u004', 'shop-14', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-09T17:28:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-09T17:34:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-09T17:44:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-09T17:53:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-597', 'u004', 'shop-13', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-01-20T19:12:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-01-20T19:15:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-01-20T19:21:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-01-20T19:25:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-598', 'u007', 'shop-13', 'OPEN', '[{"sender":"USER","text":"ได้รับของแล้วครับ แต่กล่องบุบ","timestamp":"2026-01-22T19:15:00Z"},{"sender":"SHOP","text":"ต้องขออภัยด้วยครับ สินค้าข้างในเสียหายไหมครับ?","timestamp":"2026-01-22T19:18:00Z"},{"sender":"USER","text":"ยังไม่ได้แกะครับ เดี๋ยวลองแกะดูก่อน","timestamp":"2026-01-22T19:24:00Z"},{"sender":"SHOP","text":"ครับผม ถ้าเสียหายแจ้งเคลมได้เลยนะครับ","timestamp":"2026-01-22T19:25:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-599', 'u002', 'shop-19', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-01-26T20:23:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-01-26T20:25:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-01-26T20:34:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-01-26T20:41:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-600', 'u002', 'shop-19', 'OPEN', '[{"sender":"USER","text":"ส่งของหรือยังครับ?","timestamp":"2026-02-09T20:23:00Z"},{"sender":"SHOP","text":"ส่งแล้วครับ รอบวันนี้","timestamp":"2026-02-09T20:29:00Z"},{"sender":"USER","text":"ขอเลขพัสดุหน่อยครับ","timestamp":"2026-02-09T20:33:00Z"},{"sender":"SHOP","text":"TH1234567890 ครับ","timestamp":"2026-02-09T20:42:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-601', 'u003', 'shop-14', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-09T18:18:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-09T18:27:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-09T18:29:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-09T18:31:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-602', 'u007', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-02-05T13:42:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-02-05T13:46:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-02-05T13:51:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-02-05T14:00:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-603', 'u002', 'shop-17', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีของพร้อมส่งไหมครับ?","timestamp":"2026-02-02T16:15:00Z"},{"sender":"SHOP","text":"มีครับ พร้อมส่งทันทีครับ!","timestamp":"2026-02-02T16:21:00Z"},{"sender":"USER","text":"งั้นสั่งเลยนะครับ","timestamp":"2026-02-02T16:25:00Z"},{"sender":"SHOP","text":"ขอบคุณครับ รอรับออเดอร์ได้เลย","timestamp":"2026-02-02T16:34:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-604', 'u007', 'shop-13', 'OPEN', '[{"sender":"USER","text":"สินค้านี้มีประกันไหมครับ?","timestamp":"2026-01-19T13:28:00Z"},{"sender":"SHOP","text":"มีประกันศูนย์ 1 ปีครับ","timestamp":"2026-01-19T13:30:00Z"},{"sender":"USER","text":"ถ้าเสียส่งซ่อมที่ไหนครับ?","timestamp":"2026-01-19T13:31:00Z"},{"sender":"SHOP","text":"ส่งที่ศูนย์บริการทั่วประเทศได้เลยครับ","timestamp":"2026-01-19T13:35:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.chats (chat_id, user_id, shop_id, status, messages) VALUES ('chat-605', 'u002', 'shop-13', 'OPEN', '[{"sender":"USER","text":"รุ่นนี้ขนาดเท่าไหร่ครับ?","timestamp":"2026-02-09T18:18:00Z"},{"sender":"SHOP","text":"ขนาด 30x40 ซม. ครับ","timestamp":"2026-02-09T18:27:00Z"},{"sender":"USER","text":"มีสีดำไหมครับ?","timestamp":"2026-02-09T18:29:00Z"},{"sender":"SHOP","text":"มีครับ เลือกในตัวเลือกได้เลย","timestamp":"2026-02-09T18:31:00Z"}]'::jsonb) ON CONFLICT DO NOTHING;

INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-001', 'Phuket City Hospital', 'HOSPITAL', 'hos-02', '570/8 Beach Road Rd, Bang Rak, Phuket 30119', '{"lat":7.8425,"lng":98.3632}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-002', 'Bangkok General Hospital', 'HOSPITAL', 'hos-02', '636/11 Phetchaburi Rd, Huai Khwang, Bangkok 74006', '{"lat":13.7196,"lng":100.5443}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-003', 'Khon Kaen City Hospital', 'HOSPITAL', 'hos-09', '660/2 Ratchada Rd, Mueang Chiang Mai, Khon Kaen 61391', '{"lat":16.3867,"lng":102.7776}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-004', 'Chon Buri Memorial Hospital', 'HOSPITAL', 'hos-09', '32/19 Rama I Rd, Mueang Chiang Mai, Chon Buri 50579', '{"lat":13.382,"lng":101.0077}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-005', 'Hotel Chon Buri Inn', 'HOTEL', 'h-020', '210/2 Rama IV Rd, Kathu, Chon Buri 66575', '{"lat":13.3738,"lng":101.0032}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-006', 'Hotel Chiang Mai Resort', 'HOTEL', 'h-012', '877/17 Beach Road Rd, Huai Khwang, Chiang Mai 23863', '{"lat":18.7482,"lng":98.9409}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-007', 'Spicy Kitchen', 'RESTAURANT', 'r-014', '362/19 Rama IV Rd, Pathum Wan, Khon Kaen 39906', '{"lat":16.4231,"lng":102.8147}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-008', 'Spicy Spoon', 'RESTAURANT', 'r-030', '934/19 Rama I Rd, Mueang Chiang Mai, Chon Buri 62260', '{"lat":13.3512,"lng":100.9389}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-009', 'Central World Live', 'EVENT_VENUE', 'venue-01', '912/3 Sukhumvit Rd, Chatuchak, Khon Kaen 73021', '{"lat":16.4549,"lng":102.8002}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-010', 'Chiang Mai General Hospital', 'HOSPITAL', 'hos-07', '421/19 Phetchaburi Rd, Watthana, Chiang Mai 66510', '{"lat":18.7783,"lng":98.9574}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-011', 'Chon Buri Memorial Hospital', 'HOSPITAL', 'hos-02', '376/13 Phetchaburi Rd, Watthana, Chon Buri 22978', '{"lat":13.3368,"lng":100.9559}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-012', 'Happy Kitchen', 'RESTAURANT', 'r-046', '845/9 Silom Rd, Bang Lamung, Bangkok 15047', '{"lat":13.7938,"lng":100.4545}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-013', 'Shop Mall Branch', 'STORE', 'shop-10', '177/3 Ratchada Rd, Chatuchak, Khon Kaen 68726', '{"lat":16.3989,"lng":102.859}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-014', 'Bangkok General Hospital', 'HOSPITAL', 'hos-08', '760/5 Silom Rd, Huai Khwang, Bangkok 59020', '{"lat":13.7786,"lng":100.4757}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-015', 'Shop Outlet Branch', 'STORE', 'shop-12', '896/4 Sukhumvit Rd, Kathu, Khon Kaen 59023', '{"lat":16.4772,"lng":102.8528}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-016', 'Shop Central Branch', 'STORE', 'shop-09', '250/14 Charoen Krung Rd, Chatuchak, Khon Kaen 54212', '{"lat":16.4014,"lng":102.7947}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-017', 'Hotel Chiang Mai Resort', 'HOTEL', 'h-036', '403/4 Rama IV Rd, Huai Khwang, Chiang Mai 23193', '{"lat":18.8139,"lng":99.0209}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-018', 'Siam Paragon Hall', 'EVENT_VENUE', 'venue-01', '521/19 Sukhumvit Rd, Bang Lamung, Phuket 19957', '{"lat":7.8752,"lng":98.3856}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-019', 'Shop Robinsons Branch', 'STORE', 'shop-09', '743/10 Charoen Krung Rd, Mueang Chiang Mai, Phuket 14391', '{"lat":7.9285,"lng":98.3654}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-020', 'Chon Buri Memorial Hospital', 'HOSPITAL', 'hos-03', '240/9 Nimmanhaemin Rd, Kathu, Chon Buri 77223', '{"lat":13.3758,"lng":100.9945}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-021', 'Golden Kitchen', 'RESTAURANT', 'r-045', '695/14 Charoen Krung Rd, Mueang Chiang Mai, Phuket 43058', '{"lat":7.8878,"lng":98.3611}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-022', 'True Digital Park', 'EVENT_VENUE', 'venue-07', '838/16 Rama IV Rd, Bang Rak, Chon Buri 55758', '{"lat":13.3462,"lng":100.9911}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-023', 'Golden Kitchen', 'RESTAURANT', 'r-049', '962/3 Rama IV Rd, Bang Rak, Chiang Mai 49889', '{"lat":18.7422,"lng":99.0176}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-024', 'Shop Robinsons Branch', 'STORE', 'shop-14', '84/14 Sathorn Rd, Bang Rak, Phuket 11156', '{"lat":7.8328,"lng":98.4009}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-025', 'Hotel Chiang Mai View', 'HOTEL', 'h-015', '376/17 Nimmanhaemin Rd, Watthana, Chiang Mai 20930', '{"lat":18.8206,"lng":99.026}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-026', 'Shop Robinsons Branch', 'STORE', 'shop-14', '174/12 Phetchaburi Rd, Watthana, Chiang Mai 37926', '{"lat":18.7759,"lng":98.9501}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-027', 'Phuket Convention Center', 'EVENT_VENUE', 'venue-04', '888/3 Beach Road Rd, Bang Lamung, Khon Kaen 49417', '{"lat":16.4782,"lng":102.8583}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-028', 'Hotel Chon Buri View', 'HOTEL', 'h-007', '503/16 Phetchaburi Rd, Chatuchak, Chon Buri 33528', '{"lat":13.3408,"lng":100.9573}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-029', 'Shop Robinsons Branch', 'STORE', 'shop-06', '34/18 Rama I Rd, Pathum Wan, Chiang Mai 73839', '{"lat":18.7766,"lng":98.9857}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-030', 'Shop Robinsons Branch', 'STORE', 'shop-09', '924/8 Rama I Rd, Watthana, Bangkok 49441', '{"lat":13.7451,"lng":100.5301}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-031', 'Hotel Chiang Mai Resort', 'HOTEL', 'h-040', '815/12 Beach Road Rd, Huai Khwang, Chiang Mai 68726', '{"lat":18.7394,"lng":98.9576}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-032', 'Golden Spoon', 'RESTAURANT', 'r-048', '152/2 Rama I Rd, Bang Rak, Khon Kaen 51176', '{"lat":16.4386,"lng":102.7999}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-033', 'Shop Outlet Branch', 'STORE', 'shop-03', '265/1 Sathorn Rd, Kathu, Bangkok 46547', '{"lat":13.7654,"lng":100.4845}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-034', 'Shop Central Branch', 'STORE', 'shop-20', '664/9 Sathorn Rd, Bang Lamung, Chiang Mai 74539', '{"lat":18.8225,"lng":99.0345}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-035', 'Shop Robinsons Branch', 'STORE', 'shop-10', '698/17 Rama I Rd, Pathum Wan, Phuket 41084', '{"lat":7.9087,"lng":98.3474}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-036', 'Thunder Dome', 'EVENT_VENUE', 'venue-08', '231/10 Silom Rd, Huai Khwang, Chon Buri 24914', '{"lat":13.3899,"lng":101.0219}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-037', 'Shop Robinsons Branch', 'STORE', 'shop-01', '525/2 Phetchaburi Rd, Watthana, Chiang Mai 12244', '{"lat":18.7431,"lng":99.0098}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-038', 'Shop Mall Branch', 'STORE', 'shop-01', '612/1 Rama I Rd, Chatuchak, Chon Buri 82545', '{"lat":13.3315,"lng":100.9804}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-039', 'Chon Buri International Hospital', 'HOSPITAL', 'hos-09', '44/7 Phetchaburi Rd, Mueang Chiang Mai, Chon Buri 81470', '{"lat":13.3349,"lng":101.0068}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-040', 'Shop Outlet Branch', 'STORE', 'shop-04', '20/2 Sathorn Rd, Watthana, Bangkok 21856', '{"lat":13.7773,"lng":100.4961}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-041', 'Happy Spoon', 'RESTAURANT', 'r-046', '806/4 Phetchaburi Rd, Kathu, Chiang Mai 48799', '{"lat":18.7545,"lng":99.0058}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-042', 'Shop Central Branch', 'STORE', 'shop-06', '261/10 Rama IV Rd, Watthana, Phuket 79059', '{"lat":7.8783,"lng":98.3687}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-043', 'Thunder Dome', 'EVENT_VENUE', 'venue-08', '953/8 Rama I Rd, Chatuchak, Bangkok 24920', '{"lat":13.73,"lng":100.489}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-044', 'Shop Outlet Branch', 'STORE', 'shop-05', '533/2 Phetchaburi Rd, Watthana, Phuket 18681', '{"lat":7.9037,"lng":98.3854}'::jsonb, '10:00 - 21:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-045', 'Bangkok Memorial Hospital', 'HOSPITAL', 'hos-10', '341/18 Rama I Rd, Mueang Chiang Mai, Bangkok 80005', '{"lat":13.8006,"lng":100.5145}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-046', 'True Digital Park', 'EVENT_VENUE', 'venue-05', '7/2 Phetchaburi Rd, Kathu, Khon Kaen 68107', '{"lat":16.4793,"lng":102.8721}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-047', 'Union Hall', 'EVENT_VENUE', 'venue-08', '470/7 Nimmanhaemin Rd, Kathu, Khon Kaen 71772', '{"lat":16.4601,"lng":102.8135}'::jsonb, '08:00 - 20:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-048', 'Hotel Chiang Mai View', 'HOTEL', 'h-038', '211/16 Sukhumvit Rd, Mueang Chiang Mai, Chiang Mai 65551', '{"lat":18.8383,"lng":99.0194}'::jsonb, '24 Hours') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-049', 'Spicy Bowl', 'RESTAURANT', 'r-027', '850/18 Charoen Krung Rd, Pathum Wan, Khon Kaen 36500', '{"lat":16.438,"lng":102.7747}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;
INSERT INTO public.locations (location_id, name, type, ref_id, address, coordinates, operating_hours) VALUES ('loc-050', 'Golden Kitchen', 'RESTAURANT', 'r-050', '664/17 Silom Rd, Pathum Wan, Chon Buri 48979', '{"lat":13.4013,"lng":100.9357}'::jsonb, '10:00 - 22:00') ON CONFLICT DO NOTHING;

INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-001', 'u001', 'PROMOTION', 'โค้ดส่งฟรีมาแล้ว', 'ใช้โค้ด FREESHIP ลดค่าส่งทันที 0 บาท', FALSE, '2026-01-29T19:12:00Z', '/vouchers') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-002', 'u011', 'ORDER_UPDATE', 'ส่งสินค้าสำเร็จ', 'พัสดุสำหรับคำสั่งซื้อ #746 จัดส่งถึงมือคุณแล้ว', FALSE, '2026-01-27T21:21:00Z', '/orders/746') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-003', 'u008', 'SYSTEM', 'แจ้งเตือนความปลอดภัย', 'มีการเข้าสู่ระบบจากอุปกรณ์ใหม่', TRUE, '2026-01-30T02:01:00Z', '/settings/security') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-004', 'u009', 'SYSTEM', 'ยินดีต้อนรับ!', 'ขอบคุณที่สมัครสมาชิกกับเรา เริ่มต้นใช้งานได้เลย', TRUE, '2026-01-31T16:05:00Z', '/profile') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-005', 'u010', 'PAYMENT', 'ชำระเงินสำเร็จ', 'ได้รับยอดเงินสำหรับรายการ #983 แล้ว', TRUE, '2026-01-28T17:24:00Z', '/wallet/history') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-006', 'u002', 'REMINDER', 'ตั๋วเครื่องบินพร้อมแล้ว', 'เตรียมตัวให้พร้อมสำหรับการเดินทางเที่ยวบิน #111', FALSE, '2026-01-29T16:54:00Z', '/tickets/111') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-007', 'u002', 'ORDER_UPDATE', 'ส่งสินค้าสำเร็จ', 'พัสดุสำหรับคำสั่งซื้อ #261 จัดส่งถึงมือคุณแล้ว', TRUE, '2026-01-21T18:47:00Z', '/orders/261') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-008', 'u013', 'PROMOTION', 'สินค้าใหม่เข้าแล้ว!', 'คอลเลกชันฤดูหนาวมาถึงแล้ว ไปดูกันเลย', FALSE, '2026-01-22T16:22:00Z', '/products/new') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-009', 'u002', 'ORDER_UPDATE', 'สินค้าจัดส่งแล้ว', 'คำสั่งซื้อ #511 ของคุณกำลังเดินทาง', TRUE, '2026-02-04T20:17:00Z', '/orders/511') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-010', 'u001', 'ORDER_UPDATE', 'ส่งสินค้าสำเร็จ', 'พัสดุสำหรับคำสั่งซื้อ #649 จัดส่งถึงมือคุณแล้ว', FALSE, '2026-01-14T21:58:00Z', '/orders/649') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-011', 'u013', 'SYSTEM', 'แจ้งเตือนความปลอดภัย', 'มีการเข้าสู่ระบบจากอุปกรณ์ใหม่', FALSE, '2026-01-16T11:27:00Z', '/settings/security') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-012', 'u011', 'PAYMENT', 'ชำระเงินสำเร็จ', 'ได้รับยอดเงินสำหรับรายการ #509 แล้ว', TRUE, '2026-02-04T14:11:00Z', '/wallet/history') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-013', 'u014', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', TRUE, '2026-01-30T12:27:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-014', 'u012', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', FALSE, '2026-01-12T16:19:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-015', 'u009', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', TRUE, '2026-01-19T17:43:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-016', 'u011', 'PROMOTION', 'โค้ดส่งฟรีมาแล้ว', 'ใช้โค้ด FREESHIP ลดค่าส่งทันที 0 บาท', TRUE, '2026-01-18T17:26:00Z', '/vouchers') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-017', 'u014', 'REMINDER', 'งานใกล้ถึงกำหนดส่ง', 'โปรเจกต์ #432 ครบกำหนดในอีก 2 วัน', FALSE, '2026-01-22T10:14:00Z', '/projects/432') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-018', 'u001', 'ORDER_UPDATE', 'คำสั่งซื้อถูกยกเลิก', 'คำสั่งซื้อ #517 ถูกยกเลิกตามคำขอ', FALSE, '2026-01-27T19:42:00Z', '/orders/517') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-019', 'u012', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', FALSE, '2026-01-27T20:29:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-020', 'u001', 'ORDER_UPDATE', 'ส่งสินค้าสำเร็จ', 'พัสดุสำหรับคำสั่งซื้อ #481 จัดส่งถึงมือคุณแล้ว', FALSE, '2026-02-03T14:50:00Z', '/orders/481') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-021', 'u002', 'PROMOTION', 'ลดราคา 50%!', 'โปรโมชั่นพิเศษเฉพาะวันนี้ รีบช้อปเลย', TRUE, '2026-01-16T19:30:00Z', '/promo/flash-sale') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-022', 'u010', 'PROMOTION', 'ลดราคา 50%!', 'โปรโมชั่นพิเศษเฉพาะวันนี้ รีบช้อปเลย', FALSE, '2026-01-29T22:07:00Z', '/promo/flash-sale') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-023', 'u009', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', TRUE, '2026-01-10T21:32:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-024', 'u010', 'REMINDER', 'งานใกล้ถึงกำหนดส่ง', 'โปรเจกต์ #782 ครบกำหนดในอีก 2 วัน', TRUE, '2026-01-14T10:25:00Z', '/projects/782') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-025', 'u006', 'PAYMENT', 'ชำระเงินสำเร็จ', 'ได้รับยอดเงินสำหรับรายการ #100 แล้ว', TRUE, '2026-01-18T22:00:00Z', '/wallet/history') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-026', 'u007', 'REMINDER', 'ตั๋วเครื่องบินพร้อมแล้ว', 'เตรียมตัวให้พร้อมสำหรับการเดินทางเที่ยวบิน #742', FALSE, '2026-02-06T06:02:00Z', '/tickets/742') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-027', 'u008', 'PROMOTION', 'ลดราคา 50%!', 'โปรโมชั่นพิเศษเฉพาะวันนี้ รีบช้อปเลย', FALSE, '2026-02-03T06:06:00Z', '/promo/flash-sale') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-028', 'u013', 'SYSTEM', 'ยินดีต้อนรับ!', 'ขอบคุณที่สมัครสมาชิกกับเรา เริ่มต้นใช้งานได้เลย', TRUE, '2026-01-26T10:44:00Z', '/profile') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-029', 'u011', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', TRUE, '2026-01-30T01:37:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-030', 'u004', 'ORDER_UPDATE', 'ส่งสินค้าสำเร็จ', 'พัสดุสำหรับคำสั่งซื้อ #883 จัดส่งถึงมือคุณแล้ว', TRUE, '2026-01-29T10:36:00Z', '/orders/883') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-031', 'u011', 'PROMOTION', 'โค้ดส่งฟรีมาแล้ว', 'ใช้โค้ด FREESHIP ลดค่าส่งทันที 0 บาท', TRUE, '2026-01-19T07:09:00Z', '/vouchers') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-032', 'u011', 'REMINDER', 'ตั๋วเครื่องบินพร้อมแล้ว', 'เตรียมตัวให้พร้อมสำหรับการเดินทางเที่ยวบิน #976', FALSE, '2026-01-28T02:25:00Z', '/tickets/976') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-033', 'u014', 'ORDER_UPDATE', 'คำสั่งซื้อถูกยกเลิก', 'คำสั่งซื้อ #367 ถูกยกเลิกตามคำขอ', FALSE, '2026-01-23T12:46:00Z', '/orders/367') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-034', 'u009', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', TRUE, '2026-02-06T13:54:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-035', 'u008', 'SYSTEM', 'ยินดีต้อนรับ!', 'ขอบคุณที่สมัครสมาชิกกับเรา เริ่มต้นใช้งานได้เลย', FALSE, '2026-01-21T09:13:00Z', '/profile') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-036', 'u006', 'REMINDER', 'งานใกล้ถึงกำหนดส่ง', 'โปรเจกต์ #196 ครบกำหนดในอีก 2 วัน', TRUE, '2026-02-09T13:39:00Z', '/projects/196') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-037', 'u003', 'PAYMENT', 'ชำระเงินสำเร็จ', 'ได้รับยอดเงินสำหรับรายการ #757 แล้ว', FALSE, '2026-01-25T00:37:00Z', '/wallet/history') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-038', 'u015', 'PROMOTION', 'สินค้าใหม่เข้าแล้ว!', 'คอลเลกชันฤดูหนาวมาถึงแล้ว ไปดูกันเลย', FALSE, '2026-01-28T06:20:00Z', '/products/new') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-039', 'u010', 'PAYMENT', 'เงินคืนเข้ากระเป๋า', 'ยอดเงินคืนจากการยกเลิกออเดอร์เข้าสู่ระบบแล้ว', FALSE, '2026-01-15T19:31:00Z', '/wallet') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-040', 'u011', 'REMINDER', 'ใบนัดแพทย์พรุ่งนี้', 'อย่าลืมคุณมีนัดกับคุณหมอ #790 พรุ่งนี้', FALSE, '2026-01-30T23:48:00Z', '/appointments/790') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-041', 'u003', 'REMINDER', 'งานใกล้ถึงกำหนดส่ง', 'โปรเจกต์ #469 ครบกำหนดในอีก 2 วัน', FALSE, '2026-02-06T05:35:00Z', '/projects/469') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-042', 'u014', 'SYSTEM', 'ปิดปรับปรุงระบบ', 'เราจะปิดปรับปรุงระบบในคืนนี้เวลา 02:00 น.', TRUE, '2026-01-24T18:35:00Z', '/announcements') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-043', 'u001', 'ORDER_UPDATE', 'คำสั่งซื้อถูกยกเลิก', 'คำสั่งซื้อ #996 ถูกยกเลิกตามคำขอ', TRUE, '2026-01-17T13:58:00Z', '/orders/996') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-044', 'u008', 'PROMOTION', 'โค้ดส่งฟรีมาแล้ว', 'ใช้โค้ด FREESHIP ลดค่าส่งทันที 0 บาท', FALSE, '2026-01-11T16:53:00Z', '/vouchers') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-045', 'u013', 'SYSTEM', 'แจ้งเตือนความปลอดภัย', 'มีการเข้าสู่ระบบจากอุปกรณ์ใหม่', TRUE, '2026-02-05T05:18:00Z', '/settings/security') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-046', 'u002', 'PAYMENT', 'ชำระเงินสำเร็จ', 'ได้รับยอดเงินสำหรับรายการ #747 แล้ว', FALSE, '2026-01-17T03:20:00Z', '/wallet/history') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-047', 'u001', 'SYSTEM', 'ยินดีต้อนรับ!', 'ขอบคุณที่สมัครสมาชิกกับเรา เริ่มต้นใช้งานได้เลย', FALSE, '2026-02-01T00:51:00Z', '/profile') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-048', 'u008', 'REMINDER', 'ใบนัดแพทย์พรุ่งนี้', 'อย่าลืมคุณมีนัดกับคุณหมอ #357 พรุ่งนี้', FALSE, '2026-01-19T08:16:00Z', '/appointments/357') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-049', 'u009', 'ORDER_UPDATE', 'สินค้าจัดส่งแล้ว', 'คำสั่งซื้อ #182 ของคุณกำลังเดินทาง', FALSE, '2026-02-03T18:27:00Z', '/orders/182') ON CONFLICT DO NOTHING;
INSERT INTO public.notifications (notif_id, user_id, type, title, message, is_read, timestamp, action_link) VALUES ('nf-050', 'u003', 'REMINDER', 'ตั๋วเครื่องบินพร้อมแล้ว', 'เตรียมตัวให้พร้อมสำหรับการเดินทางเที่ยวบิน #587', TRUE, '2026-01-16T08:08:00Z', '/tickets/587') ON CONFLICT DO NOTHING;

INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1001', 'u009', 'h-024', 'HOTEL', 2, 'Too expensive for what you get.', '2025-03-05T07:15:00Z', '["https://placehold.co/200x200?text=Review1"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1002', 'u012', 'h-046', 'HOTEL', 5, 'Breakfast was delicious.', '2025-05-14T06:10:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1003', 'u015', 'doc-33', 'DOCTOR', 2, 'Appointment was cancelled last minute.', '2025-01-15T11:47:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1004', 'u001', 'h-006', 'HOTEL', 4, 'Breakfast was delicious.', '2025-01-22T01:43:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1005', 'u012', 'h-009', 'HOTEL', 3, 'Breakfast was disappointing.', '2025-05-14T15:28:00Z', '["https://placehold.co/200x200?text=Review5"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1006', 'u010', 'p-106', 'PRODUCT', 4, 'Exactly what I was looking for.', '2025-07-31T13:21:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1007', 'u007', 'doc-24', 'DOCTOR', 5, 'Very professional and kind.', '2025-07-18T22:12:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1008', 'u012', 'h-050', 'HOTEL', 4, 'Pool area is fantastic.', '2025-02-22T23:34:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1009', 'u001', 'p-115', 'PRODUCT', 4, 'Exactly what I was looking for.', '2026-01-03T18:21:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1010', 'u002', 'h-002', 'HOTEL', 2, 'AC was not working.', '2025-04-19T11:58:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1011', 'u008', 'p-104', 'PRODUCT', 3, 'Did not match the description.', '2026-01-18T00:07:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1012', 'u009', 'doc-08', 'DOCTOR', 5, 'Highly skilled and knowledgeable.', '2025-06-05T02:18:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1013', 'u008', 'p-138', 'PRODUCT', 1, 'Stopped working after a week.', '2025-04-17T18:22:00Z', '["https://placehold.co/200x200?text=Review13"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1014', 'u001', 'h-049', 'HOTEL', 5, 'Amazing view and friendly staff.', '2025-11-05T20:13:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1015', 'u002', 'doc-34', 'DOCTOR', 4, 'Helped me recover quickly.', '2025-02-16T14:46:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1016', 'u002', 'p-110', 'PRODUCT', 3, 'Not worth the price.', '2025-08-24T01:55:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1017', 'u002', 'h-044', 'HOTEL', 5, 'Great location, close to everything.', '2025-08-08T21:05:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1018', 'u009', 'doc-18', 'DOCTOR', 5, 'Wait time was short.', '2025-09-10T00:28:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1019', 'u015', 'doc-15', 'DOCTOR', 3, 'Staff was unhelpful.', '2025-12-10T11:31:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1020', 'u012', 'p-113', 'PRODUCT', 4, 'Great quality, highly recommended!', '2025-06-11T08:36:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1021', 'u010', 'p-133', 'PRODUCT', 4, 'Fast shipping and good packaging.', '2025-02-26T23:06:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1022', 'u003', 'doc-10', 'DOCTOR', 5, 'Highly skilled and knowledgeable.', '2025-07-07T04:11:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1023', 'u002', 'doc-45', 'DOCTOR', 4, 'Helped me recover quickly.', '2025-12-03T03:47:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1024', 'u009', 'p-127', 'PRODUCT', 4, 'Fast shipping and good packaging.', '2025-11-10T00:14:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1025', 'u011', 'p-139', 'PRODUCT', 5, 'Great quality, highly recommended!', '2025-02-08T15:08:00Z', '["https://placehold.co/200x200?text=Review25"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1026', 'u002', 'p-114', 'PRODUCT', 2, 'Stopped working after a week.', '2025-11-05T11:28:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1027', 'u009', 'p-138', 'PRODUCT', 5, 'Fast shipping and good packaging.', '2025-01-14T09:56:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1028', 'u012', 'p-133', 'PRODUCT', 5, 'Fast shipping and good packaging.', '2025-11-06T08:17:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1029', 'u015', 'h-005', 'HOTEL', 3, 'Staff was rude.', '2026-02-04T20:04:00Z', '["https://placehold.co/200x200?text=Review29"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1030', 'u015', 'h-027', 'HOTEL', 2, 'AC was not working.', '2026-01-09T17:03:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1031', 'u013', 'p-131', 'PRODUCT', 5, 'Love the design and build quality.', '2025-02-02T10:33:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1032', 'u014', 'doc-08', 'DOCTOR', 4, 'Very professional and kind.', '2025-07-08T07:15:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1033', 'u015', 'doc-21', 'DOCTOR', 2, 'Prescription didn''t help.', '2025-06-07T04:39:00Z', '["https://placehold.co/200x200?text=Review33"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1034', 'u008', 'h-005', 'HOTEL', 3, 'Noisy neighbors and thin walls.', '2025-04-20T12:33:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1035', 'u005', 'p-113', 'PRODUCT', 4, 'Love the design and build quality.', '2025-03-20T06:03:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1036', 'u010', 'h-027', 'HOTEL', 5, 'Amazing view and friendly staff.', '2026-01-05T23:55:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1037', 'u010', 'p-132', 'PRODUCT', 1, 'Stopped working after a week.', '2025-05-03T18:11:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1038', 'u001', 'h-004', 'HOTEL', 5, 'Room was clean and spacious.', '2025-08-20T16:28:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1039', 'u011', 'doc-07', 'DOCTOR', 5, 'Helped me recover quickly.', '2025-03-07T10:59:00Z', '["https://placehold.co/200x200?text=Review39"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1040', 'u006', 'doc-28', 'DOCTOR', 4, 'Helped me recover quickly.', '2025-07-20T22:07:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1041', 'u006', 'p-144', 'PRODUCT', 5, 'Works perfectly.', '2026-01-15T01:01:00Z', '["https://placehold.co/200x200?text=Review41"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1042', 'u015', 'p-137', 'PRODUCT', 5, 'Works perfectly.', '2025-08-26T15:56:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1043', 'u004', 'doc-30', 'DOCTOR', 2, 'Wait time was too long.', '2025-11-25T17:43:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1044', 'u009', 'doc-07', 'DOCTOR', 4, 'Wait time was short.', '2025-01-14T06:27:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1045', 'u015', 'p-112', 'PRODUCT', 5, 'Fast shipping and good packaging.', '2025-06-06T11:15:00Z', '["https://placehold.co/200x200?text=Review45"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1046', 'u005', 'doc-40', 'DOCTOR', 3, 'Prescription didn''t help.', '2025-06-20T08:47:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1047', 'u014', 'h-043', 'HOTEL', 1, 'Noisy neighbors and thin walls.', '2025-09-10T19:02:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1048', 'u014', 'doc-36', 'DOCTOR', 2, 'Wait time was too long.', '2025-02-09T20:08:00Z', '["https://placehold.co/200x200?text=Review48"]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1049', 'u004', 'p-147', 'PRODUCT', 2, 'Shipping took too long.', '2025-05-16T09:06:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;
INSERT INTO public.reviews (review_id, user_id, target_id, target_type, rating, comment, timestamp, images) VALUES ('rev-1050', 'u011', 'doc-37', 'DOCTOR', 5, 'Helped me recover quickly.', '2025-08-30T18:27:00Z', '[]'::jsonb) ON CONFLICT DO NOTHING;

