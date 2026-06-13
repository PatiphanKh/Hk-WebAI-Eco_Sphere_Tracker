<template>
  <div>
    <div class="mb-8">
      <p class="text-sm text-gray-500 mb-1">Eco-Sphere Assistant</p>
      <h2 class="text-3xl font-bold text-gray-950">AI Eco-Assistant</h2>
    </div>

    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8 max-w-4xl">
      <div class="flex items-center gap-4 mb-6 pb-6 border-b border-gray-100">
        <div class="bg-green-100 text-green-600 p-3 rounded-xl">
          <Icon name="ph:robot-duotone" class="w-8 h-8" />
        </div>
        <div>
          <h3 class="text-lg font-semibold text-gray-900">ระบบประมวลผล Eco-Assistant</h3>
          <p class="text-sm text-gray-500">พร้อมช่วยเหลือในการคำนวณและลดการปล่อยคาร์บอนฟุตพริ้นท์ของคุณ</p>
        </div>
      </div>

      <div class="space-y-4 mb-6">
        <div class="flex gap-3 max-w-lg">
          <div class="bg-gray-100 text-gray-800 p-4 rounded-2xl rounded-tl-none text-sm leading-relaxed">
            สวัสดีครับ! ผมคือผู้ช่วย Eco-Assistant คุณสามารถสอบถามข้อมูลหรือขอคำแนะนำในการลด CO2 ในชีวิตประจำวันได้เลยครับ
          </div>
        </div>

        <div class="flex gap-3 max-w-lg ml-auto justify-end">
          <div class="bg-green-950 text-white p-4 rounded-2xl rounded-tr-none text-sm leading-relaxed">
            แนะนำวิธีประหยัดพลังงานในบ้านหน่อยครับ
          </div>
        </div>

        <div class="flex gap-3 max-w-lg">
          <div class="bg-gray-100 text-gray-800 p-4 rounded-2xl rounded-tl-none text-sm leading-relaxed">
            คำแนะนำง่ายๆ สำหรับวันนี้ครับ:<br/>
            1. ปรับอุณหภูมิเครื่องปรับอากาศเป็น 25-26°C และใช้พัดลมช่วย<br/>
            2. ถอดปลั๊กเครื่องใช้ไฟฟ้าที่ไม่ได้ใช้งาน<br/>
            3. เปลี่ยนมาใช้หลอดไฟ LED ช่วยประหยัดไฟได้มากกว่า 80%
          </div>
        </div>
      </div>

      <div class="flex gap-2">
        <input 
          type="text" 
          placeholder="พิมพ์ข้อความคุยกับผู้ช่วย..." 
          class="flex-grow bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
        />
        <button class="bg-green-950 text-white px-5 py-3 rounded-xl font-medium text-sm hover:bg-green-900 transition flex items-center gap-2">
          ส่ง
          <Icon name="ph:paper-plane-right-bold" class="w-4 h-4" />
        </button>
      </div>
    </div>
  </div>
</template>
