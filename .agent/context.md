# 🌱 Eco-Sphere Tracker (เครื่องมือคำนวณและติดตามคาร์บอนฟุตพริ้นท์ส่วนบุคคล)

**Eco-Sphere Tracker** คือแอปพลิเคชันเว็บแบบ Offline-first ที่ชุบชีวิตข้อมูลพฤติกรรมการใช้ชีวิตและการเงินในอดีตของผู้ใช้จากอุตสาหกรรมต่าง ๆ ในรูปแบบดิบ (JSON) ให้กลายเป็นภาพรวมผลกระทบสิ่งแวดล้อมเชิงลึก ช่วยให้ผู้ใช้ตระหนักรู้และปรับเปลี่ยนพฤติกรรมเพื่อมุ่งสู่การลดคาร์บอนอย่างยั่งยืน

---

## 🎯 ที่มาและปัญหา (Background & Motivation)
ในแต่ละวัน พฤติกรรมการใช้ชีวิตและการบริโภคของเรา เช่น การเดินทางด้วยเครื่องบิน การสั่งอาหารเดลิเวอรี่ที่มีบรรจุภัณฑ์พลาสติก การช้อปปิ้งออนไลน์ หรือแม้แต่การเข้าพักโรงแรม ล้วนสร้างคาร์บอนฟุตพริ้นท์ (Carbon Footprint) ปล่อยก๊าซเรือนกระจกสะสมเข้าสู่บรรยากาศ ทว่าผู้บริโภคทั่วไปมักไม่สามารถรับรู้ตัวเลขผลกระทบนี้ได้อย่างเป็นรูปธรรม 

โปรเจกต์นี้จึงถูกพัฒนาขึ้นเพื่อดึงข้อมูลเชิงกายภาพและพฤติกรรมจริงของผู้ใช้งานมาจำลอง แปลงค่า และนำเสนอผลกระทบสิ่งแวดล้อมพร้อมเครื่องมือให้คำแนะนำอัจฉริยะ (AI Coach) เพื่อช่วยวางแผนการลดหย่อนและสร้างสมดุลทางนิเวศ

---

## 🚀 ฟีเจอร์หลักของระบบ (Key Features)

### 1. 📊 แดชบอร์ดสรุปผลกระทบคาร์บอน (Eco Dashboard & Analytics)
* **KPIs สรุปภาพรวม:** แสดงปริมาณการปล่อยคาร์บอนสะสมทั้งหมด (Total CO₂ kg) เทียบกับเป้าหมายจำกัดคาร์บอน และแสดงคะแนนความดีสิ่งแวดล้อม (Eco Points)
* **แผนภูมิจำแนกสัดส่วน:** ใช้แผนภูมิ Conic-Gradient ในการแจกแจงสัดส่วนคาร์บอนตามแหล่งกำเนิด (เช่น เที่ยวบิน, ขยะอาหารเดลิเวอรี่, ของช้อปปิ้ง, โรงแรมที่พัก)
* **แผนภูมิแท่งประวัติและแนวโน้ม (Trend Chart):** แสดงแนวโน้มการลดคาร์บอนของผู้ใช้ในแต่ละเดือนเปรียบเทียบในอดีต

### 2. 🤖 ผู้ช่วยอัจฉริยะวิเคราะห์นิเวศวิทยา (AI Eco-Advisor Chatbot)
* **Gemini API Integration:** เชื่อมต่อกับ Google Gemini API (Free Tier) เพื่อทำหน้าที่เป็นโค้ชรักษ์โลกส่วนตัว วิเคราะห์ข้อมูลพฤติกรรมจริงในเครื่องของผู้ใช้และให้คำแนะนำแบบเฉพาะเจาะจง (Personalized green recommendations)
* **Local Fallback Engine:** หากไม่มีคีย์ API หรือเครือข่ายอินเทอร์เน็ตหลุด ระบบจะสลับไปใช้ตัววิเคราะห์ข้อมูลออฟไลน์ (Rule-based) ในเครื่องทันที ทำให้ผู้ใช้ยังพิมพ์คุยสอบถามข้อมูลสถิติสิ่งแวดล้อมของตนเองได้ตลอดเวลา

### 3. ⚡ ตัวจำลองมลพิษเรียลไทม์ (Real-time Carbon Simulator)
* จำลองสถานการณ์เมื่อมีพฤติกรรมและการทำธุรกรรมใหม่ไหลเข้ามาในชีวิตผู้ใช้ (เช่น การสั่งซื้อสินค้าใหม่, การสั่งอาหารเดลิเวอรี่, การจองตั๋วบินฉุกเฉิน)
* ยอดคาร์บอนฟุตพริ้นท์สะสมและแผนภูมิแสดงผลบนแดชบอร์ดจะอัปเดตแบบสด ๆ ทันทีโดยไม่ต้องโหลดหน้าเว็บซ้ำ พร้อมมีกล่องแจ้งเตือน (Toast Alert) แสดงผลกระทบคาร์บอนของพฤติกรรมนั้น ๆ เป็นกิโลกรัมคาร์บอน

### 4. 📱 แอปพลิเคชันออฟไลน์แบบสมบูรณ์ (PWA / Offline-first)
* ติดตั้ง **Service Worker** และระบบแคชไฟล์ เพื่อให้สามารถเปิดเว็บแอปพลิเคชันขึ้นมาใช้งานและแสดงผลหน้าจอได้อย่างรวดเร็วแม้สัญญาณเน็ตขาดหาย
* ข้อมูลทั้งหมดถูกจัดเก็บและประมวลผลบนเครื่องของผู้ใช้ด้วย **LocalStorage** ของบราวเซอร์

---

## 📂 โครงสร้างและการเชื่อมโยงข้อมูล (Data Model & Schema)

ระบบจะดึงฐานข้อมูลจำลอง JSON ทั้ง 9 อุตสาหกรรมในระบบมาคำนวณคาร์บอนฟุตพริ้นท์โดยมีคีย์หลักคือ `user_id` ในการดึงความสัมพันธ์ข้ามไฟล์ดังนี้:

* **ข้อมูลผู้ใช้:** [users.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/users.json)
* **หมวดหมู่ที่ปล่อยคาร์บอนหลัก:**
  * **การบิน (Carbon สูงสุด):** คำนวณจากไฟล์ [flight_tickets.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/3. ระบบจองตั๋วเดินทาง (Travel Ticketing)/flight_tickets.json) และ [flights.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/3. ระบบจองตั๋วเดินทาง (Travel Ticketing)/flights.json) (อิงพิกัดระยะทางจริงจาก [locations.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/10. common/locations.json))
  * **โรงแรมที่พัก:** คำนวณจากระยะเวลาพักและสิ่งอำนวยความสะดวกใน [hotel_bookings.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/2. ระบบจองโรงแรม (Hotel Booking)/hotel_bookings.json) และ [hotels.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/2. ระบบจองโรงแรม (Hotel Booking)/hotels.json)
  * **อาหารและการจัดส่ง:** คำนวณจากบรรจุภัณฑ์พลาสติกของการจัดส่งเดลิเวอรี่ และประเภทส่วนผสมอาหารใน [food_orders.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/5. ระบบสั่งอาหาร (Food Delivery)/food_orders.json) และ [restaurants.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/5. ระบบสั่งอาหาร (Food Delivery)/restaurants.json)
  * **การบริโภคสินค้า:** คำนวณความสิ้นเปลืองของขยะและทรัพยากรตามประเภทสินค้าใน [ecommerce_orders.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/1. ระบบร้านค้า (E-commerce)/ecommerce_orders.json) และ [products.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/1. ระบบร้านค้า (E-commerce)/products.json)
* **กิจกรรมช่วยลดคาร์บอน (Carbon Offsets):**
  * **การศึกษาและการทำงานออนไลน์:** ดึงข้อมูลความพยายามทำงานแบบออนไลน์และการสอบวัดผลจาก [enrollments.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/7. ระบบเรียนออนไลน์ (Education - LMS)/enrollments.json) และ [tasks.json](file:///C:/Users/localhost/Documents/antigravity/lucid-hopper/data/9. ระบบจัดการงาน (Task - Productivity)/tasks.json) มาแปลงเป็นแต้ม Eco Points ชดเชย

---

## 🛠️ โครงสร้างเทคโนโลยี (Tech Stack)
* **Frontend:** Vanilla HTML5, Modern ECMAScript (ES Modules)
* **Styling:** Vanilla CSS (เน้น Dark mode, Glassmorphic Glass, CSS variable ดีไซน์)
* **Build Tool:** Vite (สำหรับการรันเครื่องทดสอบระบบ)
* **PWA:** Service Worker API & Cache API
* **AI:** Google Generative AI API (Gemini-2.5-flash)
