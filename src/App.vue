<template>
  <div id="app">
    <nav class="flex items-center justify-between flex-wrap bg-blue-uni p-6">
      <div class="flex items-center flex-no-shrink text-white mr-6">
        <img
          id="large-logo"
          src="./assets/university-of-glasgow-280.png"
          alt="University of Glasgow logo"
        >
      </div>

      <div class="block lg:hidden"></div>
      <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
        <span
          class="font-semibold text-xl tracking-tight justify-around text-white mr-6"
        >UofG Help Desk Dashboard</span>
        <div class="text-sm lg:flex-grow"></div>
        <div></div>
      </div>
    </nav>
    <router-view/>
  </div>
</template>
