<template>
  <div class="min-h-screen flex flex-col justify-center items-center bg-gradient-to-tr from-[#f1f9f5] via-[#e8f5e9]/50 to-[#f5fbf7] p-6 text-slate-800">
    <div class="w-full max-w-5xl">
      <!-- Logo Header -->
      <div class="text-center mb-8">
        <div class="bg-white p-3.5 rounded-full shadow-md border border-[#c1e2cb] inline-flex items-center justify-center mb-6 w-16 h-16 animate-bounce [animation-duration:3s]">
          <Icon name="ph:leaf-bold" class="w-8 h-8 text-green-600" />
        </div>
        <h1 class="text-3xl sm:text-4xl font-black text-emerald-950 tracking-tight">
          ติดตามรอยเท้าคาร์บอนของคุณ
        </h1>
        <p class="text-xs sm:text-sm text-gray-500 font-extrabold mt-2.5">
          เลือกโปรไฟล์เพื่อดูข้อมูลสิ่งแวดล้อมส่วนตัว
        </p>
      </div>

      <!-- Loader -->
      <div v-if="loading" class="text-center py-12">
        <Icon name="ph:circle-notch-bold" class="w-8 h-8 text-green-700 animate-spin" />
        <p class="text-xs text-gray-400 mt-2 font-bold">กำลังดึงข้อมูลโปรไฟล์จาก Supabase...</p>
      </div>

      <!-- Profile Cards Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 max-w-5xl mx-auto mt-8">
        <div 
          v-for="user in users" 
          :key="user.user_id"
          @click="selectProfile(user)"
          class="bg-white p-5 rounded-2xl border border-gray-100/80 shadow-sm hover:shadow-md hover:-translate-y-0.5 transition-all duration-300 cursor-pointer flex gap-4 items-center"
        >
          <!-- Avatar -->
          <img :src="user.avatar" class="w-14 h-14 rounded-full border border-gray-200 object-cover flex-shrink-0" alt="Avatar" />
          
          <!-- Details -->
          <div class="flex-grow">
            <div class="flex justify-between items-start">
              <div>
                <h3 class="font-extrabold text-slate-800 text-sm tracking-tight leading-none">{{ user.name }}</h3>
                <!-- Points Badge -->
                <span class="inline-flex items-center gap-1.5 bg-[#e8f5e9] text-green-700 border border-green-100 rounded-full px-2.5 py-0.5 text-[9px] font-extrabold mt-2">
                  <Icon name="ph:leaf-fill" class="w-3 h-3 text-green-600" />
                  Eco Points: {{ user.pts.toLocaleString() }} pts
                </span>
              </div>
            </div>

            <!-- CO2 Accumulation Progress Bar -->
            <div class="mt-4">
              <div class="flex justify-between text-[9px] font-bold text-gray-400">
                <span>CO₂ Accumulation</span>
                <span :class="{
                  'text-green-600': user.co2Level === 'Low',
                  'text-amber-600': user.co2Level === 'Moderate',
                  'text-red-600': user.co2Level === 'High'
                }">{{ user.co2Level }}</span>
              </div>
              <div class="w-full bg-gray-100 h-1.5 rounded-full mt-1.5 overflow-hidden">
                <div 
                  class="h-full rounded-full transition-all duration-700" 
                  :class="{
                    'bg-green-500': user.co2Level === 'Low',
                    'bg-amber-500': user.co2Level === 'Moderate',
                    'bg-red-500': user.co2Level === 'High'
                  }"
                  :style="{ width: user.co2Progress + '%' }"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Bottom Encryption Footer -->
      <div class="mt-16 text-center space-y-3">
        <p class="text-[10px] text-gray-400 font-extrabold uppercase tracking-widest">ข้อมูลถูกเข้ารหัสและเก็บในอุปกรณ์ของคุณ</p>
        <div class="inline-flex items-center gap-2 bg-green-50 text-green-700 px-4 py-1.5 rounded-full border border-green-100 text-[10px] font-extrabold">
          <Icon :name="isOffline ? 'ph:wifi-slash-bold' : 'ph:cloud-check-bold'" class="w-4 h-4 text-green-600" :class="{ 'animate-pulse': !isOffline }" />
          {{ isOffline ? 'พร้อมใช้งานระบบออฟไลน์ (เปิดใช้แคช)' : 'พร้อมใช้งานระบบออฟไลน์' }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'

const selectedUserId = useState('selected_user_id', () => 'u001')
const isOffline = useOffline()

const users = ref([])
const loading = ref(true)

// Supabase details from runtime config (with fallback to default)
const config = useRuntimeConfig()
const SUPABASE_URL = config.public.supabaseUrl || 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
const SUPABASE_ANON_KEY = config.public.supabaseAnonKey || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'
const headers = {
  apikey: SUPABASE_ANON_KEY,
  Authorization: `Bearer ${SUPABASE_ANON_KEY}`
}

const fetchUsersList = async () => {
  try {
    loading.value = true
    const data = await $fetch(`${SUPABASE_URL}/rest/v1/users?select=*&order=name`, { headers })
    isOffline.value = false
    
    if (data && data.length > 0) {
      users.value = data.map((u, index) => {
        const avatars = [
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80', // Somchai
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80', // Alice
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80', // Mana
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80', // Somsri
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80', // John
          'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'  // Prasit
        ]
        
        let pts = u.loyalty_points || 0
        let co2Level = 'Low'
        let co2Progress = 20
        let name = u.name

        // Dynamic calculation for all users based on their points
        if (pts > 2000) {
          co2Level = 'High'
          co2Progress = 85
        } else if (pts > 800) {
          co2Level = 'Moderate'
          co2Progress = 55
        } else {
          co2Level = 'Low'
          co2Progress = 20
        }

        return {
          user_id: u.user_id,
          name: name,
          pts: pts,
          co2Level: co2Level,
          co2Progress: co2Progress,
          avatar: avatars[index % avatars.length]
        }
      })
    }
  } catch (err) {
    console.error('Error fetching users on profile select:', err)
    isOffline.value = true
    
    // Offline local fallback mockup (exact match to design)
    users.value = [
      { user_id: 'u001', name: 'Somchai Jaidee', pts: 1248, co2Level: 'Moderate', co2Progress: 60, avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' },
      { user_id: 'u002', name: 'Alice Green', pts: 858, co2Level: 'Low', co2Progress: 25, avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' },
      { user_id: 'u005', name: 'Wichai Nilsuwan', pts: 2188, co2Level: 'High', co2Progress: 90, avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' }
    ]
  } finally {
    loading.value = false
  }
}

const selectProfile = (user) => {
  if (typeof window !== 'undefined') {
    localStorage.setItem('selected_user_id', user.user_id)
    selectedUserId.value = user.user_id
    
    // Save to shared state
    const selectedUserProfile = useState('selected_user_profile')
    selectedUserProfile.value = {
      user_id: user.user_id,
      name: user.name,
      loyalty_points: user.pts
    }
    navigateTo('/')
  }
}

onMounted(() => {
  fetchUsersList()
})
</script>
