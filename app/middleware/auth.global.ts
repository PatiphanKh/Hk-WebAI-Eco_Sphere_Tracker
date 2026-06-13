export default defineNuxtRouteMiddleware((to) => {
  const session = useCookie('auth_session')

  // Redirect to login if user is not authenticated and trying to access a gated page
  if (!session.value && to.path !== '/login') {
    return navigateTo('/login')
  }

  // Redirect to dashboard if user is authenticated and trying to access login page
  if (session.value && to.path === '/login') {
    return navigateTo('/')
  }
})
