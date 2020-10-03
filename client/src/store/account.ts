import { Module } from 'vuex'
import { AppState } from './index'
import { User } from '../generated/graphql'

export interface AccountState {
  jwt: string | null
  user: User | null
  isLoggedIn: boolean
}

export const accountStore: Module<AccountState, AppState> = {
  namespaced: true,
  state: {
    jwt: localStorage.getItem('jwt'),
    isLoggedIn: false,
    user: null,
  },
  mutations: {
    signIn(state, { jwt, user }) {
      localStorage.setItem('jwt', jwt)

      state.jwt = jwt
      state.user = user
      state.isLoggedIn = true
    },
    signOut(state) {
      localStorage.removeItem('jwt')

      state.jwt = null
      state.user = null
      state.isLoggedIn = false
    },
  },
}
