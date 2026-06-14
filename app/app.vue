<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  if (typeof window !== 'undefined' && 'serviceWorker' in navigator) {
    navigator.serviceWorker.register('/sw.js')
      .then((reg) => console.log('Service Worker Registered!', reg))
      .catch((err) => console.error('Service Worker registration failed:', err))
  }
})
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<style>
/* Toast slide-in/out animations */
.toast-enter-active {
  animation: toast-in 0.35s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
}
.toast-leave-active {
  animation: toast-out 0.25s ease-in forwards;
}
.toast-move {
  transition: transform 0.3s ease;
}

@keyframes toast-in {
  from {
    opacity: 0;
    transform: translateX(120%) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateX(0) scale(1);
  }
}

@keyframes toast-out {
  from {
    opacity: 1;
    transform: translateX(0) scale(1);
  }
  to {
    opacity: 0;
    transform: translateX(120%) scale(0.9);
  }
}

/* Nav-toast activity animations (slide from right, no bounce) */
.nav-toast-enter-active {
  animation: nav-toast-in 0.4s ease-out forwards;
}
.nav-toast-leave-active {
  animation: nav-toast-out 0.25s ease-in forwards;
}
.nav-toast-move {
  transition: transform 0.3s ease;
}

@keyframes nav-toast-in {
  from {
    opacity: 0;
    transform: translateX(100%) translateY(-4px);
  }
  to {
    opacity: 1;
    transform: translateX(0) translateY(0);
  }
}

@keyframes nav-toast-out {
  from {
    opacity: 1;
    transform: translateX(0) translateY(0);
  }
  to {
    opacity: 0;
    transform: translateX(100%) translateY(-4px);
  }
}
</style>
