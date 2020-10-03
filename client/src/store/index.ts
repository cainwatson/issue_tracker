import { createLogger, createStore } from 'vuex'
import { AccountState, accountStore } from './account'

export interface AppState {
  account: AccountState
}

const IS_DEV = process.env.NODE_ENV !== 'production'

export default createStore<AppState>({
  strict: IS_DEV,
  plugins: IS_DEV ? [createLogger()] : [],
  modules: {
    account: accountStore,
  },
})
