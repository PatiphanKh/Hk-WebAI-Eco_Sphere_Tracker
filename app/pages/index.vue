<template>
  <div>
    <div class="flex justify-between items-start mb-8">
      <div>
        <p class="text-sm text-gray-500 mb-1">Eco-Sphere Tracker</p>
        <h2 class="text-3xl font-bold text-gray-950">แดชบอร์ด Eco-Sphere</h2>
      </div>
      
      <div 
        v-if="showSyncComplete"
        class="bg-white p-4 rounded-xl shadow-sm border border-gray-100 flex items-center gap-3 w-72 transition duration-300"
      >
        <div class="bg-green-100 text-green-600 p-2.5 rounded-full relative">
          <Icon name="ph:cloud-check-duotone" class="w-6 h-6" />
          <span class="absolute top-0 right-0 block h-2.5 w-2.5 rounded-full ring-2 ring-white bg-green-500" />
        </div>
        <div>
          <p class="font-semibold text-gray-900">Sync Complete</p>
          <p class="text-xs text-gray-500">Latest sensor data retrieved.</p>
        </div>
        <button @click="showSyncComplete = false" class="ml-auto text-gray-400 hover:text-gray-600">
          <Icon name="ph:x" class="w-4 h-4" />
        </button>
      </div>
    </div>

    <div class="grid grid-cols-3 gap-6">
      
      <div class="col-span-2 space-y-6">
        <div class="grid grid-cols-2 gap-6">
          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:border-gray-200 transition">
            <div class="flex justify-between items-start mb-4">
              <p class="text-gray-600">ปริมาณปล่อย CO2 สะสม</p>
              <div class="text-red-500 font-bold text-xs bg-red-50 px-2 py-0.5 rounded">CO₂</div>
            </div>
            <p class="text-5xl font-extrabold text-gray-950">
              245 <span class="text-2xl font-bold text-gray-600 ml-1">kg CO2</span>
            </p>
          </div>
          
          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:border-gray-200 transition">
            <div class="flex justify-between items-start mb-4">
              <p class="text-gray-600">คะแนน Eco Points</p>
              <Icon name="ph:star-duotone" class="w-5 h-5 text-green-500" />
            </div>
            <p class="text-5xl font-extrabold text-gray-950">1,250</p>
          </div>
        </div>

        <div class="bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
          <h3 class="text-xl font-semibold mb-6 text-gray-900">สัดส่วนการปล่อยคาร์บอน</h3>
          
          <div class="space-y-5">
            <div v-for="item in carbonData" :key="item.label">
              <div class="flex justify-between text-sm mb-1.5">
                <span class="text-gray-700">{{ item.label }}</span>
                <span class="font-medium text-gray-900">{{ item.percentage }}%</span>
              </div>
              <div class="w-full bg-gray-100 rounded-full h-2.5">
                <div 
                  class="h-2.5 rounded-full transition-all duration-500" 
                  :class="item.color"
                  :style="{ width: item.percentage + '%' }"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-span-1 space-y-6">
        <div class="bg-green-950 p-6 rounded-2xl text-white shadow-lg hover:shadow-xl transition duration-300">
          <div class="flex justify-between items-start mb-4">
            <p class="text-green-200">อัตราการลดคาร์บอน</p>
            <Icon name="ph:leaf-duotone" class="w-5 h-5 text-green-300 animate-pulse" />
          </div>
          <p class="text-5xl font-extrabold mb-2">15%</p>
          <svg viewBox="0 0 100 20" class="w-full h-10 text-green-400" preserveAspectRatio="none">
            <polyline
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              points="0,15 10,18 20,10 30,12 40,5 50,8 60,2 70,5 80,0 90,3 100,1"
            />
          </svg>
        </div>

        <div class="bg-green-100 p-6 rounded-2xl border border-green-200 text-green-900 flex gap-4">
          <Icon name="ph:lightbulb-duotone" class="w-10 h-10 text-green-600 flex-shrink-0" />
          <p class="text-sm leading-relaxed">
            ค่าคาร์บอนของคุณในเดือนนี้สูงเกิน 200kg CO2 จากไฟล์ตบินไปเชียงใหม่สัปดาห์ที่แล้ว แนะนำให้ลดคาร์บอนชดเชย
          </p>
        </div>

        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
          <div class="flex items-center gap-2 mb-5">
            <Icon name="ph:hard-drive-duotone" class="w-5 h-5 text-gray-500" />
            <h3 class="text-lg font-semibold text-gray-900">ข้อมูลที่บันทึกออฟไลน์</h3>
          </div>
          
          <div class="space-y-3">
            <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 cursor-pointer transition">
              <Icon name="ph:file-text-duotone" class="w-5 h-5 text-gray-500" />
              <span class="text-sm text-gray-800 flex-grow">แผ่นลดคาร์บอนเดือนมิถุนายน</span>
              <Icon name="ph:caret-right" class="w-4 h-4 text-gray-400" />
            </div>
            <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 cursor-pointer transition">
              <Icon name="ph:calendar-blank-duotone" class="w-5 h-5 text-gray-500" />
              <span class="text-sm text-gray-800 flex-grow">ตารางนัดหมายประเมินพลังงาน</span>
              <Icon name="ph:caret-right" class="w-4 h-4 text-gray-400" />
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
const showSyncComplete = ref(true)

// ข้อมูลจำลองสำหรับกราฟสัดส่วนคาร์บอน
const carbonData = ref([
  { label: 'การบิน', percentage: 45, color: 'bg-red-500' },
  { label: 'ท่องเที่ยว', percentage: 25, color: 'bg-green-700' },
  { label: 'ช้อปปิ้ง', percentage: 20, color: 'bg-green-500' },
  { label: 'ฟู้ดเดลิเวอรี่', percentage: 10, color: 'bg-green-300' },
]);
</script>
