<template>
  <div class="min-h-screen flex bg-[#f1f9f5] font-sans text-gray-900">
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
      <div class="bg-[#dcedc8] text-[#33691e] py-2 px-4 text-center text-xs font-bold flex items-center justify-center gap-2 border-b border-[#c5e1a5]">
        <Icon name="ph:broadcast-bold" class="w-4 h-4 text-[#558b2f]" />
        คุณกำลังใช้งานแบบออฟไลน์ — ข้อมูลแสดงจากแคชล่าสุด
      </div>
      
      <!-- Content Container -->
      <div class="p-8 overflow-y-auto flex-1">
        <slot />
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute()  

const handleExport = () => {
  alert('กำลังเตรียมดาวน์โหลดรายงานสรุปคาร์บอนฟุตพริ้นท์...')
}
</script>
