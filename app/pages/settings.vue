<template>
  <div>
    <div class="mb-8">
      <p class="text-sm text-gray-500 mb-1">Eco-Sphere Settings</p>
      <h2 class="text-3xl font-bold text-gray-950">System Settings</h2>
    </div>

    <div class="space-y-6 max-w-4xl">
      <!-- System & API Config -->
      <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
        <h3 class="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
          <Icon name="ph:sliders-horizontal-duotone" class="w-5 h-5 text-green-600" />
          การตั้งค่าระบบ
        </h3>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">ความถี่การซิงค์ข้อมูล (วินาที)</label>
            <input 
              type="number" 
              v-model="syncFreqInput"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            />
          </div>

          <div class="md:col-span-2">
            <label class="flex items-center gap-3 cursor-pointer">
              <input 
                type="checkbox" 
                v-model="cacheOfflineInput"
                class="w-4 h-4 text-green-600 border-gray-300 rounded focus:ring-green-500" 
              />
              <span class="text-sm text-gray-700 font-semibold">เปิดใช้งาน Local Offline Sync (สำรองในแคช)</span>
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
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">ชื่อผู้ใช้งาน</label>
            <input 
              type="text" 
              v-model="usernameInput"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
            />
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">สิทธิ์การใช้งาน (Role)</label>
            <input 
              type="text" 
              value="Admin" 
              disabled
              class="w-full bg-gray-100 border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-500 cursor-not-allowed font-bold"
            />
          </div>
        </div>
      </div>

      <div class="flex justify-end gap-3 border-t border-gray-100 pt-6">
        <button 
          @click="cancelSettings"
          class="px-6 py-3 border border-gray-200 rounded-xl text-sm font-medium text-gray-700 hover:bg-gray-50 transition"
        >
          ยกเลิก
        </button>
        <button 
          @click="saveSettings"
          class="px-6 py-3 bg-[#1b4332] text-white rounded-xl text-sm font-bold hover:bg-[#133024] transition shadow-sm"
        >
          บันทึกการตั้งค่า
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const config = useRuntimeConfig()

// globally shared states
const selectedUserId = useState('selected_user_id', () => 'u001')

// local inputs
const syncFreqInput = ref(30)
const cacheOfflineInput = ref(true)
const usernameInput = ref('Somchai Jaidee')

const loadSettings = () => {
  if (typeof window !== 'undefined') {
    syncFreqInput.value = parseInt(localStorage.getItem('sync_frequency') || '30', 10)
    cacheOfflineInput.value = localStorage.getItem('cache_offline') !== 'false'
    
    // Read selected user id and map usernameInput
    const savedId = localStorage.getItem('selected_user_id')
    if (savedId) {
      selectedUserId.value = savedId
    }
    const names = {
      'u001': 'Somchai Jaidee',
      'u002': 'Alice Green',
      'u005': 'Wichai Nilsuwan'
    }
    usernameInput.value = names[selectedUserId.value] || localStorage.getItem('username') || 'Somchai Jaidee'
  }
}

const saveSettings = () => {
  if (typeof window !== 'undefined') {
    localStorage.setItem('sync_frequency', syncFreqInput.value.toString())
    localStorage.setItem('cache_offline', cacheOfflineInput.value.toString())
    localStorage.setItem('username', usernameInput.value)
  }

  alert('บันทึกการตั้งค่าเรียบร้อยแล้ว!')
}

const cancelSettings = () => {
  loadSettings()
}

onMounted(() => {
  loadSettings()
})
</script>
