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
        <span>AI ใช้ข้อมูลการปล่อยคาร์บอนของ {{ displayFullName }} ในเดือนมิถุนายน เป็นบริบทในการตอบคำถาม</span>
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
import { ref, computed, nextTick, onMounted, watch, onBeforeUnmount } from 'vue'

const config = useRuntimeConfig()

// shared global states
const selectedUserId = useState('selected_user_id', () => 'u001')
const geminiApiKey = useState('gemini_api_key', () => config.public.geminiApiKey || '')
const isOffline = useOffline()
const supabase = useSupabaseClient()
let realtimeChannel = null

const inputMessage = ref('')
const typing = ref(false)
const messageBox = ref(null)
const loading = ref(false)

// Supabase details from runtime config (with fallback to default if not set in .env)
const SUPABASE_URL = config.public.supabaseUrl || 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
const SUPABASE_ANON_KEY = config.public.supabaseAnonKey || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'
const headers = {
  apikey: SUPABASE_ANON_KEY,
  Authorization: `Bearer ${SUPABASE_ANON_KEY}`
}

// Compute if engine is online or cloud
const isOnline = computed(() => true)

// User dynamic states
const selectedUser = ref(null)
const productsMap = ref({})
const flightTickets = ref([])
const foodOrders = ref([])
const ecommerceOrders = ref([])
const hotelBookings = ref([])
const transactions = ref([])

const displayFirstName = computed(() => {
  const uid = selectedUserId.value
  if (uid === 'u001') return 'สมชาย'
  if (uid === 'u002') return 'อลิส'
  if (uid === 'u005') return 'วิชัย'
  
  if (!selectedUser.value) return 'ผู้ใช้งาน'
  const name = selectedUser.value.name
  if (name === 'Somchai Jaidee') return 'สมชาย'
  if (name === 'Alice Smith' || name === 'Alice Green') return 'อลิส'
  if (name === 'Mana Dee') return 'มานะ'
  if (name === 'Somsri Jai-ngam') return 'สมศรี'
  return name.split(' ')[0]
})

const displayFullName = computed(() => {
  const uid = selectedUserId.value
  if (uid === 'u001') return 'Somchai Jaidee'
  if (uid === 'u002') return 'Alice Green'
  if (uid === 'u005') return 'Wichai Nilsuwan'
  
  if (selectedUser.value) return selectedUser.value.name
  return 'Somchai Jaidee'
})

// Quick prompts list
const quickPrompts = [
  'การซื้อของฉันสร้างคาร์บอนเท่าไหร่?',
  'อาหารชนิดไหนคาร์บอนต่ำสุด?',
  'สรุปรายงานเดือนนี้ให้หน่อย'
]

// Initial greeting generator
const initGreeting = () => {
  const name = displayFirstName.value
  messages.value = [
    {
      id: Date.now(),
      sender: 'ai',
      text: `สวัสดีครับคุณ🌲 ยินดีต้อนรับสู่ Eco AI Assistant ครับ! ผมพร้อมช่วยคุณวิเคราะห์ข้อมูลคาร์บอนฟุตพริ้นท์สะสม รวมถึงแนะนำแนวทางรักษ์โลกที่เหมาะกับไลฟ์สไตล์ของคุณ วันนี้อยากให้ผมช่วยในเรื่องไหนเป็นพิเศษไหมครับ?`
    }
  ]
}

const messages = ref([])

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
  initGreeting()
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

  // 0. Check connection status
  if (isOffline.value) {
    setTimeout(() => {
      typing.value = false
      messages.value.push({
        id: Date.now(),
        sender: 'ai',
        text: 'ขณะนี้ระบบอยู่ในโหมดออฟไลน์ ไม่สามารถส่งคำถามหา AI ได้ชั่วคราวครับ กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของท่าน 🌐'
      })
      scrollToBottom()
    }, 600)
    return
  }

  // 1. Check if Gemini API key is configured
  const apiKey = geminiApiKey.value || config.public.geminiApiKey
  if (!apiKey) {
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
    const total = isOnline.value ? calculations.value.totalCO2 : 342.8
    const flight = isOnline.value ? calculations.value.co2Flight : 195.2
    const travel = isOnline.value ? calculations.value.co2Travel : 68.5
    const shop = isOnline.value ? calculations.value.co2Shopping : 51.4
    const food = isOnline.value ? calculations.value.co2Food : 27.7
    const highest = isOnline.value ? calculations.value.highestCategory : 'การบิน'
    const pts = isOnline.value ? calculations.value.loyaltyPoints : 1240
    const level = pts < 1500 ? 'มือใหม่รักษ์โลก 🌱' : 'ผู้พิทักษ์โลก 🌳'

    // Format detailed Supabase records to supply as context for AI
    let databaseContext = ''
    if (isOnline.value) {
      databaseContext += `\n[ข้อมูลจริงประวัติกิจกรรมและการปล่อยคาร์บอนของผู้ใช้จาก Supabase Database]:\n`
      databaseContext += `- ชื่อผู้ใช้: ${selectedUser.value?.name || 'ไม่ระบุ'}\n`
      databaseContext += `- คะแนนสะสม: ${pts} คะแนน (${level})\n`

      // Flights details
      if (flightTickets.value.length > 0) {
        databaseContext += `- เที่ยวบินสะสม:\n`
        flightTickets.value.forEach(t => {
          if (t.status !== 'CANCELLED') {
            const flightDate = t.flights?.departure_time ? new Date(t.flights.departure_time).toLocaleDateString('th-TH') : 'ไม่ระบุ'
            databaseContext += `  • เที่ยวบิน ${t.flights?.origin || 'BKK'} ไป ${t.flights?.destination || 'CNX'} (${t.flights?.airline || ''}) วันที่ ${flightDate}, คาร์บอน: 234.5 kg CO2, สถานะ: ${t.status}\n`
          }
        })
      }

      // Hotels details
      if (hotelBookings.value.length > 0) {
        databaseContext += `- การพักโรงแรม/ที่พัก:\n`
        hotelBookings.value.forEach(b => {
          if (b.status !== 'CANCELLED') {
            const checkInDate = new Date(b.check_in).toLocaleDateString('th-TH')
            const nights = Math.ceil(Math.abs(new Date(b.check_out) - new Date(b.check_in)) / (1000 * 60 * 60 * 24)) || 1
            databaseContext += `  • โรงแรม ${b.hotels?.name || 'โรงแรม'} (${b.hotels?.location || ''}), เข้าพัก ${checkInDate} จำนวน ${nights} คืน, คาร์บอน: ${nights * 12.0} kg CO2, สถานะ: ${b.status}\n`
          }
        })
      }

      // Ecommerce details
      if (ecommerceOrders.value.length > 0) {
        databaseContext += `- การซื้อสินค้าออนไลน์ (E-commerce):\n`
        ecommerceOrders.value.forEach(o => {
          if (o.status !== 'CANCELLED') {
            const orderDate = new Date(o.timestamp).toLocaleDateString('th-TH')
            const items = o.items || []
            let itemDetails = []
            items.forEach(i => {
              const prod = productsMap.value[i.product_id]
              if (prod) {
                itemDetails.push(`${prod.name} (หมวดหมู่: ${prod.category}, จำนวน: ${i.qty})`)
              } else {
                itemDetails.push(`สินค้ารหัส ${i.product_id} (จำนวน: ${i.qty})`)
              }
            })
            databaseContext += `  • คำสั่งซื้อวันที่ ${orderDate}: ${itemDetails.join(', ')}, สถานะ: ${o.status}\n`
          }
        })
      }

      // Food details
      if (foodOrders.value.length > 0) {
        databaseContext += `- คำสั่งซื้ออาหารเดลิเวอรี:\n`
        foodOrders.value.forEach(o => {
          if (o.status !== 'CANCELLED') {
            const menuItems = o.menu_items || []
            databaseContext += `  • ร้าน ${o.restaurants?.name || 'ร้านอาหาร'} (${o.restaurants?.cuisine || ''}): เมนู [${menuItems.join(', ')}], ราคารวม: ฿${o.total_price || 0}, สถานะ: ${o.status}\n`
          }
        })
      }

      // Transactions details
      if (transactions.value.length > 0) {
        databaseContext += `- รายการธุรกรรมการเงิน:\n`
        transactions.value.forEach(tx => {
          const txDate = new Date(tx.date).toLocaleDateString('th-TH')
          databaseContext += `  • ประเภท: ${tx.type}, หมวดหมู่: ${tx.category}, ยอดเงิน: ฿${tx.amount.toLocaleString()}, โน้ต: ${tx.note || 'ไม่มี'}, วันที่: ${txDate}\n`
        })
      }
    } else {
      databaseContext += `\n(หมายเหตุ: ปัจจุบันเปิดโหมดออฟไลน์ ข้อมูลประวัติเที่ยวบิน/สินค้า เป็นข้อมูลเริ่มต้นจำลองคาร์บอนรวมสะสม 342.8 kg CO2)\n`
    }

    const systemPrompt = `คุณคือ Eco AI Assistant ผู้เชี่ยวชาญด้านคาร์บอนฟุตพริ้นท์และการอนุรักษ์สิ่งแวดล้อม
ข้อมูลและคาร์บอนฟุตพริ้นท์สะสมของผู้ใช้ปัจจุบัน (${name}):
- ปริมาณปล่อยคาร์บอนรวม: ${total} kg CO2
- คาร์บอนการบิน: ${flight} kg
- คาร์บอนการเดินทาง/ที่พัก: ${travel} kg
- คาร์บอนการช้อปปิ้ง: ${shop} kg
- คาร์บอนอาหาร: ${food} kg
- คะแนนสิ่งแวดล้อมสะสม: ${pts} pts (ระดับ: ${level})
- หมวดหมู่ที่ปล่อยคาร์บอนสูงที่สุด: ${highest}
${databaseContext}

กติกาในการตอบแชทเพื่อให้ดูเป็นธรรมชาติและเป็นกันเอง:
1. ตอบคำถามอย่างเป็นธรรมชาติ เป็นกันเอง มีความกระตือรือร้นและใส่ใจในสิ่งแวดล้อม
2. ใช้ภาษาไทยที่ลื่นไหลเป็นกันเอง (เช่น มีการทักทายอย่างอบอุ่น ใช้คำพูดเช่น "ผมดีใจมากเลยครับที่ได้คุยด้วย", "จากข้อมูลตรงนี้พบว่า...") หลีกเลี่ยงภาษาที่ดูแข็งทื่อเป็นหุ่นยนต์หรือแปลมาจากภาษาอังกฤษตรงตัว
3. อ้างอิงถึงข้อมูลดิบใน Supabase เมื่อมีคำถามที่เกี่ยวข้องโดยนำข้อมูลมาเล่าประกอบบทสนทนาอย่างกลมกลืน (ไม่จำเป็นต้องกางสถิติทุกอย่างออกมาเว้นแต่ผู้ใช้จะขอให้สรุปรายงาน)
4. หากพบกิจกรรมที่ลดคาร์บอนได้ดีหรือคะแนนสะสมสูง ให้กล่าวชื่นชมสนับสนุนเชิงบวก
5. แนะนำแนวทางลดคาร์บอนที่จับต้องได้และทำได้จริงเป็นข้อๆ อย่างเป็นมิตรและสร้างสรรค์`

    // 3. Request Gemini API (gemini-3.5-flash)
    const response = await $fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=${apiKey}`, {
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
    isOffline.value = false
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
      }
    }
  }
}

// Fetch user dynamic data
const fetchUserData = async () => {
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
    console.warn('Network error fetching user data context in assistant:', err)
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
        } catch (e) {
          console.error('Failed to parse cached data in assistant:', e)
        }
      } else {
        // Fallback mockup
        if (selectedUserId.value === 'u001') {
          selectedUser.value = { name: 'Somchai Jaidee', user_id: 'u001', loyalty_points: 1240 }
          flightTickets.value = [{ ticket_id: 'f1', flights: { origin: 'BKK', destination: 'CNX', airline: 'AirAsia' }, status: 'COMPLETED' }]
          transactions.value = [
            { txn_id: 'tx1', type: 'EXPENSE', category: 'Transport', amount: 1370 },
            { txn_id: 'tx2', type: 'EXPENSE', category: 'Shopping', amount: 5140 },
            { txn_id: 'tx3', type: 'EXPENSE', category: 'Food', amount: 2770 }
          ]
        } else if (selectedUserId.value === 'u002') {
          selectedUser.value = { name: 'Alice Green', user_id: 'u002', loyalty_points: 858 }
          flightTickets.value = []
          transactions.value = []
        } else if (selectedUserId.value === 'u005') {
          selectedUser.value = { name: 'Wichai Nilsuwan', user_id: 'u005', loyalty_points: 2188 }
          flightTickets.value = []
          transactions.value = []
        } else {
          selectedUser.value = { name: 'User', user_id: selectedUserId.value, loyalty_points: 500 }
          flightTickets.value = []
          transactions.value = []
        }
      }
    }
  } finally {
    loading.value = false
  }
}

const subscribeRealtime = () => {
  if (typeof window === 'undefined') return
  
  if (realtimeChannel) {
    supabase.removeChannel(realtimeChannel)
  }

  realtimeChannel = supabase.channel(`assistant-user-${selectedUserId.value}`)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'users', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'flight_tickets', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'hotel_bookings', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'ecommerce_orders', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'food_orders', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .on('postgres_changes', { event: '*', schema: 'public', table: 'transactions', filter: `user_id=eq.${selectedUserId.value}` }, () => {
      fetchUserData()
    })
    .subscribe()
}

// Watch for changes in user to trigger data reload and resubscribe
watch(selectedUserId, async () => {
  await fetchUserData()
  initGreeting()
  subscribeRealtime()
})

onMounted(async () => {
  if (typeof window !== 'undefined') {
    const saved = localStorage.getItem('selected_user_id')
    if (saved) {
      selectedUserId.value = saved
    } else {
      navigateTo('/select-profile')
      return
    }
    geminiApiKey.value = localStorage.getItem('gemini_api_key') || config.public.geminiApiKey || ''
  } else {
    geminiApiKey.value = config.public.geminiApiKey || ''
  }
  await fetchProducts()
  await fetchUserData()
  initGreeting()
  scrollToBottom()
  subscribeRealtime()
})

onBeforeUnmount(() => {
  if (realtimeChannel) {
    supabase.removeChannel(realtimeChannel)
  }
})
</script>
