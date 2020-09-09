import { createApp } from 'vue'
import UIkit from 'uikit'
import Icons from 'uikit/dist/js/uikit-icons'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import store from './store'

UIkit.use(Icons)

createApp(App)
  .use(store)
  .use(router)
  .mount('#app')
