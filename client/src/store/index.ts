import { createStore } from 'vuex'

export default createStore({
  strict: process.env.NODE_ENV !== 'production',
  state: {
    jwt: localStorage.getItem('jwt'),
  },
  mutations: {
    signIn(state, { jwt }) {
      localStorage.setItem('jwt', jwt)
      state.jwt = jwt
    },
  },
  modules: {},
})
