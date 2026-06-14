import { onMounted, onUnmounted } from 'vue'

export const useOffline = () => {
  const isOffline = useState('is_offline', () => false)

  if (process.client) {
    const updateStatus = () => {
      isOffline.value = !navigator.onLine
    }

    onMounted(() => {
      updateStatus()
      window.addEventListener('online', updateStatus)
      window.addEventListener('offline', updateStatus)
    })

    onUnmounted(() => {
      window.removeEventListener('online', updateStatus)
      window.removeEventListener('offline', updateStatus)
    })
  }

  return isOffline
}
