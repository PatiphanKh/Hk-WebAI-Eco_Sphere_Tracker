<template>
  <div class="min-h-screen flex bg-gray-50 font-sans">
    <aside class="w-64 bg-white p-6 flex flex-col border-r border-gray-100">
      <div class="mb-10">
        <h1 class="text-2xl font-bold text-gray-900">Eco-Sphere</h1>
        <p class="text-sm text-gray-500">Data-Driven Precision</p>
      </div>

      <nav class="flex-grow space-y-2">
        <NuxtLink 
          to="/" 
          class="flex items-center gap-3 px-4 py-2.5 rounded-lg transition"
          :class="route.path === '/' ? 'bg-green-100 text-green-700 font-medium' : 'text-gray-600 hover:bg-gray-100'"
        >
          <Icon name="ph:squares-four-duotone" class="w-5 h-5" />
          Dashboard
        </NuxtLink>
        <NuxtLink 
          to="/ai-assistant" 
          class="flex items-center gap-3 px-4 py-2.5 rounded-lg transition"
          :class="route.path === '/ai-assistant' ? 'bg-green-100 text-green-700 font-medium' : 'text-gray-600 hover:bg-gray-100'"
        >
          <Icon name="ph:robot-duotone" class="w-5 h-5" />
          AI Eco-Assistant
        </NuxtLink>
        <NuxtLink     
          to="/settings" 
          class="flex items-center gap-3 px-4 py-2.5 rounded-lg transition"
          :class="route.path === '/settings' ? 'bg-green-100 text-green-700 font-medium' : 'text-gray-600 hover:bg-gray-100'"
        >
          <Icon name="ph:gear-duotone" class="w-5 h-5" />
          Simulator Settings
        </NuxtLink>
      </nav>

      <div class="mt-auto border-t border-gray-100 pt-6 flex items-center gap-3">
        <img src="https://via.placeholder.com/40" alt="Admin" class="w-10 h-10 rounded-full" />
        <div>
          <p class="font-semibold text-sm text-gray-900">Somchai Jaidee</p>
          <p class="text-xs text-gray-500">Admin</p>
        </div>
      </div>
    </aside>

    <main class="flex-1">
      <div class="bg-red-50 text-red-700 p-3 text-center text-sm border-b border-red-100">
        คุณกำลังออฟไลน์ ระบบปรับไปใช้ Local Fallback Engine ข้อมูลจะบันทึกในเครื่องชั่วคราว Simulate Offline
      </div>
      
      <div class="p-8">
        <slot />
      </div>
    </main>
  </div>
</template>

<script setup>
const route = useRoute()  

const handleLogout = () => {
  const sessionCookie = useCookie('auth_session')
  sessionCookie.value = null
  navigateTo('/login')
}
</script>
