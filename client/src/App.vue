<template>
  <main>
    <side-bar-layout>
      <router-view></router-view>
    </side-bar-layout>
  </main>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import SideBarLayout from './components/SideBarLayout.vue'

export default defineComponent({
  name: 'App',
  components: {
    SideBarLayout,
  },
})
</script>

<style lang="scss">
// Custom variables and variable overwrites.
/* $global-link-color: #da7d02; */

@import 'uikit/src/scss/variables-theme.scss';
@import 'uikit/src/scss/mixins-theme.scss';

// Custom mixin overwrites.
/* @mixin hook-card() {
  color: #000;
} */

@import 'uikit/src/scss/uikit-theme.scss';
</style>
