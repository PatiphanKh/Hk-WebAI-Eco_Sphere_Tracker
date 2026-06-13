<template>
  <div class="max-w-5xl mx-auto flex flex-col h-[calc(90vh-90px)] bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden relative">
    
    <!-- Loading Overlay -->
    <div v-if="loading" class="absolute inset-0 bg-white/40 flex items-center justify-center backdrop-blur-[1px] z-20">
      <Icon name="ph:circle-notch-bold" class="w-8 h-8 text-[#1b4332] animate-spin" />
    </div>

    <!-- Chat Header -->
    <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center bg-white">
      <div class="flex items-center gap-3">
        <div class="bg-green-100 text-green-700 p-2 rounded-xl flex items-center justify-center">
          <Icon name="ph:robot-bold" class="w-5 h-5" />
        </div>
        <div>
          <h3 class="font-extrabold text-gray-900 text-base leading-tight">Eco AI Assistant</h3>
          <span class="text-xs text-green-600 font-bold flex items-center gap-1 mt-0.5">
            <span class="relative flex h-2 w-2">
              <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
              <span class="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
            </span>
            ออนไลน์
          </span>
        </div>
      </div>
      <button 
        @click="clearChat" 
        class="text-xs text-red-500 font-extrabold hover:text-red-700 transition"
      >
        ล้างประวัติแชท
      </button>
    </div>

    <!-- Dynamic Context Alert Banner -->
    <div class="px-6 pt-4 bg-white">
      <div class="bg-[#e8f5e9] text-xs text-green-800 py-2.5 px-4 rounded-xl flex items-center justify-center gap-2 border border-[#cbe5d4] font-semibold">
        <Icon name="ph:info-bold" class="w-4 h-4 text-green-700 flex-shrink-0" />
        <span>AI ใช้ข้อมูลการปล่อยคาร์บอนของ {{ selectedUser?.name || 'Somchai' }} ในเดือนมิถุนายน เป็นบริบทในการตอบคำถาม</span>
      </div>
    </div>

    <!-- Messages Container -->
    <div 
      ref="messageBox"
      class="flex-1 overflow-y-auto p-6 space-y-4 bg-white scroll-smooth"
    >
      <div 
        v-for="msg in messages" 
        :key="msg.id" 
        class="flex gap-3 max-w-2xl"
        :class="msg.sender === 'user' ? 'ml-auto justify-end' : ''"
      >
        <!-- AI Avatar -->
        <div 
          v-if="msg.sender === 'ai'" 
          class="w-8 h-8 rounded-full bg-green-100 text-green-700 flex items-center justify-center flex-shrink-0"
        >
          <Icon name="ph:robot-bold" class="w-4 h-4" />
        </div>

        <!-- Chat Bubble -->
        <div 
          class="p-4 rounded-2xl text-xs leading-relaxed font-semibold shadow-sm whitespace-pre-line"
          :class="msg.sender === 'user' 
            ? 'bg-[#1b4332] text-white rounded-tr-none' 
            : 'bg-[#e5f4ec] text-[#1b4332] rounded-tl-none'"
        >
          {{ msg.text }}
        </div>

        <!-- User Avatar -->
        <div 
          v-if="msg.sender === 'user'" 
          class="w-8 h-8 rounded-full bg-emerald-800 text-white flex items-center justify-center flex-shrink-0 font-bold"
        >
          {{ displayFirstName.substring(0, 1) }}
        </div>
      </div>

      <!-- Typing indicator -->
      <div v-if="typing" class="flex gap-3 max-w-xs">
        <div class="w-8 h-8 rounded-full bg-green-100 text-green-700 flex items-center justify-center flex-shrink-0">
          <Icon name="ph:robot-bold" class="w-4 h-4" />
        </div>
        <div class="bg-[#e5f4ec] p-4 rounded-2xl rounded-tl-none text-xs font-semibold flex items-center gap-1.5 shadow-sm">
          <span class="w-1.5 h-1.5 bg-green-700 rounded-full animate-bounce"></span>
          <span class="w-1.5 h-1.5 bg-green-700 rounded-full animate-bounce [animation-delay:0.2s]"></span>
          <span class="w-1.5 h-1.5 bg-green-700 rounded-full animate-bounce [animation-delay:0.4s]"></span>
        </div>
      </div>
    </div>

    <!-- Quick Suggestions Row -->
    <div class="px-6 py-2 bg-white flex flex-wrap gap-2.5">
      <button 
        v-for="prompt in quickPrompts" 
        :key="prompt"
        @click="sendQuickPrompt(prompt)"
        class="border border-green-700 text-green-700 hover:bg-green-50 px-4 py-1.5 rounded-full text-[11px] font-extrabold transition cursor-pointer"
        :disabled="typing"
      >
        {{ prompt }}
      </button>
    </div>

    <!-- Input Footer Area -->
    <div class="p-6 border-t border-gray-100 bg-white flex items-center gap-3">
      <div class="flex-grow flex items-center gap-2 bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 focus-within:ring-2 focus-within:ring-green-500 focus-within:bg-white transition">
        <!-- Mic Icon -->
        <button class="text-gray-400 hover:text-gray-600">
          <Icon name="ph:microphone-bold" class="w-5 h-5" />
        </button>
        <input 
          type="text" 
          v-model="inputMessage"
          placeholder="พิมพ์ข้อความที่นี่..." 
          class="bg-transparent flex-grow text-xs font-semibold text-gray-900 focus:outline-none placeholder:text-gray-400"
          @keyup.enter="sendCustomMessage"
          :disabled="typing"
        />
      </div>
      <button 
        @click="sendCustomMessage"
        class="bg-[#1b4332] hover:bg-[#133024] text-white p-3.5 rounded-xl font-bold transition flex items-center justify-center flex-shrink-0 shadow-sm"
        :disabled="typing || !inputMessage.trim()"
      >
        <Icon name="ph:paper-plane-right-fill" class="w-5 h-5" />
      </button>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, nextTick, onMounted } from 'vue'

const config = useRuntimeConfig()

// shared global states
const selectedUserId = useState('selected_user_id', () => 'u001')
const engineMode = useState('engine_mode', () => 'offline')
const geminiApiKey = useState('gemini_api_key', () => config.public.geminiApiKey || '')

const inputMessage = ref('')
const typing = ref(false)
const messageBox = ref(null)
const loading = ref(false)

// Supabase details
const SUPABASE_URL = 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'
const headers = {
  apikey: SUPABASE_ANON_KEY,
  Authorization: `Bearer ${SUPABASE_ANON_KEY}`
}

// User dynamic states
const selectedUser = ref(null)
const productsMap = ref({})
const flightTickets = ref([])
const foodOrders = ref([])
const ecommerceOrders = ref([])
const hotelBookings = ref([])
const transactions = ref([])

const displayFirstName = computed(() => {
  if (engineMode.value === 'offline') return 'Somchai'
  if (!selectedUser.value) return 'User'
  return selectedUser.value.name.split(' ')[0]
})

// Quick prompts list
const quickPrompts = [
  'การซื้อของฉันสร้างคาร์บอนเท่าไหร่?',
  'อาหารชนิดไหนคาร์บอนต่ำสุด?',
  'สรุปรายงานเดือนนี้ให้หน่อย'
]

// Default Message History
const defaultMessages = [
  {
    id: 1,
    sender: 'ai',
    text: 'สวัสดีครับ Somchai 👏 ผมคือ Eco AI Assistant จากข้อมูลเดือนมิถุนายน พบว่าการเดินทางของคุณมีการปล่อยคาร์บอนสูงขึ้นเล็กน้อย มีอะไรให้ผมช่วยแนะนำเพื่อลดคาร์บอนไหมครับ?'
  },
  {
    id: 2,
    sender: 'user',
    text: 'เดือนนี้ฉันบินไปเชียงใหม่ 2 รอบ อยากรู้ว่าต้องชดเชยคาร์บอนยังไง?'
  },
  {
    id: 3,
    sender: 'ai',
    text: `การบินไปเชียงใหม่ 2 รอบ (ไป-กลับ) สร้างคาร์บอนฟุตพริ้นท์ประมาณ 450 kg CO2e ครับ ✈️ คุณสามารถชดเชยได้โดย:
• บริจาคสนับสนุนโครงการปลูกป่า (ประมาณ 15 ต้น) 🌲
• เลือกซื้อคาร์บอนเครดิตผ่านแอปพลิเคชันพันธมิตรของเรา
• ปรับลดการบริโภคเนื้อแดงในสัปดาห์หน้า`
  }
]

const messages = ref([...defaultMessages])

// Auto scroll helper
const scrollToBottom = () => {
  nextTick(() => {
    if (messageBox.value) {
      messageBox.value.scrollTop = messageBox.value.scrollHeight
    }
  })
}

// Clear chat history
const clearChat = () => {
  messages.value = []
  scrollToBottom()
}

// Dynamic database calculations for chatbot
const calculations = computed(() => {
  let co2Flight = 0
  let co2Travel = 0
  let co2Shopping = 0
  let co2Food = 0

  flightTickets.value.forEach(t => {
    if (t.status !== 'CANCELLED') co2Flight += 234.5
  })
  hotelBookings.value.forEach(b => {
    if (b.status !== 'CANCELLED') {
      const nights = Math.ceil(Math.abs(new Date(b.check_out) - new Date(b.check_in)) / (1000 * 60 * 60 * 24)) || 1
      co2Travel += nights * 12.0
    }
  })
  ecommerceOrders.value.forEach(o => {
    if (o.status !== 'CANCELLED') {
      const items = o.items || []
      items.forEach(i => {
        const prod = productsMap.value[i.product_id]
        if (prod) {
          const isHigh = prod.category === 'Fashion' || prod.category === 'Electronics'
          co2Shopping += (isHigh ? 15.0 : 1.5) * (i.qty || 1)
        } else {
          co2Shopping += 1.5 * (i.qty || 1)
        }
      })
    }
  })
  foodOrders.value.forEach(o => {
    if (o.status !== 'CANCELLED') {
      const items = o.menu_items || []
      const hasMeat = items.some(item => {
        const lower = item.toLowerCase()
        return lower.includes('steak') || lower.includes('burger') || lower.includes('chicken') || 
               lower.includes('pizza') || lower.includes('sushi') || lower.includes('ramen') || 
               lower.includes('curry') || lower.includes('kung') || lower.includes('spaghetti') || 
               lower.includes('rice') || lower.includes('pad thai')
      })
      co2Food += hasMeat ? 8.0 : 1.2
    }
  })
  transactions.value.forEach(tx => {
    if (tx.type === 'EXPENSE') {
      const amt = tx.amount || 0
      if (tx.category === 'Transport') co2Travel += amt * 0.05
      else if (tx.category === 'Food') co2Food += amt * 0.01
      else if (tx.category === 'Shopping') co2Shopping += amt * 0.01
    }
  })

  const total = co2Flight + co2Travel + co2Shopping + co2Food
  const categories = [
    { name: 'การบิน', amount: co2Flight },
    { name: 'การเดินทาง', amount: co2Travel },
    { name: 'ช้อปปิ้ง', amount: co2Shopping },
    { name: 'อาหาร', amount: co2Food }
  ]
  categories.sort((a, b) => b.amount - a.amount)

  return {
    totalCO2: Math.round(total * 10) / 10,
    co2Flight: Math.round(co2Flight * 10) / 10,
    co2Travel: Math.round(co2Travel * 10) / 10,
    co2Shopping: Math.round(co2Shopping * 10) / 10,
    co2Food: Math.round(co2Food * 10) / 10,
    highestCategory: categories[0].name,
    loyaltyPoints: selectedUser.value?.loyalty_points || 500
  }
})

// Trigger Response Engine
const sendQuickPrompt = (promptText) => {
  messages.value.push({
    id: Date.now(),
    sender: 'user',
    text: promptText
  })
  scrollToBottom()
  generateAIResponse(promptText)
}

const sendCustomMessage = () => {
  const text = inputMessage.value.trim()
  if (!text) return
  messages.value.push({
    id: Date.now(),
    sender: 'user',
    text: text
  })
  inputMessage.value = ''
  scrollToBottom()
  generateAIResponse(text)
}

// REST request to Gemini API
const generateAIResponse = async (userText) => {
  typing.value = true
  scrollToBottom()

  // 1. Check if Gemini API key is configured
  if (!geminiApiKey.value) {
    setTimeout(() => {
      typing.value = false
      messages.value.push({
        id: Date.now(),
        sender: 'ai',
        text: 'กรุณาระบุคีย์ Gemini API Key ในไฟล์ .env ของโครงการ (ตัวแปร GEMINI_API_KEY) เพื่อเริ่มต้นประมวลผลคำตอบด้วย AI แบบเรียลไทม์ครับ ⚙️'
      })
      scrollToBottom()
    }, 800)
    return
  }

  try {
    // 2. Prepare system context prompt with active user metrics
    const name = displayFirstName.value
    const total = engineMode.value === 'online' ? calculations.value.totalCO2 : 342.8
    const flight = engineMode.value === 'online' ? calculations.value.co2Flight : 195.2
    const travel = engineMode.value === 'online' ? calculations.value.co2Travel : 68.5
    const shop = engineMode.value === 'online' ? calculations.value.co2Shopping : 51.4
    const food = engineMode.value === 'online' ? calculations.value.co2Food : 27.7
    const highest = engineMode.value === 'online' ? calculations.value.highestCategory : 'การบิน'
    const pts = engineMode.value === 'online' ? calculations.value.loyaltyPoints : 1240
    const level = pts < 1500 ? 'มือใหม่รักษ์โลก 🌱' : 'ผู้พิทักษ์โลก 🌳'

    const systemPrompt = `คุณคือ Eco AI Assistant ผู้เชี่ยวชาญด้านคาร์บอนฟุตพริ้นท์และการอนุรักษ์สิ่งแวดล้อม
ข้อมูลและคาร์บอนฟุตพริ้นท์สะสมของผู้ใช้ปัจจุบัน (${name}):
- ปริมาณปล่อยคาร์บอนรวม: ${total} kg CO2
- คาร์บอนการบิน: ${flight} kg
- คาร์บอนการเดินทาง/ที่พัก: ${travel} kg
- คาร์บอนการช้อปปิ้ง: ${shop} kg
- คาร์บอนอาหาร: ${food} kg
- คะแนนสิ่งแวดล้อมสะสม: ${pts} pts (ระดับ: ${level})
- หมวดหมู่ที่ปล่อยคาร์บอนสูงที่สุด: ${highest}

กติกาในการตอบแชท:
1. กรุณาตอบคำถามเป็นภาษาไทย ด้วยน้ำเสียงสุภาพ เป็นมิตร และสร้างแรงบันดาลใจในการรักษาสิ่งแวดล้อม
2. อ้างอิงตัวเลขคาร์บอนและหมวดหมู่ต่างๆ ของผู้ใช้นี้เสมอเพื่อให้การวิเคราะห์ตรงกับผู้ใช้
3. เสนอวิธีลดคาร์บอนฟุตพริ้นท์ที่ทำได้จริง เช่น ปั่นจักรยาน (ลด 2.5kg CO2), ทานอาหารมังสวิรัติ (ลด 6.8kg CO2), เลือกสินค้าประเภทรีไซเคิล หรือลดไฟล์ตบิน`

    // 3. Request Gemini API (gemini-1.5-flash)
    const response = await $fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${geminiApiKey.value}`, {
      method: 'POST',
      body: {
        contents: [
          {
            role: 'user',
            parts: [{ text: `${systemPrompt}\n\nคำถามจากผู้ใช้: ${userText}` }]
          }
        ]
      }
    })

    typing.value = false
    const textReply = response?.candidates?.[0]?.content?.parts?.[0]?.text
    if (textReply) {
      messages.value.push({
        id: Date.now(),
        sender: 'ai',
        text: textReply
      })
    } else {
      throw new Error('No text generated')
    }
  } catch (err) {
    console.error('Error generating Gemini response:', err)
    typing.value = false
    messages.value.push({
      id: Date.now(),
      sender: 'ai',
      text: 'ขออภัยครับ เกิดข้อผิดพลาดในการเชื่อมต่อกับ Gemini API หรือ คีย์ API ของคุณไม่ถูกต้อง กรุณาตรวจสอบหรือเปลี่ยนคีย์ในหน้า Settings อีกครั้งครับ'
    })
  } finally {
    scrollToBottom()
  }
}

// Fetch products map from Supabase
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
  } catch (err) {
    console.error('Error fetching products map:', err)
  }
}

// Fetch user dynamic data
const fetchUserData = async () => {
  if (engineMode.value !== 'online') return
  loading.value = true
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
  } catch (err) {
    console.error('Error fetching Supabase database context:', err)
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  geminiApiKey.value = config.public.geminiApiKey || ''
  await fetchProducts()
  if (engineMode.value === 'online') {
    await fetchUserData()
  }
  scrollToBottom()
})
</script>
