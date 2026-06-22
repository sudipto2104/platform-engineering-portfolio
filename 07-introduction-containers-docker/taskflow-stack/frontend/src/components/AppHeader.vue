<template>
  <header class="header">
    <h1>TaskFlow</h1>
    <nav>
      <RouterLink to="/">Dashboard</RouterLink>
      <RouterLink to="/tasks">Tasks</RouterLink>
    </nav>
  </header>
</template>

<style scoped>
.header { display: flex; justify-content: space-between; padding: 1rem; border-bottom: 1px solid #ddd; }
nav a { margin-left: 1rem; }
</style>