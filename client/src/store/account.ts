import { Module } from 'vuex'

export interface AccountState {
  jwt: string | null
  isLoggedIn: boolean
}

export const accountStore: Module<AccountState, AccountState> = {
  namespaced: true,
  state: {
    jwt: localStorage.getItem('jwt'),
    isLoggedIn: false,
  },
  mutations: {
    signIn(state, { jwt }) {
      localStorage.setItem('jwt', jwt)

      state.jwt = jwt
      state.isLoggedIn = true
    },
  },
}
