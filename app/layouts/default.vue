<template>
  <div v-if="route.path === '/select-profile'" class="min-h-screen bg-gradient-to-tr from-[#f1f9f5] via-[#e8f5e9]/50 to-[#f5fbf7]">
    <slot />
  </div>
  <div v-else class="min-h-screen flex flex-col lg:flex-row bg-[#f1f9f5] font-sans text-gray-900">
    <!-- Mobile Top Header Bar -->
    <header class="flex lg:hidden items-center justify-between bg-[#e5f4ec] border-b border-[#d2ebd9] px-6 py-4 sticky top-0 z-30 shadow-sm w-full">
      <!-- Clickable Logo -->
      <NuxtLink to="/" class="flex items-center gap-3 cursor-pointer group">
        <div class="bg-white p-2 rounded-xl shadow-sm border border-[#c1e2cb] flex items-center justify-center group-hover:scale-105 transition-transform duration-200">
          <Icon name="ph:leaf-bold" class="w-5 h-5 text-green-600" />
        </div>
        <div>
          <h1 class="text-base font-extrabold text-emerald-950 leading-tight">Eco-Sphere</h1>
          <p class="text-[10px] text-green-700/90 font-bold tracking-tight">Carbon Tracker Active</p>
        </div>
      </NuxtLink>
      <!-- Hamburger Button -->
      <button 
        @click="isSidebarOpen = true"
        class="p-2 bg-white rounded-xl border border-[#c1e2cb] hover:bg-green-50 transition duration-200 text-emerald-950 hover:text-green-800 flex items-center justify-center shadow-sm"
      >
        <Icon name="ph:list-bold" class="w-6 h-6" />
      </button>
    </header>

    <!-- Desktop Sidebar (Hidden on mobile/tablet) -->
    <aside class="hidden lg:flex w-64 bg-[#e5f4ec] p-6 flex-col border-r border-[#d2ebd9] flex-shrink-0 relative z-30 shadow-sm">
      <!-- Clickable Logo -->
      <NuxtLink to="/" class="mb-10 flex items-center gap-3 cursor-pointer group">
        <div class="bg-white p-2 rounded-xl shadow-sm border border-[#c1e2cb] flex items-center justify-center group-hover:scale-105 transition-transform duration-200">
          <Icon name="ph:leaf-bold" class="w-6 h-6 text-green-600" />
        </div>
        <div>
          <h1 class="text-lg font-extrabold text-emerald-950 leading-tight group-hover:text-green-800 transition-colors duration-200">Eco-Sphere</h1>
          <p class="text-xs text-green-700/90 font-bold tracking-tight">Carbon Tracker Active</p>
        </div>
      </NuxtLink>

      <ClientOnly>
        <!-- User Profile Card -->
        <div class="mb-6 bg-white p-3 rounded-2xl border border-[#cbe5d4] flex items-center gap-3 shadow-sm">
          <div class="w-10 h-10 rounded-full bg-gradient-to-br from-green-100 to-emerald-200 border border-green-200 flex items-center justify-center flex-shrink-0">
            <Icon name="ph:user-bold" class="w-5 h-5 text-green-700" />
          </div>
          <div class="min-w-0">
            <p class="text-xs font-black text-emerald-950 truncate">{{ currentUser.name }}</p>
            <span class="inline-flex items-center gap-1 text-[9px] font-bold text-green-700 bg-green-50 px-1.5 py-0.5 rounded-full mt-0.5 border border-green-100">
              <span class="relative flex h-1.5 w-1.5">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-green-500"></span>
              </span>
              Active
            </span>
          </div>
        </div>
      </ClientOnly>

      <!-- Navigation Links -->
      <nav class="flex-grow space-y-1">
        <NuxtLink 
          to="/" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:squares-four-bold" class="w-5 h-5" />
          Dashboard
        </NuxtLink>
        <NuxtLink 
          to="/ai-assistant" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/ai-assistant' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:chat-text-bold" class="w-5 h-5" />
          AI Assistant
        </NuxtLink>
        <NuxtLink 
          to="/air-quality" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/air-quality' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:wind-bold" class="w-5 h-5" />
          Air Quality
        </NuxtLink>
        <NuxtLink 
          to="/water-health" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/water-health' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:drop-bold" class="w-5 h-5" />
          Water Health
        </NuxtLink>
        <NuxtLink 
          to="/flora-analysis" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/flora-analysis' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:tree-bold" class="w-5 h-5" />
          Flora Analysis
        </NuxtLink>
      </nav>

      <!-- Bottom Navigation Items -->
      <div class="border-t border-[#d2ebd9] pt-6 space-y-1">
        <NuxtLink 
          to="/settings" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/settings' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:gear-bold" class="w-5 h-5" />
          Settings
        </NuxtLink>
        <NuxtLink 
          to="/support" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/support' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:question-bold" class="w-5 h-5" />
          Support
        </NuxtLink>
        <NuxtLink 
          to="/select-profile" 
          class="flex items-center gap-3 px-4 py-3 rounded-xl transition text-sm font-semibold cursor-pointer"
          :class="route.path === '/select-profile' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
        >
          <Icon name="ph:user-switch-bold" class="w-5 h-5" />
          สลับโปรไฟล์
        </NuxtLink>

        <!-- Export Report Button -->
        <button 
          @click="handleExport"
          class="w-full bg-[#1b4332] hover:bg-[#133024] text-white py-3 px-4 rounded-xl font-bold text-sm shadow-sm transition flex items-center justify-center gap-2 mt-4 cursor-pointer"
        >
          <Icon name="ph:download-bold" class="w-4 h-4" />
          Export Report
        </button>
      </div>
    </aside>

    <!-- Mobile Sidebar Drawer (Slide-out) -->
    <Teleport to="body">
      <div v-if="isSidebarOpen" class="fixed inset-0 z-[9990] lg:hidden flex">
        <!-- Backdrop Overlay -->
        <div 
          class="fixed inset-0 bg-black/40 backdrop-blur-xs transition-opacity duration-300"
          @click="isSidebarOpen = false"
        ></div>

        <!-- Drawer Content -->
        <aside class="relative w-64 bg-[#e5f4ec] p-6 flex flex-col border-r border-[#d2ebd9] h-full z-[9991] shadow-2xl transition-transform duration-300 transform translate-x-0">
          <!-- Close Drawer Button -->
          <button 
            @click="isSidebarOpen = false"
            class="absolute top-5 right-5 p-1.5 bg-white rounded-lg border border-[#d2ebd9] hover:bg-rose-50 text-gray-500 hover:text-rose-600 transition flex items-center justify-center shadow-sm cursor-pointer"
          >
            <Icon name="ph:x-bold" class="w-4 h-4" />
          </button>

          <!-- Logo -->
          <NuxtLink to="/" class="mb-8 flex items-center gap-3 cursor-pointer group">
            <div class="bg-white p-2 rounded-xl shadow-sm border border-[#c1e2cb] flex items-center justify-center">
              <Icon name="ph:leaf-bold" class="w-5 h-5 text-green-600" />
            </div>
            <div>
              <h1 class="text-base font-extrabold text-emerald-950 leading-tight">Eco-Sphere</h1>
              <p class="text-[10px] text-green-700/90 font-bold tracking-tight">Carbon Tracker</p>
            </div>
          </NuxtLink>

          <ClientOnly>
            <!-- User Profile Card -->
            <div class="mb-6 bg-white p-3 rounded-2xl border border-[#cbe5d4] flex items-center gap-3 shadow-sm">
              <div class="w-9 h-9 rounded-full bg-gradient-to-br from-green-100 to-emerald-200 border border-green-200 flex items-center justify-center flex-shrink-0">
                <Icon name="ph:user-bold" class="w-4 h-4 text-green-700" />
              </div>
              <div class="min-w-0">
                <p class="text-xs font-black text-emerald-950 truncate">{{ currentUser.name }}</p>
                <span class="inline-flex items-center gap-1 text-[8px] font-bold text-green-700 bg-green-50 px-1.5 py-0.5 rounded-full mt-0.5 border border-green-100">
                  Active
                </span>
              </div>
            </div>
          </ClientOnly>

          <!-- Navigation Links -->
          <nav class="flex-grow space-y-1 overflow-y-auto">
            <NuxtLink 
              to="/" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:squares-four-bold" class="w-4 h-4" />
              Dashboard
            </NuxtLink>
            <NuxtLink 
              to="/ai-assistant" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/ai-assistant' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:chat-text-bold" class="w-4 h-4" />
              AI Assistant
            </NuxtLink>
            <NuxtLink 
              to="/air-quality" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/air-quality' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:wind-bold" class="w-4 h-4" />
              Air Quality
            </NuxtLink>
            <NuxtLink 
              to="/water-health" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/water-health' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:drop-bold" class="w-4 h-4" />
              Water Health
            </NuxtLink>
            <NuxtLink 
              to="/flora-analysis" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/flora-analysis' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:tree-bold" class="w-4 h-4" />
              Flora Analysis
            </NuxtLink>
          </nav>

          <!-- Bottom Navigation Items -->
          <div class="border-t border-[#d2ebd9] pt-4 space-y-1">
            <NuxtLink 
              to="/settings" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/settings' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:gear-bold" class="w-4 h-4" />
              Settings
            </NuxtLink>
            <NuxtLink 
              to="/support" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/support' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:question-bold" class="w-4 h-4" />
              Support
            </NuxtLink>
            <NuxtLink 
              to="/select-profile" 
              class="flex items-center gap-3 px-4 py-2.5 rounded-xl transition text-xs font-semibold cursor-pointer"
              :class="route.path === '/select-profile' ? 'bg-[#7fe4a9] text-[#1b4332]' : 'text-gray-600 hover:bg-[#d5ecdcf2] hover:text-gray-900'"
            >
              <Icon name="ph:user-switch-bold" class="w-4 h-4" />
              สลับโปรไฟล์
            </NuxtLink>

            <!-- Export Report Button -->
            <button 
              @click="handleExport"
              class="w-full bg-[#1b4332] hover:bg-[#133024] text-white py-2.5 px-4 rounded-xl font-bold text-xs shadow-sm transition flex items-center justify-center gap-2 mt-4 cursor-pointer"
            >
              <Icon name="ph:download-bold" class="w-4 h-4" />
              Export Report
            </button>
          </div>
        </aside>
      </div>
    </Teleport>

    <!-- Main Content Area -->
    <div class="flex-1 flex flex-col min-w-0">
      <!-- Warning Banner -->
      <div v-if="isOffline" class="bg-amber-50 text-amber-800 py-2.5 px-4 text-center text-xs font-bold flex items-center justify-center gap-2 border-b border-amber-200 w-full">
        <Icon name="ph:wifi-slash-bold" class="w-4 h-4 text-amber-700 animate-pulse" />
        คุณกำลังใช้งานแบบออฟไลน์ — แสดงข้อมูลล่าสุดจากแคชบนเครื่อง
      </div>
      
      <!-- Content Container (Responsive padding) -->
      <div class="p-4 sm:p-6 lg:p-8 overflow-y-auto flex-1">
        <slot />
      </div>
    </div>
  </div>

  <!-- Global Navigation Toast Container -->
  <Teleport to="body">
    <div class="fixed top-5 right-5 z-[9998] flex flex-col gap-3 pointer-events-none" style="max-width: 340px; width: 100%;">
      <TransitionGroup name="nav-toast">
        <div
          v-for="toast in navToasts"
          :key="toast.id"
          class="pointer-events-auto w-full rounded-2xl shadow-lg border flex gap-3 p-3.5 relative overflow-hidden"
          :class="{
            'bg-white/95 border-emerald-100 backdrop-blur-md': true
          }"
          style="backdrop-filter: blur(12px);"
        >
          <!-- Colored accent bar -->
          <div class="absolute left-0 top-0 bottom-0 w-1 rounded-l-2xl" :style="{ background: toast.accent }"></div>

          <!-- Icon -->
          <div
            class="w-8 h-8 rounded-xl flex items-center justify-center flex-shrink-0 ml-1"
            :style="{ background: toast.accent + '22', color: toast.accent }"
          >
            <Icon :name="toast.icon" class="w-4 h-4" />
          </div>

          <!-- Content -->
          <div class="flex-1 min-w-0">
            <p class="text-[11px] font-black text-gray-800 leading-tight">{{ toast.title }}</p>
            <p class="text-[10px] text-gray-500 font-medium mt-0.5 leading-relaxed">{{ toast.message }}</p>
            <!-- User badge -->
            <div class="flex items-center gap-1 mt-1.5">
              <span class="w-1.5 h-1.5 rounded-full bg-green-400 animate-pulse"></span>
              <span class="text-[9px] font-bold text-green-700">{{ currentUser.name }}</span>
            </div>
          </div>

          <!-- Close -->
          <button @click="removeNavToast(toast.id)" class="flex-shrink-0 text-gray-300 hover:text-gray-500 transition self-start mt-0.5">
            <Icon name="ph:x-bold" class="w-3 h-3" />
          </button>

          <!-- Timer bar -->
          <div
            class="absolute bottom-0 left-0 h-0.5 rounded-b-2xl transition-all duration-100"
            :style="{ width: toast.progress + '%', background: toast.accent }"
          />
        </div>
      </TransitionGroup>
    </div>
  </Teleport>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount, watch, reactive } from 'vue'

const route = useRoute()  
const isOffline = useOffline()
const selectedUserId = useState('selected_user_id', () => 'u001')
const selectedUserProfile = useState('selected_user_profile', () => null)
const supabase = useSupabaseClient()
let userRealtimeChannel = null

const isSidebarOpen = ref(false)

// Close drawer on path change
watch(() => route.path, () => {
  isSidebarOpen.value = false
})

// ============================================================
// NAVIGATION ACTIVITY TOAST SYSTEM
// ============================================================
const navToasts = ref([])
let navToastCounter = 0

const showNavToast = (icon, accent, title, message, duration = 4500) => {
  const id = ++navToastCounter
  const toast = reactive({ id, icon, accent, title, message, progress: 100 })
  navToasts.value.push(toast)

  const startTime = Date.now()
  const interval = setInterval(() => {
    const elapsed = Date.now() - startTime
    toast.progress = Math.max(0, 100 - (elapsed / duration) * 100)
    if (elapsed >= duration) {
      clearInterval(interval)
      removeNavToast(id)
    }
  }, 50)
}

const removeNavToast = (id) => {
  const idx = navToasts.value.findIndex(t => t.id === id)
  if (idx !== -1) navToasts.value.splice(idx, 1)
}

// Page activity map — what is the user doing on each page?
const pageActivityMap = {
  '/': {
    icon: 'ph:squares-four-bold',
    accent: '#059669',
    title: '📊 กลับมาที่ Dashboard แล้ว',
    message: 'ดูภาพรวมคาร์บอนฟุตพริ้นท์และกิจกรรมล่าสุดของคุณ'
  },
  '/ai-assistant': {
    icon: 'ph:chat-text-bold',
    accent: '#7c3aed',
    title: '🤖 เปิด AI Assistant',
    message: 'ถาม AI เกี่ยวกับการลดคาร์บอนและคำแนะนำสิ่งแวดล้อมส่วนตัว'
  },
  '/air-quality': {
    icon: 'ph:wind-bold',
    accent: '#0284c7',
    title: '💨 ตรวจสอบคุณภาพอากาศ',
    message: 'ดูค่า AQI, PM2.5 และดัชนีคุณภาพอากาศรอบตัวคุณแบบเรียลไทม์'
  },
  '/water-health': {
    icon: 'ph:drop-bold',
    accent: '#0891b2',
    title: '💧 ตรวจสอบสุขภาพน้ำ',
    message: 'วิเคราะห์คุณภาพน้ำและผลกระทบต่อระบบนิเวศในพื้นที่'
  },
  '/flora-analysis': {
    icon: 'ph:tree-bold',
    accent: '#16a34a',
    title: '🌳 เข้าสู่ Flora Analysis',
    message: 'ดูป่าของคุณ ปลูกต้นไม้ และวิเคราะห์การดูดซับ CO₂'
  },
  '/settings': {
    icon: 'ph:gear-bold',
    accent: '#64748b',
    title: '⚙️ เปิดหน้าตั้งค่า',
    message: 'แก้ไขข้อมูลส่วนตัวและปรับแต่งการแจ้งเตือนของคุณ'
  },
  '/support': {
    icon: 'ph:question-bold',
    accent: '#d97706',
    title: '🙋 เปิดหน้าช่วยเหลือ',
    message: 'ดูคำถามที่พบบ่อยและติดต่อทีมสนับสนุน Eco-Sphere'
  }
}

// Watch route changes and fire navigation toasts
let isFirstLoad = true
watch(() => route.path, (newPath, oldPath) => {
  // Skip the very first load to avoid toasting on initial render
  if (isFirstLoad) {
    isFirstLoad = false
    return
  }
  // Skip select-profile page
  if (newPath === '/select-profile' || oldPath === '/select-profile') return

  const activity = pageActivityMap[newPath]
  if (activity) {
    // Clear previous nav toasts first
    navToasts.value = []
    setTimeout(() => {
      showNavToast(activity.icon, activity.accent, activity.title, activity.message)
    }, 200)
  }
})

const loadUserProfile = async () => {
  if (!selectedUserId.value) return
  
  // Offline cached load
  if (isOffline.value) {
    if (typeof window !== 'undefined') {
      const cached = localStorage.getItem(`offline_cache_user_data_${selectedUserId.value}`)
      if (cached) {
        try {
          const cacheData = JSON.parse(cached)
          if (cacheData.selectedUser) {
            selectedUserProfile.value = cacheData.selectedUser
            return
          }
        } catch (e) {
          console.error('Failed to parse cache in layout:', e)
        }
      }
    }
  }

  try {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('user_id', selectedUserId.value)
      .maybeSingle()
    if (data) {
      selectedUserProfile.value = data
      isOffline.value = false
    }
  } catch (err) {
    console.error('Error loading profile in default layout:', err)
  }
}

const subscribeUserRealtime = () => {
  if (typeof window === 'undefined') return
  if (userRealtimeChannel) {
    supabase.removeChannel(userRealtimeChannel)
  }
  userRealtimeChannel = supabase.channel(`layout-user-${selectedUserId.value}`)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'users', filter: `user_id=eq.${selectedUserId.value}` }, (payload) => {
      if (payload.new) {
        selectedUserProfile.value = payload.new
      } else {
        loadUserProfile()
      }
    })
    .subscribe()
}

const currentUser = computed(() => {
  const uid = selectedUserId.value
  const avatars = {
    'u001': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    'u002': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
    'u005': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'
  }
  
  const defaultAvatar = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80'
  
  if (selectedUserProfile.value) {
    return {
      name: selectedUserProfile.value.name,
      avatar: avatars[uid] || defaultAvatar
    }
  }
  
  const names = {
    'u001': 'Somchai Jaidee',
    'u002': 'Alice Green',
    'u005': 'Wichai Nilsuwan'
  }
  
  return {
    name: names[uid] || 'Somchai Jaidee',
    avatar: avatars[uid] || defaultAvatar
  }
})

const handleExport = () => {
  alert('กำลังเตรียมดาวน์โหลดรายงานสรุปคาร์บอนฟุตพริ้นท์...')
}

watch(selectedUserId, () => {
  loadUserProfile()
  subscribeUserRealtime()
})

onMounted(async () => {
  if (typeof window !== 'undefined') {
    const savedId = localStorage.getItem('selected_user_id')
    if (savedId) {
      selectedUserId.value = savedId
    } else if (route.path !== '/select-profile') {
      navigateTo('/select-profile')
      return
    }
  }
  await loadUserProfile()
  subscribeUserRealtime()
})

onBeforeUnmount(() => {
  if (userRealtimeChannel) {
    supabase.removeChannel(userRealtimeChannel)
  }
})
</script>
