<template>
  <article
    class="uk-width-medium uk-padding uk-light uk-background-secondary"
    uk-height-viewport
  >
    <router-link to="/" class="uk-link-reset">
      <h1 class="uk-text-center uk-margin-medium-bottom">Issue Tracker</h1>
    </router-link>
    <nav>
      <ul class="uk-list uk-list-large">
        <li>
          <router-link to="/dashboard" class="uk-button uk-width-1-1">
            Dashboard
          </router-link>
        </li>
        <li>
          <router-link to="/me/projects" class="uk-button uk-width-1-1">
            My Projects
          </router-link>
        </li>
        <li>
          <router-link to="/me/organizations" class="uk-button uk-width-1-1">
            Organizations
          </router-link>
        </li>
      </ul>
    </nav>
  </article>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'SideBar',
})
</script>
