<template>
  <div class="container">
    <header>
      <h1>easy_terraform_aws</h1>
    </header>
    <main>
      <div class="success-card">
        <h2>It's alive! It's alive!</h2>
        <small>Dr. Frankenstein, "Frankenstein"(1931)</small>
        <p>Este projeto Nuxt foi implantado com sucesso usando Terraform, Docker e Nginx.</p>
        <div class="status">
          <span class="dot"></span>
          <span>Tudo funcionando perfeitamente</span>
        </div>
      </div>
    </main>
    <footer>
      <p>github.com/everton-tenorio</p>
    </footer>
  </div>
</template>

<style scoped>
* {
  font-family: monospace;
}

.container {
  min-height: 88vh;
  background: #0f0f0f;
  color: #fff;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  padding: 2rem;
}

header h1 {
  color: #00dc82;
  font-size: 2.5rem;
}

.success-card {
  background: #2a2a2a;
  padding: 2rem;
  border-radius: 8px;
  text-align: center;
  border: 1px solid #00dc82;
  max-width: 600px;
}

.success-card h2 {
  color: #00dc82;
  font-style: italic;
}

small {
  font-style: italic;
}

.success-card p {
  margin-top: 2rem;
  font-weight: 800;
}

.status {
  margin-top: 1.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.dot {
  width: 10px;
  height: 10px;
  background: #00dc82;
  border-radius: 50%;
  display: inline-block;
}

footer {
  color: #888;
  font-size: 0.9rem;
}
</style>
