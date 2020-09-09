<template>
  <div class="uk-flex">
    <side-bar />
    <div class="uk-padding">
      <slot />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import SideBar from './SideBar.vue'

export default defineComponent({
  name: 'SideBarLayout',
  components: {
    SideBar,
  },
})
</script>
