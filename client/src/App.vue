<template>
  <div>
    <p uk-margin>
      <button class="uk-button uk-button-default">Default</button>
      <button class="uk-button uk-button-primary">Primary</button>
      <button class="uk-button uk-button-secondary">Secondary</button>
      <button class="uk-button uk-button-danger">Danger</button>
      <button class="uk-button uk-button-text">Text</button>
      <button class="uk-button uk-button-link">Link</button>
    </p>
    <p>
      <button class="uk-button uk-button-default">Default</button>
      <button class="uk-button uk-button-primary">Primary</button>
      <button class="uk-button uk-button-secondary">Secondary</button>
      <button class="uk-button uk-button-danger">Danger</button>
      <button class="uk-button uk-button-text">Text</button>
      <button class="uk-button uk-button-link">Link</button>
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'App',
})
</script>

<style lang="scss" scoped>
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
