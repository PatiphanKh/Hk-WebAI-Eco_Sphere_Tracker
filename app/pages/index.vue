<template>
  <ClientOnly>
    <div>
    <!-- Greeting & Header -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
      <div>
        <h2 class="text-3xl font-extrabold text-emerald-950 flex items-center gap-2">
          สวัสดี {{ displayFirstName }} 👏
        </h2>
        <p class="text-sm text-green-700 font-bold mt-1">
          ลดคาร์บอนไปแล้ว {{ carbonSaved }} kg
        </p>
      </div>
      
      <!-- Daily Status Badge & Mode Toggle -->
      <div class="flex flex-wrap items-center gap-3 w-full sm:w-auto">
        <!-- Daily Status Card -->
        <div class="border border-[#cbe5d4] rounded-full px-4 py-1.5 flex items-center gap-2.5 bg-white shadow-sm">
          <span class="text-xs font-bold text-emerald-950">สถานะรายวัน ปกติ</span>
          <span class="relative flex h-2.5 w-2.5">
            <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
            <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-green-500"></span>
          </span>
          <div class="w-6 h-6 rounded-full bg-[#7fe4a9] text-[#1b4332] font-black text-[10px] flex items-center justify-center border border-white">
            {{ displayFirstName.substring(0, 1) }}
          </div>
        </div>
      </div>
    </div>

    <!-- Cards Row -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8 relative">
      <!-- Loading Overlay -->
      <div v-if="loading" class="absolute inset-0 bg-white/40 flex items-center justify-center backdrop-blur-[1px] z-10 rounded-2xl">
        <Icon name="ph:circle-notch-bold" class="w-8 h-8 text-[#1b4332] animate-spin" />
      </div>

      <!-- Card 1: Carbon Emitted -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <span class="text-xs font-extrabold text-gray-400 uppercase tracking-wider">kg</span>
        <div class="mt-4">
          <p class="text-4xl font-black text-gray-900 leading-none">
            {{ displayTotalCO2.toFixed(1) }}
          </p>
          <p class="text-xs font-bold text-green-700 mt-3">คาร์บอนที่ปล่อยแล้ว</p>
        </div>
      </div>

      <!-- Card 2: Eco Points -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <div class="flex justify-between items-start">
          <span class="text-xs font-extrabold text-gray-400 uppercase tracking-wider">คะแนนสิ่งแวดล้อม</span>
          <Icon name="ph:star-fill" class="w-5 h-5 text-yellow-400 animate-pulse" />
        </div>
        <div class="mt-4">
          <p class="text-4xl font-black text-gray-900 leading-none">
            {{ displayEcoPoints.toLocaleString() }} <span class="text-sm font-bold text-gray-400">pts</span>
          </p>
          <div class="mt-3 inline-block bg-green-50 text-green-700 text-[10px] font-extrabold px-2 py-0.5 rounded border border-green-100">
            ระดับ: {{ ecoLevel }}
          </div>
        </div>
      </div>

      <!-- Card 3: Highest Impact Category -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <div class="flex justify-between items-start">
          <span class="text-xs font-extrabold text-gray-400 uppercase tracking-wider">หมวดหมู่ปล่อยสูงสุด</span>
          <Icon :name="highestCategoryIcon" class="w-5 h-5 text-red-500" />
        </div>
        <div class="mt-4">
          <p class="text-2xl font-black text-gray-900 leading-tight">
            {{ displayHighestCategory.name }}
          </p>
          <p class="text-[11px] font-bold text-red-600 mt-3">
            {{ displayHighestCategory.amount.toFixed(1) }} kg CO₂ <span class="text-gray-400 font-normal">({{ displayHighestCategory.percentage }}% ของทั้งหมด)</span>
          </p>
        </div>
      </div>

      <!-- Card 4: Monthly Target -->
      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <span class="text-xs font-extrabold text-gray-400 tracking-wider">เป้าหมายรายเดือน</span>
        <div class="mt-4">
          <p class="text-2xl font-black text-gray-900 leading-none">
            {{ displayTotalCO2.toFixed(1) }} <span class="text-xs text-gray-400 font-bold">/ 400 kg</span>
          </p>
          <div class="w-full bg-gray-100 rounded-full h-2 mt-3.5 overflow-hidden">
            <div class="bg-amber-600 h-2 rounded-full transition-all duration-700" :style="{ width: Math.min(100, (displayTotalCO2 / 400) * 100) + '%' }"></div>
          </div>
          <p class="text-[10px] font-extrabold text-amber-700 mt-2.5">
            เหลืออีก {{ displayTargetRemaining.toFixed(1) }} kg
          </p>
        </div>
      </div>
    </div>

    <!-- Smart Recommendations Section -->
    <div class="mb-8">
      <h3 class="text-lg font-bold text-emerald-950 mb-4 flex items-center gap-2">
        <Icon name="ph:sparkles-bold" class="w-5 h-5 text-green-700" />
        คำแนะนำอัจฉริยะ
      </h3>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        <!-- Recommendation Card 1: Flight Offset -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:border-green-200 transition duration-300">
          <div>
            <h4 class="font-extrabold text-sm text-gray-900 flex items-center gap-1.5">
              <span class="w-1.5 h-1.5 rounded-full bg-red-500"></span>
              ปริมาณปล่อยคาร์บอนจากไฟล์ตเชียงใหม่สูงมาก
            </h4>
            <p class="text-xs text-gray-500 leading-relaxed mt-2.5">
              ไฟล์ตล่าสุดของคุณสร้างคาร์บอนกว่า 200kg พิจารณาซื้อ Carbon Credit เพื่อลดผลกระทบสิ่งแวดล้อม
            </p>
          </div>
          <div class="mt-4">
            <button 
              @click="buyOffset"
              class="rounded-full border border-green-700 text-green-700 hover:bg-green-50 px-4 py-1.5 text-xs font-bold transition flex items-center gap-1.5"
              :class="{ 'opacity-60 cursor-not-allowed bg-green-50/50 border-green-300 text-green-400': offsetBought }"
              :disabled="offsetBought"
            >
              <Icon :name="offsetBought ? 'ph:check-bold' : 'ph:leaf-bold'" class="w-3.5 h-3.5" />
              {{ offsetBought ? 'ชดเชยเรียบร้อยแล้ว' : 'ซื้อคาร์บอนชดเชย' }}
            </button>
          </div>
        </div>

        <!-- Recommendation Card 2: Bike Activity -->
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex gap-4 items-start justify-between hover:border-green-200 transition duration-300">
          <div class="flex gap-4">
            <div class="bg-green-100 text-green-700 p-3 rounded-full flex-shrink-0">
              <Icon name="ph:bicycle-bold" class="w-6 h-6 animate-bounce" />
            </div>
            <div>
              <h4 class="font-extrabold text-sm text-gray-900">เปลี่ยนมาปั่นจักรยานวันนี้?</h4>
              <p class="text-xs text-gray-500 leading-relaxed mt-2.5">
                อากาศดีมาก (AQI 32) เหมาะแก่การปั่นจักรยานไปทำงาน ช่วยลดคาร์บอนได้ถึง 2.5kg
              </p>
              <div class="mt-4">
                <button 
                  @click="logBikeActivity"
                  class="rounded-full border border-green-700 text-green-700 hover:bg-green-50 px-4 py-1.5 text-xs font-bold transition flex items-center gap-1.5"
                  :class="{ 'opacity-60 cursor-not-allowed bg-green-50/50 border-green-300 text-green-400': bikeLogged }"
                  :disabled="bikeLogged"
                >
                  <Icon :name="bikeLogged ? 'ph:check-bold' : 'ph:plus-bold'" class="w-3.5 h-3.5" />
                  {{ bikeLogged ? 'บันทึกกิจกรรมแล้ว (-2.5kg)' : 'บันทึกกิจกรรม' }}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bottom Section: Breakdown and Activities -->
    <div class="grid grid-cols-1 lg:grid-cols-5 gap-6 relative">
      <!-- Loading Overlay -->
      <div v-if="loading" class="absolute inset-0 bg-white/40 flex items-center justify-center backdrop-blur-[1px] z-10 rounded-2xl">
        <Icon name="ph:circle-notch-bold" class="w-8 h-8 text-[#1b4332] animate-spin" />
      </div>

      <!-- Left: Carbon Breakdown Circle -->
      <div class="lg:col-span-2 bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <div class="flex justify-between items-center mb-4">
          <h3 class="font-extrabold text-gray-900 text-base">สัดส่วนการปล่อยคาร์บอน</h3>
          <span class="text-xs text-gray-500 bg-gray-50 border border-gray-100 rounded px-2.5 py-1 font-bold cursor-pointer hover:bg-gray-100 transition">
            เดือนนี้ ∨
          </span>
        </div>

        <!-- Doughnut Chart Area -->
        <div class="flex justify-center items-center my-6 relative">
          <!-- Circular Conic Gradient Chart -->
          <div 
            class="w-48 h-48 rounded-full flex items-center justify-center transition-all duration-700 shadow-md" 
            :style="conicGradientStyle"
          >
            <!-- Inner Circle (makes it a doughnut chart) -->
            <div class="w-36 h-36 rounded-full bg-white flex flex-col items-center justify-center shadow-inner">
              <span class="text-3xl font-black text-gray-900">{{ displayTotalCO2.toFixed(1) }}</span>
              <span class="text-[10px] font-extrabold text-gray-400 uppercase tracking-wider">kg Total</span>
            </div>
          </div>
        </div>

        <!-- Breakdown Details List -->
        <div class="space-y-2.5 mt-2 text-xs font-bold">
          <div v-for="item in displayBreakdown" :key="item.label" class="flex justify-between items-center py-2 border-b border-gray-50 last:border-0">
            <span class="flex items-center gap-2.5">
              <span class="w-3 h-3 rounded-full" :class="item.dotColor"></span>
              <span class="text-gray-600">{{ item.label }}</span>
            </span>
            <span class="text-gray-900 font-extrabold">
              {{ item.amount.toFixed(1) }} kg <span class="text-gray-400 font-normal">({{ item.percentage }}%)</span>
            </span>
          </div>
        </div>
      </div>

      <!-- Right: Recent Activities List -->
      <div class="lg:col-span-3 bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col justify-between hover:shadow-md transition duration-300">
        <div class="flex justify-between items-center mb-4">
          <h3 class="font-bold text-gray-900 text-base">กิจกรรมล่าสุด</h3>
          <button 
            @click="scrollToAudit" 
            class="text-xs text-gray-500 hover:text-emerald-700 font-bold transition"
          >
            ดูทั้งหมด
          </button>
        </div>

        <!-- Recent Activities Table -->
        <div class="overflow-x-auto flex-grow">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="border-b border-gray-100 text-[10px] text-gray-400 font-bold uppercase tracking-wider">
                <th class="py-2.5">รายละเอียด</th>
                <th class="py-2.5 text-center">วันที่</th>
                <th class="py-2.5 text-right">CO₂ (kg)</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-50 text-xs font-semibold">
              <tr v-for="act in recentDisplayActivities" :key="act.id" class="hover:bg-gray-50/50 transition">
                <td class="py-3 flex items-center gap-3">
                  <!-- Category Icon -->
                  <div 
                    class="p-2 rounded-full flex-shrink-0"
                    :class="act.bgClass"
                  >
                    <Icon :name="act.icon" class="w-4 h-4" />
                  </div>
                  <div>
                    <p class="font-bold text-gray-900">{{ act.title }}</p>
                    <p class="text-[10px] text-gray-400 font-medium">{{ act.desc }}</p>
                  </div>
                </td>
                <td class="py-3 text-center text-gray-500 whitespace-nowrap">
                  {{ act.date }}
                </td>
                <td class="py-3 text-right font-extrabold" :class="act.co2 < 0 ? 'text-green-600' : 'text-amber-600'">
                  {{ act.co2 > 0 ? '+' : '' }}{{ act.co2.toFixed(1) }}
                </td>
              </tr>
              <tr v-if="recentDisplayActivities.length === 0">
                <td colspan="3" class="py-12 text-center text-gray-400">
                  ไม่พบรายการกิจกรรมล่าสุด
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Hidden Anchor for Scroll To -->
    <div id="audit-trail" class="mt-8"></div>
    </div>
    <template #fallback>
      <div class="flex flex-col items-center justify-center min-h-[60vh]">
        <Icon name="ph:circle-notch-bold" class="w-12 h-12 text-[#1b4332] animate-spin mb-4" />
        <p class="text-sm text-emerald-950 font-extrabold">กำลังโหลดข้อมูลแดชบอร์ดส่วนตัวของคุณ...</p>
      </div>
    </template>
  </ClientOnly>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'

// shared state with layout
const isOffline = useOffline()
const supabase = useSupabaseClient()
let realtimeChannel = null

// Interactive states
const bikeLogged = ref(false)
const offsetBought = ref(false)

const isToday = (dateStr) => {
  if (!dateStr) return false
  const d = new Date(dateStr)
  const today = new Date()
  return d.getDate() === today.getDate() &&
         d.getMonth() === today.getMonth() &&
         d.getFullYear() === today.getFullYear()
}

const logBikeActivity = async () => {
  if (loading.value || bikeLogged.value) return
  
  if (isOffline.value) {
    bikeLogged.value = true
    return
  }
  
  loading.value = true
  const newTx = {
    txn_id: 'tx-bike-' + Date.now(),
    user_id: selectedUserId.value,
    type: 'REDUCTION',
    category: 'Transport',
    amount: 0,
    date: new Date().toISOString(),
    note: 'ปั่นจักรยานไปทำงาน (ลดคาร์บอน 2.5kg)'
  }
  
  try {
    await $fetch(`${SUPABASE_URL}/rest/v1/transactions`, {
      method: 'POST',
      headers: {
        ...headers,
        'Prefer': 'return=representation'
      },
      body: newTx
    })
    
    const currentPoints = calculations.value.totalPoints
    await $fetch(`${SUPABASE_URL}/rest/v1/users?user_id=eq.${selectedUserId.value}`, {
      method: 'PATCH',
      headers,
      body: {
        loyalty_points: currentPoints + 100
      }
    })
    
    bikeLogged.value = true
  } catch (err) {
    console.error('Error saving bike activity:', err)
    alert('เกิดข้อผิดพลาดในการบันทึกกิจกรรม กรุณาลองใหม่อีกครั้ง')
  } finally {
    loading.value = false
  }
}

const buyOffset = async () => {
  if (loading.value || offsetBought.value) return
  
  if (isOffline.value) {
    offsetBought.value = true
    return
  }
  
  loading.value = true
  const newTx = {
    txn_id: 'tx-offset-' + Date.now(),
    user_id: selectedUserId.value,
    type: 'REDUCTION',
    category: 'Offset',
    amount: 0,
    date: new Date().toISOString(),
    note: 'ซื้อคาร์บอนเครดิตชดเชย (ลดคาร์บอน 200kg)'
  }
  
  try {
    await $fetch(`${SUPABASE_URL}/rest/v1/transactions`, {
      method: 'POST',
      headers: {
        ...headers,
        'Prefer': 'return=representation'
      },
      body: newTx
    })
    
    const currentPoints = calculations.value.totalPoints
    await $fetch(`${SUPABASE_URL}/rest/v1/users?user_id=eq.${selectedUserId.value}`, {
      method: 'PATCH',
      headers,
      body: {
        loyalty_points: currentPoints + 500
      }
    })
    
    offsetBought.value = true
  } catch (err) {
    console.error('Error saving offset activity:', err)
    alert('เกิดข้อผิดพลาดในการซื้อคาร์บอนเครดิตชดเชย กรุณาลองใหม่อีกครั้ง')
  } finally {
    loading.value = false
  }
}

// Supabase Connection Settings
const SUPABASE_URL = 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'
const headers = {
  apikey: SUPABASE_ANON_KEY,
  Authorization: `Bearer ${SUPABASE_ANON_KEY}`
}

// Database States
const usersList = ref([])
const selectedUserId = useState('selected_user_id', () => 'u001')
const selectedUser = ref(null)
const productsMap = ref({})
const loading = ref(false)
const error = ref(null)

// Selected user dynamic datasets
const flightTickets = ref([])
const foodOrders = ref([])
const ecommerceOrders = ref([])
const hotelBookings = ref([])
const transactions = ref([])

// Fetch all users on mount
const fetchUsers = async () => {
  try {
    const data = await $fetch(`${SUPABASE_URL}/rest/v1/users?select=*&order=name`, { headers })
    usersList.value = data || []
    isOffline.value = false
    // Cache users list
    if (typeof window !== 'undefined') {
      localStorage.setItem('offline_cache_users', JSON.stringify(usersList.value))
    }
  } catch (err) {
    console.error('Error fetching users:', err)
    isOffline.value = true
    // Fallback to cache
    if (typeof window !== 'undefined') {
      const cached = localStorage.getItem('offline_cache_users')
      if (cached) {
        usersList.value = JSON.parse(cached)
      } else {
        // Mock fallback if first run and offline
        usersList.value = [
          { user_id: 'u001', name: 'Somchai Jaidee' },
          { user_id: 'u002', name: 'Alice Green' },
          { user_id: 'u005', name: 'Wichai Nilsuwan' },
          { user_id: 'u003', name: 'Mana Dee' },
          { user_id: 'u004', name: 'Somsri Jai-ngam' }
        ]
      }
    }
  }
}

// Fetch products map
const fetchProducts = async () => {
  try {
    const data = await $fetch(`${SUPABASE_URL}/rest/v1/products?select=*`, { headers })
    const map = {}
    if (data) {
      data.forEach(p => {
        map[p.product_id] = p
      })
    }
    productsMap.value = map
    isOffline.value = false
    // Cache products
    if (typeof window !== 'undefined') {
      localStorage.setItem('offline_cache_products', JSON.stringify(productsMap.value))
    }
  } catch (err) {
    console.error('Error fetching products map:', err)
    isOffline.value = true
    if (typeof window !== 'undefined') {
      const cached = localStorage.getItem('offline_cache_products')
      if (cached) {
        productsMap.value = JSON.parse(cached)
      } else {
        // Fallback mock product map
        productsMap.value = {
          'p001': { product_id: 'p001', name: 'เสื้อผ้าแฟชั่นมือหนึ่ง', category: 'Fashion' },
          'p002': { product_id: 'p002', name: 'อุปกรณ์อิเล็กทรอนิกส์ทั่วไป', category: 'Electronics' },
          'p003': { product_id: 'p003', name: 'สมุดบันทึกจากกระดาษรีไซเคิล', category: 'Eco' }
        }
      }
    }
  }
}

// Fetch user data from database
const loadUserData = async () => {
  loading.value = true
  error.value = null
  bikeLogged.value = false
  offsetBought.value = false
  try {
    const [userRes, flightsRes, hotelsRes, ecommerceRes, foodRes, txsRes] = await Promise.all([
      $fetch(`${SUPABASE_URL}/rest/v1/users?user_id=eq.${selectedUserId.value}`, { headers }),
      $fetch(`${SUPABASE_URL}/rest/v1/flight_tickets?user_id=eq.${selectedUserId.value}&select=*,flights(*)`, { headers }),
      $fetch(`${SUPABASE_URL}/rest/v1/hotel_bookings?user_id=eq.${selectedUserId.value}&select=*,hotels(*)`, { headers }),
      $fetch(`${SUPABASE_URL}/rest/v1/ecommerce_orders?user_id=eq.${selectedUserId.value}&select=*`, { headers }),
      $fetch(`${SUPABASE_URL}/rest/v1/food_orders?user_id=eq.${selectedUserId.value}&select=*,restaurants(*)`, { headers }),
      $fetch(`${SUPABASE_URL}/rest/v1/transactions?user_id=eq.${selectedUserId.value}&select=*`, { headers })
    ])

    selectedUser.value = userRes[0] || null
    flightTickets.value = flightsRes || []
    hotelBookings.value = hotelsRes || []
    ecommerceOrders.value = ecommerceRes || []
    foodOrders.value = foodRes || []
    transactions.value = txsRes || []
    
    // Check if logged in database today
    bikeLogged.value = (txsRes || []).some(tx => tx.type === 'REDUCTION' && tx.note.includes('ปั่นจักรยาน') && isToday(tx.date))
    offsetBought.value = (txsRes || []).some(tx => tx.type === 'REDUCTION' && tx.note.includes('ชดเชย') && isToday(tx.date))

    isOffline.value = false
    
    // Cache user specific data
    if (typeof window !== 'undefined') {
      const cacheData = {
        selectedUser: selectedUser.value,
        flightTickets: flightTickets.value,
        hotelBookings: hotelBookings.value,
        ecommerceOrders: ecommerceOrders.value,
        foodOrders: foodOrders.value,
        transactions: transactions.value
      }
      localStorage.setItem(`offline_cache_user_data_${selectedUserId.value}`, JSON.stringify(cacheData))
    }
  } catch (err) {
    console.warn('Network error, loading cache for user:', selectedUserId.value, err)
    isOffline.value = true
    
    if (typeof window !== 'undefined') {
      const cached = localStorage.getItem(`offline_cache_user_data_${selectedUserId.value}`)
      if (cached) {
        try {
          const cacheData = JSON.parse(cached)
          selectedUser.value = cacheData.selectedUser
          flightTickets.value = cacheData.flightTickets
          hotelBookings.value = cacheData.hotelBookings
          ecommerceOrders.value = cacheData.ecommerceOrders
          foodOrders.value = cacheData.foodOrders
          transactions.value = cacheData.transactions
          bikeLogged.value = (cacheData.transactions || []).some(tx => tx.type === 'REDUCTION' && tx.note.includes('ปั่นจักรยาน') && isToday(tx.date))
          offsetBought.value = (cacheData.transactions || []).some(tx => tx.type === 'REDUCTION' && tx.note.includes('ชดเชย') && isToday(tx.date))
        } catch (e) {
          console.error('Failed to parse cached data:', e)
        }
      } else {
        // First-run offline fallback: Load beautiful simulated mockup dataset matching original screenshots
        if (selectedUserId.value === 'u001') {
          selectedUser.value = { name: 'Somchai Jaidee', user_id: 'u001', loyalty_points: 1240 }
          
          flightTickets.value = [
            { ticket_id: 'f1', flights: { origin: 'BKK', destination: 'CNX', airline: 'AirAsia', departure_time: '2026-06-14T10:00:00Z' }, status: 'COMPLETED' }
          ]
          hotelBookings.value = []
          ecommerceOrders.value = []
          foodOrders.value = []
          transactions.value = [
            { txn_id: 'tx1', type: 'EXPENSE', category: 'Transport', amount: 1370, note: 'ขับรถไปทำงาน', date: '2026-06-13T08:00:00Z' }, // 68.5 kg CO2
            { txn_id: 'tx2', type: 'EXPENSE', category: 'Shopping', amount: 5140, note: 'สั่งของออนไลน์', date: '2026-06-11T09:00:00Z' }, // 51.4 kg CO2
            { txn_id: 'tx3', type: 'EXPENSE', category: 'Food', amount: 2770, note: 'บุฟเฟต์ปิ้งย่าง', date: '2026-06-12T12:00:00Z' }  // 27.7 kg CO2
          ]
        } else if (selectedUserId.value === 'u002') {
          selectedUser.value = { name: 'Alice Green', user_id: 'u002', loyalty_points: 858 }
          flightTickets.value = []
          hotelBookings.value = []
          ecommerceOrders.value = []
          foodOrders.value = []
          transactions.value = []
        } else if (selectedUserId.value === 'u005') {
          selectedUser.value = { name: 'Wichai Nilsuwan', user_id: 'u005', loyalty_points: 2188 }
          flightTickets.value = []
          hotelBookings.value = []
          ecommerceOrders.value = []
          foodOrders.value = []
          transactions.value = []
        } else {
          selectedUser.value = { name: 'User', user_id: selectedUserId.value, loyalty_points: 500 }
          flightTickets.value = []
          hotelBookings.value = []
          ecommerceOrders.value = []
          foodOrders.value = []
          transactions.value = []
        }
      }
    }
  } finally {
    loading.value = false
  }
}

// 1. Dynamic Greeting Name mapping
const displayFirstName = computed(() => {
  if (!selectedUser.value) return 'ผู้ใช้งาน'
  const name = selectedUser.value.name || ''
  
  if (name.includes('Somchai')) return 'สมชาย'
  if (name.includes('Alice')) return 'อลิส'
  if (name.includes('Wichai')) return 'วิชัย'
  if (name.includes('Mana')) return 'มานะ'
  if (name.includes('Somsri')) return 'สมศรี'
  
  return name.split(' ')[0] || 'ผู้ใช้งาน'
})

// 2. Dynamic Carbon Saved calculation
const carbonSaved = computed(() => {
  let saved = 0.5 // Start with base recycling savings for online mode
  
  if (!isOffline.value) {
    transactions.value.forEach(tx => {
      if (tx.type === 'REDUCTION') {
        if (tx.note.includes('ปั่นจักรยาน')) {
          saved += 2.5
        } else if (tx.note.includes('ปลูกต้น')) {
          const match = tx.note.match(/ลดคาร์บอน\s*(\d+(\.\d+)?)\s*kg/)
          saved += match ? parseFloat(match[1]) : 15.0
        } else {
          saved += 200.0
        }
      }
    })
  } else {
    if (bikeLogged.value) saved += 2.5
    if (offsetBought.value) saved += 200.0
  }

  // Add savings from choosing low-emission options in online database
  foodOrders.value.forEach(order => {
    if (order.status !== 'CANCELLED') {
      const itemsList = order.menu_items || []
      const hasMeat = itemsList.some(item => {
        const lower = item.toLowerCase()
        return lower.includes('steak') || lower.includes('burger') || lower.includes('chicken') || 
               lower.includes('pizza') || lower.includes('sushi') || lower.includes('ramen') || 
               lower.includes('curry') || lower.includes('kung') || lower.includes('spaghetti') || 
               lower.includes('rice') || lower.includes('pad thai')
      })
      const isHealthyCuisine = order.restaurants?.cuisine === 'Healthy'
      const hasSaladOrSomTum = itemsList.some(item => {
        const lower = item.toLowerCase()
        return lower.includes('salad') || lower.includes('som tum')
      })
      const isLowEmission = (isHealthyCuisine || hasSaladOrSomTum) && !hasMeat
      if (isLowEmission) {
        saved += (8.0 - 1.2) // Saved 6.8 kg by choosing vegetarian/salad
      }
    }
  })

  ecommerceOrders.value.forEach(order => {
    if (order.status !== 'CANCELLED') {
      const itemsList = order.items || []
      itemsList.forEach(item => {
        const prod = productsMap.value[item.product_id]
        if (prod) {
          const qty = item.qty || 1
          const isHigh = prod.category === 'Fashion' || prod.category === 'Electronics'
          if (!isHigh) {
            saved += (15.0 - 1.5) * qty // Saved 13.5 kg per low emission/recycled item
          }
        }
      })
    }
  })

  return Math.round(saved * 10) / 10
})

// 3. Dynamic Carbon Database Calculations
const calculations = computed(() => {
  let co2Flight = 0
  let co2Travel = 0
  let co2Shopping = 0
  let co2Food = 0

  const list = []

  // FLIGHTS
  flightTickets.value.forEach(ticket => {
    if (ticket.status !== 'CANCELLED') {
      const co2 = 234.5
      co2Flight += co2
      list.push({
        id: ticket.ticket_id,
        date: ticket.flights?.departure_time || 'N/A',
        rawDate: ticket.flights?.departure_time || '',
        category: 'การบิน',
        title: `เที่ยวบิน ${ticket.flights?.origin || 'BKK'}-${ticket.flights?.destination || 'CNX'}`,
        desc: `${ticket.flights?.airline || 'สายการบิน'} ${ticket.seat ? `ที่นั่ง ${ticket.seat}` : ''}`,
        co2: co2,
        status: ticket.status,
        icon: 'ph:airplane-bold',
        bgClass: 'bg-red-50 text-red-600'
      })
    }
  })

  // HOTELS (Accommodation -> Travel)
  hotelBookings.value.forEach(booking => {
    if (booking.status !== 'CANCELLED') {
      const checkIn = new Date(booking.check_in)
      const checkOut = new Date(booking.check_out)
      const diffTime = Math.abs(checkOut - checkIn)
      const nights = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) || 1
      const co2 = nights * 12.0
      co2Travel += co2

      list.push({
        id: booking.booking_id,
        date: booking.check_in,
        rawDate: booking.check_in || '',
        category: 'การเดินทาง/ที่พัก',
        title: `จองโรงแรม ${booking.hotels?.name || 'โรงแรม'}`,
        desc: `${booking.hotels?.location || ''} (${nights} คืน)`,
        co2: co2,
        status: booking.status,
        icon: 'ph:bed-bold',
        bgClass: 'bg-blue-50 text-blue-600'
      })
    }
  })

  // ECOMMERCE
  ecommerceOrders.value.forEach(order => {
    if (order.status !== 'CANCELLED') {
      let orderCo2 = 0
      const itemsList = order.items || []
      const names = []

      itemsList.forEach(item => {
        const prod = productsMap.value[item.product_id]
        if (prod) {
          const qty = item.qty || 1
          const isHigh = prod.category === 'Fashion' || prod.category === 'Electronics'
          orderCo2 += (isHigh ? 15.0 : 1.5) * qty
          names.push(prod.name)
        } else {
          orderCo2 += 1.5 * (item.qty || 1)
        }
      })

      co2Shopping += orderCo2
      list.push({
        id: order.order_id,
        date: order.timestamp,
        rawDate: order.timestamp || '',
        category: 'ช้อปปิ้ง',
        title: `สั่งของออนไลน์`,
        desc: names.length > 0 ? names.join(', ') : 'ช้อปปิ้งสินค้าทั่วไป',
        co2: orderCo2,
        status: order.status,
        icon: 'ph:shopping-bag-bold',
        bgClass: 'bg-yellow-50 text-yellow-600'
      })
    }
  })

  // FOOD
  foodOrders.value.forEach(order => {
    if (order.status !== 'CANCELLED') {
      const itemsList = order.menu_items || []
      const hasMeat = itemsList.some(item => {
        const lower = item.toLowerCase()
        return lower.includes('steak') || lower.includes('burger') || lower.includes('chicken') || 
               lower.includes('pizza') || lower.includes('sushi') || lower.includes('ramen') || 
               lower.includes('curry') || lower.includes('kung') || lower.includes('spaghetti') || 
               lower.includes('rice') || lower.includes('pad thai')
      })
      const isHealthyCuisine = order.restaurants?.cuisine === 'Healthy'
      const hasSaladOrSomTum = itemsList.some(item => {
        const lower = item.toLowerCase()
        return lower.includes('salad') || lower.includes('som tum')
      })

      const isLowEmission = (isHealthyCuisine || hasSaladOrSomTum) && !hasMeat
      const co2 = isLowEmission ? 1.2 : 8.0
      co2Food += co2

      list.push({
        id: order.order_id,
        date: '2026-06-12T18:00:00Z',
        rawDate: '2026-06-12T18:00:00Z',
        category: 'อาหาร',
        title: `สั่งเดลิเวอรี่ร้าน ${order.restaurants?.name || 'ร้านอาหาร'}`,
        desc: itemsList.join(', '),
        co2: co2,
        status: order.status,
        icon: 'ph:fork-knife-bold',
        bgClass: 'bg-green-50 text-green-600'
      })
    }
  })

  // TRANSACTIONS
  transactions.value.forEach(tx => {
    if (tx.type === 'EXPENSE') {
      let txCo2 = 0
      let category = ''
      let icon = 'ph:credit-card-bold'
      let bgClass = 'bg-gray-50 text-gray-600'
      const amt = tx.amount || 0

      if (tx.category === 'Transport') {
        txCo2 = amt * 0.05
        co2Travel += txCo2
        category = 'การเดินทาง/ที่พัก'
        icon = 'ph:car-bold'
        bgClass = 'bg-blue-50 text-blue-600'
      } else if (tx.category === 'Food') {
        txCo2 = amt * 0.01
        co2Food += txCo2
        category = 'อาหาร'
        icon = 'ph:fork-knife-bold'
        bgClass = 'bg-green-50 text-green-600'
      } else if (tx.category === 'Shopping') {
        txCo2 = amt * 0.01
        co2Shopping += txCo2
        category = 'ช้อปปิ้ง'
        icon = 'ph:shopping-bag-bold'
        bgClass = 'bg-yellow-50 text-yellow-600'
      } else {
        txCo2 = amt * 0.005
        co2Shopping += txCo2
        category = 'ทั่วไป'
      }

      list.push({
        id: tx.txn_id,
        date: tx.date,
        rawDate: tx.date || '',
        category: category,
        title: `จ่ายเงินค่า${tx.note || tx.category}`,
        desc: `ธุรกรรมการเงิน ฿${amt.toLocaleString()}`,
        co2: txCo2,
        status: 'COMPLETED',
        icon: icon,
        bgClass: bgClass
      })
    } else if (tx.type === 'REDUCTION') {
      let co2 = 0
      let category = 'ชดเชยคาร์บอน'
      let icon = 'ph:leaf-bold'
      let bgClass = 'bg-green-50 text-green-600'
      const isBike = tx.note.includes('ปั่นจักรยาน')
      const isTree = tx.note.includes('ปลูกต้น')
      
      if (isBike) {
        co2 = -2.5
        co2Travel += co2
        category = 'การเดินทาง/ที่พัก'
        icon = 'ph:bicycle-bold'
      } else if (isTree) {
        const match = tx.note.match(/ลดคาร์บอน\s*(\d+(\.\d+)?)\s*kg/)
        co2 = match ? -parseFloat(match[1]) : -15.0
        co2Travel += co2
        category = 'ปลูกต้นไม้'
        icon = 'ph:tree-bold'
      } else {
        co2 = -200.0
        co2Flight += co2
        category = 'ชดเชยคาร์บอน'
        icon = 'ph:leaf-bold'
      }

      list.push({
        id: tx.txn_id,
        date: tx.date,
        rawDate: tx.date || '',
        category: category,
        title: isBike ? 'ปั่นจักรยานไปทำงาน' : (isTree ? tx.note.split(' (')[0] : 'ซื้อคาร์บอนเครดิตชดเชย'),
        desc: isBike ? 'แทนการขับรถยนต์ส่วนบุคคล (ลดคาร์บอน)' : (isTree ? 'โครงการฟื้นฟูป่าสิ่งแวดล้อม' : 'โครงการปลูกป่าชุมชนทดแทน'),
        co2: co2,
        status: 'COMPLETED',
        icon: icon,
        bgClass: bgClass
      })
    }
  })

  const totalCO2 = co2Flight + co2Travel + co2Shopping + co2Food
  const totalPoints = selectedUser.value ? selectedUser.value.loyalty_points : 500

  return {
    totalCO2,
    totalPoints,
    co2Flight,
    co2Travel,
    co2Shopping,
    co2Food,
    activities: list
  }
})

// 4. State calculations for either Offline (screenshot) or Online mode
const displayTotalCO2 = computed(() => {
  let amt = calculations.value.totalCO2
  
  if (isOffline.value) {
    if (bikeLogged.value) amt = Math.max(0, amt - 2.5)
    if (offsetBought.value) amt = Math.max(0, amt - 200.0)
  }
  
  return amt
})

const displayEcoPoints = computed(() => {
  let basePoints = calculations.value.totalPoints
  
  if (isOffline.value) {
    if (bikeLogged.value) basePoints += 100
    if (offsetBought.value) basePoints += 500
  }
  
  return basePoints
})

const ecoLevel = computed(() => {
  const pts = displayEcoPoints.value
  if (pts < 800) return 'ผู้เริ่มสะสมใบไม้ 🍃'
  if (pts < 1500) return 'มือใหม่รักษ์โลก 🌱'
  return 'ผู้พิทักษ์โลก 🌳'
})

// Highest Category details
const displayHighestCategory = computed(() => {
  let flight = calculations.value.co2Flight
  let travel = calculations.value.co2Travel
  let shop = calculations.value.co2Shopping
  let food = calculations.value.co2Food

  // subtract logged actions
  if (bikeLogged.value) travel = Math.max(0, travel - 2.5)
  if (offsetBought.value) flight = Math.max(0, flight - 200.0)

  const total = flight + travel + shop + food || 1
  const categories = [
    { name: 'การบิน', amount: flight },
    { name: 'การเดินทาง', amount: travel },
    { name: 'ช้อปปิ้ง', amount: shop },
    { name: 'อาหาร', amount: food }
  ]

  categories.sort((a, b) => b.amount - a.amount)
  const top = categories[0]
  const pct = Math.round((top.amount / total) * 100) || 0

  return {
    name: top.name,
    amount: top.amount,
    percentage: pct
  }
})

const highestCategoryIcon = computed(() => {
  const cat = displayHighestCategory.value.name
  if (cat === 'การบิน') return 'ph:airplane-tilt-bold'
  if (cat === 'การเดินทาง') return 'ph:car-bold'
  if (cat === 'ช้อปปิ้ง') return 'ph:shopping-bag-bold'
  return 'ph:fork-knife-bold'
})

const displayTargetRemaining = computed(() => {
  return Math.max(0, 400 - displayTotalCO2.value)
})

// Breakdown Data List
const displayBreakdown = computed(() => {
  let flight = calculations.value.co2Flight
  let travel = calculations.value.co2Travel
  let shop = calculations.value.co2Shopping
  let food = calculations.value.co2Food

  if (bikeLogged.value) travel = Math.max(0, travel - 2.5)
  if (offsetBought.value) flight = Math.max(0, flight - 200.0)

  const total = flight + travel + shop + food || 1

  return [
    { label: 'การบิน (Flights)', amount: flight, percentage: Math.round((flight / total) * 100) || 0, dotColor: 'bg-red-400' },
    { label: 'การเดินทาง (Travel)', amount: travel, percentage: Math.round((travel / total) * 100) || 0, dotColor: 'bg-blue-600' },
    { label: 'ช้อปปิ้ง (Shopping)', amount: shop, percentage: Math.round((shop / total) * 100) || 0, dotColor: 'bg-yellow-500' },
    { label: 'อาหาร (Food)', amount: food, percentage: Math.round((food / total) * 100) || 0, dotColor: 'bg-green-600' }
  ]
})

// CSS conic-gradient string
const conicGradientStyle = computed(() => {
  const flight = displayBreakdown.value[0].percentage
  const travel = displayBreakdown.value[1].percentage
  const shop = displayBreakdown.value[2].percentage
  
  const deg1 = flight
  const deg2 = deg1 + travel
  const deg3 = deg2 + shop

  return {
    background: `conic-gradient(
      #f87171 0% ${deg1}%,
      #1d4ed8 ${deg1}% ${deg2}%,
      #eab308 ${deg2}% ${deg3}%,
      #4ade80 ${deg3}% 100%
    )`
  }
})

// Recent activities displaying in table
const recentDisplayActivities = computed(() => {
  const list = []

  // Add offset/bike actions at the top only if offline
  if (isOffline.value) {
    if (offsetBought.value) {
      list.push({
        id: 'mock-offset',
        icon: 'ph:leaf-bold',
        bgClass: 'bg-green-50 text-green-700',
        title: 'ซื้อคาร์บอนเครดิตชดเชย',
        desc: 'โครงการปลูกป่าชุมชนทดแทน',
        date: 'วันนี้',
        rawDate: new Date().toISOString(),
        co2: -200.0
      })
    }

    if (bikeLogged.value) {
      list.push({
        id: 'mock-bike',
        icon: 'ph:bicycle-bold',
        bgClass: 'bg-green-50 text-green-700',
        title: 'ปั่นจักรยานไปทำงาน',
        desc: 'แทนการขับรถยนต์ส่วนบุคคล (ลดคาร์บอน)',
        date: 'วันนี้',
        rawDate: new Date().toISOString(),
        co2: -2.5
      })
    }
  }

  // Map database activities
  const mapped = calculations.value.activities.map(act => {
    // Formats date to simple format like '14 ต.ค. 24'
    let simpleDate = 'N/A'
    if (act.date && act.date !== 'N/A') {
      const d = new Date(act.date)
      simpleDate = d.toLocaleDateString('th-TH', {
        day: 'numeric',
        month: 'short',
        year: '2-digit'
      })
    }
    return {
      id: act.id,
      icon: act.icon,
      bgClass: act.bgClass,
      title: act.title,
      desc: act.desc,
      date: simpleDate,
      rawDate: act.rawDate || act.date || '',
      co2: act.co2
    }
  })
  
  // Combine list
  list.push(...mapped)

  // Sort activities by rawDate in descending order (newest first)
  list.sort((a, b) => {
    const da = new Date(a.rawDate || 0).getTime()
    const db = new Date(b.rawDate || 0).getTime()
    return db - da
  })

  // Take top 5
  return list.slice(0, 5)
})

// Scroll behavior to audit logs
const scrollToAudit = () => {
  const el = document.getElementById('audit-trail')
  if (el) {
    el.scrollIntoView({ behavior: 'smooth' })
  }
}

const subscribeRealtime = () => {
  if (typeof window === 'undefined') return
  
  if (realtimeChannel) {
    supabase.removeChannel(realtimeChannel)
  }

  realtimeChannel = supabase.channel(`dashboard-user-${selectedUserId.value}`)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'users', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'flight_tickets', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'hotel_bookings', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'ecommerce_orders', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'food_orders', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'planted_trees', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      loadUserData()
    })
    .subscribe()
}

onMounted(async () => {
  if (typeof window !== 'undefined') {
    const saved = localStorage.getItem('selected_user_id')
    if (saved) {
      selectedUserId.value = saved
    } else {
      navigateTo('/select-profile')
      return
    }
  }
  await Promise.all([
    fetchUsers(),
    fetchProducts()
  ])
  await loadUserData()
  subscribeRealtime()
})

onBeforeUnmount(() => {
  if (realtimeChannel) {
    supabase.removeChannel(realtimeChannel)
  }
})
</script>
