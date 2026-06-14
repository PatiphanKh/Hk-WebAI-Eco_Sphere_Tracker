import { createClient } from '@supabase/supabase-js'

export const useSupabaseClient = () => {
  const config = useRuntimeConfig()
  const url = config.public.supabaseUrl || 'https://fsqqnrjhwjhprsbquqeg.supabase.co'
  const key = config.public.supabaseAnonKey || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzcXFucmpod2pocHJzYnF1cWVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjkyMzEsImV4cCI6MjA5NjkwNTIzMX0.5ohCPqG2wjlSc8RFsfAOUbtG1IGVWu_FeiZhMqqWae0'

  // Return singleton client
  const client = useState('supabase_client_instance', () => createClient(url, key))
  return client.value
}
