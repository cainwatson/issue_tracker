<template>
  <p v-if="projects.length === 0">
    {{ emptyProjectsMessage }}
  </p>
  <ul uk-grid class="uk-child-width-1-2@m uk-child-width-1-3@l">
    <li v-for="project in projects" :key="project.id">
      <router-link
        :to="`/projects/${project.id}`"
        class="uk-link-toggle uk-link-reset"
      >
        <article class="uk-card uk-card-default uk-card-body uk-card-muted">
          <h1 class="uk-text-large">{{ project.name }}</h1>
        </article>
      </router-link>
    </li>
  </ul>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { Project } from '../generated/graphql'

export default defineComponent({
  name: 'MyProjects',
  props: {
    projects: {
      type: Array as PropType<Project[]>,
      default: [],
    },
    emptyProjectsMessage: {
      type: String,
      default: 'No projects found.',
    },
    setProjectLink: {
      type: Function as PropType<(project: Project) => string>,
      default: (project: Project) => `/projects/${project.id}`,
    },
  },
})
</script>
