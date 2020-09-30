<template>
  <section>
    <h1>Dashboard</h1>
    {{ jwt }}
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore } from 'vuex'

export default defineComponent({
  name: 'Dashboard',
  setup() {
    const store = useStore()
    return { jwt: store.state.jwt }
  },
})
</script>
