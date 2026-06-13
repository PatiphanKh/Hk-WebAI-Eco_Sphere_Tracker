<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-50 font-sans p-6">
    <div class="w-full max-w-md bg-white rounded-3xl shadow-xl border border-gray-100 p-8 space-y-8 relative overflow-hidden">
      <!-- Decorative Gradient Border -->
      <div class="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-green-500 to-green-700"></div>

      <div class="text-center">
        <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">Eco-Sphere</h1>
        <p class="text-sm text-gray-500 mt-1">Data-Driven Precision Platform</p>
      </div>

      <!-- Messages Banners -->
      <Transition
        enter-active-class="transform transition duration-300 ease-out"
        enter-from-class="opacity-0 -translate-y-2"
        enter-to-class="opacity-100 translate-y-0"
        leave-active-class="transform transition duration-200 ease-in"
        leave-from-class="opacity-100 translate-y-0"
        leave-to-class="opacity-0 -translate-y-2"
      >
        <div v-if="errorMessage" class="bg-red-50 border border-red-100 text-red-700 p-4 rounded-xl flex items-start gap-3">
          <Icon name="ph:warning-circle-duotone" class="w-5 h-5 text-red-500 flex-shrink-0 mt-0.5" />
          <div class="text-sm font-medium">{{ errorMessage }}</div>
        </div>
        
        <div v-else-if="successMessage" class="bg-green-50 border border-green-100 text-green-800 p-4 rounded-xl flex items-start gap-3">
          <Icon name="ph:check-circle-duotone" class="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
          <div class="text-sm font-medium">{{ successMessage }}</div>
        </div>
      </Transition>

      <form @submit.prevent="handleLogin" class="space-y-6">
        <div>
          <label for="email" class="block text-sm font-medium text-gray-700 mb-2">อีเมลผู้ใช้งาน</label>
          <div class="relative">
            <input 
              id="email"
              v-model="email" 
              type="email" 
              required 
              placeholder="name@example.com"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl pl-11 pr-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
              :disabled="isLoading"
            />
            <Icon name="ph:envelope-simple-duotone" class="w-5 h-5 text-gray-400 absolute left-4 top-3.5" />
          </div>
        </div>

        <div>
          <div class="flex justify-between items-center mb-2">
            <label for="password" class="block text-sm font-medium text-gray-700">รหัสผ่าน</label>
            <span class="text-xs text-gray-400">Mock: test@example.com / 123456</span>
          </div>
          <div class="relative">
            <input 
              id="password"
              v-model="password" 
              type="password" 
              required 
              placeholder="••••••••"
              class="w-full bg-gray-50 border border-gray-200 rounded-xl pl-11 pr-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:bg-white transition"
              :disabled="isLoading"
            />
            <Icon name="ph:lock-duotone" class="w-5 h-5 text-gray-400 absolute left-4 top-3.5" />
          </div>
        </div>

        <button 
          type="submit" 
          class="w-full bg-green-950 text-white py-3.5 rounded-xl font-semibold text-sm hover:bg-green-900 transition flex items-center justify-center gap-2 shadow-sm"
          :disabled="isLoading"
        >
          <span v-if="isLoading" class="flex items-center gap-2">
            <Icon name="ph:spinner-gap-bold" class="w-4 h-4 animate-spin" />
            กำลังเข้าสู่ระบบ...
          </span>
          <span v-else>เข้าสู่ระบบ</span>
        </button>
      </form>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: false
})

const email = ref('')
const password = ref('')
const isLoading = ref(false)
const errorMessage = ref('')
const successMessage = ref('')

const sessionCookie = useCookie('auth_session', {
  maxAge: 60 * 60 * 24 // 1 day
})

const handleLogin = () => {
  errorMessage.value = ''
  successMessage.value = ''
  isLoading.value = true

  // Simulate verification network delay
  setTimeout(() => {
    isLoading.value = false
    if (email.value === 'test@example.com' && password.value === '123456') {
      successMessage.value = 'เข้าสู่ระบบสำเร็จ! กำลังนำคุณไปยังแดชบอร์ด...'
      sessionCookie.value = 'mock-session-id'
      
      // Delay navigation slightly to let success animation play
      setTimeout(() => {
        navigateTo('/')
      }, 1200)
    } else {
      errorMessage.value = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง'
    }
  }, 1000)
}
</script>
