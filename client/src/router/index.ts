import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import store from '../store'
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
    path: '/me/organizations',
    name: 'My Organizations',
    meta: {
      requiresAuth: true,
    },
    component: () =>
      import(
        /* webpackChunkName: "MyOrganizations" */ '../views/MyOrganizations.vue'
      ),
  },
  {
    path: '/projects/:projectId',
    name: 'Project',
    props: true,
    meta: {
      requiresAuth: true,
    },
    redirect: to => to.path + '/backlog',
    component: () =>
      import(/* webpackChunkName: "Project" */ '../views/Project.vue'),
    children: [
      {
        path: '/projects/:projectId/backlog',
        props: true,
        component: () =>
          import(
            /* webpackChunkName: "Project" */ '../views/ProjectBacklog.vue'
          ),
      },
      {
        path: '/projects/:projectId/boards',
        props: true,
        component: () =>
          import(
            /* webpackChunkName: "Project" */ '../views/ProjectBoards.vue'
          ),
      },
    ],
  },
  {
    path: '/organizations/:organizationId',
    name: 'Organization',
    meta: {
      requiresAuth: true,
    },
    component: () =>
      import(
        /* webpackChunkName: "Organization" */ '../views/Organization.vue'
      ),
  },
  {
    path: '/404',
    name: 'Not Found',
    meta: {
      requiresAuth: false,
    },
    component: () =>
      import(/* webpackChunkName: "NotFound" */ '../views/NotFound.vue'),
  },
  {
    path: '/:pathMatch(.*)',
    redirect: '/404',
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

router.beforeResolve((to, from, next) => {
  const { isLoggedIn } = store.state.account

  if (!isLoggedIn && to.meta.requiresAuth) {
    return next({
      path: '/signin',
      query: {
        redirect: to.fullPath,
      },
    })
  }
  next()
})

export default router
