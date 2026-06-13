<template>
  <div>
    <div class="mb-8">
      <p class="text-sm text-gray-500 mb-1">Eco-Sphere Settings</p>
      <h2 class="text-3xl font-bold text-gray-950">Simulator Settings</h2>
    </div>

    <div class="space-y-6 max-w-4xl">
      <!-- Simulator Config -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
        <h3 class="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
          <Icon name="ph:sliders-horizontal-duotone" class="w-5 h-5 text-green-600" />
          การตั้งค่า Simulator & Engine
        </h3>
        
        <div class="grid grid-cols-2 gap-6">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Engine การทำงาน</label>
            <select class="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition">
              <option value="offline">Local Fallback Engine (Offline)</option>
              <option value="cloud">Cloud Native Engine (Online)</option>
              <option value="hybrid">Hybrid Engine</option>
            </select>
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">ความถี่การซิงค์ข้อมูล (วินาที)</label>
            <input 
              type="number" 
              value="30"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            />
          </div>

          <div class="col-span-2">
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" checked class="w-4 h-4 text-green-600 border-gray-300 rounded focus:ring-green-500" />
              <span class="text-sm text-gray-700">บันทึกประวัติการจำลองใน Cache เมื่อออฟไลน์ (Local Offline Sync)</span>
            </label>
          </div>
        </div>
      </div>

      <!-- Admin Profile -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
        <h3 class="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
          <Icon name="ph:user-circle-duotone" class="w-5 h-5 text-green-600" />
          ข้อมูลผู้ใช้งาน
        </h3>
        
        <div class="grid grid-cols-2 gap-6">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">ชื่อผู้ใช้งาน</label>
            <input 
              type="text" 
              value="Somchai Jaidee"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            />
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">สิทธิ์การใช้งาน (Role)</label>
            <input 
              type="text" 
              value="Admin" 
              disabled
              class="w-full bg-gray-100 border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-500 cursor-not-allowed"
            />
          </div>
        </div>
      </div>

      <div class="flex justify-end gap-3">
        <button class="px-6 py-3 border border-gray-200 rounded-xl text-sm font-medium text-gray-700 hover:bg-gray-50 transition">
          ยกเลิก
        </button>
        <button class="px-6 py-3 bg-green-950 text-white rounded-xl text-sm font-medium hover:bg-green-900 transition shadow-sm">
          บันทึกการตั้งค่า
        </button>
      </div>
    </div>
  </div>
</template>
