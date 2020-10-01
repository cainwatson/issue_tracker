import { createStore } from 'vuex'
import { AccountState, accountStore } from './account'

export interface AppState {
  account: AccountState
}

export default createStore({
  strict: process.env.NODE_ENV !== 'production',
  modules: {
    account: accountStore,
  },
})
