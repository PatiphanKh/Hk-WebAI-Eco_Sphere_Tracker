<script setup>
import { ref, onMounted } from 'vue'

// 1. สร้างตัวแปรไว้รองรับการดึงข้อมูล
const aqi = ref(0)
const pm25 = ref(0)
const pm10 = ref(0)
const co2Reduction = ref(0)
const statusText = ref('กำลังโหลดข้อมูล...')
const isLoading = ref(true)

// 2. ฟังก์ชันจำลองการดึงข้อมูล (Fetch Data) จากเซ็นเซอร์หรือระบบหลังบ้าน
const fetchAirQualityData = () => {
  isLoading.value = true
  
  // จำลองว่าดึงข้อมูลสำเร็จหลังจากผ่านไป 0.5 วินาที
  setTimeout(() => {
    aqi.value = 32
    pm25.value = 12
    pm10.value = 28
    co2Reduction.value = 2.4 // kg/CO2e ที่ผู้ใช้ช่วยลดได้วันนี้
    
    // ตั้งเงื่อนไขเปลี่ยนคำอธิบายตามค่า AQI ที่ดึงมาได้
    if (aqi.value <= 50) {
      statusText.value = 'ดีมาก อากาศสดชื่น เหมาะกับการทำกิจกรรมภายนอกและปั่นจักรยานเพื่อลดคาร์บอน'
    } else {
      statusText.value = 'เริ่มมีผลกระทบต่อสุขภาพ แนะนำให้หลีกเลี่ยงกิจกรรมกลางแจ้ง'
    }
    
    isLoading.value = false
  }, 500)
}

// 3. สั่งให้ฟังก์ชันทำงานทันทีที่หน้าเว็บนี้ถูกเปิดขึ้นมา (Lifecycle hook)
onMounted(() => {
  fetchAirQualityData()
})
</script>

<template>
  <div class="p-6 max-w-7xl mx-auto space-y-6 text-slate-800">
    
    <div class="flex items-center space-x-4 bg-white p-6 rounded-2xl shadow-sm border border-emerald-100">
      <div class="p-4 bg-emerald-50 text-emerald-600 rounded-xl">
        <Icon name="uil:wind" class="w-8 h-8" />
      </div>
      <div>
        <h1 class="text-2xl font-bold">Air Quality Tracking</h1>
        <p class="text-slate-500 text-sm">ติดตามดัชนีคุณภาพอากาศและการไหลเวียนของลม</p>
      </div>
    </div>

    <div v-if="isLoading" class="text-slate-500 bg-white p-6 rounded-2xl border text-center">
      กำลังดึงข้อมูลคุณภาพอากาศแบบ Real-time...
    </div>

    <div v-else class="space-y-6">
      <div class="bg-emerald-50/50 border border-emerald-200 p-5 rounded-2xl">
        <h3 class="font-bold text-emerald-800 mb-2">ระบบวัดผลคุณภาพอากาศเสมือนจริง</h3>
        <p class="text-emerald-700">
          ดัชนีคุณภาพอากาศ (AQI) ในพื้นที่ปัจจุบันของคุณคือ 
          <span class="font-bold text-xl text-emerald-600">{{ aqi }}</span> 
          ({{ statusText }})
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
          <p class="text-sm text-slate-400 font-medium">ฝุ่น PM 2.5</p>
          <p class="text-3xl font-bold mt-1 text-slate-700">{{ pm25 }} <span class="text-sm font-normal text-slate-400">µg/m³</span></p>
        </div>

        <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
          <p class="text-sm text-slate-400 font-medium">ฝุ่น PM 10</p>
          <p class="text-3xl font-bold mt-1 text-slate-700">{{ pm10 }} <span class="text-sm font-normal text-slate-400">µg/m³</span></p>
        </div>

        <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
          <p class="text-sm text-slate-400 font-medium">คาร์บอนที่ลดได้จากกิจกรรมวันนี้</p>
          <p class="text-3xl font-bold mt-1 text-emerald-600">-{{ co2Reduction }} <span class="text-sm font-normal text-slate-400">kg/CO2e</span></p>
        </div>
      </div>
    </div>

  </div>
</template>