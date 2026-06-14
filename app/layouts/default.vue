<template>
  <div v-if="route.path === '/select-profile'" class="min-h-screen bg-gradient-to-tr from-[#f1f9f5] via-[#e8f5e9]/50 to-[#f5fbf7]">
    <slot />
  </div>
  <div v-else class="min-h-screen flex bg-[#f1f9f5] font-sans text-gray-900">
    <!-- Sidebar -->
    <aside class="w-64 bg-[#e5f4ec] p-6 flex flex-col border-r border-[#d2ebd9] flex-shrink-0 relative z-30 shadow-sm">
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
          <img :src="currentUser.avatar" class="w-10 h-10 rounded-full object-cover border border-gray-100 flex-shrink-0" alt="Avatar" />
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

    <!-- Main Content Area -->
    <div class="flex-1 flex flex-col min-w-0">
      <!-- Warning Banner -->
      <div v-if="isOffline" class="bg-amber-50 text-amber-800 py-2.5 px-4 text-center text-xs font-bold flex items-center justify-center gap-2 border-b border-amber-200">
        <Icon name="ph:wifi-slash-bold" class="w-4 h-4 text-amber-700 animate-pulse" />
        คุณกำลังใช้งานแบบออฟไลน์ — แสดงข้อมูลล่าสุดจากแคชบนเครื่อง
      </div>
      
      <!-- Content Container -->
      <div class="p-8 overflow-y-auto flex-1">
        <slot />
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const route = useRoute()  
const isOffline = useOffline()
const selectedUserId = useState('selected_user_id', () => 'u001')

const currentUser = computed(() => {
  const uid = selectedUserId.value
  const users = {
    'u001': { name: 'Somchai Jaidee', avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' },
    'u002': { name: 'Alice Green', avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' },
    'u005': { name: 'Wichai Nilsuwan', avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80' }
  }
  return users[uid] || users['u001']
})

const handleExport = () => {
  alert('กำลังเตรียมดาวน์โหลดรายงานสรุปคาร์บอนฟุตพริ้นท์...')
}

onMounted(() => {
  if (typeof window !== 'undefined') {
    const savedId = localStorage.getItem('selected_user_id')
    if (savedId) {
      selectedUserId.value = savedId
    } else if (route.path !== '/select-profile') {
      navigateTo('/select-profile')
    }
  }
})
</script>
