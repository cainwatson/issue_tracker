<template>
  <section>
    <h1>Issue Tracker</h1>
    <ul>
      <li>
        <router-link to="/signup">Sign Up</router-link>
      </li>
      <li>
        <router-link to="/signin">Sign In</router-link>
      </li>
    </ul>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'Home',
})
</script>
