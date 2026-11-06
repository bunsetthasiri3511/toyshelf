# Toy Shelf
1. สร้างโปรเจกต์ที่ supabase.com → SQL Editor → รันไฟล์ `supabase.sql`
2. Project Settings > API → คัดลอก URL และ anon key ใส่ใน `config.js`
3. Authentication > Sign In / Providers > Email: **ปิด "Confirm email"** (จำเป็น เพราะระบบใช้ชื่อผู้ใช้ + รหัสลับ ไม่มีอีเมลจริง)
4. ทดสอบในเครื่อง: `python3 -m http.server` → http://localhost:8000
5. Push ขึ้น GitHub → Settings > Pages → branch main / root
6. Supabase > Authentication > URL Configuration: ใส่ URL ของ GitHub Pages ใน Site URL
