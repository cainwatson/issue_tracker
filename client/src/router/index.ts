import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path: '/signup',
    name: 'Sign Up',
    meta: {
      requiresAuth: false,
    },
    // route level code-splitting
    // this generates a separate chunk (SignUp.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "SignUp" */ '../views/SignUp.vue'),
  },
  {
    path: '/signin',
    name: 'Sign In',
    meta: {
      requiresAuth: false,
    },
    component: () =>
      import(/* webpackChunkName: "SignIn" */ '../views/SignIn.vue'),
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    meta: {
      requiresAuth: true,
    },
    component: () =>
      import(/* webpackChunkName: "Dashboard" */ '../views/Dashboard.vue'),
  },
  {
    path: '/me/projects',
    name: 'My Projects',
    meta: {
      requiresAuth: true,
    },
    component: () =>
      import(/* webpackChunkName: "MyProjects" */ '../views/MyProjects.vue'),
  },
  {
    path: '/projects/:projectId',
    name: 'Project',
    meta: {
      requiresAuth: true,
    },
    component: () =>
      import(/* webpackChunkName: "Project" */ '../views/Project.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
