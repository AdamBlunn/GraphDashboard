<template>
  <div id="app">
    <div id="Welcome">
      <h1 class="text-white text-center">UofG Help Desk Dashboard</h1>
    </div>
    <div id="nav">
      <router-link to="/">Home</router-link>|
      <router-link to="/about">About</router-link>
    </div>
    <router-view/>
  </div>
</template>
