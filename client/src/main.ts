import { createApp } from 'vue'
import UIkit from 'uikit'
import Icons from 'uikit/dist/js/uikit-icons'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import store from './store'
import { DefaultApolloClient } from '@vue/apollo-composable'
import { apolloClient } from './apollo'

UIkit.use(Icons)

createApp(App)
  .use(store)
  .use(router)
  .provide(DefaultApolloClient, apolloClient)
  .mount('#app')
